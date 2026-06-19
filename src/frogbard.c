/*
 * FrogBard-512 v0.3-experimental core
 *
 * WARNING: This design has not received independent cryptanalysis. Do not use
 * it to protect production secrets, passwords, signatures, or protocols.
 */

#include "frogbard.h"

#include <stdbool.h>
#include <stdint.h>
#include <string.h>

#define FROGBARD_ROUNDS FROGBARD_MAX_ROUNDS
#define FROGBARD_FINAL_PERMUTATIONS 2u

#include "frogbard_tables.h"

#ifndef __has_builtin
#define __has_builtin(x) 0
#endif

#if defined(__GNUC__) || defined(__clang__)
#define FROGBARD_NOINLINE __attribute__((noinline))
#else
#define FROGBARD_NOINLINE
#endif

static inline uint64_t rotl64(uint64_t x, unsigned n)
{
#if defined(__clang__) && __has_builtin(__builtin_rotateleft64)
    return __builtin_rotateleft64(x, n);
#else
    n &= 63u;
    return n == 0u ? x : (x << n) | (x >> (64u - n));
#endif
}

static inline uint64_t rotr64(uint64_t x, unsigned n)
{
#if defined(__clang__) && __has_builtin(__builtin_rotateright64)
    return __builtin_rotateright64(x, n);
#else
    n &= 63u;
    return n == 0u ? x : (x >> n) | (x << (64u - n));
#endif
}

static inline uint64_t load64_le(const uint8_t *p)
{
    uint64_t x;
    memcpy(&x, p, sizeof(x));
#if defined(__BYTE_ORDER__) && __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
    x = __builtin_bswap64(x);
#endif
    return x;
}

static inline void store64_le(uint8_t *p, uint64_t x)
{
#if defined(__BYTE_ORDER__) && __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
    x = __builtin_bswap64(x);
#endif
    memcpy(p, &x, sizeof(x));
}

static void secure_zero(void *ptr, size_t len)
{
    volatile uint8_t *p = (volatile uint8_t *)ptr;
    while (len-- != 0u) {
        *p++ = 0u;
    }
}

/* Involution that transposes the low eight bit positions across eight words. */
static inline void ortho_u64(uint64_t q[8])
{
#define SWAPN(cl, ch, s, x, y) do { \
    const uint64_t a_ = (x); \
    const uint64_t b_ = (y); \
    (x) = (a_ & UINT64_C(cl)) | ((b_ & UINT64_C(cl)) << (s)); \
    (y) = ((a_ & UINT64_C(ch)) >> (s)) | (b_ & UINT64_C(ch)); \
} while (0)
#define SWAP2(x, y) SWAPN(0x5555555555555555, 0xAAAAAAAAAAAAAAAA, 1, x, y)
#define SWAP4(x, y) SWAPN(0x3333333333333333, 0xCCCCCCCCCCCCCCCC, 2, x, y)
#define SWAP8(x, y) SWAPN(0x0F0F0F0F0F0F0F0F, 0xF0F0F0F0F0F0F0F0, 4, x, y)
    SWAP2(q[0], q[1]);
    SWAP2(q[2], q[3]);
    SWAP2(q[4], q[5]);
    SWAP2(q[6], q[7]);
    SWAP4(q[0], q[2]);
    SWAP4(q[1], q[3]);
    SWAP4(q[4], q[6]);
    SWAP4(q[5], q[7]);
    SWAP8(q[0], q[4]);
    SWAP8(q[1], q[5]);
    SWAP8(q[2], q[6]);
    SWAP8(q[3], q[7]);
#undef SWAP8
#undef SWAP4
#undef SWAP2
#undef SWAPN
}

#define FB_AES_WORD uint64_t
#define FB_AES_SBOX_NAME aes_sbox_bitslice_u64
#include "frogbard_aes_sbox.inc"

