#!/usr/bin/env bash
# FrogBard-512 absurd test harness
# Local research/testing only. Statistical test success is not a security proof.

set -Eeuo pipefail
shopt -s nullglob
umask 077
export LC_ALL=C
export LANG=C

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
if [[ -f "$SCRIPT_DIR/Makefile" && -f "$SCRIPT_DIR/src/frogbard.c" ]]; then
    PROJECT_DIR="$SCRIPT_DIR"
elif [[ -f "$SCRIPT_DIR/../Makefile" && -f "$SCRIPT_DIR/../src/frogbard.c" ]]; then
    PROJECT_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd -P)"
else
    echo "frogbard_absurd_test: project root not found from $SCRIPT_DIR" >&2
    exit 2
fi
SOURCE_DIR="$PROJECT_DIR/src"
PROFILE="full"
INSTALL_MODE="auto"
EXTERNAL_TOOLS=1
KEEP_WORK=0
JOBS="$(getconf _NPROCESSORS_ONLN 2>/dev/null || nproc 2>/dev/null || printf '4')"
OUTPUT_DIR=""
FUZZ_SECONDS=""
AFL_SECONDS=""
PRACTRAND_LIMIT=""
STREAM_BYTES=""
ANALYSIS_SAMPLES=""
STRESS_CASES=""
TREE_REPEATS=""
BENCH_BYTES=""
COLLISION_ATTEMPTS=""

PASS_COUNT=0
FAIL_COUNT=0
SKIP_COUNT=0
WARN_COUNT=0
START_EPOCH="$(date +%s)"

usage() {
    cat <<'USAGE'
FrogBard-512 absurd test harness

Usage:
  tools/frogbard_absurd_test.sh [options]
  ./frogbard_absurd_test.sh [options]   # also works from project root

Profiles:
  --quick              Development smoke test (about minutes)
  --full               Heavy default suite
  --insane             Multi-hour / multi-gigabyte suite

Options:
  --install            Install Ubuntu dependencies with apt-get
  --no-install         Never install packages
  --no-external        Skip PractRand, Dieharder, Valgrind, AFL++, perf
  --jobs N             Parallel jobs/threads (default: detected CPU count)
  --fuzz-seconds N     Override libFuzzer duration
  --afl-seconds N      Override AFL++ duration
  --output DIR         Report directory
  --keep-work          Preserve temporary build/test data
  -h, --help           Show this help

Examples:
  ./tools/frogbard_absurd_test.sh --quick --install
  ./tools/frogbard_absurd_test.sh --full --install --jobs 16
  ./tools/frogbard_absurd_test.sh --insane --install --jobs 32

The script only downloads from Ubuntu repositories and the official PractRand
SourceForge project. It writes a timestamped report directory and continues
through independent failures so you get a complete diagnostic picture.
USAGE
}

while (($#)); do
    case "$1" in
        --quick) PROFILE="quick" ;;
        --full) PROFILE="full" ;;
        --insane) PROFILE="insane" ;;
        --install) INSTALL_MODE="yes" ;;
        --no-install) INSTALL_MODE="no" ;;
        --no-external) EXTERNAL_TOOLS=0 ;;
        --keep-work) KEEP_WORK=1 ;;
        --jobs)
            shift
            [[ ${1:-} =~ ^[1-9][0-9]*$ ]] || { echo "invalid --jobs" >&2; exit 2; }
            JOBS="$1"
            ;;
        --fuzz-seconds)
            shift
            [[ ${1:-} =~ ^[0-9]+$ ]] || { echo "invalid --fuzz-seconds" >&2; exit 2; }
            FUZZ_SECONDS="$1"
            ;;
        --afl-seconds)
            shift
            [[ ${1:-} =~ ^[0-9]+$ ]] || { echo "invalid --afl-seconds" >&2; exit 2; }
            AFL_SECONDS="$1"
            ;;
        --output)
            shift
            [[ -n ${1:-} ]] || { echo "missing --output path" >&2; exit 2; }
            OUTPUT_DIR="$1"
            ;;
        -h|--help) usage; exit 0 ;;
        *) echo "unknown option: $1" >&2; usage >&2; exit 2 ;;
    esac
    shift
done

case "$PROFILE" in
    quick)
        : "${FUZZ_SECONDS:=20}"
        : "${AFL_SECONDS:=20}"
        PRACTRAND_LIMIT="32MB"
        STREAM_BYTES=$((64 * 1024 * 1024))
        ANALYSIS_SAMPLES=512
        STRESS_CASES=5000
        TREE_REPEATS=8
        BENCH_BYTES=$((64 * 1024 * 1024))
        COLLISION_ATTEMPTS=250000
        ;;
    full)
        : "${FUZZ_SECONDS:=600}"
        : "${AFL_SECONDS:=600}"
        PRACTRAND_LIMIT="1GB"
        STREAM_BYTES=$((1024 * 1024 * 1024))
        ANALYSIS_SAMPLES=4096
        STRESS_CASES=100000
        TREE_REPEATS=40
        BENCH_BYTES=$((1024 * 1024 * 1024))
        COLLISION_ATTEMPTS=2000000
        ;;
    insane)
        : "${FUZZ_SECONDS:=3600}"
        : "${AFL_SECONDS:=3600}"
        PRACTRAND_LIMIT="8GB"
        STREAM_BYTES=$((8 * 1024 * 1024 * 1024))
        ANALYSIS_SAMPLES=16384
        STRESS_CASES=1000000
        TREE_REPEATS=200
        BENCH_BYTES=$((8 * 1024 * 1024 * 1024))
        COLLISION_ATTEMPTS=12000000
        ;;
esac

if [[ -z "$OUTPUT_DIR" ]]; then
    OUTPUT_DIR="$PROJECT_DIR/frogbard-test-report-$(date -u +%Y%m%dT%H%M%SZ)"
fi
mkdir -p "$OUTPUT_DIR"/{logs,build,coverage,fuzz,afl,stats,bench,valgrind,artifacts,tools,tmp}
OUTPUT_DIR="$(cd "$OUTPUT_DIR" && pwd -P)"
LOG_FILE="$OUTPUT_DIR/run.log"
SUMMARY_FILE="$OUTPUT_DIR/SUMMARY.txt"
RESULTS_TSV="$OUTPUT_DIR/results.tsv"
WORK_DIR="$OUTPUT_DIR/tmp/work"
TOOLS_DIR="$OUTPUT_DIR/tools"
mkdir -p "$WORK_DIR"
: > "$RESULTS_TSV"

exec > >(tee -a "$LOG_FILE") 2>&1

color() {
    local code="$1"; shift
    if [[ -t 1 ]]; then printf '\033[%sm%s\033[0m' "$code" "$*"; else printf '%s' "$*"; fi
}

section() {
    printf '\n%s\n' "$(color '1;36' "========== $* ==========")"
}

note() { printf '%s %s\n' "$(color '36' '[INFO]')" "$*"; }
warn() { WARN_COUNT=$((WARN_COUNT + 1)); printf '%s %s\n' "$(color '33' '[WARN]')" "$*"; }

safe_name() { printf '%s' "$1" | tr -cs 'A-Za-z0-9._-' '_'; }

record_result() {
    local status="$1" name="$2" rc="$3" seconds="$4" log="$5"
    printf '%s\t%s\t%s\t%s\t%s\n' "$status" "$rc" "$seconds" "$name" "$log" >> "$RESULTS_TSV"
    case "$status" in
        PASS) PASS_COUNT=$((PASS_COUNT + 1)) ;;
        FAIL) FAIL_COUNT=$((FAIL_COUNT + 1)) ;;
        SKIP) SKIP_COUNT=$((SKIP_COUNT + 1)) ;;
    esac
}

