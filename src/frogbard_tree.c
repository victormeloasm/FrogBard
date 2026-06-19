#define _POSIX_C_SOURCE 200809L

#include "frogbard_tree.h"

#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <stdatomic.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#define TREE_HEADER_BYTES 32u
#define TREE_PARENT_BYTES 160u
#define TREE_ROOT_BYTES 112u
#define TREE_MAX_THREADS 32u

typedef struct {
    int fd;
    uint64_t file_size;
    size_t leaf_count;
    uint8_t *leaves;
    atomic_size_t next_group;
    atomic_int error_code;
} tree_shared;

static void store64_le_tree(uint8_t *p, uint64_t x)
{
#if defined(__BYTE_ORDER__) && __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
    x = __builtin_bswap64(x);
#endif
    memcpy(p, &x, sizeof(x));
}

static int pread_exact(int fd, uint8_t *dst, size_t len, off_t offset)
{
    size_t done = 0;
    while (done < len) {
        const ssize_t n = pread(fd, dst + done, len - done, offset + (off_t)done);
        if (n > 0) {
            done += (size_t)n;
            continue;
        }
        if (n < 0 && errno == EINTR) {
            continue;
        }
        if (n == 0) {
            errno = EIO;
        }
        return -1;
    }
    return 0;
}

static void make_leaf_header(uint8_t header[TREE_HEADER_BYTES],
                             uint64_t index, uint64_t chunk_len)
{
    static const uint8_t domain[16] = {
        'F','r','o','g','B','a','r','d','T','r','e','e','L','1',0,0
    };
    memcpy(header, domain, sizeof(domain));
    store64_le_tree(header + 16u, index);
    store64_le_tree(header + 24u, chunk_len);
}

static size_t chunk_length(uint64_t file_size, size_t index)
{
    const uint64_t offset = (uint64_t)index * (uint64_t)FROGBARD_TREE_CHUNK_BYTES;
    if (offset >= file_size) {
        return 0u;
    }
    const uint64_t left = file_size - offset;
    return left < FROGBARD_TREE_CHUNK_BYTES ? (size_t)left
                                             : (size_t)FROGBARD_TREE_CHUNK_BYTES;
}

static void *tree_worker(void *arg)
{
    tree_shared *shared = (tree_shared *)arg;
    const size_t stride = TREE_HEADER_BYTES + (size_t)FROGBARD_TREE_CHUNK_BYTES;
    void *allocation = NULL;
    if (posix_memalign(&allocation, 64u, 4u * stride) != 0) {
        atomic_store_explicit(&shared->error_code, ENOMEM, memory_order_relaxed);
        return NULL;
    }
    uint8_t *base = (uint8_t *)allocation;

    for (;;) {
        if (atomic_load_explicit(&shared->error_code, memory_order_relaxed) != 0) {
            break;
        }
        const size_t first = atomic_fetch_add_explicit(&shared->next_group, 4u,
                                                        memory_order_relaxed);
        if (first >= shared->leaf_count) {
            break;
        }

        size_t count = shared->leaf_count - first;
        if (count > 4u) {
            count = 4u;
        }
        size_t lengths[4] = {0u, 0u, 0u, 0u};
        const void *messages[4] = {NULL, NULL, NULL, NULL};

        for (size_t j = 0; j < count; ++j) {
            const size_t index = first + j;
            uint8_t *buffer = base + j * stride;
            const size_t len = chunk_length(shared->file_size, index);
            lengths[j] = len;
            make_leaf_header(buffer, (uint64_t)index, (uint64_t)len);
            if (len != 0u) {
                const uint64_t raw_offset = (uint64_t)index *
                                             (uint64_t)FROGBARD_TREE_CHUNK_BYTES;
                if (raw_offset > (uint64_t)INT64_MAX ||
                    pread_exact(shared->fd, buffer + TREE_HEADER_BYTES, len,
                                (off_t)raw_offset) != 0) {
                    const int saved = errno == 0 ? EIO : errno;
                    atomic_store_explicit(&shared->error_code, saved,
                                          memory_order_relaxed);
                    free(allocation);
                    return NULL;
                }
            }
            messages[j] = buffer;
        }

        if (count == 4u && lengths[0] == lengths[1] &&
            lengths[0] == lengths[2] && lengths[0] == lengths[3]) {
            uint8_t digest4[4][FROGBARD_DIGEST_BYTES];
            frogbard_hash4_equal(messages[0], messages[1], messages[2], messages[3],
                                 TREE_HEADER_BYTES + lengths[0], digest4);
            for (size_t j = 0; j < 4u; ++j) {
                memcpy(shared->leaves + (first + j) * FROGBARD_DIGEST_BYTES,
                       digest4[j], FROGBARD_DIGEST_BYTES);
            }
            memset(digest4, 0, sizeof(digest4));
        } else {
            for (size_t j = 0; j < count; ++j) {
                frogbard_hash(messages[j], TREE_HEADER_BYTES + lengths[j],
                    shared->leaves + (first + j) * FROGBARD_DIGEST_BYTES);
            }
        }
    }

    memset(allocation, 0, 4u * stride);
    free(allocation);
    return NULL;
}