static inline void derived_sbox_bitslice(uint64_t words[8], unsigned box_index)
{
    uint64_t q[8];
    uint64_t t[8];
    const uint8_t *pin = FROGBARD_SBOX_PIN[box_index];
    const uint8_t *pout = FROGBARD_SBOX_POUT[box_index];
    const uint8_t inxor = FROGBARD_SBOX_IN_XOR[box_index];
    const uint8_t outxor = FROGBARD_SBOX_OUT_XOR[box_index];

    memcpy(q, words, sizeof(q));
    ortho_u64(q);

    for (unsigned out = 0; out < 8u; ++out) {
        const unsigned src = pin[out];
        const uint64_t mask = ((inxor >> src) & 1u) != 0u ? UINT64_MAX : UINT64_C(0);
        t[out] = q[src] ^ mask;
    }

    aes_sbox_bitslice_u64(t);

    for (unsigned out = 0; out < 8u; ++out) {
        const uint64_t mask = ((outxor >> out) & 1u) != 0u ? UINT64_MAX : UINT64_C(0);
        q[out] = t[pout[out]] ^ mask;
    }

    ortho_u64(q);
    memcpy(words, q, sizeof(q));
}

static inline uint64_t sbox_word_table(uint64_t x, const uint8_t box[256])
{
    uint64_t y = 0;
    y |= (uint64_t)box[(uint8_t)(x      )];
    y |= (uint64_t)box[(uint8_t)(x >>  8)] << 8;
    y |= (uint64_t)box[(uint8_t)(x >> 16)] << 16;
    y |= (uint64_t)box[(uint8_t)(x >> 24)] << 24;
    y |= (uint64_t)box[(uint8_t)(x >> 32)] << 32;
    y |= (uint64_t)box[(uint8_t)(x >> 40)] << 40;
    y |= (uint64_t)box[(uint8_t)(x >> 48)] << 48;
    y |= (uint64_t)box[(uint8_t)(x >> 56)] << 56;
    return y;
}

static inline void quarter_round(uint64_t *a, uint64_t *b, uint64_t *c, uint64_t *d,
                                 unsigned r0, unsigned r1, unsigned r2, unsigned r3)
{
    *a += *b; *d ^= *a; *d = rotl64(*d, r0);
    *c += *d; *b ^= *c; *b = rotl64(*b, r1);
    *a += *b; *d ^= *a; *d = rotl64(*d, r2);
    *c += *d; *b ^= *c; *b = rotl64(*b, r3);
}

static inline void inverse_quarter_round(uint64_t *a, uint64_t *b,
                                         uint64_t *c, uint64_t *d,
                                         unsigned r0, unsigned r1,
                                         unsigned r2, unsigned r3)
{
    *b = rotr64(*b, r3) ^ *c; *c -= *d;
    *d = rotr64(*d, r2) ^ *a; *a -= *b;
    *b = rotr64(*b, r1) ^ *c; *c -= *d;
    *d = rotr64(*d, r0) ^ *a; *a -= *b;
}

static inline const uint8_t *voice_rotations(unsigned voice, unsigned round)
{
    static const uint8_t rot[4][4] = {
        {17, 29, 41, 53},
        {23, 31, 47, 59},
        {11, 37, 43, 57},
        {19, 27, 45, 61}
    };
    return rot[(voice + round) & 3u];
}

static inline void mix_voice(uint64_t x[8], unsigned voice, unsigned round)
{
    const uint8_t *rr = voice_rotations(voice, round);

    quarter_round(&x[0], &x[1], &x[2], &x[3], rr[0], rr[1], rr[2], rr[3]);
    quarter_round(&x[4], &x[5], &x[6], &x[7], rr[1], rr[2], rr[3], rr[0]);
    quarter_round(&x[0], &x[5], &x[2], &x[7], rr[2], rr[3], rr[0], rr[1]);
    quarter_round(&x[4], &x[1], &x[6], &x[3], rr[3], rr[0], rr[1], rr[2]);
}

static inline void inverse_mix_voice(uint64_t x[8], unsigned voice, unsigned round)
{
    const uint8_t *rr = voice_rotations(voice, round);

    inverse_quarter_round(&x[4], &x[1], &x[6], &x[3], rr[3], rr[0], rr[1], rr[2]);
    inverse_quarter_round(&x[0], &x[5], &x[2], &x[7], rr[2], rr[3], rr[0], rr[1]);
    inverse_quarter_round(&x[4], &x[5], &x[6], &x[7], rr[1], rr[2], rr[3], rr[0]);
    inverse_quarter_round(&x[0], &x[1], &x[2], &x[3], rr[0], rr[1], rr[2], rr[3]);
}

