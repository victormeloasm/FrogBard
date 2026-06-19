CC      := clang
AR      := llvm-ar
RANLIB  := llvm-ranlib

SRC_DIR   := src
TOOLS_DIR := tools

CPPFLAGS ?=
CPPFLAGS += -I$(SRC_DIR)

WARNINGS := -Wall -Wextra -Wpedantic -Wshadow -Wconversion -Wsign-conversion \
            -Wformat=2 -Wundef -Wstrict-prototypes -Wmissing-prototypes
COMMON   := -std=c11 $(WARNINGS)
OPT      := -O3 -DNDEBUG
NATIVE   := -march=native -mtune=native
LTO      := -flto=thin
LLD      := -fuse-ld=lld
SECTIONS := -ffunction-sections -fdata-sections
GC       := -Wl,--gc-sections
THREADS  := -pthread

CFLAGS  ?=
LDFLAGS ?=
LDLIBS  ?=

CORE_SRC := $(SRC_DIR)/frogbard.c
AVX2_SRC := $(SRC_DIR)/frogbard_avx2.c
TREE_SRC := $(SRC_DIR)/frogbard_tree.c
CLI_SRC  := $(SRC_DIR)/frogbard_cli.c

CORE_HDR := $(SRC_DIR)/frogbard.h \
            $(SRC_DIR)/frogbard_tables.h \
            $(SRC_DIR)/frogbard_aes_sbox.inc
TREE_HDR := $(SRC_DIR)/frogbard_tree.h

CORE_DEPS := $(CORE_SRC) $(CORE_HDR)
CLI_DEPS  := $(CLI_SRC) $(TREE_SRC) $(TREE_HDR) $(CORE_DEPS)

.PHONY: all clean test portable strict debug ubsan asan test-sanitize hardened \
        library portable-library regen-tables asm analyze analysis-tool clang-analyze fuzz \
        constant-time table fuzz-smoke info package

all: frogbard

frogbard-core.o: $(CORE_DEPS)
	$(CC) $(CPPFLAGS) $(COMMON) $(OPT) $(NATIVE) $(LTO) $(SECTIONS) \
		-DFROGBARD_EXTERNAL_HASH4 $(CFLAGS) -c $(CORE_SRC) -o $@

frogbard-avx2.o: $(AVX2_SRC) $(CORE_HDR)
	$(CC) $(CPPFLAGS) $(COMMON) $(OPT) $(NATIVE) -mavx2 $(LTO) $(SECTIONS) \
		$(CFLAGS) -c $(AVX2_SRC) -o $@

frogbard-tree.o: $(TREE_SRC) $(TREE_HDR) $(SRC_DIR)/frogbard.h
	$(CC) $(CPPFLAGS) $(COMMON) $(OPT) $(NATIVE) $(LTO) $(SECTIONS) \
		$(THREADS) $(CFLAGS) -c $(TREE_SRC) -o $@

frogbard-cli.o: $(CLI_SRC) $(SRC_DIR)/frogbard.h $(TREE_HDR)
	$(CC) $(CPPFLAGS) $(COMMON) $(OPT) $(NATIVE) $(LTO) $(SECTIONS) \
		$(CFLAGS) -c $(CLI_SRC) -o $@

frogbard: frogbard-core.o frogbard-avx2.o frogbard-tree.o frogbard-cli.o
	$(CC) $^ -o $@ $(LLD) $(LTO) $(GC) $(THREADS) $(LDFLAGS) $(LDLIBS)

portable: $(CLI_DEPS)
	$(CC) $(CPPFLAGS) $(COMMON) $(OPT) $(LTO) $(SECTIONS) $(CFLAGS) \
		$(CORE_SRC) $(TREE_SRC) $(CLI_SRC) -o frogbard-portable \
		$(LLD) $(LTO) $(GC) $(THREADS) $(LDFLAGS) $(LDLIBS)

