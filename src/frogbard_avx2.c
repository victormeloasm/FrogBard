/* Four-way AVX2 backend for FrogBard-512 equal-length messages. */

#include "frogbard.h"

#include <stdint.h>
#include <string.h>

#if !defined(__AVX2__)
#error "frogbard_avx2.c must be compiled with AVX2 enabled"
#endif

#define FROGBARD_ROUNDS FROGBARD_MAX_ROUNDS
#define FROGBARD_FINAL_PERMUTATIONS 2u
#include "frogbard_tables.h"

typedef uint64_t fb_v4u64 __attribute__((vector_size(32), aligned(32)));

static inline fb_v4u64 splat64(uint64_t x)
{
    return (fb_v4u64){x, x, x, x};
}

static inline fb_v4u64 vrotl64(fb_v4u64 x, unsigned n)
{
    return (x << n) | (x >> (64u - n));
}

static inline uint64_t load64_le_v(const uint8_t *p)
{
    uint64_t x;
    memcpy(&x, p, sizeof(x));
#if defined(__BYTE_ORDER__) && __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
    x = __builtin_bswap64(x);
#endif
    return x;
}

static inline void store64_le_v(uint8_t *p, uint64_t x)
{
#if defined(__BYTE_ORDER__) && __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
    x = __builtin_bswap64(x);
#endif
    memcpy(p, &x, sizeof(x));
}

static inline void ortho_v4(fb_v4u64 q[8])
{
#define VMASK(x) splat64(UINT64_C(x))
#define VSWAPN(cl, ch, s, x, y) do { \
    const fb_v4u64 a_ = (x); \
    const fb_v4u64 b_ = (y); \
    (x) = (a_ & VMASK(cl)) | ((b_ & VMASK(cl)) << (s)); \
    (y) = ((a_ & VMASK(ch)) >> (s)) | (b_ & VMASK(ch)); \
} while (0)
#define VSWAP2(x, y) VSWAPN(0x5555555555555555, 0xAAAAAAAAAAAAAAAA, 1, x, y)
#define VSWAP4(x, y) VSWAPN(0x3333333333333333, 0xCCCCCCCCCCCCCCCC, 2, x, y)
#define VSWAP8(x, y) VSWAPN(0x0F0F0F0F0F0F0F0F, 0xF0F0F0F0F0F0F0F0, 4, x, y)
    VSWAP2(q[0], q[1]); VSWAP2(q[2], q[3]);
    VSWAP2(q[4], q[5]); VSWAP2(q[6], q[7]);
    VSWAP4(q[0], q[2]); VSWAP4(q[1], q[3]);
    VSWAP4(q[4], q[6]); VSWAP4(q[5], q[7]);
    VSWAP8(q[0], q[4]); VSWAP8(q[1], q[5]);
    VSWAP8(q[2], q[6]); VSWAP8(q[3], q[7]);
#undef VSWAP8
#undef VSWAP4
#undef VSWAP2
#undef VSWAPN
#undef VMASK
}

#define FB_AES_WORD fb_v4u64
#define FB_AES_SBOX_NAME aes_sbox_bitslice_v4
#include "frogbard_aes_sbox.inc"

static inline void derived_sbox_v4(fb_v4u64 words[8], unsigned box_index)
{
    fb_v4u64 q[8];
    fb_v4u64 t[8];
    const uint8_t *pin = FROGBARD_SBOX_PIN[box_index];
    const uint8_t *pout = FROGBARD_SBOX_POUT[box_index];
    const uint8_t inxor = FROGBARD_SBOX_IN_XOR[box_index];
    const uint8_t outxor = FROGBARD_SBOX_OUT_XOR[box_index];

    memcpy(q, words, sizeof(q));
    ortho_v4(q);
    for (unsigned out = 0; out < 8u; ++out) {
        const unsigned src = pin[out];
        const fb_v4u64 mask = ((inxor >> src) & 1u) != 0u
            ? splat64(UINT64_MAX) : splat64(UINT64_C(0));
        t[out] = q[src] ^ mask;
    }
    aes_sbox_bitslice_v4(t);
    for (unsigned out = 0; out < 8u; ++out) {
        const fb_v4u64 mask = ((outxor >> out) & 1u) != 0u
            ? splat64(UINT64_MAX) : splat64(UINT64_C(0));
        q[out] = t[pout[out]] ^ mask;
    }
    ortho_v4(q);
    memcpy(words, q, sizeof(q));
}

