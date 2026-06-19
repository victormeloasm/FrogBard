# FrogBard-512 v0.3-experimental specification

## 1. Status

FrogBard-512 is an experimental 512-bit hash construction. This document describes the implementation in this repository. It does not make a production-security claim.

## 2. Byte and word conventions

All external words are decoded and encoded as unsigned 64-bit little-endian integers. The digest is 64 bytes.

The internal state is:

```text
V[4][8]
```

with four voices, eight 64-bit words per voice, and 2048 total state bits.

## 3. Parameters

```text
rate              1024 bits (voices 0 and 1)
capacity          1024 bits (voices 2 and 3)
message block      128 bytes
output              64 bytes
rounds              16
extra final calls    2
```

## 4. Constant generation

The phrases are exact UTF-8/ASCII byte strings without a trailing newline:

```text
Libertas per Croack!
Presunto
Floquinha
In Frog we Trust!
```

`tools/gen_tables.py` is the normative generator for v0.3 constants. It emits `frogbard_tables.h`.

Each S-box is generated from an AES S-box with:

```text
S(x) = Pout(AES(Pin(x XOR cin))) XOR cout
```

where `Pin` and `Pout` are bit permutations. Candidate affine variants with a fixed point `S(x)=x` or opposite fixed point `S(x)=x XOR 0xff` are skipped.

## 5. Round function

For round `r = 0..15` and voice `v = 0..3`:

1. XOR `RC[r][v][lane]` into all eight lanes.
2. Apply S-box `(v+r) mod 4` independently to every byte.
3. Apply four ARX quarter-rounds to the voice.

After all voices:

4. Apply the parity-dependent cross-voice braid.
5. Apply the parity-dependent lane permutation.

The exact operation order, rotations, indices and constants are normative in `frogbard.c`.

## 6. Inverse permutation

Every round step is bijective:

- round-constant XOR is self-inverse;
- every CroackBox is bijective;
- modular additions invert with subtraction;
- rotations invert with opposite rotations;
- lane permutations use inverse index maps;
- the cross-voice braid is undone in reverse operation order.

`frogbard_permute_inverse_reduced()` implements the exact inverse for any prefix of 1 through 16 rounds.

## 7. Sequential hashing

Initialization copies the generated 2048-bit IV and applies one full permutation.

For each 128-byte message block:

```text
V[0][0..7] XOR= block[0..63]
V[1][0..7] XOR= block[64..127]
P(V)
```

Final padding is sponge-style:

```text
remaining || 0x0b || zeroes || final-byte XOR 0x80
```

After absorbing the final block, the 128-bit byte count is injected into `V[2][6..7]`. The ASCII-derived final domain is injected into `V[3][6..7]`. Two additional full permutations are applied with a small per-call marker. The output is voice 0 encoded as 64 little-endian bytes.

## 8. Tree hashing

Tree mode is a distinct domain and does not equal sequential hashing.

### 8.1 Leaf

Chunk size is 1,048,576 bytes. Leaf input is:

```text
16-byte domain "FrogBardTreeL1\0\0"
LE64(chunk_index)
LE64(chunk_length)
chunk_bytes
```

The empty file has one zero-length leaf.

### 8.2 Parent

Every parent input is exactly 160 bytes:

```text
16-byte domain "FrogBardTreeP1\0\0"
LE64(level)
LE64(child_count)             # 1 or 2
left_digest[64]
right_digest[64]              # zero when child_count = 1
```

### 8.3 Root binding

The final root input is exactly 112 bytes:

```text
16-byte domain "FrogBardTreeR1\0\0"
LE64(file_size)
LE64(chunk_size)
LE64(leaf_count)
LE64(tree_height)
internal_root_digest[64]
```

The FrogBard-512 digest of this structure is the tree digest.

## 9. Implementation profiles

### Default scalar

Uses four 256-byte byte tables. Total S-box footprint is 1 KiB.

### Constant-time scalar

Uses a bitsliced Boolean circuit and the generated affine metadata. It produces identical outputs to the table profile.

### AVX2 four-way

Processes four independent equal-length messages in the four 64-bit lanes of each 256-bit vector. It is used by native tree mode and is output-compatible with four scalar calls.

## 10. Security scope

The 1024-bit capacity and 512-bit output define intended generic targets, but the custom permutation has not been independently analyzed. No security level should be inferred merely from state size, output size, avalanche measurements, or S-box properties.
