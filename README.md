# FrogBard-512

**FrogBard-512 v0.3-experimental** is a cache-friendly, streaming 512-bit hash research prototype written in low-level C11.

> **Security warning:** this is a new, unpublished design with no independent cryptanalysis. It is a research prototype, not a replacement for SHA-512, SHA-3, BLAKE2, or BLAKE3 in production.

## Build: Clang + LLD

Requirements: Clang, LLD, GNU Make, POSIX threads.

```bash
make
make test
```

The native build uses:

```text
clang -O3 -march=native -mtune=native -flto=thin -fuse-ld=lld
```

Useful targets:

```bash
make portable          # no native ISA requirement; scalar four-way fallback
make strict            # all warnings become errors
make constant-time     # bitsliced scalar CroackBox + AVX2 four-way backend
make test-sanitize     # UBSan self-test
make asan              # AddressSanitizer build (runtime support depends on host)
make hardened          # PIE, RELRO, NOW, noexecstack, stack protector
make library           # native libfrogbard.a
make portable-library  # portable scalar library
make analysis-tool     # frogbard-analyze
make analyze           # reduced-round CSV measurements
make clang-analyze     # Clang Static Analyzer
make fuzz              # build libFuzzer harness
make fuzz-smoke        # 10,000 deterministic randomized inputs
make asm               # optimized Intel-syntax assembly
```

## CLI

Hash a string:

```bash
./frogbard -s "Libertas per Croack!"
```

Hash a file with the normal streaming mode:

```bash
./frogbard -f archive.tar
```

Hash standard input:

```bash
printf abc | ./frogbard -f -
```

Hash a regular file with the parallel tree mode:

```bash
./frogbard -T archive.tar
./frogbard -T archive.tar -j 16
```

The tree digest is intentionally different from the sequential digest. It is a separately domain-separated mode.

Inspect the compiled four-way backend:

```bash
./frogbard --backend
```

Run internal tests:

```bash
./frogbard --self-test
```

## Current construction

- Digest: 512 bits
- Internal state: 2048 bits (`4 × 8 × uint64_t`)
- Sponge rate: 1024 bits
- Capacity: 1024 bits
- Block size: 128 bytes
- Main permutation: 16 rounds
- Finalization: two extra full permutations
- Operations: byte S-boxes, XOR, modular addition, rotations, fixed lane permutations
- Explicit little-endian encoding
- No dynamic allocation in the sequential hash core
- Streaming API and one-shot API

The normal scalar build uses four 256-byte S-box tables. The complete 1 KiB S-box set is designed to remain resident in L1 cache. The `constant-time` target replaces scalar table accesses with an equivalent bitsliced Boolean circuit. Both paths produce identical digests. The default table path is optimized for ordinary unkeyed hashing; use the bitsliced target when data-dependent cache access is undesirable.

## Four derived CroackBoxes

The public derivation phrases are:

1. `Libertas per Croack!`
2. `Presunto`
3. `Floquinha`
4. `In Frog we Trust!`

Each resulting S-box is affine-equivalent to the AES S-box. The derivation deterministically chooses input/output bit permutations and XOR constants, rejecting candidates with fixed or opposite-fixed points. The phrases are public constants, not keys.

`tools/gen_tables.py` reproduces:

- the four S-boxes and their inverses;
- the affine metadata used by the bitsliced path;
- round constants;
- the initial state.

## AVX2 four-way backend

The native build contains a genuine AVX2 backend for four equal-length messages. Each 256-bit vector lane carries one independent FrogBard state, so the backend preserves the scalar algorithm exactly.

The public function is:

```c
void frogbard_hash4_equal(
    const void *data0,
    const void *data1,
    const void *data2,
    const void *data3,
    size_t len,
    uint8_t out[4][FROGBARD_DIGEST_BYTES]
);
```

The parallel tree mode uses this backend for four full leaves or four parent nodes at a time. Portable builds transparently use four scalar calls.

## Parallel tree mode

Tree mode uses 1 MiB leaves and distinct encodings for:

- leaf nodes;
- parent nodes;
- final root binding.

The root binds the file length, chunk size, leaf count, and tree height. Leaf hashing is distributed among POSIX worker threads with `pread()`. Full groups of four leaves use the AVX2 backend.

Tree mode is intended for large regular files. The normal `-f` mode remains streaming and works with stdin.

## Research and analysis tools

Build:

```bash
make analysis-tool
```

Run reduced-round measurements:

```bash
./frogbard-analyze --all 512
```

The CSV output includes:

- average/minimum/maximum state avalanche after a one-bit input difference;
- rotational-relation distance;
- sampled linear absolute bias;
- all round counts from 1 through 16.

Test the exact inverse:

```bash
./frogbard-analyze --inverse 128
```

Scan sampled one-bit linear correlations and differential bit biases:

```bash
./frogbard-analyze --linear-scan 4 8192 128
./frogbard-analyze --differential-scan 4 4096 64
./frogbard-analyze --invariants 4
```

Run a deliberately truncated collision smoke test:

```bash
./frogbard-analyze --collision 4 24 200000
```

A truncated collision is expected by the birthday bound and says nothing by itself about the full 512-bit construction. These tools are exploratory, not proofs.

## Test coverage

The self-test checks:

- S-box bijectivity;
- differential uniformity 4;
- absence of fixed and opposite-fixed points;
- inverse S-box correctness;
- bitsliced/table equivalence for all 256 byte values in all four boxes;
- fixed digest vectors;
- streaming/one-shot equivalence;
- padding boundaries and arbitrary chunking;
- exact permutation inversion for rounds 1 through 16;
- AVX2/scalar four-way equivalence.

`make test` also checks tree determinism across thread counts and verifies that a one-byte file modification changes the tree root. UBSan and the Clang Static Analyzer passed in the development environment. The ASan binary builds, but the container's Clang 17 ASan runtime crashes before entering `main()` at `0xffffffffff700450`; therefore ASan execution is not claimed as passing here. The included deterministic fuzz smoke test completed 10,000 inputs.

## Performance snapshot from the development container

For a 64 MiB zero-filled file:

```text
v0.2 sequential table path:      ~1.40 s
v0.3 sequential table path:      ~1.17 s
v0.3 scalar bitsliced path:      ~2.15 s
v0.3 tree, 8 threads + AVX2:     ~0.11 s
```

These are local measurements, not portable guarantees. Disk cache, CPU, compiler, thread count, and virtualization affect the result.

## Files

```text
frogbard.c                 scalar core, inverse and self-tests
frogbard_avx2.c            AVX2 four-way backend
frogbard_cli.c             command-line interface
frogbard_tree.c/.h         parallel tree mode
frogbard.h                 public API
frogbard_tables.h          generated constants and S-boxes
frogbard_aes_sbox.inc      bitsliced Boolean circuit
SPEC.md                    construction and tree encoding
TESTVECTORS.txt            sequential vectors
TREEVECTORS.txt            tree-mode vectors
ANALYSIS.csv               1..16-round statistical smoke measurements
ANALYSIS_NOTES.txt         sampled scan and inverse-test notes
tools/gen_tables.py        deterministic constant generator
tools/frogbard_analyze.c   reduced-round analysis utility
tools/fuzz_frogbard.c      libFuzzer harness
```

## Design status

Passing statistical smoke tests does not establish collision, preimage, second-preimage, indifferentiability, or related-key security. The most valuable next work is independent review, automated differential/linear trail search, invariant-subspace analysis, rotational cryptanalysis, SAT/SMT/MILP modeling, and attacks on reduced variants.

**Libertas per Croack!**
