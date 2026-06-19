#include "frogbard.h"

#include <errno.h>
#include <inttypes.h>
#include <math.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    double avalanche_avg;
    unsigned avalanche_min;
    unsigned avalanche_max;
    double rotational_avg;
    double linear_bias;
} round_metrics;

static uint64_t prng64(uint64_t *state)
{
    uint64_t z = (*state += UINT64_C(0x9e3779b97f4a7c15));
    z = (z ^ (z >> 30)) * UINT64_C(0xbf58476d1ce4e5b9);
    z = (z ^ (z >> 27)) * UINT64_C(0x94d049bb133111eb);
    return z ^ (z >> 31);
}

static unsigned popcount_state(const uint64_t a[4][8], const uint64_t b[4][8])
{
    unsigned count = 0u;
    for (unsigned voice = 0; voice < 4u; ++voice) {
        for (unsigned lane = 0; lane < 8u; ++lane) {
            count += (unsigned)__builtin_popcountll(a[voice][lane] ^ b[voice][lane]);
        }
    }
    return count;
}

static unsigned parity_masked(const uint64_t state[4][8], const uint64_t mask[4][8])
{
    unsigned parity = 0u;
    for (unsigned voice = 0; voice < 4u; ++voice) {
        for (unsigned lane = 0; lane < 8u; ++lane) {
            parity ^= (unsigned)__builtin_parityll(state[voice][lane] & mask[voice][lane]);
        }
    }
    return parity & 1u;
}

static uint64_t rotl64_local(uint64_t x, unsigned n)
{
    return (x << n) | (x >> (64u - n));
}

static void random_state(uint64_t state[4][8], uint64_t *seed)
{
    for (unsigned voice = 0; voice < 4u; ++voice) {
        for (unsigned lane = 0; lane < 8u; ++lane) {
            state[voice][lane] = prng64(seed);
        }
    }
}

static int inverse_test(unsigned samples)
{
    uint64_t seed = UINT64_C(0x496e766572736521);
    for (unsigned rounds = 1u; rounds <= FROGBARD_MAX_ROUNDS; ++rounds) {
        for (unsigned sample = 0; sample < samples; ++sample) {
            uint64_t original[4][8];
            uint64_t state[4][8];
            random_state(state, &seed);
            memcpy(original, state, sizeof(state));
            frogbard_permute_reduced(state, rounds);
            frogbard_permute_inverse_reduced(state, rounds);
            if (memcmp(original, state, sizeof(state)) != 0) {
                fprintf(stderr, "inverse failure: rounds=%u sample=%u\n",
                        rounds, sample);
                return -1;
            }
        }
    }
    return 0;
}

static round_metrics measure_round(unsigned rounds, unsigned samples)
{
    uint64_t seed = UINT64_C(0x46726f67416e616c) ^ rounds;
    uint64_t total_avalanche = 0u;
    uint64_t total_rotational = 0u;
    unsigned minimum = 2048u;
    unsigned maximum = 0u;

    uint64_t input_mask[4][8];
    uint64_t output_mask[4][8];
    random_state(input_mask, &seed);
    random_state(output_mask, &seed);
    unsigned linear_ones = 0u;

    for (unsigned sample = 0; sample < samples; ++sample) {
        uint64_t base[4][8];
        uint64_t changed[4][8];
        uint64_t rotated[4][8];
        uint64_t base_out[4][8];
        uint64_t changed_out[4][8];
        uint64_t rotated_out[4][8];

        random_state(base, &seed);
        memcpy(changed, base, sizeof(base));
        memcpy(rotated, base, sizeof(base));

        const unsigned bit = (unsigned)(prng64(&seed) % 2048u);
        changed[bit / 512u][(bit / 64u) & 7u] ^= UINT64_C(1) << (bit & 63u);
        const unsigned rotation = 1u + (unsigned)(prng64(&seed) % 63u);
        for (unsigned voice = 0; voice < 4u; ++voice) {
            for (unsigned lane = 0; lane < 8u; ++lane) {
                rotated[voice][lane] = rotl64_local(rotated[voice][lane], rotation);
            }
        }

        memcpy(base_out, base, sizeof(base));
        memcpy(changed_out, changed, sizeof(changed));
        memcpy(rotated_out, rotated, sizeof(rotated));
        frogbard_permute_reduced(base_out, rounds);
        frogbard_permute_reduced(changed_out, rounds);
        frogbard_permute_reduced(rotated_out, rounds);

        const unsigned distance = popcount_state(base_out, changed_out);
        total_avalanche += distance;
        if (distance < minimum) minimum = distance;
        if (distance > maximum) maximum = distance;

        uint64_t rotated_base_out[4][8];
        for (unsigned voice = 0; voice < 4u; ++voice) {
            for (unsigned lane = 0; lane < 8u; ++lane) {
                rotated_base_out[voice][lane] =
                    rotl64_local(base_out[voice][lane], rotation);
            }
        }
        total_rotational += popcount_state(rotated_out, rotated_base_out);

        const unsigned relation = parity_masked(base, input_mask) ^
                                  parity_masked(base_out, output_mask);
        linear_ones += relation;
    }

    const double n = (double)samples;
    const double expected_half = n / 2.0;
    round_metrics metrics = {
        .avalanche_avg = (double)total_avalanche / n,
        .avalanche_min = minimum,
        .avalanche_max = maximum,
        .rotational_avg = (double)total_rotational / n,
        .linear_bias = fabs((double)linear_ones - expected_half) / n
    };
    return metrics;
}

