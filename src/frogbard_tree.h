#ifndef FROGBARD_TREE_H
#define FROGBARD_TREE_H

#include "frogbard.h"

#include <stddef.h>
#include <stdint.h>

#define FROGBARD_TREE_CHUNK_BYTES (1024u * 1024u)

typedef struct {
    uint64_t file_size;
    uint64_t leaf_count;
    unsigned levels;
    unsigned threads;
    int used_avx2;
} frogbard_tree_stats;

/* POSIX regular-file tree hashing. Returns 0 on success, -1 on error. */
int frogbard_tree_hash_file(const char *path, unsigned requested_threads,
                            uint8_t out[FROGBARD_DIGEST_BYTES],
                            frogbard_tree_stats *stats);

#endif