#define FROGBARD_PERMUTE8(x, a, b, c, d, e, f, g, h) do { \
    const uint64_t t0_ = (x)[a]; const uint64_t t1_ = (x)[b]; \
    const uint64_t t2_ = (x)[c]; const uint64_t t3_ = (x)[d]; \
    const uint64_t t4_ = (x)[e]; const uint64_t t5_ = (x)[f]; \
    const uint64_t t6_ = (x)[g]; const uint64_t t7_ = (x)[h]; \
    (x)[0] = t0_; (x)[1] = t1_; (x)[2] = t2_; (x)[3] = t3_; \
    (x)[4] = t4_; (x)[5] = t5_; (x)[6] = t6_; (x)[7] = t7_; \
} while (0)

static inline void permute_lanes(uint64_t v[4][8], unsigned round)
{
    if ((round & 1u) == 0u) {
        FROGBARD_PERMUTE8(v[0], 0, 3, 6, 1, 4, 7, 2, 5);
        FROGBARD_PERMUTE8(v[1], 5, 0, 3, 6, 1, 4, 7, 2);
        FROGBARD_PERMUTE8(v[2], 2, 5, 0, 3, 6, 1, 4, 7);
        FROGBARD_PERMUTE8(v[3], 7, 2, 5, 0, 3, 6, 1, 4);
    } else {
        FROGBARD_PERMUTE8(v[0], 1, 6, 3, 0, 5, 2, 7, 4);
        FROGBARD_PERMUTE8(v[1], 4, 1, 6, 3, 0, 5, 2, 7);
        FROGBARD_PERMUTE8(v[2], 7, 4, 1, 6, 3, 0, 5, 2);
        FROGBARD_PERMUTE8(v[3], 2, 7, 4, 1, 6, 3, 0, 5);
    }
}

#undef FROGBARD_PERMUTE8

static inline void inverse_permute8(uint64_t x[8], const uint8_t p[8])
{
    uint64_t tmp[8];
    for (unsigned out = 0; out < 8u; ++out) {
        tmp[p[out]] = x[out];
    }
    memcpy(x, tmp, sizeof(tmp));
}

static inline void inverse_permute_lanes(uint64_t v[4][8], unsigned round)
{
    static const uint8_t even[4][8] = {
        {0,3,6,1,4,7,2,5}, {5,0,3,6,1,4,7,2},
        {2,5,0,3,6,1,4,7}, {7,2,5,0,3,6,1,4}
    };
    static const uint8_t odd[4][8] = {
        {1,6,3,0,5,2,7,4}, {4,1,6,3,0,5,2,7},
        {7,4,1,6,3,0,5,2}, {2,7,4,1,6,3,0,5}
    };
    const uint8_t (*p)[8] = (round & 1u) == 0u ? even : odd;
    for (unsigned voice = 0; voice < 4u; ++voice) {
        inverse_permute8(v[voice], p[voice]);
    }
}

static inline void cross_voice_braid(uint64_t v[4][8], unsigned round)
{
    static const uint8_t ra[8] = { 7, 13, 19, 29, 37, 43, 53, 61 };
    static const uint8_t rb[8] = { 11, 17, 23, 31, 41, 47, 55, 59 };

    if ((round & 1u) == 0u) {
        for (unsigned i = 0; i < 8u; ++i) {
            v[0][i] += rotl64(v[1][(i + 1u) & 7u], ra[i]);
            v[2][i] ^= rotl64(v[0][(i + 3u) & 7u], rb[i]);
            v[3][i] += rotl64(v[2][(i + 5u) & 7u], ra[(i + 2u) & 7u]);
            v[1][i] ^= rotl64(v[3][(i + 7u) & 7u], rb[(i + 4u) & 7u]);
        }
    } else {
        for (unsigned i = 0; i < 8u; ++i) {
            v[3][i] += rotl64(v[2][(i + 2u) & 7u], rb[i]);
            v[1][i] ^= rotl64(v[3][(i + 4u) & 7u], ra[i]);
            v[0][i] += rotl64(v[1][(i + 6u) & 7u], rb[(i + 3u) & 7u]);
            v[2][i] ^= rotl64(v[0][(i + 1u) & 7u], ra[(i + 5u) & 7u]);
        }
    }
}