strict: $(CLI_DEPS) $(AVX2_SRC)
	$(CC) $(CPPFLAGS) $(COMMON) -Werror $(OPT) $(NATIVE) -mavx2 $(LTO) \
		$(SECTIONS) -DFROGBARD_EXTERNAL_HASH4 $(CFLAGS) \
		$(CORE_SRC) $(AVX2_SRC) $(TREE_SRC) $(CLI_SRC) \
		-o frogbard-strict $(LLD) $(LTO) $(GC) $(THREADS) $(LDFLAGS) $(LDLIBS)

debug: $(CLI_DEPS)
	$(CC) $(CPPFLAGS) $(COMMON) -O0 -g3 -fno-omit-frame-pointer $(CFLAGS) \
		$(CORE_SRC) $(TREE_SRC) $(CLI_SRC) -o frogbard-debug \
		$(LLD) $(THREADS) $(LDFLAGS) $(LDLIBS)

ubsan: $(CLI_DEPS)
	$(CC) $(CPPFLAGS) $(COMMON) -O1 -g3 -fno-omit-frame-pointer \
		-fsanitize=undefined -fno-sanitize-recover=all $(CFLAGS) \
		$(CORE_SRC) $(TREE_SRC) $(CLI_SRC) -o frogbard-ubsan \
		$(LLD) $(THREADS) -fsanitize=undefined $(LDFLAGS) $(LDLIBS)

asan: $(CLI_DEPS)
	$(CC) $(CPPFLAGS) $(COMMON) -O1 -g3 -fno-omit-frame-pointer \
		-fsanitize=address -fno-sanitize-recover=all $(CFLAGS) \
		$(CORE_SRC) $(TREE_SRC) $(CLI_SRC) -o frogbard-asan \
		$(LLD) $(THREADS) -fsanitize=address $(LDFLAGS) $(LDLIBS)

test-sanitize: ubsan
	UBSAN_OPTIONS=print_stacktrace=1:halt_on_error=1 ./frogbard-ubsan --self-test

hardened: $(CLI_DEPS) $(AVX2_SRC)
	$(CC) $(CPPFLAGS) $(COMMON) $(OPT) $(NATIVE) -mavx2 $(LTO) $(SECTIONS) \
		-DFROGBARD_EXTERNAL_HASH4 -fstack-protector-strong \
		-D_FORTIFY_SOURCE=3 -fPIE $(CFLAGS) \
		$(CORE_SRC) $(AVX2_SRC) $(TREE_SRC) $(CLI_SRC) \
		-o frogbard-hardened $(LLD) $(LTO) $(GC) $(THREADS) -pie \
		-Wl,-z,relro,-z,now,-z,noexecstack $(LDFLAGS) $(LDLIBS)

libfrogbard.a: frogbard-core.o frogbard-avx2.o
	$(AR) rcs $@ $^
	$(RANLIB) $@

library: libfrogbard.a

portable-library: $(CORE_DEPS)
	$(CC) $(CPPFLAGS) $(COMMON) $(OPT) $(LTO) $(SECTIONS) $(CFLAGS) \
		-c $(CORE_SRC) -o frogbard-portable-core.o
	$(AR) rcs libfrogbard-portable.a frogbard-portable-core.o
	$(RANLIB) libfrogbard-portable.a

regen-tables:
	python3 $(TOOLS_DIR)/gen_tables.py

analysis-tool: $(CORE_DEPS) $(TOOLS_DIR)/frogbard_analyze.c
	$(CC) $(CPPFLAGS) $(COMMON) $(OPT) $(NATIVE) $(LTO) $(SECTIONS) $(CFLAGS) \
		$(CORE_SRC) $(TOOLS_DIR)/frogbard_analyze.c -o frogbard-analyze \
		$(LLD) $(LTO) $(GC) $(LDFLAGS) -lm $(LDLIBS)