static uint32_t digest_prefix(const uint8_t digest[FROGBARD_DIGEST_BYTES],
                              unsigned bits)
{
    uint32_t value = (uint32_t)digest[0] |
                     ((uint32_t)digest[1] << 8) |
                     ((uint32_t)digest[2] << 16) |
                     ((uint32_t)digest[3] << 24);
    return bits == 32u ? value : value & ((UINT32_C(1) << bits) - 1u);
}

static int collision_smoke(unsigned rounds, unsigned bits, uint32_t limit)
{
    if (bits < 8u || bits > 32u || rounds == 0u ||
        rounds > FROGBARD_MAX_ROUNDS) {
        fputs("collision parameters: rounds=1..16, bits=8..32\n", stderr);
        return 2;
    }
    size_t capacity = 1u;
    while (capacity < (size_t)limit * 2u) {
        if (capacity > SIZE_MAX / 2u) {
            return 2;
        }
        capacity *= 2u;
    }
    uint32_t *keys = (uint32_t *)malloc(capacity * sizeof(*keys));
    uint8_t *used = (uint8_t *)calloc(capacity, 1u);
    if (keys == NULL || used == NULL) {
        free(keys); free(used);
        return 2;
    }

    uint8_t digest[FROGBARD_DIGEST_BYTES];
    uint8_t message[16] = {0};
    for (uint32_t i = 0; i < limit; ++i) {
        memcpy(message, &i, sizeof(i));
        frogbard_hash_reduced(message, sizeof(message), rounds, digest);
        const uint32_t key = digest_prefix(digest, bits);
        size_t slot = ((size_t)key * UINT64_C(11400714819323198485)) & (capacity - 1u);
        while (used[slot] != 0u) {
            if (keys[slot] == key) {
                printf("truncated collision: rounds=%u bits=%u attempts=%" PRIu32
                       " prefix=%08" PRIx32 "\n", rounds, bits, i + 1u, key);
                free(keys); free(used);
                return 0;
            }
            slot = (slot + 1u) & (capacity - 1u);
        }
        used[slot] = 1u;
        keys[slot] = key;
    }
    printf("no truncated collision within %" PRIu32
           " attempts (rounds=%u bits=%u)\n", limit, rounds, bits);
    free(keys); free(used);
    return 0;
}