static inline void inverse_cross_voice_braid(uint64_t v[4][8], unsigned round)
{
    static const uint8_t ra[8] = { 7, 13, 19, 29, 37, 43, 53, 61 };
    static const uint8_t rb[8] = { 11, 17, 23, 31, 41, 47, 55, 59 };

    if ((round & 1u) == 0u) {
        for (unsigned ii = 8u; ii-- != 0u;) {
            const unsigned i = ii;
            v[1][i] ^= rotl64(v[3][(i + 7u) & 7u], rb[(i + 4u) & 7u]);
            v[3][i] -= rotl64(v[2][(i + 5u) & 7u], ra[(i + 2u) & 7u]);
            v[2][i] ^= rotl64(v[0][(i + 3u) & 7u], rb[i]);
            v[0][i] -= rotl64(v[1][(i + 1u) & 7u], ra[i]);
        }
    } else {
        for (unsigned ii = 8u; ii-- != 0u;) {
            const unsigned i = ii;
            v[2][i] ^= rotl64(v[0][(i + 1u) & 7u], ra[(i + 5u) & 7u]);
            v[0][i] -= rotl64(v[1][(i + 6u) & 7u], rb[(i + 3u) & 7u]);
            v[1][i] ^= rotl64(v[3][(i + 4u) & 7u], ra[i]);
            v[3][i] -= rotl64(v[2][(i + 2u) & 7u], rb[i]);
        }
    }
}

static inline void apply_round(uint64_t v[4][8], unsigned round)
{
    for (unsigned voice = 0; voice < 4u; ++voice) {
        for (unsigned lane = 0; lane < 8u; ++lane) {
            v[voice][lane] ^= FROGBARD_RC[round][voice][lane];
        }
#if defined(FROGBARD_USE_BITSLICE_SBOX)
        derived_sbox_bitslice(v[voice], (voice + round) & 3u);
#else
        for (unsigned lane = 0; lane < 8u; ++lane) {
            v[voice][lane] = sbox_word_table(v[voice][lane],
                                             FROGBARD_SBOX[(voice + round) & 3u]);
        }
#endif
        mix_voice(v[voice], voice, round);
    }
    cross_voice_braid(v, round);
    permute_lanes(v, round);
}

static inline void apply_inverse_round(uint64_t v[4][8], unsigned round)
{
    inverse_permute_lanes(v, round);
    inverse_cross_voice_braid(v, round);
    for (unsigned voice = 0; voice < 4u; ++voice) {
        inverse_mix_voice(v[voice], voice, round);
        for (unsigned lane = 0; lane < 8u; ++lane) {
            v[voice][lane] = sbox_word_table(v[voice][lane],
                FROGBARD_SBOX_INV[(voice + round) & 3u]);
            v[voice][lane] ^= FROGBARD_RC[round][voice][lane];
        }
    }
}

static FROGBARD_NOINLINE void frogbard_permute_rounds(uint64_t v[4][8], unsigned rounds)
{
    for (unsigned round = 0; round < rounds; ++round) {
        apply_round(v, round);
    }
}

static FROGBARD_NOINLINE void frogbard_inverse_rounds(uint64_t v[4][8], unsigned rounds)
{
    for (unsigned rr = rounds; rr-- != 0u;) {
        apply_inverse_round(v, rr);
    }
}

void frogbard_permute_reduced(uint64_t state[4][8], unsigned rounds)
{
    if (rounds > FROGBARD_ROUNDS) {
        rounds = FROGBARD_ROUNDS;
    }
    frogbard_permute_rounds(state, rounds);
}

void frogbard_permute_inverse_reduced(uint64_t state[4][8], unsigned rounds)
{
    if (rounds > FROGBARD_ROUNDS) {
        rounds = FROGBARD_ROUNDS;
    }
    frogbard_inverse_rounds(state, rounds);
}

static void add_total_bytes(frogbard_ctx *ctx, size_t len)
{
    const uint64_t old = ctx->total_lo;
    ctx->total_lo += (uint64_t)len;
    if (ctx->total_lo < old) {
        ++ctx->total_hi;
    }
#if SIZE_MAX > UINT64_MAX
    ctx->total_hi += (uint64_t)(len >> 64);
#endif
}

