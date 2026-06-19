# Changelog

## FrogBard-512 v0.3-experimental

- Reorganized the project into scalar core, CLI, tree mode and AVX2 backend translation units.
- Added an exact bitsliced implementation of all four derived CroackBoxes.
- Added full equivalence tests between bitsliced and table S-box paths for all 256 inputs.
- Added a genuine AVX2 four-way equal-length hashing backend.
- Added a portable scalar fallback for the four-way API.
- Added a parallel 1 MiB tree-file mode with separate leaf, parent and root domains.
- Added POSIX worker threads and `pread()` leaf processing.
- Added exact inverse functions for reduced permutations from 1 through 16 rounds.
- Added `frogbard-analyze` with avalanche, rotational, sampled linear-bias, inverse and truncated-collision experiments.
- Added a libFuzzer streaming-equivalence harness.
- Added inverse S-box tables and emitted affine S-box metadata from the deterministic generator.
- Added `SPEC.md`, tree-mode vectors and third-party notices.
- Preserved every v0.1/v0.2 sequential digest vector.
- Made the normal scalar path table-based for best single-stream speed while retaining `make constant-time` for the bitsliced scalar profile.
- Improved the 64 MiB sequential benchmark from approximately 1.40 s in v0.2 to approximately 1.20 s in this development environment.
- Added generated `ANALYSIS.csv` and `ANALYSIS_NOTES.txt` artifacts.
- Corrected the tree mutation regression test so it compares the original partial-tail file against the same file with exactly one byte changed.

## FrogBard-512 v0.2-experimental

- Switched the default build to Clang with LLD.
- Added ThinLTO and native CPU tuning to the normal release target.
- Added portable, strict, debug, UBSan, ASan, hardened, static-library,
  assembly-output, and Clang static-analysis targets.
- Added a public C header and library build mode.
- Froze the four S-boxes, round constants, and IV as aligned `static const` data.
- Removed mutable global table initialization and its multithreaded data race.
- Added a deterministic table regeneration tool.
- Replaced byte-by-byte little-endian loads/stores with portable `memcpy` operations.
- Unrolled fixed lane permutations.
- Added standard-input hashing through `frogbard -f -`.

## FrogBard-512 v0.1-experimental

- Initial research prototype.