run_test() {
    local name="$1"; shift
    local id log start end rc
    id="$(safe_name "$name")"
    log="$OUTPUT_DIR/logs/${id}.log"
    start="$(date +%s)"
    printf '\n%s %s\n' "$(color '1;34' '[RUN ]')" "$name"
    printf 'command:' > "$log"
    printf ' %q' "$@" >> "$log"
    printf '\n\n' >> "$log"
    set +e
    "$@" >> "$log" 2>&1
    rc=$?
    set -e
    end="$(date +%s)"
    if ((rc == 0)); then
        printf '%s %s (%ss)\n' "$(color '1;32' '[PASS]')" "$name" "$((end-start))"
        record_result PASS "$name" "$rc" "$((end-start))" "$log"
        return 0
    fi
    printf '%s %s (rc=%d, %ss) — %s\n' "$(color '1;31' '[FAIL]')" "$name" "$rc" "$((end-start))" "$log"
    record_result FAIL "$name" "$rc" "$((end-start))" "$log"
    return 1
}

run_shell() {
    local name="$1" code="$2"
    run_test "$name" bash -o pipefail -c "$code"
}

skip_test() {
    local name="$1" reason="$2"
    printf '%s %s — %s\n' "$(color '33' '[SKIP]')" "$name" "$reason"
    record_result SKIP "$name" 0 0 "$reason"
}

reclassify_last_failure_as_skip() {
    local name="$1" reason="$2"
    if tail -n 1 "$RESULTS_TSV" | grep -q '^FAIL'; then
        sed -i '$d' "$RESULTS_TSV"
        ((FAIL_COUNT > 0)) && FAIL_COUNT=$((FAIL_COUNT - 1))
    fi
    skip_test "$name" "$reason"
}

sanitizer_runtime_broken() {
    local log="$1"
    grep -Eq '0xffffffffff700450|AddressSanitizer: nested bug|Shadow memory range interleaves|failed to allocate.*shadow|dispatch_queue_offsets|_Block_copy|libclang_rt\.tsan' "$log" 2>/dev/null
}

have() { command -v "$1" >/dev/null 2>&1; }

capture_with_timeout() {
    local seconds="$1"; shift
    timeout --signal=TERM --kill-after=2s "${seconds}s" "$@"
}

cleanup() {
    local rc=$?
    if ((KEEP_WORK == 0)); then
        rm -rf "$WORK_DIR" 2>/dev/null || true
    fi
    return "$rc"
}
trap cleanup EXIT
trap 'warn "interrupted at line $LINENO"' INT TERM

if [[ ! -f "$PROJECT_DIR/Makefile" || ! -f "$SOURCE_DIR/frogbard.c" ]]; then
    echo "Run this script from inside the FrogBard source tree." >&2
    exit 2
fi

install_packages() {
    section "Dependency installation"
    if [[ "$INSTALL_MODE" == "no" ]]; then
        note "Installation disabled by --no-install."
        return 0
    fi
    if [[ "$INSTALL_MODE" == "auto" ]]; then
        if have clang && have ld.lld && have make && have python3; then
            note "Core toolchain already available; optional tools will not be installed automatically. Use --install for everything."
            return 0
        fi
    fi
    if ! have apt-get; then
        warn "apt-get not found; package installation skipped."
        return 0
    fi

    local sudo_cmd=()
    if ((EUID != 0)); then
        if have sudo; then sudo_cmd=(sudo); else warn "sudo is unavailable; package installation skipped."; return 0; fi
    fi

    run_test "apt-get update" "${sudo_cmd[@]}" apt-get -q update || true

    local required=(
        clang lld llvm llvm-dev make python3 python3-dev git curl wget ca-certificates
        build-essential pkg-config cmake ninja-build unzip zip xz-utils jq bc time
        file binutils openssl
    )
    run_test "install required packages" "${sudo_cmd[@]}" apt-get -y -q install "${required[@]}" || true

    local optional=(
        valgrind libc6-dbg hyperfine dieharder afl++ clang-tidy clang-tools
        cppcheck shellcheck strace gdb lcov gcovr b3sum ent rng-tools-debian
        linux-tools-common linux-tools-generic
    )
    local package
    for package in "${optional[@]}"; do
        if apt-cache show "$package" >/dev/null 2>&1; then
            run_test "install optional package $package" "${sudo_cmd[@]}" apt-get -y -q install "$package" || true
        else
            skip_test "install optional package $package" "not present in configured repositories"
        fi
    done
}