static void absorb_block_rounds(frogbard_ctx *ctx,
                                const uint8_t block[FROGBARD_BLOCK_BYTES],
                                unsigned rounds)
{
    for (unsigned i = 0; i < 8u; ++i) {
        ctx->v[0][i] ^= load64_le(block + 8u * i);
        ctx->v[1][i] ^= load64_le(block + 64u + 8u * i);
    }
    frogbard_permute_rounds(ctx->v, rounds);
}

static void init_rounds(frogbard_ctx *ctx, unsigned rounds)
{
    memset(ctx, 0, sizeof(*ctx));
    memcpy(ctx->v, FROGBARD_IV, sizeof(ctx->v));
    frogbard_permute_rounds(ctx->v, rounds);
}

void frogbard_init(frogbard_ctx *ctx)
{
    init_rounds(ctx, FROGBARD_ROUNDS);
}

static void update_rounds(frogbard_ctx *ctx, const void *data_ptr,
                          size_t len, unsigned rounds)
{
    const uint8_t *data = (const uint8_t *)data_ptr;

    if (len == 0u) {
        return;
    }

    add_total_bytes(ctx, len);

    if (ctx->buffer_len != 0u) {
        const size_t room = FROGBARD_BLOCK_BYTES - ctx->buffer_len;
        const size_t take = len < room ? len : room;
        memcpy(ctx->buffer + ctx->buffer_len, data, take);
        ctx->buffer_len += take;
        data += take;
        len -= take;
        if (ctx->buffer_len == FROGBARD_BLOCK_BYTES) {
            absorb_block_rounds(ctx, ctx->buffer, rounds);
            ctx->buffer_len = 0u;
        }
    }

    while (len >= FROGBARD_BLOCK_BYTES) {
        absorb_block_rounds(ctx, data, rounds);
        data += FROGBARD_BLOCK_BYTES;
        len -= FROGBARD_BLOCK_BYTES;
    }

    if (len != 0u) {
        memcpy(ctx->buffer, data, len);
        ctx->buffer_len = len;
    }
}

void frogbard_update(frogbard_ctx *ctx, const void *data, size_t len)
{
    update_rounds(ctx, data, len, FROGBARD_ROUNDS);
}

static void final_rounds(frogbard_ctx *ctx,
                         uint8_t out[FROGBARD_DIGEST_BYTES],
                         unsigned rounds)
{
    uint8_t final_block[FROGBARD_BLOCK_BYTES];
    memset(final_block, 0, sizeof(final_block));
    memcpy(final_block, ctx->buffer, ctx->buffer_len);

    final_block[ctx->buffer_len] ^= 0x0bu;
    final_block[FROGBARD_BLOCK_BYTES - 1u] ^= 0x80u;
    absorb_block_rounds(ctx, final_block, rounds);

    ctx->v[2][6] ^= ctx->total_lo;
    ctx->v[2][7] ^= ctx->total_hi;
    ctx->v[3][6] ^= UINT64_C(0x496e2046726f6720);
    ctx->v[3][7] ^= UINT64_C(0x7765205472757374);

    for (unsigned i = 0; i < FROGBARD_FINAL_PERMUTATIONS; ++i) {
        ctx->v[3][i] ^= UINT64_C(0x21) << (i * 8u);
        frogbard_permute_rounds(ctx->v, rounds);
    }

    for (unsigned i = 0; i < 8u; ++i) {
        store64_le(out + 8u * i, ctx->v[0][i]);
    }

    secure_zero(final_block, sizeof(final_block));
    secure_zero(ctx, sizeof(*ctx));
}

void frogbard_final(frogbard_ctx *ctx, uint8_t out[FROGBARD_DIGEST_BYTES])
{
    final_rounds(ctx, out, FROGBARD_ROUNDS);
}

void frogbard_hash(const void *data, size_t len, uint8_t out[FROGBARD_DIGEST_BYTES])
{
    frogbard_ctx ctx;
    frogbard_init(&ctx);
    frogbard_update(&ctx, data, len);
    frogbard_final(&ctx, out);
}