static inline void quarter_round_v(fb_v4u64 *a, fb_v4u64 *b,
                                   fb_v4u64 *c, fb_v4u64 *d,
                                   unsigned r0, unsigned r1,
                                   unsigned r2, unsigned r3)
{
    *a += *b; *d ^= *a; *d = vrotl64(*d, r0);
    *c += *d; *b ^= *c; *b = vrotl64(*b, r1);
    *a += *b; *d ^= *a; *d = vrotl64(*d, r2);
    *c += *d; *b ^= *c; *b = vrotl64(*b, r3);
}

static inline const uint8_t *voice_rotations_v(unsigned voice, unsigned round)
{
    static const uint8_t rot[4][4] = {
        {17, 29, 41, 53}, {23, 31, 47, 59},
        {11, 37, 43, 57}, {19, 27, 45, 61}
    };
    return rot[(voice + round) & 3u];
}

static inline void mix_voice_v(fb_v4u64 x[8], unsigned voice, unsigned round)
{
    const uint8_t *rr = voice_rotations_v(voice, round);
    quarter_round_v(&x[0], &x[1], &x[2], &x[3], rr[0], rr[1], rr[2], rr[3]);
    quarter_round_v(&x[4], &x[5], &x[6], &x[7], rr[1], rr[2], rr[3], rr[0]);
    quarter_round_v(&x[0], &x[5], &x[2], &x[7], rr[2], rr[3], rr[0], rr[1]);
    quarter_round_v(&x[4], &x[1], &x[6], &x[3], rr[3], rr[0], rr[1], rr[2]);
}

#define VPERMUTE8(x, a, b, c, d, e, f, g, h) do { \
    const fb_v4u64 t0_ = (x)[a]; const fb_v4u64 t1_ = (x)[b]; \
    const fb_v4u64 t2_ = (x)[c]; const fb_v4u64 t3_ = (x)[d]; \
    const fb_v4u64 t4_ = (x)[e]; const fb_v4u64 t5_ = (x)[f]; \
    const fb_v4u64 t6_ = (x)[g]; const fb_v4u64 t7_ = (x)[h]; \
    (x)[0] = t0_; (x)[1] = t1_; (x)[2] = t2_; (x)[3] = t3_; \
    (x)[4] = t4_; (x)[5] = t5_; (x)[6] = t6_; (x)[7] = t7_; \
} while (0)

static inline void permute_lanes_v(fb_v4u64 v[4][8], unsigned round)
{
    if ((round & 1u) == 0u) {
        VPERMUTE8(v[0], 0,3,6,1,4,7,2,5);
        VPERMUTE8(v[1], 5,0,3,6,1,4,7,2);
        VPERMUTE8(v[2], 2,5,0,3,6,1,4,7);
        VPERMUTE8(v[3], 7,2,5,0,3,6,1,4);
    } else {
        VPERMUTE8(v[0], 1,6,3,0,5,2,7,4);
        VPERMUTE8(v[1], 4,1,6,3,0,5,2,7);
        VPERMUTE8(v[2], 7,4,1,6,3,0,5,2);
        VPERMUTE8(v[3], 2,7,4,1,6,3,0,5);
    }
}
#undef VPERMUTE8

static inline void cross_voice_braid_v(fb_v4u64 v[4][8], unsigned round)
{
    static const uint8_t ra[8] = {7,13,19,29,37,43,53,61};
    static const uint8_t rb[8] = {11,17,23,31,41,47,55,59};
    if ((round & 1u) == 0u) {
        for (unsigned i = 0; i < 8u; ++i) {
            v[0][i] += vrotl64(v[1][(i + 1u) & 7u], ra[i]);
            v[2][i] ^= vrotl64(v[0][(i + 3u) & 7u], rb[i]);
            v[3][i] += vrotl64(v[2][(i + 5u) & 7u], ra[(i + 2u) & 7u]);
            v[1][i] ^= vrotl64(v[3][(i + 7u) & 7u], rb[(i + 4u) & 7u]);
        }
    } else {
        for (unsigned i = 0; i < 8u; ++i) {
            v[3][i] += vrotl64(v[2][(i + 2u) & 7u], rb[i]);
            v[1][i] ^= vrotl64(v[3][(i + 4u) & 7u], ra[i]);
            v[0][i] += vrotl64(v[1][(i + 6u) & 7u], rb[(i + 3u) & 7u]);
            v[2][i] ^= vrotl64(v[0][(i + 1u) & 7u], ra[(i + 5u) & 7u]);
        }
    }
}

