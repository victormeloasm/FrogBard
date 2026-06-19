#ifndef FROGBARD_H
#define FROGBARD_H

#include <stdalign.h>
#include <stddef.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define FROGBARD_VERSION "0.3-experimental"
#define FROGBARD_DIGEST_BYTES 64u
#define FROGBARD_BLOCK_BYTES 128u
#define FROGBARD_STATE_WORDS 32u
#define FROGBARD_MAX_ROUNDS 16u

typedef struct {
    alignas(64) uint64_t v[4][8];
    alignas(64) uint8_t buffer[FROGBARD_BLOCK_BYTES];
    size_t buffer_len;
    uint64_t total_lo;
    uint64_t total_hi;
} frogbard_ctx;

void frogbard_init(frogbard_ctx *ctx);
void frogbard_update(frogbard_ctx *ctx, const void *data, size_t len);
void frogbard_final(frogbard_ctx *ctx,
                    uint8_t out[FROGBARD_DIGEST_BYTES]);
void frogbard_hash(const void *data, size_t len,
                   uint8_t out[FROGBARD_DIGEST_BYTES]);

/*
 * Hash four equal-length messages. Native AVX2 builds use a four-way SIMD
 * backend; other builds use the portable scalar fallback. Input ranges may
 * be unaligned but must be valid for len bytes.
 */
void frogbard_hash4_equal(const void *data0, const void *data1,
                          const void *data2, const void *data3, size_t len,
                          uint8_t out[4][FROGBARD_DIGEST_BYTES]);

int frogbard_has_avx2_backend(void);
int frogbard_self_test(void);

/* Research API for reduced-round analysis and permutation inversion tests. */
void frogbard_permute_reduced(uint64_t state[4][8], unsigned rounds);
void frogbard_permute_inverse_reduced(uint64_t state[4][8], unsigned rounds);
void frogbard_hash_reduced(const void *data, size_t len, unsigned rounds,
                           uint8_t out[FROGBARD_DIGEST_BYTES]);

#ifdef __cplusplus
}
#endif

#endif