void frogbard_hash_reduced(const void *data, size_t len, unsigned rounds,
                           uint8_t out[FROGBARD_DIGEST_BYTES])
{
    frogbard_ctx ctx;
    if (rounds == 0u) {
        rounds = 1u;
    } else if (rounds > FROGBARD_ROUNDS) {
        rounds = FROGBARD_ROUNDS;
    }
    init_rounds(&ctx, rounds);
    update_rounds(&ctx, data, len, rounds);
    final_rounds(&ctx, out, rounds);
}


static bool selftest_sbox_bijective(const uint8_t box[256])
{
    bool seen[256] = {false};
    for (unsigned i = 0; i < 256u; ++i) {
        if (seen[box[i]]) {
            return false;
        }
        seen[box[i]] = true;
    }
    return true;
}

static unsigned selftest_sbox_du(const uint8_t box[256])
{
    unsigned maximum = 0u;
    for (unsigned dx = 1u; dx < 256u; ++dx) {
        unsigned count[256] = {0u};
        for (unsigned x = 0u; x < 256u; ++x) {
            ++count[box[x] ^ box[x ^ dx]];
        }
        for (unsigned dy = 0u; dy < 256u; ++dy) {
            if (count[dy] > maximum) {
                maximum = count[dy];
            }
        }
    }
    return maximum;
}

static uint64_t selftest_prng(uint64_t *state)
{
    uint64_t z = (*state += UINT64_C(0x9e3779b97f4a7c15));
    z = (z ^ (z >> 30)) * UINT64_C(0xbf58476d1ce4e5b9);
    z = (z ^ (z >> 27)) * UINT64_C(0x94d049bb133111eb);
    return z ^ (z >> 31);
}

