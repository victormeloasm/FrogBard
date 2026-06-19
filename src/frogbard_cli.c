#define _POSIX_C_SOURCE 200809L

#include "frogbard.h"
#include "frogbard_tree.h"

#include <errno.h>
#include <inttypes.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static void print_hex(const uint8_t digest[FROGBARD_DIGEST_BYTES])
{
    static const char hex[] = "0123456789abcdef";
    char text[FROGBARD_DIGEST_BYTES * 2u + 1u];
    for (unsigned i = 0; i < FROGBARD_DIGEST_BYTES; ++i) {
        text[2u * i] = hex[digest[i] >> 4];
        text[2u * i + 1u] = hex[digest[i] & 0x0fu];
    }
    text[sizeof(text) - 1u] = '\0';
    puts(text);
}

static int hash_file_stream(const char *path,
                            uint8_t out[FROGBARD_DIGEST_BYTES])
{
    const bool use_stdin = strcmp(path, "-") == 0;
    FILE *fp = use_stdin ? stdin : fopen(path, "rb");
    if (fp == NULL) {
        fprintf(stderr, "frogbard: cannot open '%s': %s\n", path, strerror(errno));
        return -1;
    }

    frogbard_ctx ctx;
    frogbard_init(&ctx);
    _Alignas(64) uint8_t io_buffer[64u * 1024u];

    for (;;) {
        const size_t n = fread(io_buffer, 1u, sizeof(io_buffer), fp);
        if (n != 0u) {
            frogbard_update(&ctx, io_buffer, n);
        }
        if (n < sizeof(io_buffer)) {
            if (ferror(fp)) {
                fprintf(stderr, "frogbard: read error on '%s': %s\n",
                        path, strerror(errno));
                if (!use_stdin) {
                    (void)fclose(fp);
                }
                return -1;
            }
            break;
        }
    }

    if (!use_stdin && fclose(fp) != 0) {
        fprintf(stderr, "frogbard: close error on '%s': %s\n",
                path, strerror(errno));
        return -1;
    }

    frogbard_final(&ctx, out);
    return 0;
}

static int parse_threads(const char *text, unsigned *out)
{
    char *end = NULL;
    errno = 0;
    const unsigned long value = strtoul(text, &end, 10);
    if (errno != 0 || end == text || *end != '\0' || value == 0u ||
        value > 1024u) {
        return -1;
    }
    *out = (unsigned)value;
    return 0;
}

static void usage(FILE *stream, const char *argv0)
{
    fprintf(stream,
        "FrogBard-512 %s\n"
        "Usage:\n"
        "  %s -s \"string\"\n"
        "  %s -f path/to/file\n"
        "  %s -f -                         (standard input)\n"
        "  %s -T path/to/file [-j threads] (parallel tree mode)\n"
        "  %s --tree-file path [-j threads]\n"
        "  %s --self-test\n"
        "  %s --version\n"
        "  %s --backend\n",
        FROGBARD_VERSION, argv0, argv0, argv0, argv0,
        argv0, argv0, argv0, argv0);
}

int main(int argc, char **argv)
{
    uint8_t digest[FROGBARD_DIGEST_BYTES];

    if (argc == 2 && strcmp(argv[1], "--self-test") == 0) {
        const int rc = frogbard_self_test();
        if (rc != 0) {
            fprintf(stderr, "FrogBard-512 self-test: FAILED (%d)\n", rc);
            return 1;
        }
        puts("FrogBard-512 self-test: OK");
        puts("CroackBoxes: bitsliced/table equivalence, bijection and DU=4: OK");
        puts("Permutation inverse for rounds 1..16: OK");
        printf("Four-way backend: %s\n",
               frogbard_has_avx2_backend() ? "AVX2" : "portable scalar");
        puts("WARNING: these are implementation tests, not a security proof.");
        return 0;
    }
    if (argc == 2 && strcmp(argv[1], "--version") == 0) {
        puts("FrogBard-512 " FROGBARD_VERSION);
        return 0;
    }
    if (argc == 2 && strcmp(argv[1], "--backend") == 0) {
        puts(frogbard_has_avx2_backend() ? "avx2-4way" : "portable-scalar");
        return 0;
    }
    if (argc == 3 && strcmp(argv[1], "-s") == 0) {
        frogbard_hash(argv[2], strlen(argv[2]), digest);
        print_hex(digest);
        return 0;
    }
    if (argc == 3 && strcmp(argv[1], "-f") == 0) {
        if (hash_file_stream(argv[2], digest) != 0) {
            return 1;
        }
        print_hex(digest);
        return 0;
    }
    if (argc >= 3 &&
        (strcmp(argv[1], "-T") == 0 || strcmp(argv[1], "--tree-file") == 0)) {
        unsigned threads = 0u;
        if (argc == 5 && strcmp(argv[3], "-j") == 0) {
            if (parse_threads(argv[4], &threads) != 0) {
                fputs("frogbard: invalid thread count\n", stderr);
                return 2;
            }
        } else if (argc != 3) {
            usage(stderr, argv[0]);
            return 2;
        }
        frogbard_tree_stats stats;
        if (frogbard_tree_hash_file(argv[2], threads, digest, &stats) != 0) {
            fprintf(stderr, "frogbard: tree hash failed for '%s': %s\n",
                    argv[2], strerror(errno));
            return 1;
        }
        print_hex(digest);
        fprintf(stderr,
                "tree: bytes=%" PRIu64 " leaves=%" PRIu64
                " levels=%u threads=%u backend=%s\n",
                stats.file_size, stats.leaf_count, stats.levels,
                stats.threads, stats.used_avx2 ? "avx2-4way" : "scalar");
        return 0;
    }

    usage(argc == 1 ? stdout : stderr, argv[0]);
    return argc == 1 ? 0 : 2;
}
