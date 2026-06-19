#include "frogbard.h"

#include <stddef.h>
#include <stdint.h>
#include <string.h>

int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);

int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
{
    uint8_t one_shot[FROGBARD_DIGEST_BYTES];
    uint8_t streamed[FROGBARD_DIGEST_BYTES];
    frogbard_hash(data, size, one_shot);

    frogbard_ctx ctx;
    frogbard_init(&ctx);
    size_t offset = 0u;
    while (offset < size) {
        size_t chunk = 1u + ((offset * 17u + size) % 257u);
        if (chunk > size - offset) {
            chunk = size - offset;
        }
        frogbard_update(&ctx, data + offset, chunk);
        offset += chunk;
    }
    frogbard_final(&ctx, streamed);
    if (memcmp(one_shot, streamed, sizeof(one_shot)) != 0) {
        __builtin_trap();
    }
    return 0;
}


#ifdef FROGBARD_FUZZ_STANDALONE
#include <stdio.h>
#include <stdlib.h>

static uint64_t fuzz_rng(uint64_t *s)
{
    uint64_t x = *s;
    x ^= x << 13;
    x ^= x >> 7;
    x ^= x << 17;
    *s = x;
    return x;
}

int main(void)
{
    uint64_t seed = UINT64_C(0x46726f6746757a7a);
    uint8_t *buffer = (uint8_t *)malloc(65536u);
    if (buffer == NULL) {
        return 2;
    }
    for (unsigned run = 0; run < 10000u; ++run) {
        const size_t len = (size_t)(fuzz_rng(&seed) & 65535u);
        for (size_t i = 0; i < len; ++i) {
            buffer[i] = (uint8_t)fuzz_rng(&seed);
        }
        (void)LLVMFuzzerTestOneInput(buffer, len);
    }
    free(buffer);
    puts("fuzz smoke: 10000 inputs OK");
    return 0;
}
#endif