static int linear_scan(unsigned rounds, unsigned samples, unsigned masks)
{
    if (rounds == 0u || rounds > FROGBARD_MAX_ROUNDS ||
        samples == 0u || masks == 0u) {
        return 2;
    }
    uint64_t seed = UINT64_C(0x4c696e6561725363) ^ rounds;
    double best_bias = 0.0;
    unsigned best_input = 0u;
    unsigned best_output = 0u;

    for (unsigned m = 0; m < masks; ++m) {
        const unsigned input_bit = (unsigned)(prng64(&seed) % 2048u);
        const unsigned output_bit = (unsigned)(prng64(&seed) % 2048u);
        unsigned ones = 0u;
        for (unsigned sample = 0; sample < samples; ++sample) {
            uint64_t state[4][8];
            random_state(state, &seed);
            const unsigned in_value = (unsigned)((state[input_bit / 512u]
                [(input_bit / 64u) & 7u] >> (input_bit & 63u)) & 1u);
            frogbard_permute_reduced(state, rounds);
            const unsigned out_value = (unsigned)((state[output_bit / 512u]
                [(output_bit / 64u) & 7u] >> (output_bit & 63u)) & 1u);
            ones += in_value ^ out_value;
        }
        const double bias = fabs((double)ones - (double)samples / 2.0) /
                            (double)samples;
        if (bias > best_bias) {
            best_bias = bias;
            best_input = input_bit;
            best_output = output_bit;
        }
    }

    printf("linear scan: rounds=%u samples=%u masks=%u strongest_abs_bias=%.8f input_bit=%u output_bit=%u\n",
           rounds, samples, masks, best_bias, best_input, best_output);
    return 0;
}

static int differential_scan(unsigned rounds, unsigned samples,
                             unsigned differences)
{
    if (rounds == 0u || rounds > FROGBARD_MAX_ROUNDS ||
        samples == 0u || differences == 0u) {
        return 2;
    }
    uint64_t seed = UINT64_C(0x446966665363616e) ^ rounds;
    double best_bias = 0.0;
    unsigned best_input = 0u;
    unsigned best_output = 0u;

    uint32_t *counts = (uint32_t *)calloc(2048u, sizeof(*counts));
    if (counts == NULL) {
        return 2;
    }

    for (unsigned d = 0; d < differences; ++d) {
        memset(counts, 0, 2048u * sizeof(*counts));
        const unsigned input_bit = (unsigned)(prng64(&seed) % 2048u);
        for (unsigned sample = 0; sample < samples; ++sample) {
            uint64_t a[4][8];
            uint64_t b[4][8];
            random_state(a, &seed);
            memcpy(b, a, sizeof(a));
            b[input_bit / 512u][(input_bit / 64u) & 7u] ^=
                UINT64_C(1) << (input_bit & 63u);
            frogbard_permute_reduced(a, rounds);
            frogbard_permute_reduced(b, rounds);
            for (unsigned voice = 0; voice < 4u; ++voice) {
                for (unsigned lane = 0; lane < 8u; ++lane) {
                    uint64_t diff = a[voice][lane] ^ b[voice][lane];
                    const unsigned base = voice * 512u + lane * 64u;
                    while (diff != 0u) {
                        const unsigned bit = (unsigned)__builtin_ctzll(diff);
                        ++counts[base + bit];
                        diff &= diff - 1u;
                    }
                }
            }
        }
        for (unsigned output_bit = 0; output_bit < 2048u; ++output_bit) {
            const double probability = (double)counts[output_bit] / (double)samples;
            const double bias = fabs(probability - 0.5);
            if (bias > best_bias) {
                best_bias = bias;
                best_input = input_bit;
                best_output = output_bit;
            }
        }
    }

    printf("differential scan: rounds=%u samples=%u differences=%u strongest_bit_bias=%.8f input_bit=%u output_bit=%u\n",
           rounds, samples, differences, best_bias, best_input, best_output);
    free(counts);
    return 0;
}