static void make_parent_message(uint8_t out[TREE_PARENT_BYTES], unsigned level,
                                unsigned child_count, const uint8_t *left,
                                const uint8_t *right)
{
    static const uint8_t domain[16] = {
        'F','r','o','g','B','a','r','d','T','r','e','e','P','1',0,0
    };
    memset(out, 0, TREE_PARENT_BYTES);
    memcpy(out, domain, sizeof(domain));
    store64_le_tree(out + 16u, (uint64_t)level);
    store64_le_tree(out + 24u, (uint64_t)child_count);
    memcpy(out + 32u, left, FROGBARD_DIGEST_BYTES);
    if (child_count == 2u) {
        memcpy(out + 96u, right, FROGBARD_DIGEST_BYTES);
    }
}

static int reduce_tree(uint8_t **nodes_ptr, size_t *count_ptr, unsigned *levels)
{
    uint8_t *nodes = *nodes_ptr;
    size_t count = *count_ptr;
    unsigned level = 0u;

    while (count > 1u) {
        const size_t next_count = (count + 1u) / 2u;
        if (next_count > SIZE_MAX / FROGBARD_DIGEST_BYTES) {
            errno = EOVERFLOW;
            return -1;
        }
        uint8_t *next = (uint8_t *)malloc(next_count * FROGBARD_DIGEST_BYTES);
        if (next == NULL) {
            return -1;
        }

        size_t parent = 0u;
        while (parent + 4u <= next_count) {
            uint8_t msg[4][TREE_PARENT_BYTES];
            const void *ptr[4];
            for (unsigned j = 0; j < 4u; ++j) {
                const size_t child = 2u * (parent + j);
                const unsigned child_count = child + 1u < count ? 2u : 1u;
                make_parent_message(msg[j], level, child_count,
                    nodes + child * FROGBARD_DIGEST_BYTES,
                    child_count == 2u
                        ? nodes + (child + 1u) * FROGBARD_DIGEST_BYTES
                        : NULL);
                ptr[j] = msg[j];
            }
            uint8_t digests[4][FROGBARD_DIGEST_BYTES];
            frogbard_hash4_equal(ptr[0], ptr[1], ptr[2], ptr[3],
                                 TREE_PARENT_BYTES, digests);
            for (unsigned j = 0; j < 4u; ++j) {
                memcpy(next + (parent + j) * FROGBARD_DIGEST_BYTES,
                       digests[j], FROGBARD_DIGEST_BYTES);
            }
            parent += 4u;
        }
        for (; parent < next_count; ++parent) {
            uint8_t msg[TREE_PARENT_BYTES];
            const size_t child = 2u * parent;
            const unsigned child_count = child + 1u < count ? 2u : 1u;
            make_parent_message(msg, level, child_count,
                nodes + child * FROGBARD_DIGEST_BYTES,
                child_count == 2u
                    ? nodes + (child + 1u) * FROGBARD_DIGEST_BYTES
                    : NULL);
            frogbard_hash(msg, sizeof(msg),
                          next + parent * FROGBARD_DIGEST_BYTES);
        }

        memset(nodes, 0, count * FROGBARD_DIGEST_BYTES);
        free(nodes);
        nodes = next;
        count = next_count;
        *nodes_ptr = nodes;
        *count_ptr = count;
        ++level;
    }

    *nodes_ptr = nodes;
    *count_ptr = count;
    *levels = level;
    return 0;
}

static unsigned choose_thread_count(unsigned requested, size_t leaf_count)
{
    unsigned threads = requested;
    if (threads == 0u) {
        const long online = sysconf(_SC_NPROCESSORS_ONLN);
        threads = online > 0 ? (unsigned)online : 1u;
    }
    if (threads > TREE_MAX_THREADS) {
        threads = TREE_MAX_THREADS;
    }
    size_t groups = (leaf_count + 3u) / 4u;
    if (groups == 0u) {
        groups = 1u;
    }
    if ((size_t)threads > groups) {
        threads = (unsigned)groups;
    }
    return threads == 0u ? 1u : threads;
}