analyze: analysis-tool
	./frogbard-analyze --all 256

clang-analyze: $(CLI_DEPS)
	$(CC) $(CPPFLAGS) $(COMMON) --analyze -Xanalyzer -analyzer-output=text \
		$(CORE_SRC) $(TREE_SRC) $(CLI_SRC) $(CFLAGS)

fuzz: $(CORE_DEPS) $(TOOLS_DIR)/fuzz_frogbard.c
	$(CC) $(CPPFLAGS) -std=c11 -O1 -g -fsanitize=fuzzer,address,undefined \
		-fno-omit-frame-pointer $(CORE_SRC) $(TOOLS_DIR)/fuzz_frogbard.c \
		-o frogbard-fuzz

fuzz-smoke: $(CORE_DEPS) $(TOOLS_DIR)/fuzz_frogbard.c
	$(CC) $(CPPFLAGS) $(COMMON) -O2 -DFROGBARD_FUZZ_STANDALONE \
		$(CORE_SRC) $(TOOLS_DIR)/fuzz_frogbard.c -o frogbard-fuzz-smoke $(LLD)
	./frogbard-fuzz-smoke

constant-time: $(CLI_DEPS) $(AVX2_SRC)
	$(CC) $(CPPFLAGS) $(COMMON) $(OPT) $(NATIVE) -mavx2 $(LTO) $(SECTIONS) \
		-DFROGBARD_EXTERNAL_HASH4 -DFROGBARD_USE_BITSLICE_SBOX $(CFLAGS) \
		$(CORE_SRC) $(AVX2_SRC) $(TREE_SRC) $(CLI_SRC) \
		-o frogbard-ct $(LLD) $(LTO) $(GC) $(THREADS) $(LDFLAGS) $(LDLIBS)

table: frogbard
	cp frogbard frogbard-table

asm: $(CORE_DEPS)
	$(CC) $(CPPFLAGS) $(COMMON) $(OPT) $(NATIVE) -S -masm=intel \
		$(CORE_SRC) -o frogbard.s $(CFLAGS)

info:
	@$(CC) --version | head -n 1
	@ld.lld --version | head -n 1
	@printf 'native backend: AVX2 four-way\n'

test: frogbard analysis-tool
	./frogbard --self-test
	@set -eu; \
		tmp=$$(mktemp); trap 'rm -f "$$tmp" "$$tmp.changed"' EXIT; \
		printf abc > "$$tmp"; \
		a=$$(./frogbard -s abc); b=$$(./frogbard -f "$$tmp"); \
		test "$$a" = "$$b"; \
		dd if=/dev/urandom of="$$tmp" bs=1M count=5 status=none; \
		t1=$$(./frogbard -T "$$tmp" -j 1 2>/dev/null); \
		t2=$$(./frogbard -T "$$tmp" -j 4 2>/dev/null); \
		test "$$t1" = "$$t2"; \
		truncate -s $$((1024*1024+17)) "$$tmp"; \
		p1=$$(./frogbard -T "$$tmp" -j 1 2>/dev/null); \
		p2=$$(./frogbard -T "$$tmp" -j 4 2>/dev/null); \
		test "$$p1" = "$$p2"; \
		cp "$$tmp" "$$tmp.changed"; printf X | dd of="$$tmp.changed" bs=1 seek=1048583 conv=notrunc status=none; \
		t3=$$(./frogbard -T "$$tmp.changed" -j 2 2>/dev/null); \
		test "$$p1" != "$$t3"; \
		./frogbard-analyze --inverse 8

package: clean all test
	@echo "Build and tests complete; package from the parent directory."

clean:
	rm -f frogbard frogbard-portable frogbard-strict frogbard-debug \
		frogbard-ubsan frogbard-asan frogbard-hardened frogbard-table frogbard-ct \
		frogbard-analyze frogbard-fuzz frogbard-fuzz-smoke frogbard.s *.o *.a