install_practrand() {
    if ((EXTERNAL_TOOLS == 0)); then return 0; fi
    if have RNG_test || have practrand-RNG_test; then
        note "PractRand already installed."
        return 0
    fi
    section "PractRand 0.96 local build"
    if ! have curl || ! have unzip || ! have clang++ || ! have llvm-ar; then
        skip_test "PractRand install" "curl/unzip/clang++/llvm-ar unavailable"
        return 0
    fi

    local archive="$TOOLS_DIR/PractRand_0.96.zip"
    local src="$TOOLS_DIR/PractRand_0.96"
    local url="https://downloads.sourceforge.net/project/pracrand/PractRand_0.96.zip"
    run_test "download official PractRand 0.96" curl -fL --retry 4 --retry-delay 2 "$url" -o "$archive" || return 0
    rm -rf "$src"
    mkdir -p "$src"
    run_test "extract PractRand" unzip -q "$archive" -d "$src" || return 0
    local root
    root="$(find "$src" -type d -path '*/include/PractRand' -printf '%h\n' 2>/dev/null | sed 's#/include$##' | head -n1)"
    if [[ -z "$root" ]]; then
        root="$(find "$src" -type f -name 'RNG_test.cpp' -printf '%h\n' | sed 's#/tools$##' | head -n1)"
    fi
    if [[ -z "$root" ]]; then
        skip_test "PractRand build" "archive layout not recognized"
        return 0
    fi
    mkdir -p "$TOOLS_DIR/practrand-bin" "$TOOLS_DIR/practrand-obj"
    mapfile -t pr_sources < <(find "$root/src" -type f -name '*.cpp' -print | sort)
    if ((${#pr_sources[@]} == 0)); then
        skip_test "PractRand build" "no source files found"
        return 0
    fi
    local objects=() source object
    for source in "${pr_sources[@]}"; do
        object="$TOOLS_DIR/practrand-obj/$(printf '%s' "$source" | sha256sum | cut -c1-20).o"
        if ! run_test "PractRand compile $(basename "$source")" clang++ -std=c++17 -O3 -DNDEBUG -I"$root/include" -pthread -c "$source" -o "$object"; then
            return 0
        fi
        objects+=("$object")
    done
    run_test "PractRand archive" llvm-ar rcs "$TOOLS_DIR/libPractRand.a" "${objects[@]}" || return 0
    run_test "PractRand RNG_test link with LLD" clang++ -std=c++17 -O3 -DNDEBUG -I"$root/include" -pthread \
        "$root/tools/RNG_test.cpp" "$TOOLS_DIR/libPractRand.a" -fuse-ld=lld -o "$TOOLS_DIR/practrand-bin/RNG_test" || return 0
    export PATH="$TOOLS_DIR/practrand-bin:$PATH"
}

write_manifest() {
    section "Environment manifest"
    {
        echo "UTC: $(date -u --iso-8601=seconds)"
        echo "Profile: $PROFILE"
        echo "Project: $PROJECT_DIR"
        echo "Output: $OUTPUT_DIR"
        echo "Jobs: $JOBS"
        echo
        uname -a || true
        [[ -r /etc/os-release ]] && cat /etc/os-release
        echo
        lscpu 2>/dev/null || true
        echo
        free -h 2>/dev/null || true
        echo
        df -h "$PROJECT_DIR" "$OUTPUT_DIR" 2>/dev/null || true
        echo
        for cmd in clang clang++ ld.lld llvm-ar llvm-profdata llvm-cov make python3 gcc valgrind hyperfine dieharder RNG_test practrand-RNG_test afl-fuzz afl-clang-lto afl-clang-fast perf cppcheck clang-tidy shellcheck openssl b3sum; do
            if have "$cmd"; then
                printf '\n### %s\n' "$cmd"
                "$cmd" --version 2>&1 | head -n 4 || true
            fi
        done
    } | tee "$OUTPUT_DIR/ENVIRONMENT.txt"
    cp -f "$PROJECT_DIR/TESTVECTORS.txt" "$OUTPUT_DIR/" 2>/dev/null || true
    cp -f "$PROJECT_DIR/TREEVECTORS.txt" "$OUTPUT_DIR/" 2>/dev/null || true
}

build_matrix() {
    section "Clang + LLD build matrix"
    run_test "make clean" make -C "$PROJECT_DIR" clean || true
    run_test "native optimized build" make -C "$PROJECT_DIR" -j"$JOBS" all || true
    [[ -x "$PROJECT_DIR/frogbard" ]] && cp -f "$PROJECT_DIR/frogbard" "$OUTPUT_DIR/build/frogbard-native"

    local spec target binary
    local targets=(
        "portable:frogbard-portable"
        "strict:frogbard-strict"
        "constant-time:frogbard-ct"
        "hardened:frogbard-hardened"
        "debug:frogbard-debug"
        "ubsan:frogbard-ubsan"
        "asan:frogbard-asan"
        "library:libfrogbard.a"
        "portable-library:libfrogbard-portable.a"
        "analysis-tool:frogbard-analyze"
        "fuzz-smoke:frogbard-fuzz-smoke"
    )
    for spec in "${targets[@]}"; do
        target="${spec%%:*}"; binary="${spec#*:}"
        run_test "make $target" make -C "$PROJECT_DIR" -j"$JOBS" "$target" || true
        [[ -e "$PROJECT_DIR/$binary" ]] && cp -f "$PROJECT_DIR/$binary" "$OUTPUT_DIR/build/$binary"
    done

    run_test "Clang static analyzer" make -C "$PROJECT_DIR" clang-analyze || true
    run_test "emit optimized assembly" make -C "$PROJECT_DIR" asm || true
    [[ -f "$PROJECT_DIR/frogbard.s" ]] && cp -f "$PROJECT_DIR/frogbard.s" "$OUTPUT_DIR/build/"

    if have clang-tidy; then
        run_test "clang-tidy core" clang-tidy "$SOURCE_DIR/frogbard.c" "$SOURCE_DIR/frogbard_tree.c" "$SOURCE_DIR/frogbard_cli.c" \
            --checks='clang-analyzer-*,bugprone-*,cert-*,performance-*,portability-*,-cert-err33-c' -- \
            -std=c11 -I"$SOURCE_DIR" -pthread || true
    else
        skip_test "clang-tidy" "not installed"
    fi
    if have cppcheck; then
        run_test "cppcheck exhaustive" cppcheck --enable=warning,style,performance,portability \
            --std=c11 --force --inline-suppr --error-exitcode=1 "$PROJECT_DIR" || true
    else
        skip_test "cppcheck" "not installed"
    fi
}

optimization_matrix() {
    section "Optimizer and backend equivalence"
    local opt out
    for opt in O0 O1 O2 O3 Os Oz; do
        out="$OUTPUT_DIR/build/frogbard-$opt"
        run_test "Clang -$opt scalar build" clang -std=c11 -"$opt" -g -Wall -Wextra -Wpedantic \
            -ffunction-sections -fdata-sections "$SOURCE_DIR/frogbard.c" \
            "$SOURCE_DIR/frogbard_tree.c" "$SOURCE_DIR/frogbard_cli.c" \
            -I"$SOURCE_DIR" -pthread -fuse-ld=lld -Wl,--gc-sections -o "$out" || true
    done

    local digest_ref=""
    local exe digest
    for exe in "$OUTPUT_DIR/build"/frogbard-{native,portable,strict,ct,hardened,debug,ubsan,O0,O1,O2,O3,Os,Oz}; do
        [[ -x "$exe" ]] || continue
        set +e
        digest="$($exe -s 'Eu amo o sapo' 2>/dev/null)"
        local rc=$?
        set -e
        if ((rc != 0)); then
            warn "could not run $exe for equivalence"
            continue
        fi
        if [[ -z "$digest_ref" ]]; then digest_ref="$digest"; fi
        if [[ "$digest" == "$digest_ref" ]]; then
            record_result PASS "digest equivalence $(basename "$exe")" 0 0 "$exe"
            printf '%s %s\n' "$(color '1;32' '[PASS]')" "digest equivalence $(basename "$exe")"
        else
            record_result FAIL "digest equivalence $(basename "$exe")" 1 0 "$exe"
            printf '%s %s\n' "$(color '1;31' '[FAIL]')" "digest mismatch $(basename "$exe")"
        fi
    done
    printf '%s\n' "$digest_ref" > "$OUTPUT_DIR/artifacts/eu_amo_o_sapo.digest"
}

self_tests() {
    section "Self-tests and sanitizer executions"
    local exe
    for exe in "$OUTPUT_DIR/build"/frogbard-{native,portable,strict,ct,hardened,debug,ubsan,O0,O1,O2,O3,Os,Oz}; do
        [[ -x "$exe" ]] || continue
        run_test "self-test $(basename "$exe")" "$exe" --self-test || true
    done

    local asan="$OUTPUT_DIR/build/frogbard-asan"
    if [[ -x "$asan" ]]; then
        local asan_name="ASan + LeakSanitizer self-test"
        if ! ASAN_OPTIONS='detect_leaks=1:halt_on_error=1:strict_string_checks=1:check_initialization_order=1' \
            run_test "$asan_name" "$asan" --self-test; then
            local asan_log="$OUTPUT_DIR/logs/$(safe_name "$asan_name").log"
            if sanitizer_runtime_broken "$asan_log"; then
                reclassify_last_failure_as_skip "$asan_name" "sanitizer runtime/toolchain failed before a useful program diagnosis"
            fi
        fi
    else
        skip_test "ASan self-test" "binary unavailable"
    fi

    local tsan="$OUTPUT_DIR/build/frogbard-tsan"
    local tsan_build_name="build ThreadSanitizer tree binary"
    if run_test "$tsan_build_name" clang -std=c11 -O1 -g3 -fno-omit-frame-pointer \
        -fsanitize=thread "$SOURCE_DIR/frogbard.c" "$SOURCE_DIR/frogbard_tree.c" "$SOURCE_DIR/frogbard_cli.c" \
        -I"$SOURCE_DIR" -pthread -fuse-ld=lld -fsanitize=thread -o "$tsan"; then
        local tf="$WORK_DIR/tsan-tree.bin"
        dd if=/dev/zero of="$tf" bs=1M count=9 status=none
        local tsan_run_name="ThreadSanitizer tree mode"
        if ! TSAN_OPTIONS='halt_on_error=1:second_deadlock_stack=1' run_test "$tsan_run_name" "$tsan" -T "$tf" -j "${JOBS}"; then
            local tsan_run_log="$OUTPUT_DIR/logs/$(safe_name "$tsan_run_name").log"
            if sanitizer_runtime_broken "$tsan_run_log"; then
                reclassify_last_failure_as_skip "$tsan_run_name" "ThreadSanitizer runtime unsupported on this host"
            fi
        fi
    else
        local tsan_build_log="$OUTPUT_DIR/logs/$(safe_name "$tsan_build_name").log"
        if sanitizer_runtime_broken "$tsan_build_log"; then
            reclassify_last_failure_as_skip "$tsan_build_name" "Clang ThreadSanitizer runtime is linked against unavailable libdispatch/Blocks symbols"
        fi
    fi
}

functional_tests() {
    section "CLI, streaming, padding and tree determinism"
    local bin="$OUTPUT_DIR/build/frogbard-native"
    local portable="$OUTPUT_DIR/build/frogbard-portable"
    local ct="$OUTPUT_DIR/build/frogbard-ct"
    [[ -x "$bin" ]] || { skip_test "functional suite" "native binary unavailable"; return; }

    local edge_dir="$WORK_DIR/edges"
    mkdir -p "$edge_dir"
    local lengths=(0 1 2 3 7 8 15 16 31 32 47 48 55 56 63 64 65 95 96 111 112 119 120 121 126 127 128 129 130 191 192 255 256 257 511 512 513 1023 1024 1025 4095 4096 4097 65535 65536 65537 1048575 1048576 1048577)
    local n file d1 d2 d3 ds
    for n in "${lengths[@]}"; do
        file="$edge_dir/edge-$n.bin"
        truncate -s "$n" "$file"
        if ! d1="$(capture_with_timeout 15 "$bin" -f "$file")"; then
            record_result FAIL "file hashing timeout/failure length $n" 124 0 "$file"; continue
        fi
        if ! ds="$(capture_with_timeout 15 "$bin" -f - < "$file")"; then
            record_result FAIL "stdin hashing timeout/failure length $n" 124 0 "$file"; continue
        fi
        [[ "$d1" == "$ds" ]] || { record_result FAIL "stdin equivalence length $n" 1 0 "$file"; continue; }
        if [[ -x "$portable" ]]; then
            if ! d2="$(capture_with_timeout 15 "$portable" -f "$file")"; then record_result FAIL "portable timeout/failure length $n" 124 0 "$file"; continue; fi
            [[ "$d1" == "$d2" ]] || { record_result FAIL "portable equivalence length $n" 1 0 "$file"; continue; }
        fi
        if [[ -x "$ct" ]]; then
            if ! d3="$(capture_with_timeout 15 "$ct" -f "$file")"; then record_result FAIL "constant-time timeout/failure length $n" 124 0 "$file"; continue; fi
            [[ "$d1" == "$d3" ]] || { record_result FAIL "constant-time equivalence length $n" 1 0 "$file"; continue; }
        fi
        record_result PASS "edge length $n" 0 0 "$file"
    done
    note "Edge-size results recorded for ${#lengths[@]} message lengths."

    local unicode_file="$edge_dir/🐸 Presunto e Floquinha — dados.bin"
    printf '\0\377Libertas per Croack!\nPresunto\nFloquinha\nIn Frog we Trust!\0' > "$unicode_file"
    run_test "Unicode filename and embedded NUL bytes" "$bin" -f "$unicode_file" || true
    run_shell "directory input rejected" "! '$bin' -f '$edge_dir'" || true
    run_shell "bad option rejected" "'$bin' --definitely-invalid >/dev/null 2>&1; test \$? -eq 2" || true

    local tree_file="$WORK_DIR/tree-stress.bin"
    dd if=/dev/urandom of="$tree_file" bs=1M count=17 status=none
    dd if=/dev/urandom bs=333 count=1 status=none >> "$tree_file"
    local tree_ref="" thread tree_hash repeat
    local thread_counts=(1 2 3 4 7 8 16 "$JOBS")
    for thread in "${thread_counts[@]}"; do
        ((thread > JOBS * 2)) && continue
        if ! tree_hash="$(capture_with_timeout 120 "$bin" -T "$tree_file" -j "$thread" 2>>"$OUTPUT_DIR/logs/tree-determinism.log")"; then
            record_result FAIL "tree timeout/failure j=$thread" 124 0 "$tree_file"
            continue
        fi
        [[ -n "$tree_ref" ]] || tree_ref="$tree_hash"
        if [[ "$tree_hash" != "$tree_ref" ]]; then
            record_result FAIL "tree determinism j=$thread" 1 0 "$tree_file"
        else
            record_result PASS "tree determinism j=$thread" 0 0 "$tree_file"
        fi
    done
    local tree_ok=1
    for ((repeat=1; repeat<=TREE_REPEATS; repeat++)); do
        thread=$((1 + repeat % (JOBS > 1 ? JOBS : 1)))
        if ! tree_hash="$(capture_with_timeout 120 "$bin" -T "$tree_file" -j "$thread" 2>/dev/null)"; then
            record_result FAIL "tree repeat timeout/failure $repeat" 124 0 "$tree_file"
            tree_ok=0
            break
        fi
        if [[ "$tree_hash" != "$tree_ref" ]]; then
            record_result FAIL "tree repeat $repeat" 1 0 "$tree_file"
            tree_ok=0
            break
        fi
    done
    if ((tree_ok)); then
        record_result PASS "tree repeated determinism x$TREE_REPEATS" 0 0 "$tree_file"
    fi

    cp "$tree_file" "$tree_file.changed"
    printf X | dd of="$tree_file.changed" bs=1 seek=$((8*1024*1024+17)) conv=notrunc status=none
    local changed
    if ! changed="$(capture_with_timeout 120 "$bin" -T "$tree_file.changed" -j "$JOBS" 2>/dev/null)"; then
        record_result FAIL "tree mutation timeout/failure" 124 0 "$tree_file.changed"
        changed="$tree_ref"
    fi
    if [[ "$changed" == "$tree_ref" ]]; then
        record_result FAIL "tree one-bit/byte mutation sensitivity" 1 0 "$tree_file.changed"
    else
        record_result PASS "tree one-byte mutation sensitivity" 0 0 "$tree_file.changed"
    fi

    run_shell "parallel process determinism" "seq 1 $((JOBS*4)) | xargs -P '$JOBS' -I{} '$bin' -f '$tree_file' | sort -u | awk 'END{exit NR!=1}'" || true

    local fifo="$WORK_DIR/frogbard.fifo"
    rm -f "$fifo"; mkfifo "$fifo"
    (cat "$unicode_file" > "$fifo") &
    local fifo_pid=$!
    if ! d1="$(capture_with_timeout 30 "$bin" -f "$fifo")"; then
        kill "$fifo_pid" 2>/dev/null || true
        wait "$fifo_pid" 2>/dev/null || true
        record_result FAIL "FIFO streaming timeout/failure" 124 0 "$fifo"
        return
    fi
    wait "$fifo_pid"
    if ! d2="$(capture_with_timeout 15 "$bin" -f "$unicode_file")"; then
        record_result FAIL "FIFO reference timeout/failure" 124 0 "$unicode_file"
        return
    fi
    if [[ "$d1" == "$d2" ]]; then record_result PASS "FIFO streaming" 0 0 "$fifo"; else record_result FAIL "FIFO streaming" 1 0 "$fifo"; fi
}

write_helper_sources() {
    cat > "$WORK_DIR/frogbard_stream.c" <<'C'
#include "frogbard.h"
#include <errno.h>
#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static void store64le(uint8_t *p, uint64_t x) {
    for (unsigned i = 0; i < 8; ++i) p[i] = (uint8_t)(x >> (8u * i));
}
static uint64_t parse_u64(const char *s) {
    char *end = NULL; errno = 0; unsigned long long x = strtoull(s, &end, 0);
    if (errno || end == s || *end) { fputs("bad byte count\n", stderr); exit(2); }
    return (uint64_t)x;
}
int main(int argc, char **argv) {
    if (argc < 2 || argc > 3) { fprintf(stderr, "usage: %s bytes [counter|xor]\n", argv[0]); return 2; }
    const uint64_t wanted = parse_u64(argv[1]);
    const int xor_mode = argc == 3 && strcmp(argv[2], "xor") == 0;
    uint8_t message[64] = {0}, changed[64], a[64], b[64], out[64];
    memcpy(message + 16, "Libertas per Croack!", 20);
    memcpy(message + 40, "Presunto Floquinha", 18);
    uint64_t written = 0;
    for (uint64_t counter = 0; wanted == 0 || written < wanted; ++counter) {
        store64le(message, counter);
        store64le(message + 8, counter * UINT64_C(0x9e3779b97f4a7c15));
        frogbard_hash(message, sizeof(message), a);
        if (xor_mode) {
            memcpy(changed, message, sizeof(message));
            changed[(counter >> 6) & 63u] ^= (uint8_t)(1u << (counter & 7u));
            frogbard_hash(changed, sizeof(changed), b);
            for (unsigned i = 0; i < 64; ++i) out[i] = a[i] ^ b[i];
        } else memcpy(out, a, sizeof(out));
        size_t n = sizeof(out);
        if (wanted != 0 && wanted - written < n) n = (size_t)(wanted - written);
        if (fwrite(out, 1, n, stdout) != n) return 1;
        written += n;
    }
    return fflush(stdout) == 0 ? 0 : 1;
}
C

    cat > "$WORK_DIR/frogbard_api_stress.c" <<'C'
#include "frogbard.h"
#include <inttypes.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static uint64_t rnd(uint64_t *s) {
    uint64_t z = (*s += UINT64_C(0x9e3779b97f4a7c15));
    z = (z ^ (z >> 30)) * UINT64_C(0xbf58476d1ce4e5b9);
    z = (z ^ (z >> 27)) * UINT64_C(0x94d049bb133111eb);
    return z ^ (z >> 31);
}
static unsigned hd(const uint8_t *a, const uint8_t *b) {
    unsigned n = 0; for (unsigned i=0;i<64;i++) n += (unsigned)__builtin_popcount((unsigned)(a[i]^b[i])); return n;
}
int main(int argc, char **argv) {
    uint64_t cases = argc > 1 ? strtoull(argv[1], 0, 10) : 10000;
    uint64_t seed = UINT64_C(0x46726f6742617264);
    uint8_t *buf = malloc(8192), *copy = malloc(8192);
    if (!buf || !copy) return 2;
    uint8_t one[64], stream[64], changed[64], four[4][64], scalar[4][64];
    uint64_t total = 0, sumsq = 0, avalanche_cases = 0; unsigned min=512, max=0;
    for (uint64_t c=0;c<cases;c++) {
        size_t len = (size_t)(rnd(&seed) % 8193u);
        for (size_t i=0;i<len;i++) buf[i]=(uint8_t)rnd(&seed);
        frogbard_hash(buf,len,one);
        frogbard_ctx ctx; frogbard_init(&ctx);
        size_t pos=0;
        while(pos<len){ size_t n=(size_t)(1u+rnd(&seed)%257u); if(n>len-pos)n=len-pos; frogbard_update(&ctx,buf+pos,n); pos+=n; }
        frogbard_final(&ctx,stream);
        if(memcmp(one,stream,64)){fprintf(stderr,"stream mismatch at case %" PRIu64 "\n",c);return 1;}
        if(len){ memcpy(copy,buf,len); uint64_t bit=rnd(&seed)%(len*8u); copy[bit/8]^=(uint8_t)(1u<<(bit&7u)); frogbard_hash(copy,len,changed); unsigned d=hd(one,changed); total+=d; sumsq+=(uint64_t)d*d; avalanche_cases++; if(d<min)min=d; if(d>max)max=d; }
        const size_t equal_len=(size_t)(rnd(&seed)%2049u);
        uint8_t m[4][2048];
        for(unsigned k=0;k<4;k++){for(size_t i=0;i<equal_len;i++)m[k][i]=(uint8_t)rnd(&seed);frogbard_hash(m[k],equal_len,scalar[k]);}
        frogbard_hash4_equal(m[0],m[1],m[2],m[3],equal_len,four);
        if(memcmp(four,scalar,sizeof(four))){fprintf(stderr,"hash4 mismatch at case %" PRIu64 "\n",c);return 1;}
    }
    double n=(double)(avalanche_cases?avalanche_cases:1), mean=(double)total/n, var=(double)sumsq/n-mean*mean;
    printf("cases=%" PRIu64 " avalanche_mean=%.6f min=%u max=%u stddev=%.6f backend=%s\n",cases,mean,min,max,sqrt(var>0?var:0),frogbard_has_avx2_backend()?"avx2":"scalar");
    free(buf); free(copy); return 0;
}
C

    cat > "$WORK_DIR/frogbard_stream_stats.c" <<'C'
#include <inttypes.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

static int inspect(const char *path) {
    FILE *f = fopen(path, "rb"); if (!f) { perror(path); return 1; }
    uint64_t counts[256] = {0}, n=0, ones=0, sum=0, sumsq=0, pairs=0;
    unsigned char *buf = malloc(1u<<20); if(!buf){fclose(f);return 1;}
    int have_prev=0; unsigned prev=0;
    for (;;) {
        size_t z=fread(buf,1,1u<<20,f);
        for(size_t i=0;i<z;i++){
            unsigned x=buf[i]; counts[x]++; n++; ones+=(uint64_t)__builtin_popcount(x);
            sum+=x; sumsq+=(uint64_t)x*x; if(have_prev)pairs+=(uint64_t)prev*x; prev=x; have_prev=1;
        }
        if(z<(1u<<20)){if(ferror(f)){perror(path);free(buf);fclose(f);return 1;}break;}
    }
    free(buf); fclose(f);
    double entropy=0.0, chi=0.0, expected=n?(double)n/256.0:0.0;
    uint64_t min=UINT64_MAX,max=0;
    for(unsigned i=0;i<256;i++){
        if(counts[i]){double p=(double)counts[i]/(double)n; entropy-=p*log2(p);}
        if(expected){double d=(double)counts[i]-expected;chi+=d*d/expected;}
        if(counts[i]<min)min=counts[i];if(counts[i]>max)max=counts[i];
    }
    double bits=(double)n*8.0, mono=bits?((double)ones-bits/2.0)/sqrt(bits/4.0):0.0;
    double mean=n?(double)sum/(double)n:0.0;
    double var=n?(double)sumsq/(double)n-mean*mean:0.0;
    double serial=(n>1&&var)?((double)pairs/(double)(n-1)-mean*mean)/var:0.0;
    printf("%s bytes=%" PRIu64 " entropy=%.9f chi256=%.6f monobit_z=%.6f serial_corr=%.9f min_byte=%" PRIu64 " max_byte=%" PRIu64 "\n",
           path,n,entropy,chi,mono,serial,min,max);
    return 0;
}
int main(int argc,char **argv){if(argc<2){fprintf(stderr,"usage: %s file...\n",argv[0]);return 2;}int rc=0;for(int i=1;i<argc;i++)rc|=inspect(argv[i]);return rc;}
C

    cat > "$WORK_DIR/afl_driver.c" <<'C'
#include "frogbard.h"
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    const size_t cap = 1u << 20; uint8_t *buf = malloc(cap); if(!buf)return 0;
    size_t n=fread(buf,1,cap,stdin); uint8_t a[64],b[64]; frogbard_hash(buf,n,a);
    frogbard_ctx c; frogbard_init(&c); size_t p=0;
    while(p<n){size_t z=1u+((p*131u+n)%251u);if(z>n-p)z=n-p;frogbard_update(&c,buf+p,z);p+=z;}
    frogbard_final(&c,b); if(memcmp(a,b,64)) abort();
    free(buf); return 0;
}
C
}