static inline void permute_v4(fb_v4u64 v[4][8])
{
    for (unsigned round = 0; round < FROGBARD_ROUNDS; ++round) {
        for (unsigned voice = 0; voice < 4u; ++voice) {
            for (unsigned lane = 0; lane < 8u; ++lane) {
                v[voice][lane] ^= splat64(FROGBARD_RC[round][voice][lane]);
            }
            derived_sbox_v4(v[voice], (voice + round) & 3u);
            mix_voice_v(v[voice], voice, round);
        }
        cross_voice_braid_v(v, round);
        permute_lanes_v(v, round);
    }
}

static inline fb_v4u64 load4_words(const uint8_t *p0, const uint8_t *p1,
                                   const uint8_t *p2, const uint8_t *p3)
{
    return (fb_v4u64){load64_le_v(p0), load64_le_v(p1),
                      load64_le_v(p2), load64_le_v(p3)};
}

static inline void absorb4(fb_v4u64 v[4][8], const uint8_t *p[4])
{
    for (unsigned i = 0; i < 8u; ++i) {
        v[0][i] ^= load4_words(p[0] + 8u * i, p[1] + 8u * i,
                               p[2] + 8u * i, p[3] + 8u * i);
        v[1][i] ^= load4_words(p[0] + 64u + 8u * i,
                               p[1] + 64u + 8u * i,
                               p[2] + 64u + 8u * i,
                               p[3] + 64u + 8u * i);
    }
    permute_v4(v);
}

void frogbard_hash4_equal(const void *data0, const void *data1,
                          const void *data2, const void *data3, size_t len,
                          uint8_t out[4][FROGBARD_DIGEST_BYTES])
{
    const uint8_t *p[4] = {
        (const uint8_t *)data0, (const uint8_t *)data1,
        (const uint8_t *)data2, (const uint8_t *)data3
    };
    fb_v4u64 v[4][8];
    for (unsigned voice = 0; voice < 4u; ++voice) {
        for (unsigned lane = 0; lane < 8u; ++lane) {
            v[voice][lane] = splat64(FROGBARD_IV[voice][lane]);
        }
    }
    permute_v4(v);

    size_t remaining = len;
    while (remaining >= FROGBARD_BLOCK_BYTES) {
        absorb4(v, p);
        for (unsigned j = 0; j < 4u; ++j) {
            p[j] += FROGBARD_BLOCK_BYTES;
        }
        remaining -= FROGBARD_BLOCK_BYTES;
    }

    _Alignas(64) uint8_t tail[4][FROGBARD_BLOCK_BYTES];
    for (unsigned j = 0; j < 4u; ++j) {
        memset(tail[j], 0, FROGBARD_BLOCK_BYTES);
        if (remaining != 0u) {
            memcpy(tail[j], p[j], remaining);
        }
        tail[j][remaining] ^= 0x0bu;
        tail[j][FROGBARD_BLOCK_BYTES - 1u] ^= 0x80u;
        p[j] = tail[j];
    }
    absorb4(v, p);

    const fb_v4u64 length = splat64((uint64_t)len);
    v[2][6] ^= length;
    v[3][6] ^= splat64(UINT64_C(0x496e2046726f6720));
    v[3][7] ^= splat64(UINT64_C(0x7765205472757374));
    for (unsigned i = 0; i < FROGBARD_FINAL_PERMUTATIONS; ++i) {
        v[3][i] ^= splat64(UINT64_C(0x21) << (i * 8u));
        permute_v4(v);
    }

    for (unsigned i = 0; i < 8u; ++i) {
        _Alignas(32) uint64_t lanes[4];
        memcpy(lanes, &v[0][i], sizeof(lanes));
        for (unsigned j = 0; j < 4u; ++j) {
            store64_le_v(out[j] + 8u * i, lanes[j]);
        }
    }

    memset(tail, 0, sizeof(tail));
    memset(v, 0, sizeof(v));
}

int frogbard_has_avx2_backend(void)
{
    return 1;
}