int frogbard_self_test(void)
{
    for (unsigned box = 0; box < 4u; ++box) {
        if (!selftest_sbox_bijective(FROGBARD_SBOX[box]) ||
            selftest_sbox_du(FROGBARD_SBOX[box]) != 4u) {
            return 1;
        }
        for (unsigned x = 0; x < 256u; ++x) {
            if (FROGBARD_SBOX[box][x] == (uint8_t)x ||
                FROGBARD_SBOX[box][x] == (uint8_t)(x ^ 0xffu) ||
                FROGBARD_SBOX_INV[box][FROGBARD_SBOX[box][x]] != (uint8_t)x) {
                return 2;
            }
        }
        for (unsigned base = 0; base < 256u; base += 64u) {
            uint64_t words[8];
            uint8_t bytes[64];
            for (unsigned i = 0; i < 64u; ++i) {
                bytes[i] = (uint8_t)(base + i);
            }
            memcpy(words, bytes, sizeof(words));
            derived_sbox_bitslice(words, box);
            memcpy(bytes, words, sizeof(words));
            for (unsigned i = 0; i < 64u; ++i) {
                if (bytes[i] != FROGBARD_SBOX[box][base + i]) {
                    return 3;
                }
            }
        }
    }

    static const uint8_t expected_empty[FROGBARD_DIGEST_BYTES] = {
        0x5a,0x6e,0x1f,0x56,0x91,0xb5,0x51,0xd2,0x41,0x50,0x93,0x15,0x14,0x47,0xd6,0x19,
        0xf7,0x19,0xad,0x92,0x0b,0xb8,0x06,0x1f,0x0f,0x88,0xa5,0x86,0xe7,0xa9,0xcf,0x60,
        0xb2,0x08,0x6b,0xc6,0x5d,0x57,0x7d,0xba,0xbc,0xce,0xdd,0x0a,0x47,0xc0,0xad,0xae,
        0xb2,0x52,0x3f,0x95,0x4a,0xc9,0x7a,0xfb,0xdb,0x1a,0x01,0xac,0xaa,0x3d,0xd9,0x61
    };
    static const uint8_t expected_abc[FROGBARD_DIGEST_BYTES] = {
        0xd7,0x34,0x21,0xee,0x14,0x19,0xc7,0xba,0x0a,0x5d,0xa9,0x1d,0x9e,0x72,0x8c,0x5b,
        0x43,0x83,0xe2,0x63,0x37,0xde,0xc3,0xc3,0x77,0xca,0x53,0xf6,0x56,0xb5,0x56,0xb1,
        0x1b,0xc9,0x24,0xb8,0x67,0x71,0x63,0xe8,0x81,0x87,0xa3,0x14,0x81,0xf5,0x53,0xe2,
        0xc1,0xc4,0xab,0xc4,0x8f,0xe2,0x13,0xce,0x11,0xa1,0x20,0x8d,0x71,0x47,0x41,0x13
    };
    uint8_t a[FROGBARD_DIGEST_BYTES];
    uint8_t b[FROGBARD_DIGEST_BYTES];
    frogbard_hash("", 0u, a);
    if (memcmp(a, expected_empty, sizeof(a)) != 0) {
        return 4;
    }
    frogbard_hash("abc", 3u, a);
    if (memcmp(a, expected_abc, sizeof(a)) != 0) {
        return 5;
    }

    frogbard_ctx ctx;
    frogbard_init(&ctx);
    frogbard_update(&ctx, "a", 1u);
    frogbard_update(&ctx, "b", 1u);
    frogbard_update(&ctx, "c", 1u);
    frogbard_final(&ctx, b);
    if (memcmp(a, b, sizeof(a)) != 0) {
        return 6;
    }

    uint8_t message[257];
    for (unsigned i = 0; i < sizeof(message); ++i) {
        message[i] = (uint8_t)(i * 131u + 17u);
    }
    for (size_t len = 0; len <= sizeof(message); ++len) {
        frogbard_hash(message, len, a);
        frogbard_init(&ctx);
        size_t off = 0u;
        while (off < len) {
            size_t take = ((off * 7u) + 1u) % 31u + 1u;
            if (take > len - off) {
                take = len - off;
            }
            frogbard_update(&ctx, message + off, take);
            off += take;
        }
        frogbard_final(&ctx, b);
        if (memcmp(a, b, sizeof(a)) != 0) {
            return 7;
        }
    }

    uint64_t seed = UINT64_C(0x46726f6742617264);
    for (unsigned rounds = 1u; rounds <= FROGBARD_ROUNDS; ++rounds) {
        for (unsigned sample = 0; sample < 8u; ++sample) {
            uint64_t original[4][8];
            uint64_t state[4][8];
            for (unsigned voice = 0; voice < 4u; ++voice) {
                for (unsigned lane = 0; lane < 8u; ++lane) {
                    state[voice][lane] = selftest_prng(&seed);
                }
            }
            memcpy(original, state, sizeof(state));
            frogbard_permute_reduced(state, rounds);
            frogbard_permute_inverse_reduced(state, rounds);
            if (memcmp(original, state, sizeof(state)) != 0) {
                return 8;
            }
        }
    }

    uint8_t batch_messages[4][257];
    uint8_t out4[4][FROGBARD_DIGEST_BYTES];
    for (unsigned j = 0; j < 4u; ++j) {
        for (unsigned i = 0; i < sizeof(batch_messages[j]); ++i) {
            batch_messages[j][i] = (uint8_t)(i * (17u + j * 2u) + 31u * j);
        }
    }
    for (size_t len = 0; len <= sizeof(batch_messages[0]); ++len) {
        frogbard_hash4_equal(batch_messages[0], batch_messages[1],
                             batch_messages[2], batch_messages[3], len, out4);
        for (unsigned j = 0; j < 4u; ++j) {
            frogbard_hash(batch_messages[j], len, a);
            if (memcmp(a, out4[j], sizeof(a)) != 0) {
                return 9;
            }
        }
    }

    secure_zero(batch_messages, sizeof(batch_messages));
    secure_zero(a, sizeof(a));
    secure_zero(b, sizeof(b));
    secure_zero(out4, sizeof(out4));
    return 0;
}

/* Portable fallback; native AVX2 implementation is added in a separate TU. */
#if !defined(FROGBARD_EXTERNAL_HASH4)
void frogbard_hash4_equal(const void *data0, const void *data1,
                          const void *data2, const void *data3, size_t len,
                          uint8_t out[4][FROGBARD_DIGEST_BYTES])
{
    frogbard_hash(data0, len, out[0]);
    frogbard_hash(data1, len, out[1]);
    frogbard_hash(data2, len, out[2]);
    frogbard_hash(data3, len, out[3]);
}

int frogbard_has_avx2_backend(void)
{
    return 0;
}
#endif