helper_tests() {
    section "Deep API stress and full-hash avalanche"
    write_helper_sources
    local stream="$OUTPUT_DIR/build/frogbard-stream"
    local stress="$OUTPUT_DIR/build/frogbard-api-stress"
    local stream_stats="$OUTPUT_DIR/build/frogbard-stream-stats"
    run_test "build raw hash stream generator" clang -std=c11 -O3 -DNDEBUG -march=native -mtune=native \
        -Wall -Wextra -Wpedantic "$SOURCE_DIR/frogbard.c" "$WORK_DIR/frogbard_stream.c" \
        -I"$SOURCE_DIR" -fuse-ld=lld -o "$stream" || true
    run_test "build API stress harness with AVX2" clang -std=c11 -O3 -DNDEBUG -march=native -mtune=native -mavx2 \
        -Wall -Wextra -Wpedantic -DFROGBARD_EXTERNAL_HASH4 "$SOURCE_DIR/frogbard.c" \
        "$SOURCE_DIR/frogbard_avx2.c" "$WORK_DIR/frogbard_api_stress.c" -I"$SOURCE_DIR" \
        -fuse-ld=lld -lm -o "$stress" || true
    run_test "build binary stream statistics tool" clang -std=c11 -O3 -Wall -Wextra -Wpedantic \
        "$WORK_DIR/frogbard_stream_stats.c" -fuse-ld=lld -lm -o "$stream_stats" || true
    [[ -x "$stress" ]] && run_test "API randomized stress ($STRESS_CASES cases)" "$stress" "$STRESS_CASES" || true
}