static int invariant_smoke(unsigned rounds)
{
    if (rounds == 0u || rounds > FROGBARD_MAX_ROUNDS) {
        return 2;
    }
    uint64_t patterns[4][4][8] = {{{0}}};
    for (unsigned voice = 0; voice < 4u; ++voice) {
        for (unsigned lane = 0; lane < 8u; ++lane) {
            patterns[1][voice][lane] = UINT64_MAX;
            patterns[2][voice][lane] = UINT64_C(0x0123456789abcdef);
            patterns[3][voice][lane] = UINT64_C(1) << lane;
        }
    }
    for (unsigned p = 0; p < 4u; ++p) {
        uint64_t state[4][8];
        memcpy(state, patterns[p], sizeof(state));
        frogbard_permute_reduced(state, rounds);
        bool all_voices_equal = true;
        bool all_lanes_equal = true;
        for (unsigned voice = 1; voice < 4u; ++voice) {
            if (memcmp(state[0], state[voice], sizeof(state[0])) != 0) {
                all_voices_equal = false;
            }
        }
        for (unsigned voice = 0; voice < 4u; ++voice) {
            for (unsigned lane = 1; lane < 8u; ++lane) {
                if (state[voice][lane] != state[voice][0]) {
                    all_lanes_equal = false;
                }
            }
        }
        printf("invariant smoke: rounds=%u pattern=%u equal_voices=%s equal_lanes=%s\n",
               rounds, p, all_voices_equal ? "yes" : "no",
               all_lanes_equal ? "yes" : "no");
    }
    return 0;
}

static unsigned parse_unsigned(const char *text, unsigned fallback)
{
    char *end = NULL;
    errno = 0;
    const unsigned long value = strtoul(text, &end, 10);
    if (errno != 0 || end == text || *end != '\0' || value > UINT32_MAX) {
        return fallback;
    }
    return (unsigned)value;
}

static void usage(const char *argv0)
{
    fprintf(stderr,
        "Usage:\n"
        "  %s --all [samples]\n"
        "  %s --inverse [samples]\n"
        "  %s --linear-scan rounds samples masks\n"
        "  %s --differential-scan rounds samples differences\n"
        "  %s --invariants rounds\n"
        "  %s --collision rounds bits attempts\n",
        argv0, argv0, argv0, argv0, argv0, argv0);
}

int main(int argc, char **argv)
{
    if (argc >= 2 && strcmp(argv[1], "--inverse") == 0) {
        const unsigned samples = argc >= 3 ? parse_unsigned(argv[2], 64u) : 64u;
        if (inverse_test(samples) != 0) {
            return 1;
        }
        printf("inverse: OK (%u samples per round, rounds 1..16)\n", samples);
        return 0;
    }
    if (argc >= 2 && strcmp(argv[1], "--all") == 0) {
        const unsigned samples = argc >= 3 ? parse_unsigned(argv[2], 512u) : 512u;
        if (samples == 0u || inverse_test(samples < 64u ? samples : 64u) != 0) {
            return 1;
        }
        puts("round,avalanche_avg,avalanche_min,avalanche_max,rotational_distance_avg,linear_abs_bias");
        for (unsigned rounds = 1u; rounds <= FROGBARD_MAX_ROUNDS; ++rounds) {
            const round_metrics m = measure_round(rounds, samples);
            printf("%u,%.3f,%u,%u,%.3f,%.6f\n",
                   rounds, m.avalanche_avg, m.avalanche_min,
                   m.avalanche_max, m.rotational_avg, m.linear_bias);
        }
        return 0;
    }
    if (argc == 5 && strcmp(argv[1], "--linear-scan") == 0) {
        return linear_scan(parse_unsigned(argv[2], 0u),
                           parse_unsigned(argv[3], 0u),
                           parse_unsigned(argv[4], 0u));
    }
    if (argc == 5 && strcmp(argv[1], "--differential-scan") == 0) {
        return differential_scan(parse_unsigned(argv[2], 0u),
                                 parse_unsigned(argv[3], 0u),
                                 parse_unsigned(argv[4], 0u));
    }
    if (argc == 3 && strcmp(argv[1], "--invariants") == 0) {
        return invariant_smoke(parse_unsigned(argv[2], 0u));
    }
    if (argc == 5 && strcmp(argv[1], "--collision") == 0) {
        const unsigned rounds = parse_unsigned(argv[2], 0u);
        const unsigned bits = parse_unsigned(argv[3], 0u);
        const unsigned attempts = parse_unsigned(argv[4], 0u);
        return collision_smoke(rounds, bits, attempts);
    }
    usage(argv[0]);
    return 2;
}