int frogbard_tree_hash_file(const char *path, unsigned requested_threads,
                            uint8_t out[FROGBARD_DIGEST_BYTES],
                            frogbard_tree_stats *stats)
{
    int result = -1;
    int fd = -1;
    uint8_t *leaves = NULL;
    pthread_t *thread_ids = NULL;
    size_t leaf_alloc_count = 0u;

    fd = open(path, O_RDONLY | O_CLOEXEC);
    if (fd < 0) {
        return -1;
    }
    struct stat st;
    if (fstat(fd, &st) != 0) {
        goto cleanup;
    }
    if (!S_ISREG(st.st_mode) || st.st_size < 0) {
        errno = EINVAL;
        goto cleanup;
    }
    const uint64_t file_size = (uint64_t)st.st_size;
    uint64_t leaves64 = file_size == 0u ? 1u
        : (file_size + (uint64_t)FROGBARD_TREE_CHUNK_BYTES - 1u) /
          (uint64_t)FROGBARD_TREE_CHUNK_BYTES;
    if (leaves64 > SIZE_MAX || (size_t)leaves64 > SIZE_MAX / FROGBARD_DIGEST_BYTES) {
        errno = EOVERFLOW;
        goto cleanup;
    }
    const size_t leaf_count = (size_t)leaves64;
    leaf_alloc_count = leaf_count;
    leaves = (uint8_t *)malloc(leaf_count * FROGBARD_DIGEST_BYTES);
    if (leaves == NULL) {
        goto cleanup;
    }

    tree_shared shared = {
        .fd = fd,
        .file_size = file_size,
        .leaf_count = leaf_count,
        .leaves = leaves,
        .next_group = ATOMIC_VAR_INIT(0u),
        .error_code = ATOMIC_VAR_INIT(0)
    };
    const unsigned threads = choose_thread_count(requested_threads, leaf_count);
    thread_ids = (pthread_t *)calloc(threads, sizeof(*thread_ids));
    if (thread_ids == NULL) {
        goto cleanup;
    }

    unsigned created = 0u;
    for (; created < threads; ++created) {
        const int rc = pthread_create(&thread_ids[created], NULL, tree_worker, &shared);
        if (rc != 0) {
            atomic_store_explicit(&shared.error_code, rc, memory_order_relaxed);
            break;
        }
    }
    for (unsigned i = 0; i < created; ++i) {
        (void)pthread_join(thread_ids[i], NULL);
    }
    const int worker_error = atomic_load_explicit(&shared.error_code,
                                                   memory_order_relaxed);
    if (worker_error != 0) {
        errno = worker_error;
        goto cleanup;
    }

    size_t root_count = leaf_count;
    unsigned levels = 0u;
    const int reduce_rc = reduce_tree(&leaves, &root_count, &levels);
    leaf_alloc_count = root_count;
    if (reduce_rc != 0) {
        goto cleanup;
    }

    uint8_t root_message[TREE_ROOT_BYTES];
    static const uint8_t root_domain[16] = {
        'F','r','o','g','B','a','r','d','T','r','e','e','R','1',0,0
    };
    memset(root_message, 0, sizeof(root_message));
    memcpy(root_message, root_domain, sizeof(root_domain));
    store64_le_tree(root_message + 16u, file_size);
    store64_le_tree(root_message + 24u, FROGBARD_TREE_CHUNK_BYTES);
    store64_le_tree(root_message + 32u, leaves64);
    store64_le_tree(root_message + 40u, levels);
    memcpy(root_message + 48u, leaves, FROGBARD_DIGEST_BYTES);
    frogbard_hash(root_message, sizeof(root_message), out);
    memset(root_message, 0, sizeof(root_message));

    if (stats != NULL) {
        stats->file_size = file_size;
        stats->leaf_count = leaves64;
        stats->levels = levels;
        stats->threads = threads;
        stats->used_avx2 = frogbard_has_avx2_backend();
    }
    result = 0;

cleanup:
    if (leaves != NULL) {
        memset(leaves, 0, leaf_alloc_count * FROGBARD_DIGEST_BYTES);
        free(leaves);
    }
    free(thread_ids);
    if (fd >= 0) {
        (void)close(fd);
    }
    return result;
}