coverage_tests() {
    section "LLVM source coverage"
    if ! have llvm-profdata || ! have llvm-cov; then skip_test "LLVM coverage" "llvm-profdata/llvm-cov missing"; return; fi
    local covbin="$OUTPUT_DIR/coverage/frogbard-coverage"
    run_test "build LLVM coverage binary" clang -std=c11 -O0 -g3 -fprofile-instr-generate -fcoverage-mapping \
        "$SOURCE_DIR/frogbard.c" "$SOURCE_DIR/frogbard_tree.c" "$SOURCE_DIR/frogbard_cli.c" \
        -I"$SOURCE_DIR" -pthread -fuse-ld=lld -o "$covbin" || return
    export LLVM_PROFILE_FILE="$OUTPUT_DIR/coverage/%p.profraw"
    run_test "coverage self-test" "$covbin" --self-test || true
    local f="$WORK_DIR/coverage-input.bin"
    dd if=/dev/zero of="$f" bs=1M count=3 status=none
    run_test "coverage sequential file" "$covbin" -f "$f" || true
    run_test "coverage tree file" "$covbin" -T "$f" -j 3 || true
    run_test "merge LLVM profiles" llvm-profdata merge -sparse "$OUTPUT_DIR"/coverage/*.profraw -o "$OUTPUT_DIR/coverage/frogbard.profdata" || return
    run_test "LLVM coverage report" bash -c "llvm-cov report '$covbin' -instr-profile='$OUTPUT_DIR/coverage/frogbard.profdata' '$SOURCE_DIR/frogbard.c' '$SOURCE_DIR/frogbard_tree.c' '$SOURCE_DIR/frogbard_cli.c' > '$OUTPUT_DIR/coverage/report.txt'" || true
    run_test "LLVM HTML coverage" llvm-cov show "$covbin" -instr-profile="$OUTPUT_DIR/coverage/frogbard.profdata" \
        -format=html -output-dir="$OUTPUT_DIR/coverage/html" "$SOURCE_DIR/frogbard.c" "$SOURCE_DIR/frogbard_tree.c" "$SOURCE_DIR/frogbard_cli.c" || true
}

valgrind_tests() {
    section "Valgrind memory, race and cache analysis"
    if ((EXTERNAL_TOOLS == 0)) || ! have valgrind; then skip_test "Valgrind suite" "disabled or unavailable"; return; fi
    local dbg="$OUTPUT_DIR/build/frogbard-debug"
    [[ -x "$dbg" ]] || { skip_test "Valgrind suite" "debug binary unavailable"; return; }
    local f="$WORK_DIR/valgrind.bin"
    dd if=/dev/zero of="$f" bs=1M count=5 status=none
    run_test "Valgrind Memcheck self-test" valgrind --tool=memcheck --leak-check=full --show-leak-kinds=all \
        --track-origins=yes --errors-for-leak-kinds=definite,indirect --error-exitcode=99 "$dbg" --self-test || true
    run_test "Valgrind Memcheck streaming file" valgrind --tool=memcheck --leak-check=full --track-origins=yes \
        --error-exitcode=99 "$dbg" -f "$f" || true
    run_test "Valgrind Helgrind tree" valgrind --tool=helgrind --history-level=approx --error-exitcode=99 \
        "$dbg" -T "$f" -j 4 || true
    run_test "Valgrind DRD tree" valgrind --tool=drd --check-stack-var=yes --error-exitcode=99 \
        "$dbg" -T "$f" -j 4 || true
    run_test "Valgrind Cachegrind" valgrind --tool=cachegrind --cachegrind-out-file="$OUTPUT_DIR/valgrind/cachegrind.out" \
        "$dbg" -f "$f" || true
    if have cg_annotate && [[ -f "$OUTPUT_DIR/valgrind/cachegrind.out" ]]; then
        run_shell "Cachegrind annotation" "cg_annotate '$OUTPUT_DIR/valgrind/cachegrind.out' > '$OUTPUT_DIR/valgrind/cachegrind.txt'" || true
    fi
    run_test "Valgrind Massif tree" valgrind --tool=massif --massif-out-file="$OUTPUT_DIR/valgrind/massif.out" \
        "$dbg" -T "$f" -j 4 || true
    if have ms_print && [[ -f "$OUTPUT_DIR/valgrind/massif.out" ]]; then
        run_shell "Massif report" "ms_print '$OUTPUT_DIR/valgrind/massif.out' > '$OUTPUT_DIR/valgrind/massif.txt'" || true
    fi
}

fuzz_tests() {
    section "Coverage-guided fuzzing"
    local corpus="$OUTPUT_DIR/fuzz/corpus"
    mkdir -p "$corpus" "$OUTPUT_DIR/fuzz/artifacts"
    : > "$corpus/empty"
    printf abc > "$corpus/abc"
    printf 'Libertas per Croack!' > "$corpus/libertas"
    printf 'Presunto\0Floquinha\0In Frog we Trust!' > "$corpus/forest"
    dd if=/dev/urandom of="$corpus/random-128" bs=128 count=1 status=none
    dd if=/dev/urandom of="$corpus/random-4096" bs=4096 count=1 status=none

    run_test "build libFuzzer + ASan + UBSan" make -C "$PROJECT_DIR" fuzz || true
    local fuzzer="$PROJECT_DIR/frogbard-fuzz"
    if [[ -x "$fuzzer" ]]; then
        cp -f "$fuzzer" "$OUTPUT_DIR/build/"
        local fuzz_name="libFuzzer ${FUZZ_SECONDS}s"
        if ! ASAN_OPTIONS='detect_leaks=1:halt_on_error=1' UBSAN_OPTIONS='halt_on_error=1:print_stacktrace=1' \
            run_test "$fuzz_name" "$fuzzer" "$corpus" \
            -max_total_time="$FUZZ_SECONDS" -max_len=1048576 -timeout=10 -rss_limit_mb=4096 \
            -artifact_prefix="$OUTPUT_DIR/fuzz/artifacts/" -print_final_stats=1; then
            local fuzz_log="$OUTPUT_DIR/logs/$(safe_name "$fuzz_name").log"
            if sanitizer_runtime_broken "$fuzz_log"; then
                reclassify_last_failure_as_skip "$fuzz_name" "ASan/libFuzzer runtime unsupported on this host"
            fi
        fi
    else
        skip_test "libFuzzer run" "fuzzer binary unavailable"
    fi

    if ((EXTERNAL_TOOLS == 0)); then skip_test "AFL++" "external tools disabled"; return; fi
    local aflcc=""
    if have afl-clang-lto; then aflcc="$(command -v afl-clang-lto)"; elif have afl-clang-fast; then aflcc="$(command -v afl-clang-fast)"; fi
    if [[ -z "$aflcc" ]] || ! have afl-fuzz; then skip_test "AFL++" "afl-clang-lto/fast or afl-fuzz unavailable"; return; fi
    local afl_target="$OUTPUT_DIR/build/frogbard-afl"
    run_test "build AFL++ instrumented target" "$aflcc" -std=c11 -O1 -g \
        "$SOURCE_DIR/frogbard.c" "$WORK_DIR/afl_driver.c" -I"$SOURCE_DIR" -o "$afl_target" || return
    mkdir -p "$OUTPUT_DIR/afl/in" "$OUTPUT_DIR/afl/out"
    cp -f "$corpus"/* "$OUTPUT_DIR/afl/in/"
    AFL_SKIP_CPUFREQ=1 AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES=1 AFL_NO_UI=1 \
        run_test "AFL++ ${AFL_SECONDS}s" afl-fuzz -V "$AFL_SECONDS" -m none -t 2000+ \
        -i "$OUTPUT_DIR/afl/in" -o "$OUTPUT_DIR/afl/out" -- "$afl_target" || true
}

cryptanalysis_smoke() {
    section "Reduced-round cryptanalysis smoke suite"
    local analyze="$OUTPUT_DIR/build/frogbard-analyze"
    [[ -x "$analyze" ]] || analyze="$PROJECT_DIR/frogbard-analyze"
    [[ -x "$analyze" ]] || { skip_test "reduced-round analysis" "analysis tool unavailable"; return; }

    run_shell "all-round avalanche CSV" "'$analyze' --all '$ANALYSIS_SAMPLES' > '$OUTPUT_DIR/stats/round-metrics.csv'" || true
    run_shell "inverse stress" "'$analyze' --inverse '$ANALYSIS_SAMPLES' > '$OUTPUT_DIR/stats/inverse.txt'" || true
    local rounds samples masks diffs
    if [[ "$PROFILE" == quick ]]; then samples=512; masks=32; diffs=16; else samples=8192; masks=256; diffs=128; fi
    [[ "$PROFILE" == insane ]] && { samples=65536; masks=2048; diffs=1024; }
    for rounds in 1 2 3 4 6 8 12 16; do
        run_shell "linear scan r=$rounds" "'$analyze' --linear-scan '$rounds' '$samples' '$masks' > '$OUTPUT_DIR/stats/linear-r$rounds.txt'" || true
        run_shell "differential scan r=$rounds" "'$analyze' --differential-scan '$rounds' '$samples' '$diffs' > '$OUTPUT_DIR/stats/differential-r$rounds.txt'" || true
        run_shell "invariant scan r=$rounds" "'$analyze' --invariants '$rounds' > '$OUTPUT_DIR/stats/invariants-r$rounds.txt'" || true
    done
    for rounds in 1 2 3 4 6 8 12 16; do
        run_shell "truncated collision r=$rounds/32-bit" "'$analyze' --collision '$rounds' 32 '$COLLISION_ATTEMPTS' > '$OUTPUT_DIR/stats/collision-r$rounds.txt'" || true
    done
}

statistical_tests() {
    section "Digest stream statistical batteries"
    local stream="$OUTPUT_DIR/build/frogbard-stream"
    [[ -x "$stream" ]] || { skip_test "statistical streams" "stream generator unavailable"; return; }
    local raw="$OUTPUT_DIR/stats/counter-stream.bin"
    local xor="$OUTPUT_DIR/stats/differential-stream.bin"

    if ((STREAM_BYTES > 2147483648)) && [[ "$PROFILE" == insane ]]; then
        note "Insane profile will pipe 8 GiB to PractRand but stores 4 GiB for file-based tests."
    fi
    run_test "generate counter hash stream ($(numfmt --to=iec "$STREAM_BYTES" 2>/dev/null || echo "$STREAM_BYTES bytes"))" \
        bash -c "'$stream' '$STREAM_BYTES' counter > '$raw'" || true
    run_test "generate one-bit differential stream" bash -c "'$stream' '$STREAM_BYTES' xor > '$xor'" || true

    local stream_stats="$OUTPUT_DIR/build/frogbard-stream-stats"
    if [[ -x "$stream_stats" ]]; then
        run_shell "internal byte/bit statistics" "'$stream_stats' '$raw' '$xor' | tee '$OUTPUT_DIR/stats/internal-statistics.txt'" || true
    else
        skip_test "internal byte/bit statistics" "statistics helper unavailable"
    fi
    local rngtest=""
    if have RNG_test; then rngtest="$(command -v RNG_test)"; elif have practrand-RNG_test; then rngtest="$(command -v practrand-RNG_test)"; fi
    if ((EXTERNAL_TOOLS == 1)) && [[ -n "$rngtest" ]]; then
        run_shell "PractRand counter stream to $PRACTRAND_LIMIT" "'$stream' 0 counter | '$rngtest' stdin64 -tlmin '$PRACTRAND_LIMIT' -tlmax '$PRACTRAND_LIMIT' > '$OUTPUT_DIR/stats/practrand-counter.txt'" || true
        run_shell "PractRand differential stream to $PRACTRAND_LIMIT" "'$stream' 0 xor | '$rngtest' stdin64 -tlmin '$PRACTRAND_LIMIT' -tlmax '$PRACTRAND_LIMIT' > '$OUTPUT_DIR/stats/practrand-differential.txt'" || true
    else
        skip_test "PractRand" "disabled or unavailable"
    fi

    if ((EXTERNAL_TOOLS == 1)) && have dieharder; then
        if [[ "$PROFILE" == quick ]]; then
            run_shell "Dieharder birthdays counter" "dieharder -g 201 -f '$raw' -d 0 > '$OUTPUT_DIR/stats/dieharder-counter.txt'" || true
            run_shell "Dieharder birthdays differential" "dieharder -g 201 -f '$xor' -d 0 > '$OUTPUT_DIR/stats/dieharder-differential.txt'" || true
        else
            run_shell "Dieharder full counter battery" "dieharder -g 201 -f '$raw' -a > '$OUTPUT_DIR/stats/dieharder-counter.txt'" || true
            run_shell "Dieharder full differential battery" "dieharder -g 201 -f '$xor' -a > '$OUTPUT_DIR/stats/dieharder-differential.txt'" || true
        fi
    else
        skip_test "Dieharder" "disabled or unavailable"
    fi
    if have ent; then
        run_shell "ENT counter stream" "ent '$raw' > '$OUTPUT_DIR/stats/ent-counter.txt'" || true
        run_shell "ENT differential stream" "ent '$xor' > '$OUTPUT_DIR/stats/ent-differential.txt'" || true
    fi
}

hardening_tests() {
    section "Binary hardening and object inspection"
    local bin="$OUTPUT_DIR/build/frogbard-hardened"
    [[ -x "$bin" ]] || { skip_test "hardening inspection" "hardened binary unavailable"; return; }
    run_shell "ELF headers" "readelf -W -h -l -d -s '$bin' > '$OUTPUT_DIR/artifacts/readelf-hardened.txt'" || true
    run_shell "PIE enabled" "readelf -h '$bin' | grep -q 'Type:.*DYN'" || true
    run_shell "RELRO enabled" "readelf -l '$bin' | grep -q GNU_RELRO" || true
    run_shell "BIND_NOW enabled" "readelf -d '$bin' | grep -Eq 'BIND_NOW|FLAGS.*NOW'" || true
    run_shell "non-executable stack" "readelf -W -l '$bin' | awk '/GNU_STACK/{if(\$NF ~ /E/) exit 1; found=1} END{exit !found}'" || true
    run_shell "stack protector linked" "nm -D '$bin' | grep -q __stack_chk_fail" || true
    run_shell "no unexpected RPATH" "! readelf -d '$bin' | grep -Eq 'RPATH|RUNPATH'" || true
    run_shell "symbol inventory" "nm -an '$bin' > '$OUTPUT_DIR/artifacts/nm-hardened.txt'" || true
    run_shell "AVX2 opcode inventory" "objdump -d -M intel '$OUTPUT_DIR/build/frogbard-native' | awk '/v(px|por|pand|pshuf|perm|xor)/ { if (++n <= 100) print }' > '$OUTPUT_DIR/artifacts/avx2-opcodes.txt'" || true
}

reproducibility_tests() {
    section "Generated constants and reproducible builds"
    if [[ -x "$PROJECT_DIR/tools/gen_tables.py" || -f "$PROJECT_DIR/tools/gen_tables.py" ]]; then
        local before="$WORK_DIR/frogbard_tables.before"
        cp "$SOURCE_DIR/frogbard_tables.h" "$before"
        run_test "regenerate constants from four phrases" python3 "$PROJECT_DIR/tools/gen_tables.py" || true
        run_test "generated tables are byte-identical" cmp -s "$before" "$SOURCE_DIR/frogbard_tables.h" || true
    fi
    local a="$WORK_DIR/repro-a" b="$WORK_DIR/repro-b"
    run_test "repro build A" env SOURCE_DATE_EPOCH=1700000000 clang -std=c11 -O3 -DNDEBUG \
        -ffile-prefix-map="$PROJECT_DIR"=. "$SOURCE_DIR/frogbard.c" "$SOURCE_DIR/frogbard_tree.c" "$SOURCE_DIR/frogbard_cli.c" \
        -I"$SOURCE_DIR" -pthread -fuse-ld=lld -Wl,--build-id=none -o "$a" || true
    run_test "repro build B" env SOURCE_DATE_EPOCH=1700000000 clang -std=c11 -O3 -DNDEBUG \
        -ffile-prefix-map="$PROJECT_DIR"=. "$SOURCE_DIR/frogbard.c" "$SOURCE_DIR/frogbard_tree.c" "$SOURCE_DIR/frogbard_cli.c" \
        -I"$SOURCE_DIR" -pthread -fuse-ld=lld -Wl,--build-id=none -o "$b" || true
    [[ -f "$a" && -f "$b" ]] && run_test "bit-for-bit reproducible binary" cmp -s "$a" "$b" || true
}

benchmark_tests() {
    section "Performance, cache and scaling"
    local bin="$OUTPUT_DIR/build/frogbard-native"
    local ct="$OUTPUT_DIR/build/frogbard-ct"
    local portable="$OUTPUT_DIR/build/frogbard-portable"
    [[ -x "$bin" ]] || { skip_test "benchmarks" "native binary unavailable"; return; }
    local f="$WORK_DIR/benchmark.bin"
    run_test "create benchmark file" truncate -s "$BENCH_BYTES" "$f" || return

    if have hyperfine; then
        local commands=("'$bin' -f '$f' >/dev/null")
        [[ -x "$portable" ]] && commands+=("'$portable' -f '$f' >/dev/null")
        [[ -x "$ct" ]] && commands+=("'$ct' -f '$f' >/dev/null")
        for j in 1 2 4 8 16 "$JOBS"; do
            ((j > JOBS * 2)) && continue
            commands+=("'$bin' -T '$f' -j '$j' >/dev/null 2>/dev/null")
        done
        have openssl && commands+=("openssl dgst -sha512 '$f' >/dev/null" "openssl dgst -sha3-512 '$f' >/dev/null" "openssl dgst -blake2b512 '$f' >/dev/null")
        have b3sum && commands+=("b3sum '$f' >/dev/null")
        run_test "hyperfine benchmark matrix" hyperfine --warmup 1 --runs 5 --export-json "$OUTPUT_DIR/bench/hyperfine.json" \
            --export-markdown "$OUTPUT_DIR/bench/hyperfine.md" "${commands[@]}" || true
    else
        skip_test "hyperfine" "not installed"
    fi
    run_shell "GNU time sequential" "/usr/bin/time -v '$bin' -f '$f' >/dev/null 2> '$OUTPUT_DIR/bench/time-sequential.txt'" || true
    run_shell "GNU time tree" "/usr/bin/time -v '$bin' -T '$f' -j '$JOBS' >/dev/null 2> '$OUTPUT_DIR/bench/time-tree.txt'" || true

    if ((EXTERNAL_TOOLS == 1)) && have perf; then
        run_shell "perf stat sequential" "perf stat -r 3 -e cycles,instructions,branches,branch-misses,cache-references,cache-misses '$bin' -f '$f' >/dev/null 2> '$OUTPUT_DIR/bench/perf-sequential.txt'" || true
        run_shell "perf stat tree" "perf stat -r 3 -e cycles,instructions,branches,branch-misses,cache-references,cache-misses '$bin' -T '$f' -j '$JOBS' >/dev/null 2> '$OUTPUT_DIR/bench/perf-tree.txt'" || true
    else
        skip_test "perf stat" "disabled or unavailable"
    fi
    run_shell "binary sizes" "size '$OUTPUT_DIR/build'/frogbard-* > '$OUTPUT_DIR/bench/binary-sizes.txt'" || true
}

resource_limit_tests() {
    section "Resource limits and hostile operating conditions"
    local bin="$OUTPUT_DIR/build/frogbard-portable"
    [[ -x "$bin" ]] || bin="$OUTPUT_DIR/build/frogbard-native"
    [[ -x "$bin" ]] || return
    local f="$WORK_DIR/limits.bin"
    truncate -s $((32*1024*1024)) "$f"
    run_shell "small stack sequential" "ulimit -s 256; '$bin' -f '$f' >/dev/null" || true
    run_shell "small stack tree" "ulimit -s 512; '$bin' -T '$f' -j 4 >/dev/null 2>/dev/null" || true
    run_shell "limited virtual memory sequential" "ulimit -v 262144; '$bin' -f '$f' >/dev/null" || true
    run_shell "read-only project execution" "chmod -R a-w '$WORK_DIR'; '$bin' -s abc >/dev/null; chmod -R u+w '$WORK_DIR'" || true
}

report_summary() {
    section "Summary"
    local end elapsed
    end="$(date +%s)"; elapsed=$((end - START_EPOCH))
    {
        echo "FrogBard-512 absurd test report"
        echo "UTC finished: $(date -u --iso-8601=seconds)"
        echo "Profile: $PROFILE"
        echo "Elapsed seconds: $elapsed"
        echo "PASS: $PASS_COUNT"
        echo "FAIL: $FAIL_COUNT"
        echo "SKIP: $SKIP_COUNT"
        echo "WARN: $WARN_COUNT"
        echo "Report directory: $OUTPUT_DIR"
        echo
        echo "Important: implementation/statistical tests do not prove collision, preimage,"
        echo "second-preimage, indifferentiability, or structural cryptanalytic security."
        echo
        echo "Failed tests:"
        awk -F '\t' '$1=="FAIL" {print "- " $4 " (rc=" $2 ") log=" $5}' "$RESULTS_TSV" || true
        echo
        echo "Skipped tests:"
        awk -F '\t' '$1=="SKIP" {print "- " $4 " — " $5}' "$RESULTS_TSV" || true
    } | tee "$SUMMARY_FILE"
    printf '\n%s\n' "$(color '1;35' "Report: $OUTPUT_DIR")"
    if ((FAIL_COUNT > 0)); then return 1; fi
    return 0
}

main() {
    note "FrogBard absurd suite profile=$PROFILE jobs=$JOBS"
    note "Results will be written to $OUTPUT_DIR"
    install_packages
    install_practrand
    write_manifest
    build_matrix
    optimization_matrix
    self_tests
    functional_tests
    helper_tests
    coverage_tests
    valgrind_tests
    fuzz_tests
    cryptanalysis_smoke
    statistical_tests
    hardening_tests
    reproducibility_tests
    benchmark_tests
    resource_limit_tests
    report_summary
}

main "$@"
