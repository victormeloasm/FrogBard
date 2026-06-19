	.intel_syntax noprefix
	.file	"frogbard.c"
	.text
	.globl	frogbard_permute_reduced        # -- Begin function frogbard_permute_reduced
	.p2align	4
	.type	frogbard_permute_reduced,@function
frogbard_permute_reduced:               # @frogbard_permute_reduced
	.cfi_startproc
# %bb.0:
	cmp	esi, 16
	mov	eax, 16
	cmovae	esi, eax
	jmp	frogbard_permute_rounds         # TAILCALL
.Lfunc_end0:
	.size	frogbard_permute_reduced, .Lfunc_end0-frogbard_permute_reduced
	.cfi_endproc
                                        # -- End function
	.p2align	4                               # -- Begin function frogbard_permute_rounds
	.type	frogbard_permute_rounds,@function
frogbard_permute_rounds:                # @frogbard_permute_rounds
	.cfi_startproc
# %bb.0:
	test	esi, esi
	je	.LBB1_9
# %bb.1:
	push	rbp
	.cfi_def_cfa_offset 16
	push	r15
	.cfi_def_cfa_offset 24
	push	r14
	.cfi_def_cfa_offset 32
	push	r13
	.cfi_def_cfa_offset 40
	push	r12
	.cfi_def_cfa_offset 48
	push	rbx
	.cfi_def_cfa_offset 56
	sub	rsp, 64
	.cfi_def_cfa_offset 120
	.cfi_offset rbx, -56
	.cfi_offset r12, -48
	.cfi_offset r13, -40
	.cfi_offset r14, -32
	.cfi_offset r15, -24
	.cfi_offset rbp, -16
	mov	eax, esi
	mov	qword ptr [rsp + 56], rax       # 8-byte Spill
	lea	rax, [rip + FROGBARD_RC]
	lea	rsi, [rip + FROGBARD_SBOX]
	mov	r8d, 2080
	mov	ebx, 2088
	mov	r15d, 2096
	xor	ecx, ecx
	mov	qword ptr [rsp - 128], rdi      # 8-byte Spill
	jmp	.LBB1_2
	.p2align	4
.LBB1_6:                                #   in Loop: Header=BB1_2 Depth=1
	mov	rax, qword ptr [rdi + 144]
	mov	rsi, qword ptr [rsp - 128]      # 8-byte Reload
	mov	r8, qword ptr [rsp - 128]       # 8-byte Reload
	mov	r14, qword ptr [rsp - 128]      # 8-byte Reload
	mov	rbx, qword ptr [rsp - 128]      # 8-byte Reload
	rorx	r11, rax, 53
	add	r11, qword ptr [rdi + 192]
	mov	qword ptr [rdi + 192], r11
	mov	qword ptr [rsp - 120], r11      # 8-byte Spill
	mov	r15, qword ptr [rdi + 224]
	mov	rdx, qword ptr [rdi + 112]
	rorx	rcx, r15, 57
	xor	rcx, qword ptr [rdi + 64]
	mov	qword ptr [rsp + 8], rdx        # 8-byte Spill
	mov	r10, rcx
	mov	qword ptr [rsp], rcx            # 8-byte Spill
	rorx	rcx, rdx, 33
	add	rcx, qword ptr [rdi]
	mov	rdi, qword ptr [rsi + 8]
	mov	rdx, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [rsp + 24], rcx       # 8-byte Spill
	mov	rcx, qword ptr [rsp - 128]      # 8-byte Reload
	mov	rsi, qword ptr [rdx + 16]
	rorx	rdx, rdi, 21
	xor	rdx, qword ptr [r8 + 128]
	mov	r8, qword ptr [rsp - 128]       # 8-byte Reload
	mov	qword ptr [rsp - 112], rdx      # 8-byte Spill
	mov	rcx, qword ptr [rcx + 152]
	mov	rdx, qword ptr [rsp - 128]      # 8-byte Reload
	rorx	r12, rcx, 47
	add	r12, qword ptr [rdx + 200]
	mov	rdx, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [rdx + 200], r12
	mov	rdx, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [rsp - 80], r12       # 8-byte Spill
	mov	r9, qword ptr [rdx + 232]
	rorx	rdx, r9, 51
	xor	rdx, qword ptr [r8 + 72]
	mov	qword ptr [r14 + 72], rdx
	mov	r8, qword ptr [rbx + 120]
	rorx	rbx, rsi, 11
	mov	qword ptr [rsp - 8], r8         # 8-byte Spill
	rorx	r8, r8, 23
	add	r8, rdi
	mov	qword ptr [rsp + 16], r8        # 8-byte Spill
	rorx	r8, r10, 17
	mov	r10, qword ptr [rsp - 128]      # 8-byte Reload
	add	r8, rsi
	mov	rsi, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [rsp - 24], r8        # 8-byte Spill
	mov	r8, qword ptr [rsp - 128]       # 8-byte Reload
	mov	r13, qword ptr [rsi + 160]
	xor	rbx, qword ptr [r8 + 136]
	mov	r8, qword ptr [rsp - 128]       # 8-byte Reload
	rorx	rsi, r13, 41
	add	rsi, qword ptr [r10 + 208]
	mov	qword ptr [rsp - 40], rbx       # 8-byte Spill
	mov	qword ptr [r8 + 208], rsi
	mov	qword ptr [rsp - 104], rsi      # 8-byte Spill
	mov	rsi, qword ptr [rsp - 128]      # 8-byte Reload
	mov	r8, qword ptr [rsp - 128]       # 8-byte Reload
	mov	rdi, qword ptr [rsi + 24]
	rorx	rsi, rdi, 3
	xor	rsi, rax
	mov	qword ptr [rsp - 16], rsi       # 8-byte Spill
	rorx	rsi, rdx, 9
	mov	rdx, qword ptr [rsp - 128]      # 8-byte Reload
	add	rsi, rdi
	mov	qword ptr [rsp - 48], rsi       # 8-byte Spill
	mov	rsi, qword ptr [rsp - 128]      # 8-byte Reload
	mov	rax, qword ptr [rdx + 32]
	rorx	rdx, rax, 57
	xor	rdx, rcx
	mov	qword ptr [rsp - 32], rdx       # 8-byte Spill
	mov	rdx, qword ptr [rsp - 128]      # 8-byte Reload
	mov	rbp, qword ptr [rdx + 240]
	mov	rdx, qword ptr [rsp - 128]      # 8-byte Reload
	rorx	rdi, rbp, 45
	mov	rbx, qword ptr [rdx + 168]
	xor	rdi, qword ptr [rsi + 80]
	mov	rsi, qword ptr [rsp - 128]      # 8-byte Reload
	mov	rdx, qword ptr [rsp - 128]      # 8-byte Reload
	rorx	r14, rbx, 33
	add	r14, qword ptr [rsi + 216]
	mov	rsi, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [rdx + 216], r14
	mov	rdx, qword ptr [rsp - 128]      # 8-byte Reload
	mov	rcx, qword ptr [rsi + 248]
	mov	rsi, qword ptr [rsp - 128]      # 8-byte Reload
	rorx	r10, rcx, 35
	xor	r10, qword ptr [rdx + 88]
	mov	rdx, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [rsp - 72], rcx       # 8-byte Spill
	mov	qword ptr [rsi + 88], r10
	rorx	rsi, rdi, 5
	mov	rdx, qword ptr [rdx + 176]
	add	rsi, rax
	mov	qword ptr [rsp - 64], rsi       # 8-byte Spill
	mov	rsi, qword ptr [rsp - 128]      # 8-byte Reload
	rorx	rcx, rdx, 23
	add	rcx, r15
	rorx	r15, r10, 53
	mov	qword ptr [rsp - 96], rcx       # 8-byte Spill
	mov	rcx, qword ptr [rsp - 128]      # 8-byte Reload
	mov	rax, qword ptr [rcx + 40]
	rorx	rcx, rax, 51
	add	r15, rax
	xor	rcx, r13
	rorx	r13, r11, 27
	mov	qword ptr [rsp - 56], rcx       # 8-byte Spill
	mov	rcx, qword ptr [r8 + 184]
	rorx	r8, rcx, 17
	add	r8, r9
	rorx	r9, r12, 21
	xor	r9, qword ptr [rsi + 104]
	mov	rsi, qword ptr [rsp - 128]      # 8-byte Reload
	mov	r12, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [rsp - 88], r8        # 8-byte Spill
	mov	r8, qword ptr [rsp - 128]       # 8-byte Reload
	xor	r13, qword ptr [r8 + 96]
	mov	r8, qword ptr [rsp - 128]       # 8-byte Reload
	mov	qword ptr [r8 + 104], r9
	rorx	r8, qword ptr [rsp - 112], 9    # 8-byte Folded Reload
	rorx	r11, r13, 47
	mov	r10, qword ptr [rsi + 48]
	mov	rsi, qword ptr [rsp - 40]       # 8-byte Reload
	add	r8, rbp
	mov	qword ptr [rsp + 40], r8        # 8-byte Spill
	mov	r8, qword ptr [rsp - 128]       # 8-byte Reload
	rorx	rax, r10, 45
	add	r11, r10
	xor	rax, rbx
	rorx	rbx, qword ptr [rsp - 104], 11  # 8-byte Folded Reload
	xor	rbx, qword ptr [rsp + 8]        # 8-byte Folded Reload
	mov	r10, qword ptr [r8 + 56]
	rorx	r8, r14, 3
	xor	r8, qword ptr [rsp - 8]         # 8-byte Folded Reload
	mov	qword ptr [r12 + 120], r8
	mov	r12, qword ptr [rsp + 24]       # 8-byte Reload
	rorx	r8, r9, 41
	rorx	rbp, r10, 35
	add	r8, r10
	mov	r10, qword ptr [rsp - 128]      # 8-byte Reload
	xor	rbp, rdx
	rorx	rdx, rsi, 5
	add	rdx, qword ptr [rsp - 72]       # 8-byte Folded Reload
	rorx	r9, r12, 27
	xor	r9, rcx
	mov	rcx, qword ptr [rsp + 16]       # 8-byte Reload
	mov	qword ptr [r10], rcx
	mov	rcx, qword ptr [rsp - 128]      # 8-byte Reload
	mov	r10, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [rcx + 8], r11
	mov	rcx, qword ptr [rsp - 48]       # 8-byte Reload
	mov	r11, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [r10 + 16], rcx
	mov	rcx, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [r11 + 24], r12
	mov	r11, qword ptr [rsp - 128]      # 8-byte Reload
	mov	r10, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [rcx + 32], r15
	mov	rcx, qword ptr [rsp - 24]       # 8-byte Reload
	mov	qword ptr [r11 + 40], rcx
	mov	rcx, qword ptr [rsp - 128]      # 8-byte Reload
	mov	r11, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [rcx + 48], r8
	mov	rcx, qword ptr [rsp - 64]       # 8-byte Reload
	mov	r8, qword ptr [rsp - 128]       # 8-byte Reload
	mov	qword ptr [r10 + 56], rcx
	mov	r10, qword ptr [rsp - 128]      # 8-byte Reload
	mov	rcx, qword ptr [rsp - 16]       # 8-byte Reload
	mov	qword ptr [r10 + 64], r13
	mov	qword ptr [r8 + 80], rbx
	mov	r8, qword ptr [rsp]             # 8-byte Reload
	mov	r10, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [r11 + 96], r8
	mov	qword ptr [r10 + 112], rdi
	mov	rdi, qword ptr [rsp - 128]      # 8-byte Reload
	mov	r8, qword ptr [rsp - 56]        # 8-byte Reload
	mov	qword ptr [rdi + 128], r9
	mov	qword ptr [rdi + 136], r8
	mov	qword ptr [rdi + 144], rsi
	mov	rsi, qword ptr [rsp - 104]      # 8-byte Reload
	mov	r9, qword ptr [rsp - 32]        # 8-byte Reload
	mov	r8, qword ptr [rsp - 112]       # 8-byte Reload
	mov	qword ptr [rdi + 152], rbp
	mov	qword ptr [rdi + 160], r9
	mov	qword ptr [rdi + 168], r8
	mov	qword ptr [rdi + 176], rax
	mov	qword ptr [rdi + 184], rcx
.LBB1_7:                                #   in Loop: Header=BB1_2 Depth=1
	mov	rax, qword ptr [rsp - 96]       # 8-byte Reload
	mov	qword ptr [rdi + 192], rsi
	mov	qword ptr [rdi + 200], rdx
	mov	rcx, qword ptr [rsp + 48]       # 8-byte Reload
	lea	rsi, [rip + FROGBARD_SBOX]
	mov	r8d, 2080
	mov	ebx, 2088
	mov	r15d, 2096
	mov	qword ptr [rdi + 208], rax
	mov	rax, qword ptr [rsp - 80]       # 8-byte Reload
	inc	rcx
	mov	qword ptr [rdi + 216], rax
	mov	rax, qword ptr [rsp + 40]       # 8-byte Reload
	mov	qword ptr [rdi + 224], rax
	mov	rax, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [rdi + 232], r14
	mov	qword ptr [rdi + 240], rax
	mov	rax, qword ptr [rsp - 88]       # 8-byte Reload
	mov	qword ptr [rdi + 248], rax
	mov	rax, qword ptr [rsp + 32]       # 8-byte Reload
	add	rax, 256
	cmp	rcx, qword ptr [rsp + 56]       # 8-byte Folded Reload
	je	.LBB1_8
.LBB1_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_3 Depth 2
	mov	ebp, 56
	mov	qword ptr [rsp + 32], rax       # 8-byte Spill
	mov	qword ptr [rsp + 48], rcx       # 8-byte Spill
	.p2align	4
.LBB1_3:                                #   Parent Loop BB1_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	mov	r9, qword ptr [rsp + 32]        # 8-byte Reload
	mov	rdx, qword ptr [rdi + rbp - 56]
	mov	eax, ecx
	and	eax, 3
	mov	qword ptr [rsp - 80], rcx       # 8-byte Spill
	mov	edi, 2064
	mov	r12d, 2064
	mov	qword ptr [rsp - 88], rax       # 8-byte Spill
                                        # kill: def $eax killed $eax killed $rax def $rax
	shl	eax, 8
	add	rax, rsi
	xor	rdx, qword ptr [r9 + rbp - 56]
	movzx	ecx, dh
	movzx	r10d, dl
	bextr	r11d, edx, edi
	mov	r14d, edx
	bextr	rdi, rdx, rbx
	bextr	rsi, rdx, r8
	bextr	r8, rdx, r15
	shr	rdx, 56
	shr	r14d, 24
	movzx	ecx, byte ptr [rcx + rax]
	movzx	r10d, byte ptr [r10 + rax]
	movzx	ebx, byte ptr [rdx + rax]
	mov	rdx, qword ptr [rsp - 128]      # 8-byte Reload
	movzx	edi, byte ptr [rdi + rax]
	movzx	r8d, byte ptr [r8 + rax]
	shl	ecx, 8
	mov	rdx, qword ptr [rdx + rbp - 48]
	shl	rdi, 40
	shl	r8, 48
	shl	rbx, 56
	or	rcx, r10
	movzx	r10d, byte ptr [r11 + rax]
	movzx	r11d, byte ptr [rsi + rax]
	xor	rdx, qword ptr [r9 + rbp - 48]
	shl	r10d, 16
	shl	r11, 32
	bextr	esi, edx, r12d
	mov	r15d, edx
	shr	r15d, 24
	or	r10, rcx
	movzx	ecx, byte ptr [r14 + rax]
	movzx	esi, byte ptr [rsi + rax]
	shl	ecx, 24
	shl	esi, 16
	or	rcx, r10
	mov	r10d, 2096
	or	r11, rcx
	movzx	ecx, dl
	bextr	r10, rdx, r10
	mov	qword ptr [rsp - 120], rcx      # 8-byte Spill
	or	rdi, r11
	movzx	ecx, dh
	movzx	r10d, byte ptr [r10 + rax]
	or	r8, rdi
	mov	rdi, qword ptr [rsp - 120]      # 8-byte Reload
	mov	r14, rcx
	mov	ecx, 2080
	or	rbx, r8
	movzx	r8d, byte ptr [r14 + rax]
	bextr	r12, rdx, rcx
	mov	ecx, 2088
	bextr	rcx, rdx, rcx
	shr	rdx, 56
	movzx	r13d, byte ptr [rdx + rax]
	mov	rdx, qword ptr [rsp - 128]      # 8-byte Reload
	shl	r10, 48
	movzx	edi, byte ptr [rdi + rax]
	shl	r8d, 8
	mov	rdx, qword ptr [rdx + rbp - 40]
	shl	r13, 56
	xor	rdx, qword ptr [r9 + rbp - 40]
	or	r8, rdi
	movzx	edi, byte ptr [r15 + rax]
	or	rsi, r8
	movzx	r8d, byte ptr [r12 + rax]
	mov	r12d, 2096
	mov	r14d, edx
	shr	r14d, 24
	bextr	r12, rdx, r12
	shl	edi, 24
	or	rdi, rsi
	movzx	esi, byte ptr [rcx + rax]
	shl	r8, 32
	movzx	ecx, dh
	or	r8, rdi
	movzx	ecx, byte ptr [rcx + rax]
	mov	edi, 2064
	bextr	r11d, edx, edi
	mov	edi, 2080
	bextr	r15, rdx, rdi
	mov	edi, 2088
	bextr	rdi, rdx, rdi
	shl	rsi, 40
	or	rsi, r8
	movzx	r8d, dl
	shl	ecx, 8
	shr	rdx, 56
	or	r10, rsi
	movzx	esi, byte ptr [r8 + rax]
	movzx	edx, byte ptr [rdx + rax]
	or	r13, r10
	add	rbx, r13
	or	rcx, rsi
	movzx	esi, byte ptr [r11 + rax]
	mov	qword ptr [rsp - 120], rdx      # 8-byte Spill
	mov	rdx, qword ptr [rsp - 128]      # 8-byte Reload
	shl	esi, 16
	mov	rdx, qword ptr [rdx + rbp - 32]
	or	rsi, rcx
	movzx	ecx, byte ptr [r14 + rax]
	xor	rdx, qword ptr [r9 + rbp - 32]
	mov	r14d, 2088
	shl	ecx, 24
	mov	r11d, edx
	movzx	r8d, dl
	shr	r11d, 24
	or	rcx, rsi
	movzx	esi, byte ptr [r15 + rax]
	bextr	r15, rdx, r14
	mov	r14d, 2096
	shl	rsi, 32
	or	rsi, rcx
	movzx	ecx, byte ptr [rdi + rax]
	mov	edi, 2064
	bextr	r10d, edx, edi
	mov	edi, 2080
	bextr	rdi, rdx, rdi
	shl	rcx, 40
	or	rcx, rsi
	movzx	esi, byte ptr [r12 + rax]
	bextr	r12, rdx, r14
	shl	rsi, 48
	or	rsi, rcx
	movzx	ecx, dh
	shr	rdx, 56
	movzx	r14d, byte ptr [rdx + rax]
	mov	rdx, qword ptr [rsp - 128]      # 8-byte Reload
	movzx	ecx, byte ptr [rcx + rax]
	mov	rdx, qword ptr [rdx + rbp - 24]
	shl	ecx, 8
	shl	r14, 56
	xor	rdx, qword ptr [r9 + rbp - 24]
	mov	r9, qword ptr [rsp - 120]       # 8-byte Reload
	shl	r9, 56
	or	r9, rsi
	movzx	esi, byte ptr [r8 + rax]
	mov	qword ptr [rsp - 120], r9       # 8-byte Spill
	mov	r9, qword ptr [rsp + 32]        # 8-byte Reload
	or	rcx, rsi
	movzx	esi, byte ptr [r10 + rax]
	mov	r10d, edx
	shr	r10d, 24
	shl	esi, 16
	or	rsi, rcx
	movzx	ecx, byte ptr [r11 + rax]
	mov	r11d, 2088
	bextr	r11, rdx, r11
	shl	ecx, 24
	or	rcx, rsi
	movzx	esi, byte ptr [rdi + rax]
	mov	edi, 2064
	bextr	r8d, edx, edi
	mov	edi, 2080
	bextr	rdi, rdx, rdi
	shl	rsi, 32
	or	rsi, rcx
	movzx	ecx, byte ptr [r15 + rax]
	mov	r15d, 2096
	shl	rcx, 40
	or	rcx, rsi
	movzx	esi, byte ptr [r12 + rax]
	bextr	r12, rdx, r15
	shl	rsi, 48
	or	rsi, rcx
	movzx	ecx, dl
	or	r14, rsi
	movzx	esi, dh
	movzx	ecx, byte ptr [rcx + rax]
	shr	rdx, 56
	movzx	esi, byte ptr [rsi + rax]
	movzx	r15d, byte ptr [rdx + rax]
	mov	rdx, qword ptr [rsp - 128]      # 8-byte Reload
	xor	r14, rbx
	shl	esi, 8
	mov	rdx, qword ptr [rdx + rbp - 16]
	shl	r15, 56
	or	rsi, rcx
	movzx	ecx, byte ptr [r8 + rax]
	xor	rdx, qword ptr [r9 + rbp - 16]
	mov	r8d, 2080
	shl	ecx, 16
	bextr	r8, rdx, r8
	or	rcx, rsi
	movzx	esi, byte ptr [r10 + rax]
	mov	r10d, 2088
	bextr	r10, rdx, r10
	shl	esi, 24
	or	rsi, rcx
	movzx	ecx, byte ptr [rdi + rax]
	mov	edi, edx
	shr	edi, 24
	shl	rcx, 32
	or	rcx, rsi
	movzx	esi, byte ptr [r11 + rax]
	mov	r11d, 2096
	bextr	r11, rdx, r11
	shl	rsi, 40
	or	rsi, rcx
	movzx	ecx, byte ptr [r12 + rax]
	shl	rcx, 48
	or	rcx, rsi
	or	r15, rcx
	movzx	ecx, dl
	movzx	esi, byte ptr [rcx + rax]
	movzx	ecx, dh
	movzx	ecx, byte ptr [rcx + rax]
	shl	ecx, 8
	or	rcx, rsi
	mov	esi, 2064
	bextr	esi, edx, esi
	shr	rdx, 56
	movzx	esi, byte ptr [rsi + rax]
	movzx	r12d, byte ptr [rdx + rax]
	mov	rdx, qword ptr [rsp - 128]      # 8-byte Reload
	shl	esi, 16
	mov	rdx, qword ptr [rdx + rbp - 8]
	shl	r12, 56
	or	rsi, rcx
	movzx	ecx, byte ptr [rdi + rax]
	xor	rdx, qword ptr [r9 + rbp - 8]
	shl	ecx, 24
	or	rcx, rsi
	movzx	esi, byte ptr [r8 + rax]
	mov	r8d, 2096
	bextr	r8, rdx, r8
	shl	rsi, 32
	or	rsi, rcx
	movzx	ecx, byte ptr [r10 + rax]
	shl	rcx, 40
	or	rcx, rsi
	movzx	esi, byte ptr [r11 + rax]
	mov	r11d, edx
	shr	r11d, 24
	movzx	r11d, byte ptr [r11 + rax]
	shl	rsi, 48
	or	rsi, rcx
	movzx	ecx, dl
	shl	r11d, 24
	or	r12, rsi
	movzx	esi, dh
	movzx	ecx, byte ptr [rcx + rax]
	movzx	edi, byte ptr [rsi + rax]
	add	r15, r12
	shl	edi, 8
	or	rdi, rcx
	mov	ecx, 2064
	bextr	ecx, edx, ecx
	movzx	esi, byte ptr [rcx + rax]
	mov	ecx, 2080
	bextr	rcx, rdx, rcx
	movzx	ecx, byte ptr [rcx + rax]
	shl	esi, 16
	or	rsi, rdi
	mov	edi, 2088
	bextr	rdi, rdx, rdi
	shr	rdx, 56
	or	r11, rsi
	shl	rcx, 32
	movzx	edi, byte ptr [rdi + rax]
	movzx	r10d, byte ptr [rdx + rax]
	mov	rdx, qword ptr [rsp - 128]      # 8-byte Reload
	or	rcx, r11
	shl	rdi, 40
	mov	rdx, qword ptr [rdx + rbp]
	shl	r10, 56
	or	rdi, rcx
	movzx	ecx, byte ptr [r8 + rax]
	xor	rdx, qword ptr [r9 + rbp]
	mov	r8d, 2088
	mov	r9d, 2096
	shl	rcx, 48
	movzx	esi, dh
	bextr	r8, rdx, r8
	bextr	r9, rdx, r9
	or	rcx, rdi
	movzx	esi, byte ptr [rsi + rax]
	mov	edi, 2080
	or	r10, rcx
	movzx	ecx, dl
	bextr	rdi, rdx, rdi
	movzx	ecx, byte ptr [rcx + rax]
	shl	esi, 8
	or	rsi, rcx
	mov	ecx, 2064
	bextr	ecx, edx, ecx
	movzx	ecx, byte ptr [rcx + rax]
	shl	ecx, 16
	or	rcx, rsi
	mov	esi, edx
	shr	rdx, 56
	shr	esi, 24
	movzx	r11d, byte ptr [rdx + rax]
	movzx	edx, byte ptr [rsi + rax]
	shl	edx, 24
	shl	r11, 56
	or	rdx, rcx
	movzx	ecx, byte ptr [rdi + rax]
	mov	rdi, qword ptr [rsp - 128]      # 8-byte Reload
	shl	rcx, 32
	or	rcx, rdx
	movzx	edx, byte ptr [r8 + rax]
	mov	r8, qword ptr [rsp - 88]        # 8-byte Reload
	movzx	eax, byte ptr [r9 + rax]
	mov	r9, qword ptr [rsp - 120]       # 8-byte Reload
	shl	rdx, 40
	shl	rax, 48
	or	rdx, rcx
	lea	rcx, [rip + voice_rotations.rot]
	movzx	esi, byte ptr [rcx + 4*r8]
	or	rax, rdx
	movzx	edx, byte ptr [rcx + 4*r8 + 1]
	or	r11, rax
	movzx	eax, byte ptr [rcx + 4*r8 + 2]
	movzx	r8d, byte ptr [rcx + 4*r8 + 3]
	xor	r11, r15
	mov	ecx, esi
	rol	r14, cl
	mov	ecx, edx
	add	r9, r14
	xor	r13, r9
	rol	r13, cl
	mov	ecx, eax
	add	rbx, r13
	xor	r14, rbx
	rol	r14, cl
	mov	ecx, r8d
	add	r9, r14
	xor	r13, r9
	rol	r13, cl
	mov	ecx, edx
	rol	r11, cl
	mov	ecx, eax
	add	r10, r11
	xor	r12, r10
	rol	r12, cl
	mov	ecx, r8d
	add	r15, r12
	xor	r11, r15
	add	r15, r13
	rol	r11, cl
	mov	ecx, esi
	xor	r14, r15
	add	r10, r11
	xor	r12, r10
	rol	r12, cl
	mov	ecx, eax
	add	rbx, r12
	xor	r11, rbx
	rol	r11, cl
	mov	ecx, r8d
	add	r9, r11
	xor	r12, r9
	rol	r12, cl
	mov	ecx, esi
	add	rbx, r12
	mov	qword ptr [rdi + rbp - 56], rbx
	xor	rbx, r11
	rol	rbx, cl
	mov	ecx, edx
	mov	qword ptr [rdi + rbp], rbx
	add	rbx, r9
	mov	qword ptr [rdi + rbp - 40], rbx
	xor	rbx, r12
	rol	rbx, cl
	mov	ecx, r8d
	mov	r8d, 2080
	rol	r14, cl
	mov	ecx, esi
	mov	qword ptr [rdi + rbp - 16], rbx
	mov	ebx, 2088
	lea	rsi, [rip + FROGBARD_SBOX]
	add	r10, r14
	xor	r13, r10
	rol	r13, cl
	mov	ecx, edx
	add	r15, r13
	mov	qword ptr [rdi + rbp - 24], r15
	xor	r15, r14
	rol	r15, cl
	mov	ecx, eax
	mov	qword ptr [rdi + rbp - 32], r15
	add	r15, r10
	mov	qword ptr [rdi + rbp - 8], r15
	xor	r15, r13
	rol	r15, cl
	mov	rcx, qword ptr [rsp - 80]       # 8-byte Reload
	mov	qword ptr [rdi + rbp - 48], r15
	mov	r15d, 2096
	add	rbp, 64
	inc	rcx
	cmp	rbp, 312
	jne	.LBB1_3
# %bb.4:                                #   in Loop: Header=BB1_2 Depth=1
	test	byte ptr [rsp + 48], 1          # 1-byte Folded Reload
	jne	.LBB1_6
# %bb.5:                                #   in Loop: Header=BB1_2 Depth=1
	mov	rcx, qword ptr [rdi + 72]
	mov	rsi, qword ptr [rsp - 128]      # 8-byte Reload
	mov	r8, qword ptr [rsp - 128]       # 8-byte Reload
	rorx	r11, rcx, 57
	add	r11, qword ptr [rdi]
	mov	qword ptr [rdi], r11
	mov	rax, qword ptr [rdi + 24]
	mov	r9, qword ptr [rdi + 32]
	rorx	rdx, rax, 53
	xor	rdx, qword ptr [rdi + 128]
	mov	rdi, qword ptr [rsp - 128]      # 8-byte Reload
	mov	rdi, qword ptr [rdi + 168]
	mov	r15, rdx
	mov	qword ptr [rsp - 32], rdx       # 8-byte Spill
	rorx	r10, rdi, 45
	add	r10, qword ptr [rsi + 192]
	mov	rsi, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [r8 + 192], r10
	mov	r8, qword ptr [rsp - 128]       # 8-byte Reload
	mov	qword ptr [rsp - 80], r10       # 8-byte Spill
	mov	rdx, qword ptr [rsi + 248]
	rorx	rsi, rdx, 23
	mov	qword ptr [rsp - 104], rdx      # 8-byte Spill
	mov	rdx, qword ptr [rsp - 128]      # 8-byte Reload
	xor	rsi, qword ptr [r8 + 64]
	mov	qword ptr [rsp + 16], rsi       # 8-byte Spill
	mov	rdx, qword ptr [rdx + 80]
	mov	rsi, qword ptr [rsp - 128]      # 8-byte Reload
	rorx	r8, rdx, 51
	add	r8, qword ptr [rsi + 8]
	mov	rsi, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [rsp], r8             # 8-byte Spill
	rorx	r8, r9, 47
	xor	r8, qword ptr [rsi + 136]
	mov	rsi, qword ptr [rsp - 128]      # 8-byte Reload
	mov	rsi, qword ptr [rsi + 176]
	mov	rbp, r8
	mov	qword ptr [rsp - 64], r8        # 8-byte Spill
	mov	qword ptr [rsp - 96], rsi       # 8-byte Spill
	rorx	r8, rsi, 35
	mov	rsi, qword ptr [rsp - 128]      # 8-byte Reload
	add	r8, qword ptr [rsi + 200]
	mov	rsi, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [rsi + 200], r8
	rorx	rsi, r10, 17
	mov	qword ptr [rsp - 120], r8       # 8-byte Spill
	xor	rsi, rcx
	mov	qword ptr [rsp + 24], rsi       # 8-byte Spill
	rorx	rsi, r8, 9
	mov	r8, qword ptr [rsp - 128]       # 8-byte Reload
	xor	rsi, rdx
	mov	rdx, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [rsp + 8], rsi        # 8-byte Spill
	mov	rcx, qword ptr [rdx + 88]
	mov	rdx, qword ptr [rsp - 128]      # 8-byte Reload
	rorx	rsi, rcx, 45
	add	rsi, qword ptr [rdx + 16]
	mov	rdx, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [rsp - 40], rsi       # 8-byte Spill
	mov	rsi, qword ptr [rsp - 128]      # 8-byte Reload
	mov	rdx, qword ptr [rdx + 184]
	mov	r10, qword ptr [rsi + 40]
	mov	qword ptr [rsp - 48], rdx       # 8-byte Spill
	rorx	rdx, rdx, 27
	rorx	rsi, r10, 41
	xor	rsi, qword ptr [r8 + 144]
	mov	qword ptr [rsp - 112], rsi      # 8-byte Spill
	mov	rsi, qword ptr [rsp - 128]      # 8-byte Reload
	add	rdx, qword ptr [rsi + 208]
	mov	rsi, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [rsi + 208], rdx
	mov	rsi, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [rsp - 16], rdx       # 8-byte Spill
	rorx	rdx, rdx, 5
	xor	rdx, rcx
	mov	rcx, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [rsp - 24], rdx       # 8-byte Spill
	mov	rdx, qword ptr [rsp - 128]      # 8-byte Reload
	mov	r12, qword ptr [rsi + 96]
	mov	r8, qword ptr [rcx + 48]
	rorx	rsi, r12, 35
	add	rsi, rax
	rorx	rcx, r8, 33
	xor	rcx, qword ptr [rdx + 152]
	mov	rdx, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [rsp - 8], rsi        # 8-byte Spill
	mov	rsi, qword ptr [rsp - 128]      # 8-byte Reload
	mov	r14, qword ptr [rsi + 56]
	mov	rsi, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [rdx + 152], rcx
	rorx	rdx, r15, 21
	mov	rbx, qword ptr [rsi + 104]
	mov	rsi, qword ptr [rsp - 128]      # 8-byte Reload
	add	rdx, qword ptr [rsi + 216]
	mov	rsi, qword ptr [rsp - 128]      # 8-byte Reload
	rorx	rax, rbx, 27
	add	rax, r9
	rorx	r9, rbp, 11
	mov	qword ptr [rsi + 32], rax
	mov	rax, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [rsp + 40], rdx       # 8-byte Spill
	rorx	rdx, rdx, 53
	mov	rsi, qword ptr [rsp - 128]      # 8-byte Reload
	xor	rdx, r12
	mov	qword ptr [rsp - 56], rdx       # 8-byte Spill
	rorx	rdx, r11, 17
	mov	r11, qword ptr [rsp - 128]      # 8-byte Reload
	xor	rdx, rdi
	mov	qword ptr [rsp - 72], rdx       # 8-byte Spill
	mov	rdx, qword ptr [rsp - 128]      # 8-byte Reload
	add	r9, qword ptr [rax + 224]
	mov	rax, qword ptr [rsp - 128]      # 8-byte Reload
	mov	rsi, qword ptr [rsi + 112]
	mov	r15, qword ptr [rdx + 120]
	mov	rdx, qword ptr [rsp + 16]       # 8-byte Reload
	rorx	rbp, r9, 47
	mov	qword ptr [rsp - 88], r9        # 8-byte Spill
	rorx	r9, qword ptr [rsp - 112], 3    # 8-byte Folded Reload
	rorx	r13, rsi, 21
	add	r9, qword ptr [rax + 232]
	xor	rbp, rbx
	mov	rbx, qword ptr [rsp]            # 8-byte Reload
	add	r13, r10
	mov	rax, qword ptr [rsp - 40]       # 8-byte Reload
	rorx	r12, r15, 11
	rorx	r10, rdx, 3
	add	r12, r8
	add	r10, r14
	rorx	r8, rbx, 9
	rorx	rdi, r9, 41
	xor	r8, qword ptr [rsp - 96]        # 8-byte Folded Reload
	mov	qword ptr [rsp - 96], r9        # 8-byte Spill
	rorx	r9, r14, 23
	rorx	r14, rcx, 57
	mov	rcx, qword ptr [rsp - 128]      # 8-byte Reload
	xor	r9, qword ptr [r11 + 160]
	mov	r11, qword ptr [rsp - 128]      # 8-byte Reload
	xor	rdi, rsi
	rorx	rsi, rax, 5
	xor	rsi, qword ptr [rsp - 48]       # 8-byte Folded Reload
	add	r14, qword ptr [rcx + 240]
	mov	qword ptr [r11 + 184], rsi
	mov	r11, qword ptr [rsp - 128]      # 8-byte Reload
	rorx	rsi, r9, 51
	add	rsi, qword ptr [rsp - 104]      # 8-byte Folded Reload
	rorx	rcx, r14, 33
	xor	rcx, r15
	mov	r15, qword ptr [rsp - 8]        # 8-byte Reload
	mov	qword ptr [r11 + 8], r15
	mov	r11, qword ptr [rsp - 128]      # 8-byte Reload
	mov	r15, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [r11 + 16], r12
	mov	qword ptr [r15 + 24], rbx
	mov	rbx, qword ptr [rsp - 128]      # 8-byte Reload
	mov	r11, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [rbx + 40], r10
	mov	r10, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [r11 + 48], rax
	mov	r11, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [r10 + 56], r13
	mov	r10, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [r11 + 64], rbp
	mov	r11, qword ptr [rsp - 128]      # 8-byte Reload
	mov	qword ptr [r10 + 72], rdx
	mov	r10, qword ptr [rsp - 24]       # 8-byte Reload
	mov	rdx, qword ptr [rsp - 16]       # 8-byte Reload
	mov	qword ptr [r11 + 80], r10
	mov	r10, qword ptr [rsp - 128]      # 8-byte Reload
	mov	r11, qword ptr [rsp + 24]       # 8-byte Reload
	mov	qword ptr [r10 + 88], rdi
	mov	rdi, qword ptr [rsp - 128]      # 8-byte Reload
	mov	r10, qword ptr [rsp - 56]       # 8-byte Reload
	mov	qword ptr [rdi + 96], r11
	mov	qword ptr [rdi + 104], r10
	mov	qword ptr [rdi + 112], rcx
	mov	rcx, qword ptr [rsp + 8]        # 8-byte Reload
	mov	r10, qword ptr [rsp - 112]      # 8-byte Reload
	mov	qword ptr [rdi + 120], rcx
	mov	rcx, qword ptr [rsp - 72]       # 8-byte Reload
	mov	qword ptr [rdi + 128], r10
	mov	r10, qword ptr [rsp - 32]       # 8-byte Reload
	mov	qword ptr [rdi + 136], rcx
	mov	rcx, qword ptr [rsp - 64]       # 8-byte Reload
	mov	qword ptr [rdi + 144], r10
	mov	qword ptr [rdi + 160], r8
	mov	qword ptr [rdi + 168], rcx
	mov	qword ptr [rdi + 176], r9
	jmp	.LBB1_7
.LBB1_8:
	add	rsp, 64
	.cfi_def_cfa_offset 56
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	r12
	.cfi_def_cfa_offset 40
	pop	r13
	.cfi_def_cfa_offset 32
	pop	r14
	.cfi_def_cfa_offset 24
	pop	r15
	.cfi_def_cfa_offset 16
	pop	rbp
	.cfi_def_cfa_offset 8
	.cfi_restore rbx
	.cfi_restore r12
	.cfi_restore r13
	.cfi_restore r14
	.cfi_restore r15
	.cfi_restore rbp
.LBB1_9:
	ret
.Lfunc_end1:
	.size	frogbard_permute_rounds, .Lfunc_end1-frogbard_permute_rounds
	.cfi_endproc
                                        # -- End function
	.globl	frogbard_permute_inverse_reduced # -- Begin function frogbard_permute_inverse_reduced
	.p2align	4
	.type	frogbard_permute_inverse_reduced,@function
frogbard_permute_inverse_reduced:       # @frogbard_permute_inverse_reduced
	.cfi_startproc
# %bb.0:
	cmp	esi, 16
	mov	eax, 16
	cmovae	esi, eax
	jmp	frogbard_inverse_rounds         # TAILCALL
.Lfunc_end2:
	.size	frogbard_permute_inverse_reduced, .Lfunc_end2-frogbard_permute_inverse_reduced
	.cfi_endproc
                                        # -- End function
	.p2align	4                               # -- Begin function frogbard_inverse_rounds
	.type	frogbard_inverse_rounds,@function
frogbard_inverse_rounds:                # @frogbard_inverse_rounds
	.cfi_startproc
# %bb.0:
                                        # kill: def $esi killed $esi def $rsi
	test	esi, esi
	je	.LBB3_11
# %bb.1:
	push	rbp
	.cfi_def_cfa_offset 16
	push	r15
	.cfi_def_cfa_offset 24
	push	r14
	.cfi_def_cfa_offset 32
	push	r13
	.cfi_def_cfa_offset 40
	push	r12
	.cfi_def_cfa_offset 48
	push	rbx
	.cfi_def_cfa_offset 56
	sub	rsp, 152
	.cfi_def_cfa_offset 208
	.cfi_offset rbx, -56
	.cfi_offset r12, -48
	.cfi_offset r13, -40
	.cfi_offset r14, -32
	.cfi_offset r15, -24
	.cfi_offset rbp, -16
	lea	rax, [rdi + 64]
	lea	rcx, [rdi + 192]
	lea	rdx, [rdi + 128]
	mov	qword ptr [rsp - 120], rdi      # 8-byte Spill
	mov	qword ptr [rsp + 40], rax       # 8-byte Spill
	mov	eax, esi
	dec	esi
	mov	qword ptr [rsp + 24], rcx       # 8-byte Spill
	lea	rcx, [rip + FROGBARD_RC]
	mov	qword ptr [rsp + 32], rdx       # 8-byte Spill
	shl	rsi, 8
	add	rcx, rsi
	mov	qword ptr [rsp], rcx            # 8-byte Spill
	.p2align	4
.LBB3_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_6 Depth 2
                                        #       Child Loop BB3_7 Depth 3
	mov	rsi, qword ptr [rdi]
	dec	rax
	xor	edx, edx
	lea	r9, [rsp - 16]
	lea	r10, [rsp - 40]
	lea	rbx, [rsp - 48]
	lea	r11, [rsp - 8]
	mov	qword ptr [rsp + 8], rax        # 8-byte Spill
                                        # kill: def $eax killed $eax killed $rax def $rax
	and	eax, 1
	mov	ecx, eax
	xor	ecx, 1
	test	eax, eax
	sete	dl
	mov	qword ptr [rsp + 8*rax - 64], rsi
	mov	rsi, r9
	cmove	rsi, r10
	cmove	r10, r9
	mov	r8, qword ptr [rdi + 8]
	mov	qword ptr [rsi], r8
	mov	r8, qword ptr [rdi + 16]
	mov	qword ptr [r10], r8
	mov	r8, qword ptr [rdi + 24]
	mov	qword ptr [rsp + 8*rcx - 64], r8
	mov	r8, qword ptr [rdi + 32]
	mov	qword ptr [rsp + 8*rax - 32], r8
	mov	r8, rbx
	cmove	r8, r11
	cmove	r11, rbx
	mov	r9, qword ptr [rdi + 40]
	mov	qword ptr [r8], r9
	mov	r9, qword ptr [rdi + 48]
	mov	qword ptr [r11], r9
	mov	r9, qword ptr [rdi + 56]
	mov	qword ptr [rsp + 8*rdx - 32], r9
	vmovups	ymm0, ymmword ptr [rsp - 64]
	vmovups	ymm1, ymmword ptr [rsp - 32]
	vmovups	ymmword ptr [rdi + 32], ymm1
	vmovups	ymmword ptr [rdi], ymm0
	mov	r9, qword ptr [rdi + 64]
	mov	qword ptr [rsp + 8*rdx - 32], r9
	mov	r9, qword ptr [rdi + 72]
	mov	qword ptr [rsp + 8*rax - 64], r9
	mov	r9, qword ptr [rdi + 80]
	mov	qword ptr [rsi], r9
	mov	r9, qword ptr [rdi + 88]
	mov	qword ptr [r10], r9
	mov	r9, qword ptr [rdi + 96]
	mov	qword ptr [rsp + 8*rcx - 64], r9
	mov	r9, qword ptr [rdi + 104]
	mov	qword ptr [rsp + 8*rax - 32], r9
	mov	r9, qword ptr [rdi + 112]
	mov	qword ptr [r8], r9
	mov	r9, qword ptr [rdi + 120]
	mov	qword ptr [r11], r9
	mov	r9, qword ptr [rsp + 40]        # 8-byte Reload
	vmovups	ymm0, ymmword ptr [rsp - 64]
	vmovups	ymm1, ymmword ptr [rsp - 32]
	vmovups	ymmword ptr [r9 + 32], ymm1
	vmovups	ymmword ptr [r9], ymm0
	mov	r9, qword ptr [rdi + 128]
	mov	qword ptr [r11], r9
	mov	r9, qword ptr [rdi + 136]
	mov	qword ptr [rsp + 8*rdx - 32], r9
	mov	r9, qword ptr [rdi + 144]
	mov	qword ptr [rsp + 8*rax - 64], r9
	mov	r9, qword ptr [rdi + 152]
	mov	qword ptr [rsi], r9
	mov	r9, qword ptr [rdi + 160]
	mov	qword ptr [r10], r9
	mov	r9, qword ptr [rdi + 168]
	mov	qword ptr [rsp + 8*rcx - 64], r9
	mov	r9, qword ptr [rdi + 176]
	mov	qword ptr [rsp + 8*rax - 32], r9
	mov	r9, qword ptr [rdi + 184]
	mov	qword ptr [r8], r9
	mov	r9, qword ptr [rsp + 32]        # 8-byte Reload
	vmovups	ymm0, ymmword ptr [rsp - 64]
	vmovups	ymm1, ymmword ptr [rsp - 32]
	vmovups	ymmword ptr [r9 + 32], ymm1
	vmovups	ymmword ptr [r9], ymm0
	mov	r9, qword ptr [rdi + 192]
	mov	qword ptr [r8], r9
	mov	r8, qword ptr [rdi + 200]
	mov	qword ptr [r11], r8
	mov	r8, qword ptr [rdi + 208]
	mov	qword ptr [rsp + 8*rdx - 32], r8
	mov	rdx, qword ptr [rdi + 216]
	mov	qword ptr [rsp + 8*rax - 64], rdx
	mov	rdx, qword ptr [rdi + 224]
	mov	qword ptr [rsi], rdx
	mov	rdx, qword ptr [rdi + 232]
	mov	qword ptr [r10], rdx
	mov	rdx, qword ptr [rdi + 240]
	mov	qword ptr [rsp + 8*rcx - 64], rdx
	mov	rcx, qword ptr [rdi + 248]
	mov	qword ptr [rsp + 8*rax - 32], rcx
	mov	rax, qword ptr [rsp + 24]       # 8-byte Reload
	vmovups	ymm0, ymmword ptr [rsp - 64]
	vmovups	ymm1, ymmword ptr [rsp - 32]
	vmovups	ymmword ptr [rax + 32], ymm1
	vmovups	ymmword ptr [rax], ymm0
	jne	.LBB3_3
# %bb.4:                                #   in Loop: Header=BB3_2 Depth=1
	mov	r8, qword ptr [rdi + 240]
	rorx	rsi, r8, 33
	xor	rsi, qword ptr [rdi + 120]
	mov	qword ptr [rdi + 120], rsi
	rorx	rsi, rsi, 11
	mov	r12, qword ptr [rdi + 160]
	mov	rcx, qword ptr [rdi + 248]
	rorx	rax, r12, 51
	sub	rcx, rax
	mov	qword ptr [rdi + 248], rcx
	mov	qword ptr [rsp - 96], rcx       # 8-byte Spill
	mov	rcx, qword ptr [rsp - 120]      # 8-byte Reload
	mov	r15, qword ptr [rdi + 16]
	mov	r11, qword ptr [rdi + 8]
	rorx	rbx, r15, 5
	xor	rbx, qword ptr [rdi + 184]
	mov	qword ptr [rsp - 112], r11      # 8-byte Spill
	mov	qword ptr [rdi + 184], rbx
	mov	rax, qword ptr [rdi + 64]
	mov	rdx, qword ptr [rdi + 56]
	mov	qword ptr [rsp - 104], rax      # 8-byte Spill
	rorx	rax, rax, 3
	sub	rdx, rax
	mov	qword ptr [rdi + 56], rdx
	mov	rax, qword ptr [rdi + 232]
	rorx	r9, rax, 41
	xor	r9, qword ptr [rdi + 112]
	mov	qword ptr [rdi + 112], r9
	mov	r13, qword ptr [rdi + 152]
	mov	rdi, qword ptr [rsp - 120]      # 8-byte Reload
	rorx	r10, r13, 57
	sub	r8, r10
	mov	r10, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [rcx + 240], r8
	rorx	r8, r11, 9
	mov	rcx, qword ptr [rsp - 120]      # 8-byte Reload
	mov	r11, qword ptr [rsp - 120]      # 8-byte Reload
	xor	r8, qword ptr [rdi + 176]
	mov	rdi, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [r10 + 176], r8
	mov	rbp, qword ptr [rdi + 48]
	mov	rdi, qword ptr [rsp - 120]      # 8-byte Reload
	sub	rbp, rsi
	mov	rsi, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [rcx + 48], rbp
	mov	rcx, qword ptr [rsi + 224]
	mov	rsi, qword ptr [rsp - 120]      # 8-byte Reload
	rorx	r10, rcx, 47
	xor	r10, qword ptr [rsi + 104]
	mov	qword ptr [r11 + 104], r10
	mov	r11, qword ptr [rsp - 120]      # 8-byte Reload
	mov	rsi, qword ptr [rdi + 144]
	mov	rdi, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [rsp - 80], rsi       # 8-byte Spill
	rorx	rsi, rsi, 3
	sub	rax, rsi
	mov	rsi, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [r11 + 232], rax
	mov	rax, qword ptr [rsp - 120]      # 8-byte Reload
	mov	rax, qword ptr [rax]
	mov	qword ptr [rsp - 88], rax       # 8-byte Spill
	rorx	r11, rax, 17
	mov	rax, qword ptr [rsp - 120]      # 8-byte Reload
	xor	r11, qword ptr [rax + 168]
	mov	rax, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [rax + 168], r11
	rorx	rax, r9, 21
	mov	rsi, qword ptr [rsi + 40]
	sub	rsi, rax
	mov	rax, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [rax + 40], rsi
	mov	rax, qword ptr [rsp - 120]      # 8-byte Reload
	rorx	rsi, rsi, 41
	xor	rsi, qword ptr [rsp - 80]       # 8-byte Folded Reload
	mov	r9, qword ptr [rax + 216]
	rorx	rax, r9, 53
	xor	rax, qword ptr [rdi + 96]
	mov	rdi, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [rdi + 96], rax
	mov	rdi, qword ptr [rsp - 120]      # 8-byte Reload
	rorx	rax, rax, 35
	mov	rdi, qword ptr [rdi + 136]
	rorx	r14, rdi, 11
	mov	qword ptr [rsp - 72], rdi       # 8-byte Spill
	mov	rdi, qword ptr [rsp - 120]      # 8-byte Reload
	sub	rcx, r14
	mov	r14, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [r14 + 224], rcx
	rorx	r14, rdx, 23
	mov	rdx, qword ptr [rsp - 120]      # 8-byte Reload
	rorx	rcx, r10, 27
	xor	r14, r12
	mov	r12, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [rdx + 160], r14
	mov	rdx, qword ptr [rsp - 120]      # 8-byte Reload
	mov	r14, qword ptr [rsp - 120]      # 8-byte Reload
	mov	r10, qword ptr [rdx + 32]
	mov	rdx, qword ptr [rsp - 120]      # 8-byte Reload
	sub	r10, rcx
	mov	qword ptr [rdi + 32], r10
	mov	rdi, qword ptr [rsp - 120]      # 8-byte Reload
	mov	rcx, qword ptr [rdx + 208]
	rorx	rdx, rcx, 5
	xor	rdx, qword ptr [rdi + 88]
	mov	rdi, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [r12 + 88], rdx
	rorx	rdx, rdx, 45
	mov	r14, qword ptr [r14 + 128]
	sub	r15, rdx
	mov	rdx, qword ptr [rsp - 120]      # 8-byte Reload
	rorx	r12, r14, 21
	sub	r9, r12
	mov	r12, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [rdi + 216], r9
	rorx	r9, rbp, 33
	mov	rdi, qword ptr [rsp - 120]      # 8-byte Reload
	xor	r9, r13
	mov	qword ptr [r12 + 152], r9
	mov	r9, qword ptr [rsp - 120]       # 8-byte Reload
	mov	r12, qword ptr [rsp - 120]      # 8-byte Reload
	mov	r13, qword ptr [r9 + 24]
	sub	r13, rax
	rorx	rax, rbx, 27
	mov	rbx, qword ptr [rsp - 120]      # 8-byte Reload
	sub	rcx, rax
	mov	rax, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [rax + 24], r13
	mov	rax, qword ptr [rsp - 120]      # 8-byte Reload
	mov	rax, qword ptr [rax + 200]
	rorx	r9, rax, 9
	xor	r9, qword ptr [rdi + 80]
	mov	rdi, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [r12 + 80], r9
	mov	qword ptr [rbx + 208], rcx
	mov	qword ptr [rdi + 144], rsi
	mov	rsi, qword ptr [rsp - 120]      # 8-byte Reload
	mov	rdi, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [rsi + 16], r15
	mov	rsi, qword ptr [rsp - 120]      # 8-byte Reload
	mov	rcx, qword ptr [rdx + 192]
	rorx	rdx, r8, 35
	mov	r8, qword ptr [rsp - 120]       # 8-byte Reload
	sub	rax, rdx
	rorx	rdx, rcx, 17
	xor	rdx, qword ptr [rsi + 72]
	mov	rsi, qword ptr [rsp - 112]      # 8-byte Reload
	mov	qword ptr [r8 + 72], rdx
	mov	qword ptr [rdi + 200], rax
	rorx	rax, r10, 47
	mov	r8, qword ptr [rsp - 120]       # 8-byte Reload
	xor	rax, qword ptr [rsp - 72]       # 8-byte Folded Reload
	mov	qword ptr [r8 + 136], rax
	rorx	rax, r9, 51
	mov	rdi, r8
	sub	rsi, rax
	rorx	rax, qword ptr [rsp - 96], 23   # 8-byte Folded Reload
	xor	rax, qword ptr [rsp - 104]      # 8-byte Folded Reload
	mov	qword ptr [r8 + 8], rsi
	rorx	rsi, rdx, 57
	mov	rdx, qword ptr [rsp - 88]       # 8-byte Reload
	mov	qword ptr [r8 + 64], rax
	rorx	rax, r11, 45
	sub	rdx, rsi
	sub	rcx, rax
	rorx	rax, r13, 53
	xor	rax, r14
	mov	qword ptr [r8 + 192], rcx
	jmp	.LBB3_5
	.p2align	4
.LBB3_3:                                #   in Loop: Header=BB3_2 Depth=1
	mov	rax, qword ptr [rdi]
	mov	rdx, qword ptr [rdi + 48]
	mov	qword ptr [rsp - 88], rax       # 8-byte Spill
	rorx	rax, rax, 27
	xor	rax, qword ptr [rdi + 184]
	mov	qword ptr [rdi + 184], rax
	rorx	rax, rax, 17
	mov	rcx, qword ptr [rdi + 104]
	mov	r9, qword ptr [rdi + 56]
	rorx	rsi, rcx, 41
	sub	r9, rsi
	mov	qword ptr [rdi + 56], r9
	mov	r8, qword ptr [rdi + 216]
	rorx	rsi, r8, 3
	xor	rsi, qword ptr [rdi + 120]
	mov	qword ptr [rdi + 120], rsi
	mov	qword ptr [rsp - 96], rsi       # 8-byte Spill
	mov	rsi, qword ptr [rdi + 136]
	mov	r15, qword ptr [rdi + 248]
	mov	qword ptr [rsp - 112], rsi      # 8-byte Spill
	rorx	rsi, rsi, 5
	sub	r15, rsi
	rorx	rsi, r9, 35
	mov	qword ptr [rdi + 248], r15
	xor	rsi, qword ptr [rdi + 176]
	mov	qword ptr [rdi + 176], rsi
	mov	r9, qword ptr [rdi + 96]
	rorx	r10, r9, 47
	sub	rdx, r10
	mov	qword ptr [rdi + 48], rdx
	rorx	rbp, rdx, 45
	mov	rdx, qword ptr [rsp - 120]      # 8-byte Reload
	mov	r11, qword ptr [rdi + 208]
	rorx	r10, r11, 11
	xor	r10, qword ptr [rdi + 112]
	mov	qword ptr [rdi + 112], r10
	mov	qword ptr [rsp - 104], r10      # 8-byte Spill
	mov	r10, qword ptr [rdi + 128]
	mov	r12, qword ptr [rdi + 240]
	mov	rdi, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [rsp - 80], r10       # 8-byte Spill
	rorx	r10, r10, 9
	sub	r12, r10
	mov	r10, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [rdi + 240], r12
	mov	rdi, qword ptr [rsp - 120]      # 8-byte Reload
	rorx	r12, r12, 45
	xor	rbp, qword ptr [rdx + 168]
	mov	rdx, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [rdx + 168], rbp
	mov	rdx, qword ptr [rsp - 120]      # 8-byte Reload
	rorx	rbp, rbp, 33
	mov	rdi, qword ptr [rdi + 88]
	sub	r8, rbp
	mov	rdx, qword ptr [rdx + 40]
	rorx	rbx, rdi, 53
	mov	qword ptr [rsp - 72], rdi       # 8-byte Spill
	mov	rdi, qword ptr [rsp - 120]      # 8-byte Reload
	sub	rdx, rbx
	mov	rbx, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [r10 + 40], rdx
	mov	r10, qword ptr [rsp - 120]      # 8-byte Reload
	mov	rbx, qword ptr [rbx + 200]
	rorx	r14, rbx, 21
	xor	r14, rcx
	rorx	rcx, rdx, 51
	mov	rdx, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [rdi + 104], r14
	mov	rdi, qword ptr [rsp - 120]      # 8-byte Reload
	mov	r13, qword ptr [r10 + 232]
	mov	r10, qword ptr [rsp - 120]      # 8-byte Reload
	sub	r13, rax
	mov	rax, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [rax + 232], r13
	mov	rax, qword ptr [rsp - 120]      # 8-byte Reload
	xor	rcx, qword ptr [rax + 160]
	mov	rax, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [rax + 160], rcx
	mov	rax, qword ptr [rsp - 120]      # 8-byte Reload
	rorx	rcx, rcx, 41
	mov	rdx, qword ptr [rdx + 80]
	sub	r11, rcx
	mov	rcx, qword ptr [rsp - 120]      # 8-byte Reload
	mov	rax, qword ptr [rax + 32]
	rorx	r14, rdx, 5
	xor	r12, rdx
	mov	rdx, qword ptr [rsp - 120]      # 8-byte Reload
	sub	rax, r14
	mov	qword ptr [rdi + 32], rax
	rorx	rax, rax, 57
	mov	r14, qword ptr [r10 + 192]
	mov	r10, qword ptr [rsp - 120]      # 8-byte Reload
	rorx	rdi, r14, 27
	xor	rdi, r9
	rorx	r9, rsi, 23
	mov	qword ptr [r10 + 96], rdi
	mov	r10, qword ptr [rsp - 120]      # 8-byte Reload
	mov	rsi, qword ptr [r10 + 224]
	mov	r10, qword ptr [rsp - 120]      # 8-byte Reload
	sub	rsi, r9
	mov	r9, qword ptr [rsp - 120]       # 8-byte Reload
	mov	qword ptr [r10 + 224], rsi
	mov	r10, qword ptr [rsp - 120]      # 8-byte Reload
	rorx	rsi, rsi, 57
	xor	rax, qword ptr [r9 + 152]
	mov	r9, qword ptr [rsp - 120]       # 8-byte Reload
	mov	qword ptr [r10 + 152], rax
	rorx	rax, rax, 47
	mov	rdi, qword ptr [r9 + 24]
	mov	r9, qword ptr [rsp - 120]       # 8-byte Reload
	sub	rbx, rax
	mov	rax, qword ptr [rsp - 120]      # 8-byte Reload
	mov	r9, qword ptr [r9 + 72]
	rorx	r10, r9, 9
	sub	rdi, r10
	rorx	r10, r15, 35
	mov	r15, qword ptr [rsp - 120]      # 8-byte Reload
	xor	r10, qword ptr [rsp - 72]       # 8-byte Folded Reload
	rorx	rbp, rdi, 3
	mov	qword ptr [r15 + 24], rdi
	mov	r15, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [r15 + 88], r10
	mov	r15, qword ptr [rsp - 120]      # 8-byte Reload
	mov	r10, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [r15 + 216], r8
	mov	r15, qword ptr [rsp - 120]      # 8-byte Reload
	xor	rbp, qword ptr [r10 + 144]
	mov	r10, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [r15 + 144], rbp
	mov	rdi, qword ptr [r10 + 16]
	mov	r10, qword ptr [rsp - 120]      # 8-byte Reload
	mov	r10, qword ptr [r10 + 64]
	rorx	r15, r10, 17
	xor	rsi, r10
	sub	rdi, r15
	mov	qword ptr [rdx + 16], rdi
	mov	rdx, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [rdx + 80], r12
	mov	qword ptr [rcx + 208], r11
	rorx	rcx, rdi, 11
	xor	rcx, qword ptr [rsp - 112]      # 8-byte Folded Reload
	mov	rdx, qword ptr [rsp - 120]      # 8-byte Reload
	mov	rdi, qword ptr [rsp - 120]      # 8-byte Reload
	mov	qword ptr [rdx + 136], rcx
	mov	rdx, qword ptr [rsp - 120]      # 8-byte Reload
	rorx	rcx, qword ptr [rsp - 96], 23   # 8-byte Folded Reload
	mov	rdx, qword ptr [rdx + 8]
	sub	rdx, rcx
	rorx	rcx, r13, 51
	xor	rcx, r9
	mov	r9, qword ptr [rsp - 120]       # 8-byte Reload
	mov	qword ptr [rdi + 8], rdx
	rorx	rdi, qword ptr [rsp - 104], 33  # 8-byte Folded Reload
	mov	qword ptr [r9 + 72], rcx
	mov	qword ptr [rax + 200], rbx
	rorx	rax, rdx, 21
	mov	rdx, qword ptr [rsp - 88]       # 8-byte Reload
	mov	r9, qword ptr [rsp - 120]       # 8-byte Reload
	xor	rax, qword ptr [rsp - 80]       # 8-byte Folded Reload
	sub	rdx, rdi
	rorx	rdi, rbp, 53
	mov	qword ptr [r9 + 64], rsi
	sub	r14, rdi
	mov	rdi, r9
	mov	qword ptr [r9 + 192], r14
.LBB3_5:                                #   in Loop: Header=BB3_2 Depth=1
	mov	qword ptr [rdi + 128], rax
	mov	rcx, qword ptr [rsp]            # 8-byte Reload
	mov	rax, qword ptr [rsp + 8]        # 8-byte Reload
	mov	r9d, 2064
	mov	r10d, 2080
	mov	r14d, 2088
	mov	qword ptr [rdi], rdx
	mov	rdx, rdi
	xor	esi, esi
	.p2align	4
.LBB3_6:                                #   Parent Loop BB3_2 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB3_7 Depth 3
	lea	ebx, [rax + rsi]
	mov	r12, rsi
	shl	r12, 6
	lea	rax, [rip + voice_rotations.rot]
	mov	qword ptr [rsp + 16], rcx       # 8-byte Spill
	mov	qword ptr [rsp + 48], rsi       # 8-byte Spill
	mov	qword ptr [rsp - 88], rdx       # 8-byte Spill
	and	ebx, 3
	mov	r15, qword ptr [rdi + r12 + 8]
	mov	r13, qword ptr [rdi + r12 + 48]
	mov	rdx, qword ptr [rdi + r12 + 32]
	mov	r11, qword ptr [rdi + r12]
	movzx	ecx, byte ptr [rax + 4*rbx + 2]
	movzx	ebp, byte ptr [rax + 4*rbx + 1]
	movzx	r8d, byte ptr [rax + 4*rbx + 3]
	movzx	esi, byte ptr [rax + 4*rbx]
	mov	rax, qword ptr [rdi + r12 + 24]
	shl	ebx, 8
	ror	r15, cl
	mov	byte ptr [rsp - 112], cl        # 1-byte Spill
	mov	ecx, ebp
	mov	byte ptr [rsp - 104], r8b       # 1-byte Spill
	mov	byte ptr [rsp - 96], sil        # 1-byte Spill
	mov	byte ptr [rsp - 80], bpl        # 1-byte Spill
	xor	r15, r13
	sub	r13, rax
	ror	rax, cl
	mov	ecx, esi
	mov	rsi, qword ptr [rdi + r12 + 16]
	xor	rax, rdx
	sub	rdx, r15
	ror	r15, cl
	mov	ecx, r8d
	mov	r8, qword ptr [rdi + r12 + 40]
	xor	r15, r13
	sub	r13, rax
	ror	rax, cl
	mov	ecx, ebp
	mov	rbp, qword ptr [rdi + r12 + 56]
	xor	rax, rdx
	sub	rdx, r15
	ror	r8, cl
	movzx	ecx, byte ptr [rsp - 96]        # 1-byte Folded Reload
	xor	r8, rsi
	sub	rsi, rbp
	ror	rbp, cl
	movzx	ecx, byte ptr [rsp - 104]       # 1-byte Folded Reload
	xor	rbp, r11
	sub	r11, r8
	ror	r8, cl
	movzx	ecx, byte ptr [rsp - 112]       # 1-byte Folded Reload
	xor	r8, rsi
	sub	rsi, rbp
	ror	rbp, cl
	movzx	ecx, byte ptr [rsp - 96]        # 1-byte Folded Reload
	xor	rbp, r11
	sub	r11, r8
	ror	r8, cl
	movzx	ecx, byte ptr [rsp - 104]       # 1-byte Folded Reload
	xor	r8, r13
	sub	r13, rbp
	ror	rbp, cl
	movzx	ecx, byte ptr [rsp - 112]       # 1-byte Folded Reload
	xor	rbp, rdx
	sub	rdx, r8
	ror	r8, cl
	xor	r8, r13
	sub	r13, rbp
	mov	qword ptr [rdi + r12 + 40], r8
	mov	qword ptr [rdi + r12 + 48], r13
	movzx	r13d, byte ptr [rsp - 80]       # 1-byte Folded Reload
	mov	ecx, r13d
	ror	rbp, cl
	movzx	ecx, byte ptr [rsp - 104]       # 1-byte Folded Reload
	xor	rbp, rdx
	sub	rdx, r8
	mov	r8d, 2096
	mov	qword ptr [rdi + r12 + 56], rbp
	mov	qword ptr [rdi + r12 + 32], rdx
	mov	rdx, qword ptr [rsp - 88]       # 8-byte Reload
	ror	r15, cl
	movzx	ecx, byte ptr [rsp - 112]       # 1-byte Folded Reload
	xor	r15, rsi
	sub	rsi, rax
	ror	rax, cl
	mov	ecx, r13d
	xor	rax, r11
	sub	r11, r15
	ror	r15, cl
	movzx	ecx, byte ptr [rsp - 96]        # 1-byte Folded Reload
	xor	r15, rsi
	sub	rsi, rax
	mov	qword ptr [rdi + r12 + 8], r15
	mov	qword ptr [rdi + r12 + 16], rsi
	ror	rax, cl
	lea	rcx, [rip + FROGBARD_SBOX_INV]
	xor	rax, r11
	sub	r11, r15
	add	rbx, rcx
	xor	r15d, r15d
	mov	qword ptr [rdi + r12 + 24], rax
	mov	qword ptr [rdi + r12], r11
	.p2align	4
.LBB3_7:                                #   Parent Loop BB3_2 Depth=1
                                        #     Parent Loop BB3_6 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	mov	rcx, qword ptr [rdx + 8*r15]
	mov	edi, 2064
	mov	r11d, 2080
	movzx	eax, cl
	mov	qword ptr [rsp - 96], rax       # 8-byte Spill
	movzx	eax, ch
	mov	qword ptr [rsp - 104], rax      # 8-byte Spill
	bextr	eax, ecx, r9d
	mov	qword ptr [rsp - 112], rax      # 8-byte Spill
	mov	eax, ecx
	mov	qword ptr [rsp - 80], rax       # 8-byte Spill
	bextr	rax, rcx, r10
	mov	qword ptr [rsp - 72], rax       # 8-byte Spill
	bextr	rax, rcx, r14
	mov	qword ptr [rsp + 144], rax      # 8-byte Spill
	bextr	rax, rcx, r8
	shr	rcx, 56
	mov	r8d, 2088
	mov	qword ptr [rsp + 136], rax      # 8-byte Spill
	mov	rax, qword ptr [rdx + 8*r15 + 8]
	movzx	ecx, byte ptr [rbx + rcx]
	movzx	edx, al
	bextr	rsi, rax, r10
	mov	r14d, eax
	movzx	ebp, ah
	vmovd	xmm0, ecx
	shr	r14d, 24
	mov	qword ptr [rsp + 64], rdx       # 8-byte Spill
	bextr	edx, eax, r9d
	mov	qword ptr [rsp + 112], rsi      # 8-byte Spill
	bextr	rsi, rax, r8
	mov	qword ptr [rsp + 72], rdx       # 8-byte Spill
	mov	edx, 2096
	mov	qword ptr [rsp + 120], rsi      # 8-byte Spill
	bextr	rcx, rax, rdx
	shr	rax, 56
	vpinsrb	xmm0, xmm0, byte ptr [rbx + rax], 1
	mov	rax, qword ptr [rsp - 88]       # 8-byte Reload
	mov	qword ptr [rsp + 128], rcx      # 8-byte Spill
	mov	rax, qword ptr [rax + 8*r15 + 16]
	mov	r10d, eax
	bextr	rcx, rax, r11
	bextr	r12, rax, r8
	bextr	rdx, rax, rdx
	movzx	r9d, al
	movzx	esi, ah
	bextr	r13d, eax, edi
	shr	rax, 56
	shr	r10d, 24
	vpinsrb	xmm0, xmm0, byte ptr [rbx + rax], 2
	mov	rax, qword ptr [rsp - 88]       # 8-byte Reload
	mov	qword ptr [rsp + 88], rcx       # 8-byte Spill
	mov	qword ptr [rsp + 96], r12       # 8-byte Spill
	mov	qword ptr [rsp + 104], rdx      # 8-byte Spill
	mov	rax, qword ptr [rax + 8*r15 + 24]
	bextr	r8, rax, r8
	mov	r12d, eax
	movzx	edx, al
	movzx	ecx, ah
	bextr	edi, eax, edi
	bextr	r11, rax, r11
	shr	r12d, 24
	mov	qword ptr [rsp + 56], r8        # 8-byte Spill
	mov	r8d, 2096
	bextr	r8, rax, r8
	shr	rax, 56
	vpinsrb	xmm0, xmm0, byte ptr [rbx + rax], 3
	mov	rax, qword ptr [rsp - 104]      # 8-byte Reload
	mov	qword ptr [rsp + 80], r8        # 8-byte Spill
	mov	r8d, 2096
	movzx	eax, byte ptr [rbx + rax]
	vpmovzxbq	ymm0, xmm0              # ymm0 = xmm0[0],zero,zero,zero,zero,zero,zero,zero,xmm0[1],zero,zero,zero,zero,zero,zero,zero,xmm0[2],zero,zero,zero,zero,zero,zero,zero,xmm0[3],zero,zero,zero,zero,zero,zero,zero
	vmovd	xmm1, eax
	mov	rax, qword ptr [rsp - 96]       # 8-byte Reload
	vpinsrb	xmm1, xmm1, byte ptr [rbx + rbp], 1
	vpsllq	ymm0, ymm0, 56
	vpinsrb	xmm1, xmm1, byte ptr [rbx + rsi], 2
	movzx	eax, byte ptr [rbx + rax]
	vpinsrb	xmm1, xmm1, byte ptr [rbx + rcx], 3
	vmovd	xmm2, eax
	mov	rax, qword ptr [rsp + 64]       # 8-byte Reload
	vpinsrb	xmm2, xmm2, byte ptr [rbx + rax], 1
	mov	rax, qword ptr [rsp - 112]      # 8-byte Reload
	vpmovzxbq	ymm1, xmm1              # ymm1 = xmm1[0],zero,zero,zero,zero,zero,zero,zero,xmm1[1],zero,zero,zero,zero,zero,zero,zero,xmm1[2],zero,zero,zero,zero,zero,zero,zero,xmm1[3],zero,zero,zero,zero,zero,zero,zero
	vpinsrb	xmm2, xmm2, byte ptr [rbx + r9], 2
	mov	r9d, 2064
	movzx	eax, byte ptr [rbx + rax]
	vpsllq	ymm1, ymm1, 8
	vpinsrb	xmm2, xmm2, byte ptr [rbx + rdx], 3
	mov	rdx, qword ptr [rsp - 88]       # 8-byte Reload
	vmovd	xmm3, eax
	mov	rax, qword ptr [rsp + 72]       # 8-byte Reload
	vpinsrb	xmm3, xmm3, byte ptr [rbx + rax], 1
	mov	rax, qword ptr [rsp - 80]       # 8-byte Reload
	vpmovzxbq	ymm2, xmm2              # ymm2 = xmm2[0],zero,zero,zero,zero,zero,zero,zero,xmm2[1],zero,zero,zero,zero,zero,zero,zero,xmm2[2],zero,zero,zero,zero,zero,zero,zero,xmm2[3],zero,zero,zero,zero,zero,zero,zero
	vpinsrb	xmm3, xmm3, byte ptr [rbx + r13], 2
	shr	eax, 24
	vpor	ymm1, ymm1, ymm2
	movzx	eax, byte ptr [rbx + rax]
	vpinsrb	xmm3, xmm3, byte ptr [rbx + rdi], 3
	vmovd	xmm4, eax
	mov	rax, qword ptr [rsp - 72]       # 8-byte Reload
	vpinsrb	xmm4, xmm4, byte ptr [rbx + r14], 1
	mov	r14d, 2088
	vpinsrb	xmm4, xmm4, byte ptr [rbx + r10], 2
	mov	r10d, 2080
	movzx	eax, byte ptr [rbx + rax]
	vpmovzxbq	ymm2, xmm3              # ymm2 = xmm3[0],zero,zero,zero,zero,zero,zero,zero,xmm3[1],zero,zero,zero,zero,zero,zero,zero,xmm3[2],zero,zero,zero,zero,zero,zero,zero,xmm3[3],zero,zero,zero,zero,zero,zero,zero
	vpinsrb	xmm4, xmm4, byte ptr [rbx + r12], 3
	vpsllq	ymm2, ymm2, 16
	vmovd	xmm5, eax
	mov	rax, qword ptr [rsp + 112]      # 8-byte Reload
	vpinsrb	xmm5, xmm5, byte ptr [rbx + rax], 1
	mov	rax, qword ptr [rsp + 88]       # 8-byte Reload
	vpmovzxbq	ymm3, xmm4              # ymm3 = xmm4[0],zero,zero,zero,zero,zero,zero,zero,xmm4[1],zero,zero,zero,zero,zero,zero,zero,xmm4[2],zero,zero,zero,zero,zero,zero,zero,xmm4[3],zero,zero,zero,zero,zero,zero,zero
	vpinsrb	xmm5, xmm5, byte ptr [rbx + rax], 2
	mov	rax, qword ptr [rsp + 144]      # 8-byte Reload
	vpsllq	ymm3, ymm3, 24
	vpor	ymm2, ymm2, ymm3
	vpor	ymm1, ymm1, ymm2
	vpinsrb	xmm5, xmm5, byte ptr [rbx + r11], 3
	movzx	eax, byte ptr [rbx + rax]
	vmovd	xmm6, eax
	mov	rax, qword ptr [rsp + 120]      # 8-byte Reload
	vpmovzxbq	ymm2, xmm5              # ymm2 = xmm5[0],zero,zero,zero,zero,zero,zero,zero,xmm5[1],zero,zero,zero,zero,zero,zero,zero,xmm5[2],zero,zero,zero,zero,zero,zero,zero,xmm5[3],zero,zero,zero,zero,zero,zero,zero
	vpinsrb	xmm6, xmm6, byte ptr [rbx + rax], 1
	mov	rax, qword ptr [rsp + 96]       # 8-byte Reload
	vpsllq	ymm2, ymm2, 32
	vpinsrb	xmm6, xmm6, byte ptr [rbx + rax], 2
	mov	rax, qword ptr [rsp + 56]       # 8-byte Reload
	vpinsrb	xmm6, xmm6, byte ptr [rbx + rax], 3
	mov	rax, qword ptr [rsp + 136]      # 8-byte Reload
	movzx	eax, byte ptr [rbx + rax]
	vpmovzxbq	ymm3, xmm6              # ymm3 = xmm6[0],zero,zero,zero,zero,zero,zero,zero,xmm6[1],zero,zero,zero,zero,zero,zero,zero,xmm6[2],zero,zero,zero,zero,zero,zero,zero,xmm6[3],zero,zero,zero,zero,zero,zero,zero
	vmovd	xmm7, eax
	mov	rax, qword ptr [rsp + 128]      # 8-byte Reload
	vpsllq	ymm3, ymm3, 40
	vpor	ymm2, ymm2, ymm3
	vpinsrb	xmm7, xmm7, byte ptr [rbx + rax], 1
	mov	rax, qword ptr [rsp + 104]      # 8-byte Reload
	vpinsrb	xmm7, xmm7, byte ptr [rbx + rax], 2
	mov	rax, qword ptr [rsp + 80]       # 8-byte Reload
	vpinsrb	xmm7, xmm7, byte ptr [rbx + rax], 3
	mov	rax, qword ptr [rsp + 16]       # 8-byte Reload
	vpmovzxbq	ymm4, xmm7              # ymm4 = xmm7[0],zero,zero,zero,zero,zero,zero,zero,xmm7[1],zero,zero,zero,zero,zero,zero,zero,xmm7[2],zero,zero,zero,zero,zero,zero,zero,xmm7[3],zero,zero,zero,zero,zero,zero,zero
	vpsllq	ymm3, ymm4, 48
	vpor	ymm2, ymm2, ymm3
	vpor	ymm1, ymm1, ymm2
	vpor	ymm0, ymm1, ymm0
	vpxor	ymm0, ymm0, ymmword ptr [rax + 8*r15]
	vmovdqu	ymmword ptr [rdx + 8*r15], ymm0
	add	r15, 4
	cmp	r15, 8
	jne	.LBB3_7
# %bb.8:                                #   in Loop: Header=BB3_6 Depth=2
	mov	rsi, qword ptr [rsp + 48]       # 8-byte Reload
	mov	rcx, qword ptr [rsp + 16]       # 8-byte Reload
	mov	rdi, qword ptr [rsp - 120]      # 8-byte Reload
	mov	rax, qword ptr [rsp + 8]        # 8-byte Reload
	add	rdx, 64
	inc	rsi
	add	rcx, 64
	cmp	rsi, 4
	jne	.LBB3_6
# %bb.9:                                #   in Loop: Header=BB3_2 Depth=1
	add	qword ptr [rsp], -256           # 8-byte Folded Spill
	test	eax, eax
	jne	.LBB3_2
# %bb.10:
	add	rsp, 152
	.cfi_def_cfa_offset 56
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	r12
	.cfi_def_cfa_offset 40
	pop	r13
	.cfi_def_cfa_offset 32
	pop	r14
	.cfi_def_cfa_offset 24
	pop	r15
	.cfi_def_cfa_offset 16
	pop	rbp
	.cfi_def_cfa_offset 8
	.cfi_restore rbx
	.cfi_restore r12
	.cfi_restore r13
	.cfi_restore r14
	.cfi_restore r15
	.cfi_restore rbp
.LBB3_11:
	vzeroupper
	ret
.Lfunc_end3:
	.size	frogbard_inverse_rounds, .Lfunc_end3-frogbard_inverse_rounds
	.cfi_endproc
                                        # -- End function
	.globl	frogbard_init                   # -- Begin function frogbard_init
	.p2align	4
	.type	frogbard_init,@function
frogbard_init:                          # @frogbard_init
	.cfi_startproc
# %bb.0:
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+32]
	vxorps	xmm0, xmm0, xmm0
	vmovaps	ymmword ptr [rdi + 416], ymm0
	vmovaps	ymmword ptr [rdi + 384], ymm0
	vmovaps	ymmword ptr [rdi + 352], ymm0
	vmovaps	ymmword ptr [rdi + 320], ymm0
	vmovaps	ymmword ptr [rdi + 288], ymm0
	vmovaps	ymmword ptr [rdi + 256], ymm0
	mov	esi, 16
	vmovaps	ymmword ptr [rdi], ymm2
	vmovaps	ymmword ptr [rdi + 32], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+64]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+96]
	vmovaps	ymmword ptr [rdi + 64], ymm2
	vmovaps	ymmword ptr [rdi + 96], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+128]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+160]
	vmovaps	ymmword ptr [rdi + 128], ymm2
	vmovaps	ymmword ptr [rdi + 160], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+192]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+224]
	vmovaps	ymmword ptr [rdi + 192], ymm2
	vmovaps	ymmword ptr [rdi + 224], ymm1
	vzeroupper
	jmp	frogbard_permute_rounds         # TAILCALL
.Lfunc_end4:
	.size	frogbard_init, .Lfunc_end4-frogbard_init
	.cfi_endproc
                                        # -- End function
	.globl	frogbard_update                 # -- Begin function frogbard_update
	.p2align	4
	.type	frogbard_update,@function
frogbard_update:                        # @frogbard_update
	.cfi_startproc
# %bb.0:
	mov	ecx, 16
	jmp	update_rounds                   # TAILCALL
.Lfunc_end5:
	.size	frogbard_update, .Lfunc_end5-frogbard_update
	.cfi_endproc
                                        # -- End function
	.p2align	4                               # -- Begin function update_rounds
	.type	update_rounds,@function
update_rounds:                          # @update_rounds
	.cfi_startproc
# %bb.0:
	test	rdx, rdx
	je	.LBB6_11
# %bb.1:
	push	rbp
	.cfi_def_cfa_offset 16
	push	r15
	.cfi_def_cfa_offset 24
	push	r14
	.cfi_def_cfa_offset 32
	push	r12
	.cfi_def_cfa_offset 40
	push	rbx
	.cfi_def_cfa_offset 48
	.cfi_offset rbx, -48
	.cfi_offset r12, -40
	.cfi_offset r14, -32
	.cfi_offset r15, -24
	.cfi_offset rbp, -16
	add	qword ptr [rdi + 392], rdx
	mov	ebp, ecx
	mov	rbx, rdx
	mov	r15, rsi
	mov	r14, rdi
	jae	.LBB6_3
# %bb.2:
	inc	qword ptr [r14 + 400]
.LBB6_3:
	mov	rax, qword ptr [r14 + 384]
	test	rax, rax
	je	.LBB6_6
# %bb.4:
	mov	r12d, 128
	lea	rdi, [r14 + rax + 256]
	mov	rsi, r15
	sub	r12, rax
	cmp	rbx, r12
	cmovb	r12, rbx
	mov	rdx, r12
	call	memcpy@PLT
	mov	rax, qword ptr [r14 + 384]
	add	r15, r12
	sub	rbx, r12
	add	rax, r12
	mov	qword ptr [r14 + 384], rax
	cmp	rax, 128
	jne	.LBB6_6
# %bb.5:
	vmovups	ymm0, ymmword ptr [r14]
	vmovups	ymm1, ymmword ptr [r14 + 32]
	vmovups	ymm2, ymmword ptr [r14 + 64]
	vmovups	ymm3, ymmword ptr [r14 + 96]
	mov	rdi, r14
	mov	esi, ebp
	vxorps	ymm0, ymm0, ymmword ptr [r14 + 256]
	vmovups	ymmword ptr [r14], ymm0
	vxorps	ymm0, ymm2, ymmword ptr [r14 + 320]
	vmovups	ymmword ptr [r14 + 64], ymm0
	vxorps	ymm0, ymm1, ymmword ptr [r14 + 288]
	vmovups	ymmword ptr [r14 + 32], ymm0
	vxorps	ymm0, ymm3, ymmword ptr [r14 + 352]
	vmovups	ymmword ptr [r14 + 96], ymm0
	vzeroupper
	call	frogbard_permute_rounds
	mov	qword ptr [r14 + 384], 0
.LBB6_6:
	cmp	rbx, 128
	jb	.LBB6_8
	.p2align	4
.LBB6_7:                                # =>This Inner Loop Header: Depth=1
	mov	rax, qword ptr [r15]
	mov	rdi, r14
	mov	esi, ebp
	xor	qword ptr [r14], rax
	mov	rax, qword ptr [r15 + 64]
	xor	qword ptr [r14 + 64], rax
	mov	rax, qword ptr [r15 + 8]
	xor	qword ptr [r14 + 8], rax
	mov	rax, qword ptr [r15 + 72]
	xor	qword ptr [r14 + 72], rax
	mov	rax, qword ptr [r15 + 16]
	xor	qword ptr [r14 + 16], rax
	mov	rax, qword ptr [r15 + 80]
	xor	qword ptr [r14 + 80], rax
	mov	rax, qword ptr [r15 + 24]
	xor	qword ptr [r14 + 24], rax
	mov	rax, qword ptr [r15 + 88]
	xor	qword ptr [r14 + 88], rax
	mov	rax, qword ptr [r15 + 32]
	xor	qword ptr [r14 + 32], rax
	mov	rax, qword ptr [r15 + 96]
	xor	qword ptr [r14 + 96], rax
	mov	rax, qword ptr [r15 + 40]
	xor	qword ptr [r14 + 40], rax
	mov	rax, qword ptr [r15 + 104]
	xor	qword ptr [r14 + 104], rax
	mov	rax, qword ptr [r15 + 48]
	xor	qword ptr [r14 + 48], rax
	mov	rax, qword ptr [r15 + 112]
	xor	qword ptr [r14 + 112], rax
	mov	rax, qword ptr [r15 + 56]
	xor	qword ptr [r14 + 56], rax
	mov	rax, qword ptr [r15 + 120]
	xor	qword ptr [r14 + 120], rax
	call	frogbard_permute_rounds
	sub	r15, -128
	add	rbx, -128
	cmp	rbx, 127
	ja	.LBB6_7
.LBB6_8:
	test	rbx, rbx
	je	.LBB6_10
# %bb.9:
	lea	rdi, [r14 + 256]
	mov	rsi, r15
	mov	rdx, rbx
	call	memcpy@PLT
	mov	qword ptr [r14 + 384], rbx
.LBB6_10:
	pop	rbx
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r14
	.cfi_def_cfa_offset 24
	pop	r15
	.cfi_def_cfa_offset 16
	pop	rbp
	.cfi_def_cfa_offset 8
	.cfi_restore rbx
	.cfi_restore r12
	.cfi_restore r14
	.cfi_restore r15
	.cfi_restore rbp
.LBB6_11:
	ret
.Lfunc_end6:
	.size	update_rounds, .Lfunc_end6-update_rounds
	.cfi_endproc
                                        # -- End function
	.globl	frogbard_final                  # -- Begin function frogbard_final
	.p2align	4
	.type	frogbard_final,@function
frogbard_final:                         # @frogbard_final
	.cfi_startproc
# %bb.0:
	mov	edx, 16
	jmp	final_rounds                    # TAILCALL
.Lfunc_end7:
	.size	frogbard_final, .Lfunc_end7-frogbard_final
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function final_rounds
.LCPI8_0:
	.quad	5291202099146614560             # 0x496e2046726f6720
	.quad	8603318210230842228             # 0x7765205472757374
	.text
	.p2align	4
	.type	final_rounds,@function
final_rounds:                           # @final_rounds
	.cfi_startproc
# %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	push	r15
	.cfi_def_cfa_offset 24
	push	r14
	.cfi_def_cfa_offset 32
	push	rbx
	.cfi_def_cfa_offset 40
	sub	rsp, 136
	.cfi_def_cfa_offset 176
	.cfi_offset rbx, -40
	.cfi_offset r14, -32
	.cfi_offset r15, -24
	.cfi_offset rbp, -16
	vxorps	xmm0, xmm0, xmm0
	vmovups	ymmword ptr [rsp + 96], ymm0
	vmovups	ymmword ptr [rsp + 64], ymm0
	vmovups	ymmword ptr [rsp + 32], ymm0
	vmovups	ymmword ptr [rsp], ymm0
	mov	r14, rsi
	lea	rsi, [rdi + 256]
	mov	ebp, edx
	mov	rbx, rdi
	mov	r15, qword ptr [rdi + 384]
	mov	rdi, rsp
	mov	rdx, r15
	vzeroupper
	call	memcpy@PLT
	xor	byte ptr [rsp + r15], 11
	xor	byte ptr [rsp + 127], -128
	mov	rdi, rbx
	mov	esi, ebp
	vmovups	ymm0, ymmword ptr [rbx]
	vmovups	ymm1, ymmword ptr [rbx + 32]
	vmovups	ymm2, ymmword ptr [rbx + 64]
	vmovups	ymm3, ymmword ptr [rbx + 96]
	vxorps	ymm0, ymm0, ymmword ptr [rsp]
	vmovups	ymmword ptr [rbx], ymm0
	vxorps	ymm0, ymm2, ymmword ptr [rsp + 64]
	vmovups	ymmword ptr [rbx + 64], ymm0
	vxorps	ymm0, ymm1, ymmword ptr [rsp + 32]
	vmovups	ymmword ptr [rbx + 32], ymm0
	vxorps	ymm0, ymm3, ymmword ptr [rsp + 96]
	vmovups	ymmword ptr [rbx + 96], ymm0
	vzeroupper
	call	frogbard_permute_rounds
	vmovaps	xmm0, xmmword ptr [rbx + 176]
	vmovaps	xmm1, xmmword ptr [rbx + 240]
	mov	rdi, rbx
	mov	esi, ebp
	vxorps	xmm0, xmm0, xmmword ptr [rbx + 392]
	vxorps	xmm1, xmm1, xmmword ptr [rip + .LCPI8_0]
	vmovaps	xmmword ptr [rbx + 176], xmm0
	vmovaps	xmmword ptr [rbx + 240], xmm1
	xor	byte ptr [rbx + 192], 33
	call	frogbard_permute_rounds
	xor	byte ptr [rbx + 201], 33
	mov	rdi, rbx
	mov	esi, ebp
	call	frogbard_permute_rounds
	mov	rax, qword ptr [rbx]
	mov	qword ptr [r14], rax
	mov	rax, qword ptr [rbx + 8]
	mov	qword ptr [r14 + 8], rax
	mov	rax, qword ptr [rbx + 16]
	mov	qword ptr [r14 + 16], rax
	mov	rax, qword ptr [rbx + 24]
	mov	qword ptr [r14 + 24], rax
	mov	rax, qword ptr [rbx + 32]
	mov	qword ptr [r14 + 32], rax
	mov	rax, qword ptr [rbx + 40]
	mov	qword ptr [r14 + 40], rax
	mov	rax, qword ptr [rbx + 48]
	mov	qword ptr [r14 + 48], rax
	mov	rax, qword ptr [rbx + 56]
	mov	qword ptr [r14 + 56], rax
	mov	byte ptr [rsp], 0
	mov	byte ptr [rsp + 1], 0
	mov	byte ptr [rsp + 2], 0
	mov	byte ptr [rsp + 3], 0
	mov	byte ptr [rsp + 4], 0
	mov	byte ptr [rsp + 5], 0
	mov	byte ptr [rsp + 6], 0
	mov	byte ptr [rsp + 7], 0
	mov	byte ptr [rsp + 8], 0
	mov	byte ptr [rsp + 9], 0
	mov	byte ptr [rsp + 10], 0
	mov	byte ptr [rsp + 11], 0
	mov	byte ptr [rsp + 12], 0
	mov	byte ptr [rsp + 13], 0
	mov	byte ptr [rsp + 14], 0
	mov	byte ptr [rsp + 15], 0
	mov	byte ptr [rsp + 16], 0
	mov	byte ptr [rsp + 17], 0
	mov	byte ptr [rsp + 18], 0
	mov	byte ptr [rsp + 19], 0
	mov	byte ptr [rsp + 20], 0
	mov	byte ptr [rsp + 21], 0
	mov	byte ptr [rsp + 22], 0
	mov	byte ptr [rsp + 23], 0
	mov	byte ptr [rsp + 24], 0
	mov	byte ptr [rsp + 25], 0
	mov	byte ptr [rsp + 26], 0
	mov	byte ptr [rsp + 27], 0
	mov	byte ptr [rsp + 28], 0
	mov	byte ptr [rsp + 29], 0
	mov	byte ptr [rsp + 30], 0
	mov	byte ptr [rsp + 31], 0
	mov	byte ptr [rsp + 32], 0
	mov	byte ptr [rsp + 33], 0
	mov	byte ptr [rsp + 34], 0
	mov	byte ptr [rsp + 35], 0
	mov	byte ptr [rsp + 36], 0
	mov	byte ptr [rsp + 37], 0
	mov	byte ptr [rsp + 38], 0
	mov	byte ptr [rsp + 39], 0
	mov	byte ptr [rsp + 40], 0
	mov	byte ptr [rsp + 41], 0
	mov	byte ptr [rsp + 42], 0
	mov	byte ptr [rsp + 43], 0
	mov	byte ptr [rsp + 44], 0
	mov	byte ptr [rsp + 45], 0
	mov	byte ptr [rsp + 46], 0
	mov	byte ptr [rsp + 47], 0
	mov	byte ptr [rsp + 48], 0
	mov	byte ptr [rsp + 49], 0
	mov	byte ptr [rsp + 50], 0
	mov	byte ptr [rsp + 51], 0
	mov	byte ptr [rsp + 52], 0
	mov	byte ptr [rsp + 53], 0
	mov	byte ptr [rsp + 54], 0
	mov	byte ptr [rsp + 55], 0
	mov	byte ptr [rsp + 56], 0
	mov	byte ptr [rsp + 57], 0
	mov	byte ptr [rsp + 58], 0
	mov	byte ptr [rsp + 59], 0
	mov	byte ptr [rsp + 60], 0
	mov	byte ptr [rsp + 61], 0
	mov	byte ptr [rsp + 62], 0
	mov	byte ptr [rsp + 63], 0
	mov	byte ptr [rsp + 64], 0
	mov	byte ptr [rsp + 65], 0
	mov	byte ptr [rsp + 66], 0
	mov	byte ptr [rsp + 67], 0
	mov	byte ptr [rsp + 68], 0
	mov	byte ptr [rsp + 69], 0
	mov	byte ptr [rsp + 70], 0
	mov	byte ptr [rsp + 71], 0
	mov	byte ptr [rsp + 72], 0
	mov	byte ptr [rsp + 73], 0
	mov	byte ptr [rsp + 74], 0
	mov	byte ptr [rsp + 75], 0
	mov	byte ptr [rsp + 76], 0
	mov	byte ptr [rsp + 77], 0
	mov	byte ptr [rsp + 78], 0
	mov	byte ptr [rsp + 79], 0
	mov	byte ptr [rsp + 80], 0
	mov	byte ptr [rsp + 81], 0
	mov	byte ptr [rsp + 82], 0
	mov	byte ptr [rsp + 83], 0
	mov	byte ptr [rsp + 84], 0
	mov	byte ptr [rsp + 85], 0
	mov	byte ptr [rsp + 86], 0
	mov	byte ptr [rsp + 87], 0
	mov	byte ptr [rsp + 88], 0
	mov	byte ptr [rsp + 89], 0
	mov	byte ptr [rsp + 90], 0
	mov	byte ptr [rsp + 91], 0
	mov	byte ptr [rsp + 92], 0
	mov	byte ptr [rsp + 93], 0
	mov	byte ptr [rsp + 94], 0
	mov	byte ptr [rsp + 95], 0
	mov	byte ptr [rsp + 96], 0
	mov	byte ptr [rsp + 97], 0
	mov	byte ptr [rsp + 98], 0
	mov	byte ptr [rsp + 99], 0
	mov	byte ptr [rsp + 100], 0
	mov	byte ptr [rsp + 101], 0
	mov	byte ptr [rsp + 102], 0
	mov	byte ptr [rsp + 103], 0
	mov	byte ptr [rsp + 104], 0
	mov	byte ptr [rsp + 105], 0
	mov	byte ptr [rsp + 106], 0
	mov	byte ptr [rsp + 107], 0
	mov	byte ptr [rsp + 108], 0
	mov	byte ptr [rsp + 109], 0
	mov	byte ptr [rsp + 110], 0
	mov	byte ptr [rsp + 111], 0
	mov	byte ptr [rsp + 112], 0
	mov	byte ptr [rsp + 113], 0
	mov	byte ptr [rsp + 114], 0
	mov	byte ptr [rsp + 115], 0
	mov	byte ptr [rsp + 116], 0
	mov	byte ptr [rsp + 117], 0
	mov	byte ptr [rsp + 118], 0
	mov	byte ptr [rsp + 119], 0
	mov	byte ptr [rsp + 120], 0
	mov	byte ptr [rsp + 121], 0
	mov	byte ptr [rsp + 122], 0
	mov	byte ptr [rsp + 123], 0
	mov	byte ptr [rsp + 124], 0
	mov	byte ptr [rsp + 125], 0
	mov	byte ptr [rsp + 126], 0
	xor	eax, eax
	mov	byte ptr [rsp + 127], 0
	.p2align	4
.LBB8_1:                                # =>This Inner Loop Header: Depth=1
	mov	byte ptr [rbx + rax], 0
	mov	byte ptr [rbx + rax + 1], 0
	mov	byte ptr [rbx + rax + 2], 0
	mov	byte ptr [rbx + rax + 3], 0
	mov	byte ptr [rbx + rax + 4], 0
	mov	byte ptr [rbx + rax + 5], 0
	mov	byte ptr [rbx + rax + 6], 0
	mov	byte ptr [rbx + rax + 7], 0
	mov	byte ptr [rbx + rax + 8], 0
	mov	byte ptr [rbx + rax + 9], 0
	mov	byte ptr [rbx + rax + 10], 0
	mov	byte ptr [rbx + rax + 11], 0
	mov	byte ptr [rbx + rax + 12], 0
	mov	byte ptr [rbx + rax + 13], 0
	mov	byte ptr [rbx + rax + 14], 0
	mov	byte ptr [rbx + rax + 15], 0
	mov	byte ptr [rbx + rax + 16], 0
	mov	byte ptr [rbx + rax + 17], 0
	mov	byte ptr [rbx + rax + 18], 0
	mov	byte ptr [rbx + rax + 19], 0
	mov	byte ptr [rbx + rax + 20], 0
	mov	byte ptr [rbx + rax + 21], 0
	mov	byte ptr [rbx + rax + 22], 0
	mov	byte ptr [rbx + rax + 23], 0
	mov	byte ptr [rbx + rax + 24], 0
	mov	byte ptr [rbx + rax + 25], 0
	mov	byte ptr [rbx + rax + 26], 0
	mov	byte ptr [rbx + rax + 27], 0
	mov	byte ptr [rbx + rax + 28], 0
	mov	byte ptr [rbx + rax + 29], 0
	mov	byte ptr [rbx + rax + 30], 0
	mov	byte ptr [rbx + rax + 31], 0
	add	rax, 32
	cmp	rax, 448
	jne	.LBB8_1
# %bb.2:
	add	rsp, 136
	.cfi_def_cfa_offset 40
	pop	rbx
	.cfi_def_cfa_offset 32
	pop	r14
	.cfi_def_cfa_offset 24
	pop	r15
	.cfi_def_cfa_offset 16
	pop	rbp
	.cfi_def_cfa_offset 8
	ret
.Lfunc_end8:
	.size	final_rounds, .Lfunc_end8-final_rounds
	.cfi_endproc
                                        # -- End function
	.globl	frogbard_hash                   # -- Begin function frogbard_hash
	.p2align	4
	.type	frogbard_hash,@function
frogbard_hash:                          # @frogbard_hash
	.cfi_startproc
# %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	push	r15
	push	r14
	push	r12
	push	rbx
	and	rsp, -64
	sub	rsp, 512
	.cfi_offset rbx, -48
	.cfi_offset r12, -40
	.cfi_offset r14, -32
	.cfi_offset r15, -24
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+32]
	vxorps	xmm0, xmm0, xmm0
	vmovaps	ymmword ptr [rsp + 416], ymm0
	vmovaps	ymmword ptr [rsp + 384], ymm0
	vmovaps	ymmword ptr [rsp + 352], ymm0
	vmovaps	ymmword ptr [rsp + 320], ymm0
	vmovaps	ymmword ptr [rsp + 288], ymm0
	vmovaps	ymmword ptr [rsp + 256], ymm0
	mov	r14, rsi
	mov	esi, 16
	mov	rbx, rdx
	mov	r15, rdi
	mov	r12, rsp
	mov	rdi, r12
	vmovaps	ymmword ptr [rsp], ymm2
	vmovaps	ymmword ptr [rsp + 32], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+64]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+96]
	vmovaps	ymmword ptr [rsp + 64], ymm2
	vmovaps	ymmword ptr [rsp + 96], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+128]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+160]
	vmovaps	ymmword ptr [rsp + 128], ymm2
	vmovaps	ymmword ptr [rsp + 160], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+192]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+224]
	vmovaps	ymmword ptr [rsp + 192], ymm2
	vmovaps	ymmword ptr [rsp + 224], ymm1
	vzeroupper
	call	frogbard_permute_rounds
	mov	ecx, 16
	mov	rdi, r12
	mov	rsi, r15
	mov	rdx, r14
	call	update_rounds
	mov	edx, 16
	mov	rdi, r12
	mov	rsi, rbx
	call	final_rounds
	lea	rsp, [rbp - 32]
	pop	rbx
	pop	r12
	pop	r14
	pop	r15
	pop	rbp
	.cfi_def_cfa rsp, 8
	ret
.Lfunc_end9:
	.size	frogbard_hash, .Lfunc_end9-frogbard_hash
	.cfi_endproc
                                        # -- End function
	.globl	frogbard_hash_reduced           # -- Begin function frogbard_hash_reduced
	.p2align	4
	.type	frogbard_hash_reduced,@function
frogbard_hash_reduced:                  # @frogbard_hash_reduced
	.cfi_startproc
# %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	and	rsp, -64
	sub	rsp, 512
	.cfi_offset rbx, -56
	.cfi_offset r12, -48
	.cfi_offset r13, -40
	.cfi_offset r14, -32
	.cfi_offset r15, -24
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+32]
	vxorps	xmm0, xmm0, xmm0
	vmovaps	ymmword ptr [rsp + 416], ymm0
	vmovaps	ymmword ptr [rsp + 384], ymm0
	vmovaps	ymmword ptr [rsp + 352], ymm0
	vmovaps	ymmword ptr [rsp + 320], ymm0
	vmovaps	ymmword ptr [rsp + 288], ymm0
	vmovaps	ymmword ptr [rsp + 256], ymm0
	cmp	edx, 16
	mov	eax, 16
	mov	r15d, 1
	mov	rbx, rcx
	mov	r14, rsi
	mov	r12, rdi
	mov	r13, rsp
	mov	rdi, r13
	cmovb	eax, edx
	test	edx, edx
	cmovne	r15d, eax
	mov	esi, r15d
	vmovaps	ymmword ptr [rsp], ymm2
	vmovaps	ymmword ptr [rsp + 32], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+64]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+96]
	vmovaps	ymmword ptr [rsp + 64], ymm2
	vmovaps	ymmword ptr [rsp + 96], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+128]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+160]
	vmovaps	ymmword ptr [rsp + 128], ymm2
	vmovaps	ymmword ptr [rsp + 160], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+192]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+224]
	vmovaps	ymmword ptr [rsp + 192], ymm2
	vmovaps	ymmword ptr [rsp + 224], ymm1
	vzeroupper
	call	frogbard_permute_rounds
	mov	rdi, r13
	mov	rsi, r12
	mov	rdx, r14
	mov	ecx, r15d
	call	update_rounds
	mov	rdi, r13
	mov	rsi, rbx
	mov	edx, r15d
	call	final_rounds
	lea	rsp, [rbp - 40]
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	.cfi_def_cfa rsp, 8
	ret
.Lfunc_end10:
	.size	frogbard_hash_reduced, .Lfunc_end10-frogbard_hash_reduced
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function frogbard_self_test
.LCPI11_0:
	.long	27                              # 0x1b
	.long	27                              # 0x1b
	.long	26                              # 0x1a
	.long	26                              # 0x1a
.LCPI11_2:
	.byte	33                              # 0x21
	.byte	34                              # 0x22
	.byte	35                              # 0x23
	.byte	36                              # 0x24
	.byte	37                              # 0x25
	.byte	38                              # 0x26
	.byte	39                              # 0x27
	.byte	40                              # 0x28
	.byte	41                              # 0x29
	.byte	42                              # 0x2a
	.byte	43                              # 0x2b
	.byte	44                              # 0x2c
	.byte	45                              # 0x2d
	.byte	46                              # 0x2e
	.byte	47                              # 0x2f
	.byte	48                              # 0x30
.LCPI11_3:
	.byte	49                              # 0x31
	.byte	50                              # 0x32
	.byte	51                              # 0x33
	.byte	52                              # 0x34
	.byte	53                              # 0x35
	.byte	54                              # 0x36
	.byte	55                              # 0x37
	.byte	56                              # 0x38
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
.LCPI11_4:
	.byte	57                              # 0x39
	.byte	58                              # 0x3a
	.byte	59                              # 0x3b
	.byte	60                              # 0x3c
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
.LCPI11_5:
	.quad	-6148914691236517206            # 0xaaaaaaaaaaaaaaaa
	.quad	6148914691236517205             # 0x5555555555555555
.LCPI11_6:
	.quad	6148914691236517205             # 0x5555555555555555
	.quad	-6148914691236517206            # 0xaaaaaaaaaaaaaaaa
.LCPI11_7:
	.zero	16,204
	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	5, 0x0
.LCPI11_1:
	.byte	1                               # 0x1
	.byte	2                               # 0x2
	.byte	3                               # 0x3
	.byte	4                               # 0x4
	.byte	5                               # 0x5
	.byte	6                               # 0x6
	.byte	7                               # 0x7
	.byte	8                               # 0x8
	.byte	9                               # 0x9
	.byte	10                              # 0xa
	.byte	11                              # 0xb
	.byte	12                              # 0xc
	.byte	13                              # 0xd
	.byte	14                              # 0xe
	.byte	15                              # 0xf
	.byte	16                              # 0x10
	.byte	17                              # 0x11
	.byte	18                              # 0x12
	.byte	19                              # 0x13
	.byte	20                              # 0x14
	.byte	21                              # 0x15
	.byte	22                              # 0x16
	.byte	23                              # 0x17
	.byte	24                              # 0x18
	.byte	25                              # 0x19
	.byte	26                              # 0x1a
	.byte	27                              # 0x1b
	.byte	28                              # 0x1c
	.byte	29                              # 0x1d
	.byte	30                              # 0x1e
	.byte	31                              # 0x1f
	.byte	32                              # 0x20
.LCPI11_9:
	.quad	-3689348814741910324            # 0xcccccccccccccccc
	.quad	3689348814741910323             # 0x3333333333333333
	.quad	-3689348814741910324            # 0xcccccccccccccccc
	.quad	-3689348814741910324            # 0xcccccccccccccccc
.LCPI11_10:
	.quad	1085102592571150095             # 0xf0f0f0f0f0f0f0f
	.quad	1085102592571150095             # 0xf0f0f0f0f0f0f0f
	.quad	1085102592571150095             # 0xf0f0f0f0f0f0f0f
	.quad	-1085102592571150096            # 0xf0f0f0f0f0f0f0f0
.LCPI11_11:
	.quad	-1085102592571150096            # 0xf0f0f0f0f0f0f0f0
	.quad	-1085102592571150096            # 0xf0f0f0f0f0f0f0f0
	.quad	-1085102592571150096            # 0xf0f0f0f0f0f0f0f0
	.quad	1085102592571150095             # 0xf0f0f0f0f0f0f0f
.LCPI11_12:
	.byte	178                             # 0xb2
	.byte	8                               # 0x8
	.byte	107                             # 0x6b
	.byte	198                             # 0xc6
	.byte	93                              # 0x5d
	.byte	87                              # 0x57
	.byte	125                             # 0x7d
	.byte	186                             # 0xba
	.byte	188                             # 0xbc
	.byte	206                             # 0xce
	.byte	221                             # 0xdd
	.byte	10                              # 0xa
	.byte	71                              # 0x47
	.byte	192                             # 0xc0
	.byte	173                             # 0xad
	.byte	174                             # 0xae
	.byte	178                             # 0xb2
	.byte	82                              # 0x52
	.byte	63                              # 0x3f
	.byte	149                             # 0x95
	.byte	74                              # 0x4a
	.byte	201                             # 0xc9
	.byte	122                             # 0x7a
	.byte	251                             # 0xfb
	.byte	219                             # 0xdb
	.byte	26                              # 0x1a
	.byte	1                               # 0x1
	.byte	172                             # 0xac
	.byte	170                             # 0xaa
	.byte	61                              # 0x3d
	.byte	217                             # 0xd9
	.byte	97                              # 0x61
.LCPI11_13:
	.byte	90                              # 0x5a
	.byte	110                             # 0x6e
	.byte	31                              # 0x1f
	.byte	86                              # 0x56
	.byte	145                             # 0x91
	.byte	181                             # 0xb5
	.byte	81                              # 0x51
	.byte	210                             # 0xd2
	.byte	65                              # 0x41
	.byte	80                              # 0x50
	.byte	147                             # 0x93
	.byte	21                              # 0x15
	.byte	20                              # 0x14
	.byte	71                              # 0x47
	.byte	214                             # 0xd6
	.byte	25                              # 0x19
	.byte	247                             # 0xf7
	.byte	25                              # 0x19
	.byte	173                             # 0xad
	.byte	146                             # 0x92
	.byte	11                              # 0xb
	.byte	184                             # 0xb8
	.byte	6                               # 0x6
	.byte	31                              # 0x1f
	.byte	15                              # 0xf
	.byte	136                             # 0x88
	.byte	165                             # 0xa5
	.byte	134                             # 0x86
	.byte	231                             # 0xe7
	.byte	169                             # 0xa9
	.byte	207                             # 0xcf
	.byte	96                              # 0x60
.LCPI11_14:
	.byte	27                              # 0x1b
	.byte	201                             # 0xc9
	.byte	36                              # 0x24
	.byte	184                             # 0xb8
	.byte	103                             # 0x67
	.byte	113                             # 0x71
	.byte	99                              # 0x63
	.byte	232                             # 0xe8
	.byte	129                             # 0x81
	.byte	135                             # 0x87
	.byte	163                             # 0xa3
	.byte	20                              # 0x14
	.byte	129                             # 0x81
	.byte	245                             # 0xf5
	.byte	83                              # 0x53
	.byte	226                             # 0xe2
	.byte	193                             # 0xc1
	.byte	196                             # 0xc4
	.byte	171                             # 0xab
	.byte	196                             # 0xc4
	.byte	143                             # 0x8f
	.byte	226                             # 0xe2
	.byte	19                              # 0x13
	.byte	206                             # 0xce
	.byte	17                              # 0x11
	.byte	161                             # 0xa1
	.byte	32                              # 0x20
	.byte	141                             # 0x8d
	.byte	113                             # 0x71
	.byte	71                              # 0x47
	.byte	65                              # 0x41
	.byte	19                              # 0x13
.LCPI11_15:
	.byte	215                             # 0xd7
	.byte	52                              # 0x34
	.byte	33                              # 0x21
	.byte	238                             # 0xee
	.byte	20                              # 0x14
	.byte	25                              # 0x19
	.byte	199                             # 0xc7
	.byte	186                             # 0xba
	.byte	10                              # 0xa
	.byte	93                              # 0x5d
	.byte	169                             # 0xa9
	.byte	29                              # 0x1d
	.byte	158                             # 0x9e
	.byte	114                             # 0x72
	.byte	140                             # 0x8c
	.byte	91                              # 0x5b
	.byte	67                              # 0x43
	.byte	131                             # 0x83
	.byte	226                             # 0xe2
	.byte	99                              # 0x63
	.byte	55                              # 0x37
	.byte	222                             # 0xde
	.byte	195                             # 0xc3
	.byte	195                             # 0xc3
	.byte	119                             # 0x77
	.byte	202                             # 0xca
	.byte	83                              # 0x53
	.byte	246                             # 0xf6
	.byte	86                              # 0x56
	.byte	181                             # 0xb5
	.byte	86                              # 0x56
	.byte	177                             # 0xb1
.LCPI11_16:
	.byte	17                              # 0x11
	.byte	148                             # 0x94
	.byte	23                              # 0x17
	.byte	154                             # 0x9a
	.byte	29                              # 0x1d
	.byte	160                             # 0xa0
	.byte	35                              # 0x23
	.byte	166                             # 0xa6
	.byte	41                              # 0x29
	.byte	172                             # 0xac
	.byte	47                              # 0x2f
	.byte	178                             # 0xb2
	.byte	53                              # 0x35
	.byte	184                             # 0xb8
	.byte	59                              # 0x3b
	.byte	190                             # 0xbe
	.byte	65                              # 0x41
	.byte	196                             # 0xc4
	.byte	71                              # 0x47
	.byte	202                             # 0xca
	.byte	77                              # 0x4d
	.byte	208                             # 0xd0
	.byte	83                              # 0x53
	.byte	214                             # 0xd6
	.byte	89                              # 0x59
	.byte	220                             # 0xdc
	.byte	95                              # 0x5f
	.byte	226                             # 0xe2
	.byte	101                             # 0x65
	.byte	232                             # 0xe8
	.byte	107                             # 0x6b
	.byte	238                             # 0xee
.LCPI11_17:
	.byte	113                             # 0x71
	.byte	244                             # 0xf4
	.byte	119                             # 0x77
	.byte	250                             # 0xfa
	.byte	125                             # 0x7d
	.byte	0                               # 0x0
	.byte	131                             # 0x83
	.byte	6                               # 0x6
	.byte	137                             # 0x89
	.byte	12                              # 0xc
	.byte	143                             # 0x8f
	.byte	18                              # 0x12
	.byte	149                             # 0x95
	.byte	24                              # 0x18
	.byte	155                             # 0x9b
	.byte	30                              # 0x1e
	.byte	161                             # 0xa1
	.byte	36                              # 0x24
	.byte	167                             # 0xa7
	.byte	42                              # 0x2a
	.byte	173                             # 0xad
	.byte	48                              # 0x30
	.byte	179                             # 0xb3
	.byte	54                              # 0x36
	.byte	185                             # 0xb9
	.byte	60                              # 0x3c
	.byte	191                             # 0xbf
	.byte	66                              # 0x42
	.byte	197                             # 0xc5
	.byte	72                              # 0x48
	.byte	203                             # 0xcb
	.byte	78                              # 0x4e
.LCPI11_18:
	.byte	209                             # 0xd1
	.byte	84                              # 0x54
	.byte	215                             # 0xd7
	.byte	90                              # 0x5a
	.byte	221                             # 0xdd
	.byte	96                              # 0x60
	.byte	227                             # 0xe3
	.byte	102                             # 0x66
	.byte	233                             # 0xe9
	.byte	108                             # 0x6c
	.byte	239                             # 0xef
	.byte	114                             # 0x72
	.byte	245                             # 0xf5
	.byte	120                             # 0x78
	.byte	251                             # 0xfb
	.byte	126                             # 0x7e
	.byte	1                               # 0x1
	.byte	132                             # 0x84
	.byte	7                               # 0x7
	.byte	138                             # 0x8a
	.byte	13                              # 0xd
	.byte	144                             # 0x90
	.byte	19                              # 0x13
	.byte	150                             # 0x96
	.byte	25                              # 0x19
	.byte	156                             # 0x9c
	.byte	31                              # 0x1f
	.byte	162                             # 0xa2
	.byte	37                              # 0x25
	.byte	168                             # 0xa8
	.byte	43                              # 0x2b
	.byte	174                             # 0xae
.LCPI11_19:
	.byte	49                              # 0x31
	.byte	180                             # 0xb4
	.byte	55                              # 0x37
	.byte	186                             # 0xba
	.byte	61                              # 0x3d
	.byte	192                             # 0xc0
	.byte	67                              # 0x43
	.byte	198                             # 0xc6
	.byte	73                              # 0x49
	.byte	204                             # 0xcc
	.byte	79                              # 0x4f
	.byte	210                             # 0xd2
	.byte	85                              # 0x55
	.byte	216                             # 0xd8
	.byte	91                              # 0x5b
	.byte	222                             # 0xde
	.byte	97                              # 0x61
	.byte	228                             # 0xe4
	.byte	103                             # 0x67
	.byte	234                             # 0xea
	.byte	109                             # 0x6d
	.byte	240                             # 0xf0
	.byte	115                             # 0x73
	.byte	246                             # 0xf6
	.byte	121                             # 0x79
	.byte	252                             # 0xfc
	.byte	127                             # 0x7f
	.byte	2                               # 0x2
	.byte	133                             # 0x85
	.byte	8                               # 0x8
	.byte	139                             # 0x8b
	.byte	14                              # 0xe
.LCPI11_20:
	.byte	145                             # 0x91
	.byte	20                              # 0x14
	.byte	151                             # 0x97
	.byte	26                              # 0x1a
	.byte	157                             # 0x9d
	.byte	32                              # 0x20
	.byte	163                             # 0xa3
	.byte	38                              # 0x26
	.byte	169                             # 0xa9
	.byte	44                              # 0x2c
	.byte	175                             # 0xaf
	.byte	50                              # 0x32
	.byte	181                             # 0xb5
	.byte	56                              # 0x38
	.byte	187                             # 0xbb
	.byte	62                              # 0x3e
	.byte	193                             # 0xc1
	.byte	68                              # 0x44
	.byte	199                             # 0xc7
	.byte	74                              # 0x4a
	.byte	205                             # 0xcd
	.byte	80                              # 0x50
	.byte	211                             # 0xd3
	.byte	86                              # 0x56
	.byte	217                             # 0xd9
	.byte	92                              # 0x5c
	.byte	223                             # 0xdf
	.byte	98                              # 0x62
	.byte	229                             # 0xe5
	.byte	104                             # 0x68
	.byte	235                             # 0xeb
	.byte	110                             # 0x6e
.LCPI11_21:
	.byte	241                             # 0xf1
	.byte	116                             # 0x74
	.byte	247                             # 0xf7
	.byte	122                             # 0x7a
	.byte	253                             # 0xfd
	.byte	128                             # 0x80
	.byte	3                               # 0x3
	.byte	134                             # 0x86
	.byte	9                               # 0x9
	.byte	140                             # 0x8c
	.byte	15                              # 0xf
	.byte	146                             # 0x92
	.byte	21                              # 0x15
	.byte	152                             # 0x98
	.byte	27                              # 0x1b
	.byte	158                             # 0x9e
	.byte	33                              # 0x21
	.byte	164                             # 0xa4
	.byte	39                              # 0x27
	.byte	170                             # 0xaa
	.byte	45                              # 0x2d
	.byte	176                             # 0xb0
	.byte	51                              # 0x33
	.byte	182                             # 0xb6
	.byte	57                              # 0x39
	.byte	188                             # 0xbc
	.byte	63                              # 0x3f
	.byte	194                             # 0xc2
	.byte	69                              # 0x45
	.byte	200                             # 0xc8
	.byte	75                              # 0x4b
	.byte	206                             # 0xce
.LCPI11_22:
	.byte	81                              # 0x51
	.byte	212                             # 0xd4
	.byte	87                              # 0x57
	.byte	218                             # 0xda
	.byte	93                              # 0x5d
	.byte	224                             # 0xe0
	.byte	99                              # 0x63
	.byte	230                             # 0xe6
	.byte	105                             # 0x69
	.byte	236                             # 0xec
	.byte	111                             # 0x6f
	.byte	242                             # 0xf2
	.byte	117                             # 0x75
	.byte	248                             # 0xf8
	.byte	123                             # 0x7b
	.byte	254                             # 0xfe
	.byte	129                             # 0x81
	.byte	4                               # 0x4
	.byte	135                             # 0x87
	.byte	10                              # 0xa
	.byte	141                             # 0x8d
	.byte	16                              # 0x10
	.byte	147                             # 0x93
	.byte	22                              # 0x16
	.byte	153                             # 0x99
	.byte	28                              # 0x1c
	.byte	159                             # 0x9f
	.byte	34                              # 0x22
	.byte	165                             # 0xa5
	.byte	40                              # 0x28
	.byte	171                             # 0xab
	.byte	46                              # 0x2e
.LCPI11_23:
	.byte	177                             # 0xb1
	.byte	52                              # 0x34
	.byte	183                             # 0xb7
	.byte	58                              # 0x3a
	.byte	189                             # 0xbd
	.byte	64                              # 0x40
	.byte	195                             # 0xc3
	.byte	70                              # 0x46
	.byte	201                             # 0xc9
	.byte	76                              # 0x4c
	.byte	207                             # 0xcf
	.byte	82                              # 0x52
	.byte	213                             # 0xd5
	.byte	88                              # 0x58
	.byte	219                             # 0xdb
	.byte	94                              # 0x5e
	.byte	225                             # 0xe1
	.byte	100                             # 0x64
	.byte	231                             # 0xe7
	.byte	106                             # 0x6a
	.byte	237                             # 0xed
	.byte	112                             # 0x70
	.byte	243                             # 0xf3
	.byte	118                             # 0x76
	.byte	249                             # 0xf9
	.byte	124                             # 0x7c
	.byte	255                             # 0xff
	.byte	130                             # 0x82
	.byte	5                               # 0x5
	.byte	136                             # 0x88
	.byte	11                              # 0xb
	.byte	142                             # 0x8e
.LCPI11_24:
	.quad	-7046029254386353131            # 0x9e3779b97f4a7c15
	.quad	-8074031068348523331            # 0x8ff34785799e5cbd
	.quad	-9102032882310693531            # 0x81af155173f23d65
	.quad	8316709377436687885             # 0x736ae31d6e461e0d
.LCPI11_29:
	.quad	4354685564936845354             # 0x3c6ef372fe94f82a
	.quad	3326683750974675154             # 0x2e2ac13ef8e8d8d2
	.quad	2298681937012504954             # 0x1fe68f0af33cb97a
	.quad	1270680123050334754             # 0x11a25cd6ed909a22
.LCPI11_30:
	.quad	-2691343689449507777            # 0xdaa66d2c7ddf743f
	.quad	-3719345503411677977            # 0xcc623af8783354e7
	.quad	-4747347317373848177            # 0xbe1e08c47287358f
	.quad	-5775349131336018377            # 0xafd9d6906cdb1637
.LCPI11_31:
	.quad	8709371129873690708             # 0x78dde6e5fd29f054
	.quad	7681369315911520508             # 0x6a99b4b1f77dd0fc
	.quad	6653367501949350308             # 0x5c55827df1d1b1a4
	.quad	5625365687987180108             # 0x4e115049ec25924c
.LCPI11_32:
	.quad	1663341875487337577             # 0x1715609f7c746c69
	.quad	635340061525167377              # 0x8d12e6b76c84d11
	.quad	-392661752437002823             # 0xfa8cfc37711c2db9
	.quad	-1420663566399173023            # 0xec48ca036b700e61
.LCPI11_33:
	.quad	-5382687378899015554            # 0xb54cda58fbbee87e
	.quad	-6410689192861185754            # 0xa708a824f612c926
	.quad	-7438691006823355954            # 0x98c475f0f066a9ce
	.quad	-8466692820785526154            # 0x8a8043bceaba8a76
.LCPI11_34:
	.quad	6018027440424182931             # 0x538454127b096493
	.quad	4990025626462012731             # 0x454021de755d453b
	.quad	3962023812499842531             # 0x36fbefaa6fb125e3
	.quad	2934021998537672331             # 0x28b7bd766a05068b
.LCPI11_35:
	.quad	-1028001813962170200            # 0xf1bbcdcbfa53e0a8
	.quad	-2056003627924340400            # 0xe3779b97f4a7c150
	.quad	-3084005441886510600            # 0xd5336963eefba1f8
	.quad	-4112007255848680800            # 0xc6ef372fe94f82a0
.LCPI11_36:
	.byte	0                               # 0x0
	.byte	17                              # 0x11
	.byte	34                              # 0x22
	.byte	51                              # 0x33
	.byte	68                              # 0x44
	.byte	85                              # 0x55
	.byte	102                             # 0x66
	.byte	119                             # 0x77
	.byte	136                             # 0x88
	.byte	153                             # 0x99
	.byte	170                             # 0xaa
	.byte	187                             # 0xbb
	.byte	204                             # 0xcc
	.byte	221                             # 0xdd
	.byte	238                             # 0xee
	.byte	255                             # 0xff
	.byte	16                              # 0x10
	.byte	33                              # 0x21
	.byte	50                              # 0x32
	.byte	67                              # 0x43
	.byte	84                              # 0x54
	.byte	101                             # 0x65
	.byte	118                             # 0x76
	.byte	135                             # 0x87
	.byte	152                             # 0x98
	.byte	169                             # 0xa9
	.byte	186                             # 0xba
	.byte	203                             # 0xcb
	.byte	220                             # 0xdc
	.byte	237                             # 0xed
	.byte	254                             # 0xfe
	.byte	15                              # 0xf
.LCPI11_37:
	.byte	32                              # 0x20
	.byte	49                              # 0x31
	.byte	66                              # 0x42
	.byte	83                              # 0x53
	.byte	100                             # 0x64
	.byte	117                             # 0x75
	.byte	134                             # 0x86
	.byte	151                             # 0x97
	.byte	168                             # 0xa8
	.byte	185                             # 0xb9
	.byte	202                             # 0xca
	.byte	219                             # 0xdb
	.byte	236                             # 0xec
	.byte	253                             # 0xfd
	.byte	14                              # 0xe
	.byte	31                              # 0x1f
	.byte	48                              # 0x30
	.byte	65                              # 0x41
	.byte	82                              # 0x52
	.byte	99                              # 0x63
	.byte	116                             # 0x74
	.byte	133                             # 0x85
	.byte	150                             # 0x96
	.byte	167                             # 0xa7
	.byte	184                             # 0xb8
	.byte	201                             # 0xc9
	.byte	218                             # 0xda
	.byte	235                             # 0xeb
	.byte	252                             # 0xfc
	.byte	13                              # 0xd
	.byte	30                              # 0x1e
	.byte	47                              # 0x2f
.LCPI11_38:
	.byte	64                              # 0x40
	.byte	81                              # 0x51
	.byte	98                              # 0x62
	.byte	115                             # 0x73
	.byte	132                             # 0x84
	.byte	149                             # 0x95
	.byte	166                             # 0xa6
	.byte	183                             # 0xb7
	.byte	200                             # 0xc8
	.byte	217                             # 0xd9
	.byte	234                             # 0xea
	.byte	251                             # 0xfb
	.byte	12                              # 0xc
	.byte	29                              # 0x1d
	.byte	46                              # 0x2e
	.byte	63                              # 0x3f
	.byte	80                              # 0x50
	.byte	97                              # 0x61
	.byte	114                             # 0x72
	.byte	131                             # 0x83
	.byte	148                             # 0x94
	.byte	165                             # 0xa5
	.byte	182                             # 0xb6
	.byte	199                             # 0xc7
	.byte	216                             # 0xd8
	.byte	233                             # 0xe9
	.byte	250                             # 0xfa
	.byte	11                              # 0xb
	.byte	28                              # 0x1c
	.byte	45                              # 0x2d
	.byte	62                              # 0x3e
	.byte	79                              # 0x4f
.LCPI11_39:
	.byte	96                              # 0x60
	.byte	113                             # 0x71
	.byte	130                             # 0x82
	.byte	147                             # 0x93
	.byte	164                             # 0xa4
	.byte	181                             # 0xb5
	.byte	198                             # 0xc6
	.byte	215                             # 0xd7
	.byte	232                             # 0xe8
	.byte	249                             # 0xf9
	.byte	10                              # 0xa
	.byte	27                              # 0x1b
	.byte	44                              # 0x2c
	.byte	61                              # 0x3d
	.byte	78                              # 0x4e
	.byte	95                              # 0x5f
	.byte	112                             # 0x70
	.byte	129                             # 0x81
	.byte	146                             # 0x92
	.byte	163                             # 0xa3
	.byte	180                             # 0xb4
	.byte	197                             # 0xc5
	.byte	214                             # 0xd6
	.byte	231                             # 0xe7
	.byte	248                             # 0xf8
	.byte	9                               # 0x9
	.byte	26                              # 0x1a
	.byte	43                              # 0x2b
	.byte	60                              # 0x3c
	.byte	77                              # 0x4d
	.byte	94                              # 0x5e
	.byte	111                             # 0x6f
.LCPI11_40:
	.byte	128                             # 0x80
	.byte	145                             # 0x91
	.byte	162                             # 0xa2
	.byte	179                             # 0xb3
	.byte	196                             # 0xc4
	.byte	213                             # 0xd5
	.byte	230                             # 0xe6
	.byte	247                             # 0xf7
	.byte	8                               # 0x8
	.byte	25                              # 0x19
	.byte	42                              # 0x2a
	.byte	59                              # 0x3b
	.byte	76                              # 0x4c
	.byte	93                              # 0x5d
	.byte	110                             # 0x6e
	.byte	127                             # 0x7f
	.byte	144                             # 0x90
	.byte	161                             # 0xa1
	.byte	178                             # 0xb2
	.byte	195                             # 0xc3
	.byte	212                             # 0xd4
	.byte	229                             # 0xe5
	.byte	246                             # 0xf6
	.byte	7                               # 0x7
	.byte	24                              # 0x18
	.byte	41                              # 0x29
	.byte	58                              # 0x3a
	.byte	75                              # 0x4b
	.byte	92                              # 0x5c
	.byte	109                             # 0x6d
	.byte	126                             # 0x7e
	.byte	143                             # 0x8f
.LCPI11_41:
	.byte	160                             # 0xa0
	.byte	177                             # 0xb1
	.byte	194                             # 0xc2
	.byte	211                             # 0xd3
	.byte	228                             # 0xe4
	.byte	245                             # 0xf5
	.byte	6                               # 0x6
	.byte	23                              # 0x17
	.byte	40                              # 0x28
	.byte	57                              # 0x39
	.byte	74                              # 0x4a
	.byte	91                              # 0x5b
	.byte	108                             # 0x6c
	.byte	125                             # 0x7d
	.byte	142                             # 0x8e
	.byte	159                             # 0x9f
	.byte	176                             # 0xb0
	.byte	193                             # 0xc1
	.byte	210                             # 0xd2
	.byte	227                             # 0xe3
	.byte	244                             # 0xf4
	.byte	5                               # 0x5
	.byte	22                              # 0x16
	.byte	39                              # 0x27
	.byte	56                              # 0x38
	.byte	73                              # 0x49
	.byte	90                              # 0x5a
	.byte	107                             # 0x6b
	.byte	124                             # 0x7c
	.byte	141                             # 0x8d
	.byte	158                             # 0x9e
	.byte	175                             # 0xaf
.LCPI11_42:
	.byte	192                             # 0xc0
	.byte	209                             # 0xd1
	.byte	226                             # 0xe2
	.byte	243                             # 0xf3
	.byte	4                               # 0x4
	.byte	21                              # 0x15
	.byte	38                              # 0x26
	.byte	55                              # 0x37
	.byte	72                              # 0x48
	.byte	89                              # 0x59
	.byte	106                             # 0x6a
	.byte	123                             # 0x7b
	.byte	140                             # 0x8c
	.byte	157                             # 0x9d
	.byte	174                             # 0xae
	.byte	191                             # 0xbf
	.byte	208                             # 0xd0
	.byte	225                             # 0xe1
	.byte	242                             # 0xf2
	.byte	3                               # 0x3
	.byte	20                              # 0x14
	.byte	37                              # 0x25
	.byte	54                              # 0x36
	.byte	71                              # 0x47
	.byte	88                              # 0x58
	.byte	105                             # 0x69
	.byte	122                             # 0x7a
	.byte	139                             # 0x8b
	.byte	156                             # 0x9c
	.byte	173                             # 0xad
	.byte	190                             # 0xbe
	.byte	207                             # 0xcf
.LCPI11_43:
	.byte	224                             # 0xe0
	.byte	241                             # 0xf1
	.byte	2                               # 0x2
	.byte	19                              # 0x13
	.byte	36                              # 0x24
	.byte	53                              # 0x35
	.byte	70                              # 0x46
	.byte	87                              # 0x57
	.byte	104                             # 0x68
	.byte	121                             # 0x79
	.byte	138                             # 0x8a
	.byte	155                             # 0x9b
	.byte	172                             # 0xac
	.byte	189                             # 0xbd
	.byte	206                             # 0xce
	.byte	223                             # 0xdf
	.byte	240                             # 0xf0
	.byte	1                               # 0x1
	.byte	18                              # 0x12
	.byte	35                              # 0x23
	.byte	52                              # 0x34
	.byte	69                              # 0x45
	.byte	86                              # 0x56
	.byte	103                             # 0x67
	.byte	120                             # 0x78
	.byte	137                             # 0x89
	.byte	154                             # 0x9a
	.byte	171                             # 0xab
	.byte	188                             # 0xbc
	.byte	205                             # 0xcd
	.byte	222                             # 0xde
	.byte	239                             # 0xef
.LCPI11_44:
	.byte	31                              # 0x1f
	.byte	50                              # 0x32
	.byte	69                              # 0x45
	.byte	88                              # 0x58
	.byte	107                             # 0x6b
	.byte	126                             # 0x7e
	.byte	145                             # 0x91
	.byte	164                             # 0xa4
	.byte	183                             # 0xb7
	.byte	202                             # 0xca
	.byte	221                             # 0xdd
	.byte	240                             # 0xf0
	.byte	3                               # 0x3
	.byte	22                              # 0x16
	.byte	41                              # 0x29
	.byte	60                              # 0x3c
	.byte	79                              # 0x4f
	.byte	98                              # 0x62
	.byte	117                             # 0x75
	.byte	136                             # 0x88
	.byte	155                             # 0x9b
	.byte	174                             # 0xae
	.byte	193                             # 0xc1
	.byte	212                             # 0xd4
	.byte	231                             # 0xe7
	.byte	250                             # 0xfa
	.byte	13                              # 0xd
	.byte	32                              # 0x20
	.byte	51                              # 0x33
	.byte	70                              # 0x46
	.byte	89                              # 0x59
	.byte	108                             # 0x6c
.LCPI11_45:
	.byte	127                             # 0x7f
	.byte	146                             # 0x92
	.byte	165                             # 0xa5
	.byte	184                             # 0xb8
	.byte	203                             # 0xcb
	.byte	222                             # 0xde
	.byte	241                             # 0xf1
	.byte	4                               # 0x4
	.byte	23                              # 0x17
	.byte	42                              # 0x2a
	.byte	61                              # 0x3d
	.byte	80                              # 0x50
	.byte	99                              # 0x63
	.byte	118                             # 0x76
	.byte	137                             # 0x89
	.byte	156                             # 0x9c
	.byte	175                             # 0xaf
	.byte	194                             # 0xc2
	.byte	213                             # 0xd5
	.byte	232                             # 0xe8
	.byte	251                             # 0xfb
	.byte	14                              # 0xe
	.byte	33                              # 0x21
	.byte	52                              # 0x34
	.byte	71                              # 0x47
	.byte	90                              # 0x5a
	.byte	109                             # 0x6d
	.byte	128                             # 0x80
	.byte	147                             # 0x93
	.byte	166                             # 0xa6
	.byte	185                             # 0xb9
	.byte	204                             # 0xcc
.LCPI11_46:
	.byte	223                             # 0xdf
	.byte	242                             # 0xf2
	.byte	5                               # 0x5
	.byte	24                              # 0x18
	.byte	43                              # 0x2b
	.byte	62                              # 0x3e
	.byte	81                              # 0x51
	.byte	100                             # 0x64
	.byte	119                             # 0x77
	.byte	138                             # 0x8a
	.byte	157                             # 0x9d
	.byte	176                             # 0xb0
	.byte	195                             # 0xc3
	.byte	214                             # 0xd6
	.byte	233                             # 0xe9
	.byte	252                             # 0xfc
	.byte	15                              # 0xf
	.byte	34                              # 0x22
	.byte	53                              # 0x35
	.byte	72                              # 0x48
	.byte	91                              # 0x5b
	.byte	110                             # 0x6e
	.byte	129                             # 0x81
	.byte	148                             # 0x94
	.byte	167                             # 0xa7
	.byte	186                             # 0xba
	.byte	205                             # 0xcd
	.byte	224                             # 0xe0
	.byte	243                             # 0xf3
	.byte	6                               # 0x6
	.byte	25                              # 0x19
	.byte	44                              # 0x2c
.LCPI11_47:
	.byte	63                              # 0x3f
	.byte	82                              # 0x52
	.byte	101                             # 0x65
	.byte	120                             # 0x78
	.byte	139                             # 0x8b
	.byte	158                             # 0x9e
	.byte	177                             # 0xb1
	.byte	196                             # 0xc4
	.byte	215                             # 0xd7
	.byte	234                             # 0xea
	.byte	253                             # 0xfd
	.byte	16                              # 0x10
	.byte	35                              # 0x23
	.byte	54                              # 0x36
	.byte	73                              # 0x49
	.byte	92                              # 0x5c
	.byte	111                             # 0x6f
	.byte	130                             # 0x82
	.byte	149                             # 0x95
	.byte	168                             # 0xa8
	.byte	187                             # 0xbb
	.byte	206                             # 0xce
	.byte	225                             # 0xe1
	.byte	244                             # 0xf4
	.byte	7                               # 0x7
	.byte	26                              # 0x1a
	.byte	45                              # 0x2d
	.byte	64                              # 0x40
	.byte	83                              # 0x53
	.byte	102                             # 0x66
	.byte	121                             # 0x79
	.byte	140                             # 0x8c
.LCPI11_48:
	.byte	159                             # 0x9f
	.byte	178                             # 0xb2
	.byte	197                             # 0xc5
	.byte	216                             # 0xd8
	.byte	235                             # 0xeb
	.byte	254                             # 0xfe
	.byte	17                              # 0x11
	.byte	36                              # 0x24
	.byte	55                              # 0x37
	.byte	74                              # 0x4a
	.byte	93                              # 0x5d
	.byte	112                             # 0x70
	.byte	131                             # 0x83
	.byte	150                             # 0x96
	.byte	169                             # 0xa9
	.byte	188                             # 0xbc
	.byte	207                             # 0xcf
	.byte	226                             # 0xe2
	.byte	245                             # 0xf5
	.byte	8                               # 0x8
	.byte	27                              # 0x1b
	.byte	46                              # 0x2e
	.byte	65                              # 0x41
	.byte	84                              # 0x54
	.byte	103                             # 0x67
	.byte	122                             # 0x7a
	.byte	141                             # 0x8d
	.byte	160                             # 0xa0
	.byte	179                             # 0xb3
	.byte	198                             # 0xc6
	.byte	217                             # 0xd9
	.byte	236                             # 0xec
.LCPI11_49:
	.byte	255                             # 0xff
	.byte	18                              # 0x12
	.byte	37                              # 0x25
	.byte	56                              # 0x38
	.byte	75                              # 0x4b
	.byte	94                              # 0x5e
	.byte	113                             # 0x71
	.byte	132                             # 0x84
	.byte	151                             # 0x97
	.byte	170                             # 0xaa
	.byte	189                             # 0xbd
	.byte	208                             # 0xd0
	.byte	227                             # 0xe3
	.byte	246                             # 0xf6
	.byte	9                               # 0x9
	.byte	28                              # 0x1c
	.byte	47                              # 0x2f
	.byte	66                              # 0x42
	.byte	85                              # 0x55
	.byte	104                             # 0x68
	.byte	123                             # 0x7b
	.byte	142                             # 0x8e
	.byte	161                             # 0xa1
	.byte	180                             # 0xb4
	.byte	199                             # 0xc7
	.byte	218                             # 0xda
	.byte	237                             # 0xed
	.byte	0                               # 0x0
	.byte	19                              # 0x13
	.byte	38                              # 0x26
	.byte	57                              # 0x39
	.byte	76                              # 0x4c
.LCPI11_50:
	.byte	95                              # 0x5f
	.byte	114                             # 0x72
	.byte	133                             # 0x85
	.byte	152                             # 0x98
	.byte	171                             # 0xab
	.byte	190                             # 0xbe
	.byte	209                             # 0xd1
	.byte	228                             # 0xe4
	.byte	247                             # 0xf7
	.byte	10                              # 0xa
	.byte	29                              # 0x1d
	.byte	48                              # 0x30
	.byte	67                              # 0x43
	.byte	86                              # 0x56
	.byte	105                             # 0x69
	.byte	124                             # 0x7c
	.byte	143                             # 0x8f
	.byte	162                             # 0xa2
	.byte	181                             # 0xb5
	.byte	200                             # 0xc8
	.byte	219                             # 0xdb
	.byte	238                             # 0xee
	.byte	1                               # 0x1
	.byte	20                              # 0x14
	.byte	39                              # 0x27
	.byte	58                              # 0x3a
	.byte	77                              # 0x4d
	.byte	96                              # 0x60
	.byte	115                             # 0x73
	.byte	134                             # 0x86
	.byte	153                             # 0x99
	.byte	172                             # 0xac
.LCPI11_51:
	.byte	191                             # 0xbf
	.byte	210                             # 0xd2
	.byte	229                             # 0xe5
	.byte	248                             # 0xf8
	.byte	11                              # 0xb
	.byte	30                              # 0x1e
	.byte	49                              # 0x31
	.byte	68                              # 0x44
	.byte	87                              # 0x57
	.byte	106                             # 0x6a
	.byte	125                             # 0x7d
	.byte	144                             # 0x90
	.byte	163                             # 0xa3
	.byte	182                             # 0xb6
	.byte	201                             # 0xc9
	.byte	220                             # 0xdc
	.byte	239                             # 0xef
	.byte	2                               # 0x2
	.byte	21                              # 0x15
	.byte	40                              # 0x28
	.byte	59                              # 0x3b
	.byte	78                              # 0x4e
	.byte	97                              # 0x61
	.byte	116                             # 0x74
	.byte	135                             # 0x87
	.byte	154                             # 0x9a
	.byte	173                             # 0xad
	.byte	192                             # 0xc0
	.byte	211                             # 0xd3
	.byte	230                             # 0xe6
	.byte	249                             # 0xf9
	.byte	12                              # 0xc
.LCPI11_52:
	.byte	62                              # 0x3e
	.byte	83                              # 0x53
	.byte	104                             # 0x68
	.byte	125                             # 0x7d
	.byte	146                             # 0x92
	.byte	167                             # 0xa7
	.byte	188                             # 0xbc
	.byte	209                             # 0xd1
	.byte	230                             # 0xe6
	.byte	251                             # 0xfb
	.byte	16                              # 0x10
	.byte	37                              # 0x25
	.byte	58                              # 0x3a
	.byte	79                              # 0x4f
	.byte	100                             # 0x64
	.byte	121                             # 0x79
	.byte	142                             # 0x8e
	.byte	163                             # 0xa3
	.byte	184                             # 0xb8
	.byte	205                             # 0xcd
	.byte	226                             # 0xe2
	.byte	247                             # 0xf7
	.byte	12                              # 0xc
	.byte	33                              # 0x21
	.byte	54                              # 0x36
	.byte	75                              # 0x4b
	.byte	96                              # 0x60
	.byte	117                             # 0x75
	.byte	138                             # 0x8a
	.byte	159                             # 0x9f
	.byte	180                             # 0xb4
	.byte	201                             # 0xc9
.LCPI11_53:
	.byte	222                             # 0xde
	.byte	243                             # 0xf3
	.byte	8                               # 0x8
	.byte	29                              # 0x1d
	.byte	50                              # 0x32
	.byte	71                              # 0x47
	.byte	92                              # 0x5c
	.byte	113                             # 0x71
	.byte	134                             # 0x86
	.byte	155                             # 0x9b
	.byte	176                             # 0xb0
	.byte	197                             # 0xc5
	.byte	218                             # 0xda
	.byte	239                             # 0xef
	.byte	4                               # 0x4
	.byte	25                              # 0x19
	.byte	46                              # 0x2e
	.byte	67                              # 0x43
	.byte	88                              # 0x58
	.byte	109                             # 0x6d
	.byte	130                             # 0x82
	.byte	151                             # 0x97
	.byte	172                             # 0xac
	.byte	193                             # 0xc1
	.byte	214                             # 0xd6
	.byte	235                             # 0xeb
	.byte	0                               # 0x0
	.byte	21                              # 0x15
	.byte	42                              # 0x2a
	.byte	63                              # 0x3f
	.byte	84                              # 0x54
	.byte	105                             # 0x69
.LCPI11_54:
	.byte	126                             # 0x7e
	.byte	147                             # 0x93
	.byte	168                             # 0xa8
	.byte	189                             # 0xbd
	.byte	210                             # 0xd2
	.byte	231                             # 0xe7
	.byte	252                             # 0xfc
	.byte	17                              # 0x11
	.byte	38                              # 0x26
	.byte	59                              # 0x3b
	.byte	80                              # 0x50
	.byte	101                             # 0x65
	.byte	122                             # 0x7a
	.byte	143                             # 0x8f
	.byte	164                             # 0xa4
	.byte	185                             # 0xb9
	.byte	206                             # 0xce
	.byte	227                             # 0xe3
	.byte	248                             # 0xf8
	.byte	13                              # 0xd
	.byte	34                              # 0x22
	.byte	55                              # 0x37
	.byte	76                              # 0x4c
	.byte	97                              # 0x61
	.byte	118                             # 0x76
	.byte	139                             # 0x8b
	.byte	160                             # 0xa0
	.byte	181                             # 0xb5
	.byte	202                             # 0xca
	.byte	223                             # 0xdf
	.byte	244                             # 0xf4
	.byte	9                               # 0x9
.LCPI11_55:
	.byte	30                              # 0x1e
	.byte	51                              # 0x33
	.byte	72                              # 0x48
	.byte	93                              # 0x5d
	.byte	114                             # 0x72
	.byte	135                             # 0x87
	.byte	156                             # 0x9c
	.byte	177                             # 0xb1
	.byte	198                             # 0xc6
	.byte	219                             # 0xdb
	.byte	240                             # 0xf0
	.byte	5                               # 0x5
	.byte	26                              # 0x1a
	.byte	47                              # 0x2f
	.byte	68                              # 0x44
	.byte	89                              # 0x59
	.byte	110                             # 0x6e
	.byte	131                             # 0x83
	.byte	152                             # 0x98
	.byte	173                             # 0xad
	.byte	194                             # 0xc2
	.byte	215                             # 0xd7
	.byte	236                             # 0xec
	.byte	1                               # 0x1
	.byte	22                              # 0x16
	.byte	43                              # 0x2b
	.byte	64                              # 0x40
	.byte	85                              # 0x55
	.byte	106                             # 0x6a
	.byte	127                             # 0x7f
	.byte	148                             # 0x94
	.byte	169                             # 0xa9
.LCPI11_56:
	.byte	190                             # 0xbe
	.byte	211                             # 0xd3
	.byte	232                             # 0xe8
	.byte	253                             # 0xfd
	.byte	18                              # 0x12
	.byte	39                              # 0x27
	.byte	60                              # 0x3c
	.byte	81                              # 0x51
	.byte	102                             # 0x66
	.byte	123                             # 0x7b
	.byte	144                             # 0x90
	.byte	165                             # 0xa5
	.byte	186                             # 0xba
	.byte	207                             # 0xcf
	.byte	228                             # 0xe4
	.byte	249                             # 0xf9
	.byte	14                              # 0xe
	.byte	35                              # 0x23
	.byte	56                              # 0x38
	.byte	77                              # 0x4d
	.byte	98                              # 0x62
	.byte	119                             # 0x77
	.byte	140                             # 0x8c
	.byte	161                             # 0xa1
	.byte	182                             # 0xb6
	.byte	203                             # 0xcb
	.byte	224                             # 0xe0
	.byte	245                             # 0xf5
	.byte	10                              # 0xa
	.byte	31                              # 0x1f
	.byte	52                              # 0x34
	.byte	73                              # 0x49
.LCPI11_57:
	.byte	94                              # 0x5e
	.byte	115                             # 0x73
	.byte	136                             # 0x88
	.byte	157                             # 0x9d
	.byte	178                             # 0xb2
	.byte	199                             # 0xc7
	.byte	220                             # 0xdc
	.byte	241                             # 0xf1
	.byte	6                               # 0x6
	.byte	27                              # 0x1b
	.byte	48                              # 0x30
	.byte	69                              # 0x45
	.byte	90                              # 0x5a
	.byte	111                             # 0x6f
	.byte	132                             # 0x84
	.byte	153                             # 0x99
	.byte	174                             # 0xae
	.byte	195                             # 0xc3
	.byte	216                             # 0xd8
	.byte	237                             # 0xed
	.byte	2                               # 0x2
	.byte	23                              # 0x17
	.byte	44                              # 0x2c
	.byte	65                              # 0x41
	.byte	86                              # 0x56
	.byte	107                             # 0x6b
	.byte	128                             # 0x80
	.byte	149                             # 0x95
	.byte	170                             # 0xaa
	.byte	191                             # 0xbf
	.byte	212                             # 0xd4
	.byte	233                             # 0xe9
.LCPI11_58:
	.byte	254                             # 0xfe
	.byte	19                              # 0x13
	.byte	40                              # 0x28
	.byte	61                              # 0x3d
	.byte	82                              # 0x52
	.byte	103                             # 0x67
	.byte	124                             # 0x7c
	.byte	145                             # 0x91
	.byte	166                             # 0xa6
	.byte	187                             # 0xbb
	.byte	208                             # 0xd0
	.byte	229                             # 0xe5
	.byte	250                             # 0xfa
	.byte	15                              # 0xf
	.byte	36                              # 0x24
	.byte	57                              # 0x39
	.byte	78                              # 0x4e
	.byte	99                              # 0x63
	.byte	120                             # 0x78
	.byte	141                             # 0x8d
	.byte	162                             # 0xa2
	.byte	183                             # 0xb7
	.byte	204                             # 0xcc
	.byte	225                             # 0xe1
	.byte	246                             # 0xf6
	.byte	11                              # 0xb
	.byte	32                              # 0x20
	.byte	53                              # 0x35
	.byte	74                              # 0x4a
	.byte	95                              # 0x5f
	.byte	116                             # 0x74
	.byte	137                             # 0x89
.LCPI11_59:
	.byte	158                             # 0x9e
	.byte	179                             # 0xb3
	.byte	200                             # 0xc8
	.byte	221                             # 0xdd
	.byte	242                             # 0xf2
	.byte	7                               # 0x7
	.byte	28                              # 0x1c
	.byte	49                              # 0x31
	.byte	70                              # 0x46
	.byte	91                              # 0x5b
	.byte	112                             # 0x70
	.byte	133                             # 0x85
	.byte	154                             # 0x9a
	.byte	175                             # 0xaf
	.byte	196                             # 0xc4
	.byte	217                             # 0xd9
	.byte	238                             # 0xee
	.byte	3                               # 0x3
	.byte	24                              # 0x18
	.byte	45                              # 0x2d
	.byte	66                              # 0x42
	.byte	87                              # 0x57
	.byte	108                             # 0x6c
	.byte	129                             # 0x81
	.byte	150                             # 0x96
	.byte	171                             # 0xab
	.byte	192                             # 0xc0
	.byte	213                             # 0xd5
	.byte	234                             # 0xea
	.byte	255                             # 0xff
	.byte	20                              # 0x14
	.byte	41                              # 0x29
.LCPI11_60:
	.byte	93                              # 0x5d
	.byte	116                             # 0x74
	.byte	139                             # 0x8b
	.byte	162                             # 0xa2
	.byte	185                             # 0xb9
	.byte	208                             # 0xd0
	.byte	231                             # 0xe7
	.byte	254                             # 0xfe
	.byte	21                              # 0x15
	.byte	44                              # 0x2c
	.byte	67                              # 0x43
	.byte	90                              # 0x5a
	.byte	113                             # 0x71
	.byte	136                             # 0x88
	.byte	159                             # 0x9f
	.byte	182                             # 0xb6
	.byte	205                             # 0xcd
	.byte	228                             # 0xe4
	.byte	251                             # 0xfb
	.byte	18                              # 0x12
	.byte	41                              # 0x29
	.byte	64                              # 0x40
	.byte	87                              # 0x57
	.byte	110                             # 0x6e
	.byte	133                             # 0x85
	.byte	156                             # 0x9c
	.byte	179                             # 0xb3
	.byte	202                             # 0xca
	.byte	225                             # 0xe1
	.byte	248                             # 0xf8
	.byte	15                              # 0xf
	.byte	38                              # 0x26
.LCPI11_61:
	.byte	61                              # 0x3d
	.byte	84                              # 0x54
	.byte	107                             # 0x6b
	.byte	130                             # 0x82
	.byte	153                             # 0x99
	.byte	176                             # 0xb0
	.byte	199                             # 0xc7
	.byte	222                             # 0xde
	.byte	245                             # 0xf5
	.byte	12                              # 0xc
	.byte	35                              # 0x23
	.byte	58                              # 0x3a
	.byte	81                              # 0x51
	.byte	104                             # 0x68
	.byte	127                             # 0x7f
	.byte	150                             # 0x96
	.byte	173                             # 0xad
	.byte	196                             # 0xc4
	.byte	219                             # 0xdb
	.byte	242                             # 0xf2
	.byte	9                               # 0x9
	.byte	32                              # 0x20
	.byte	55                              # 0x37
	.byte	78                              # 0x4e
	.byte	101                             # 0x65
	.byte	124                             # 0x7c
	.byte	147                             # 0x93
	.byte	170                             # 0xaa
	.byte	193                             # 0xc1
	.byte	216                             # 0xd8
	.byte	239                             # 0xef
	.byte	6                               # 0x6
.LCPI11_62:
	.byte	29                              # 0x1d
	.byte	52                              # 0x34
	.byte	75                              # 0x4b
	.byte	98                              # 0x62
	.byte	121                             # 0x79
	.byte	144                             # 0x90
	.byte	167                             # 0xa7
	.byte	190                             # 0xbe
	.byte	213                             # 0xd5
	.byte	236                             # 0xec
	.byte	3                               # 0x3
	.byte	26                              # 0x1a
	.byte	49                              # 0x31
	.byte	72                              # 0x48
	.byte	95                              # 0x5f
	.byte	118                             # 0x76
	.byte	141                             # 0x8d
	.byte	164                             # 0xa4
	.byte	187                             # 0xbb
	.byte	210                             # 0xd2
	.byte	233                             # 0xe9
	.byte	0                               # 0x0
	.byte	23                              # 0x17
	.byte	46                              # 0x2e
	.byte	69                              # 0x45
	.byte	92                              # 0x5c
	.byte	115                             # 0x73
	.byte	138                             # 0x8a
	.byte	161                             # 0xa1
	.byte	184                             # 0xb8
	.byte	207                             # 0xcf
	.byte	230                             # 0xe6
.LCPI11_63:
	.byte	253                             # 0xfd
	.byte	20                              # 0x14
	.byte	43                              # 0x2b
	.byte	66                              # 0x42
	.byte	89                              # 0x59
	.byte	112                             # 0x70
	.byte	135                             # 0x87
	.byte	158                             # 0x9e
	.byte	181                             # 0xb5
	.byte	204                             # 0xcc
	.byte	227                             # 0xe3
	.byte	250                             # 0xfa
	.byte	17                              # 0x11
	.byte	40                              # 0x28
	.byte	63                              # 0x3f
	.byte	86                              # 0x56
	.byte	109                             # 0x6d
	.byte	132                             # 0x84
	.byte	155                             # 0x9b
	.byte	178                             # 0xb2
	.byte	201                             # 0xc9
	.byte	224                             # 0xe0
	.byte	247                             # 0xf7
	.byte	14                              # 0xe
	.byte	37                              # 0x25
	.byte	60                              # 0x3c
	.byte	83                              # 0x53
	.byte	106                             # 0x6a
	.byte	129                             # 0x81
	.byte	152                             # 0x98
	.byte	175                             # 0xaf
	.byte	198                             # 0xc6
.LCPI11_64:
	.byte	221                             # 0xdd
	.byte	244                             # 0xf4
	.byte	11                              # 0xb
	.byte	34                              # 0x22
	.byte	57                              # 0x39
	.byte	80                              # 0x50
	.byte	103                             # 0x67
	.byte	126                             # 0x7e
	.byte	149                             # 0x95
	.byte	172                             # 0xac
	.byte	195                             # 0xc3
	.byte	218                             # 0xda
	.byte	241                             # 0xf1
	.byte	8                               # 0x8
	.byte	31                              # 0x1f
	.byte	54                              # 0x36
	.byte	77                              # 0x4d
	.byte	100                             # 0x64
	.byte	123                             # 0x7b
	.byte	146                             # 0x92
	.byte	169                             # 0xa9
	.byte	192                             # 0xc0
	.byte	215                             # 0xd7
	.byte	238                             # 0xee
	.byte	5                               # 0x5
	.byte	28                              # 0x1c
	.byte	51                              # 0x33
	.byte	74                              # 0x4a
	.byte	97                              # 0x61
	.byte	120                             # 0x78
	.byte	143                             # 0x8f
	.byte	166                             # 0xa6
.LCPI11_65:
	.byte	189                             # 0xbd
	.byte	212                             # 0xd4
	.byte	235                             # 0xeb
	.byte	2                               # 0x2
	.byte	25                              # 0x19
	.byte	48                              # 0x30
	.byte	71                              # 0x47
	.byte	94                              # 0x5e
	.byte	117                             # 0x75
	.byte	140                             # 0x8c
	.byte	163                             # 0xa3
	.byte	186                             # 0xba
	.byte	209                             # 0xd1
	.byte	232                             # 0xe8
	.byte	255                             # 0xff
	.byte	22                              # 0x16
	.byte	45                              # 0x2d
	.byte	68                              # 0x44
	.byte	91                              # 0x5b
	.byte	114                             # 0x72
	.byte	137                             # 0x89
	.byte	160                             # 0xa0
	.byte	183                             # 0xb7
	.byte	206                             # 0xce
	.byte	229                             # 0xe5
	.byte	252                             # 0xfc
	.byte	19                              # 0x13
	.byte	42                              # 0x2a
	.byte	65                              # 0x41
	.byte	88                              # 0x58
	.byte	111                             # 0x6f
	.byte	134                             # 0x86
.LCPI11_66:
	.byte	157                             # 0x9d
	.byte	180                             # 0xb4
	.byte	203                             # 0xcb
	.byte	226                             # 0xe2
	.byte	249                             # 0xf9
	.byte	16                              # 0x10
	.byte	39                              # 0x27
	.byte	62                              # 0x3e
	.byte	85                              # 0x55
	.byte	108                             # 0x6c
	.byte	131                             # 0x83
	.byte	154                             # 0x9a
	.byte	177                             # 0xb1
	.byte	200                             # 0xc8
	.byte	223                             # 0xdf
	.byte	246                             # 0xf6
	.byte	13                              # 0xd
	.byte	36                              # 0x24
	.byte	59                              # 0x3b
	.byte	82                              # 0x52
	.byte	105                             # 0x69
	.byte	128                             # 0x80
	.byte	151                             # 0x97
	.byte	174                             # 0xae
	.byte	197                             # 0xc5
	.byte	220                             # 0xdc
	.byte	243                             # 0xf3
	.byte	10                              # 0xa
	.byte	33                              # 0x21
	.byte	56                              # 0x38
	.byte	79                              # 0x4f
	.byte	102                             # 0x66
.LCPI11_67:
	.byte	125                             # 0x7d
	.byte	148                             # 0x94
	.byte	171                             # 0xab
	.byte	194                             # 0xc2
	.byte	217                             # 0xd9
	.byte	240                             # 0xf0
	.byte	7                               # 0x7
	.byte	30                              # 0x1e
	.byte	53                              # 0x35
	.byte	76                              # 0x4c
	.byte	99                              # 0x63
	.byte	122                             # 0x7a
	.byte	145                             # 0x91
	.byte	168                             # 0xa8
	.byte	191                             # 0xbf
	.byte	214                             # 0xd6
	.byte	237                             # 0xed
	.byte	4                               # 0x4
	.byte	27                              # 0x1b
	.byte	50                              # 0x32
	.byte	73                              # 0x49
	.byte	96                              # 0x60
	.byte	119                             # 0x77
	.byte	142                             # 0x8e
	.byte	165                             # 0xa5
	.byte	188                             # 0xbc
	.byte	211                             # 0xd3
	.byte	234                             # 0xea
	.byte	1                               # 0x1
	.byte	24                              # 0x18
	.byte	47                              # 0x2f
	.byte	70                              # 0x46
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0
.LCPI11_8:
	.quad	-1085102592571150096            # 0xf0f0f0f0f0f0f0f0
.LCPI11_25:
	.quad	3210233709                      # 0xbf58476d
.LCPI11_26:
	.quad	-4658895280553007687            # 0xbf58476d1ce4e5b9
.LCPI11_27:
	.quad	2496678331                      # 0x94d049bb
.LCPI11_28:
	.quad	-7723592293110705685            # 0x94d049bb133111eb
	.section	.rodata,"a",@progbits
.LCPI11_68:
	.byte	204                             # 0xcc
	.text
	.globl	frogbard_self_test
	.p2align	4
	.type	frogbard_self_test,@function
frogbard_self_test:                     # @frogbard_self_test
	.cfi_startproc
# %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	and	rsp, -64
	sub	rsp, 3264
	.cfi_offset rbx, -56
	.cfi_offset r12, -48
	.cfi_offset r13, -40
	.cfi_offset r14, -32
	.cfi_offset r15, -24
	vpbroadcastq	ymm1, qword ptr [rip + .LCPI11_8] # ymm1 = [17361641481138401520,17361641481138401520,17361641481138401520,17361641481138401520]
	lea	rax, [rip + FROGBARD_SBOX]
	lea	r15, [rip + FROGBARD_SBOX+7]
	lea	rdx, [rip + FROGBARD_SBOX+3]
	xor	esi, esi
	vpxor	xmm0, xmm0, xmm0
	mov	rdi, rax
.LBB11_1:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB11_2 Depth 2
                                        #     Child Loop BB11_12 Depth 2
                                        #       Child Loop BB11_13 Depth 3
                                        #     Child Loop BB11_17 Depth 2
                                        #     Child Loop BB11_31 Depth 2
                                        #       Child Loop BB11_32 Depth 3
	mov	r13, rsi
	shl	r13, 8
	vmovdqa	ymmword ptr [rsp + 800], ymm0
	vmovdqa	ymmword ptr [rsp + 768], ymm0
	vmovdqa	ymmword ptr [rsp + 736], ymm0
	vmovdqa	ymmword ptr [rsp + 704], ymm0
	vmovdqa	ymmword ptr [rsp + 672], ymm0
	vmovdqa	ymmword ptr [rsp + 640], ymm0
	vmovdqa	ymmword ptr [rsp + 608], ymm0
	vmovdqa	ymmword ptr [rsp + 576], ymm0
	lea	r14, [rax + r13]
	xor	eax, eax
.LBB11_2:                               #   Parent Loop BB11_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzx	ecx, byte ptr [r15 + rax - 7]
	cmp	byte ptr [rsp + rcx + 576], 0
	jne	.LBB11_67
# %bb.3:                                #   in Loop: Header=BB11_2 Depth=2
	mov	byte ptr [rsp + rcx + 576], 1
	movzx	ecx, byte ptr [r15 + rax - 6]
	cmp	byte ptr [rsp + rcx + 576], 0
	jne	.LBB11_67
# %bb.4:                                #   in Loop: Header=BB11_2 Depth=2
	mov	byte ptr [rsp + rcx + 576], 1
	movzx	ecx, byte ptr [r15 + rax - 5]
	cmp	byte ptr [rsp + rcx + 576], 0
	jne	.LBB11_67
# %bb.5:                                #   in Loop: Header=BB11_2 Depth=2
	mov	byte ptr [rsp + rcx + 576], 1
	movzx	ecx, byte ptr [r15 + rax - 4]
	cmp	byte ptr [rsp + rcx + 576], 0
	jne	.LBB11_67
# %bb.6:                                #   in Loop: Header=BB11_2 Depth=2
	mov	byte ptr [rsp + rcx + 576], 1
	movzx	ecx, byte ptr [r15 + rax - 3]
	cmp	byte ptr [rsp + rcx + 576], 0
	jne	.LBB11_67
# %bb.7:                                #   in Loop: Header=BB11_2 Depth=2
	mov	byte ptr [rsp + rcx + 576], 1
	movzx	ecx, byte ptr [r15 + rax - 2]
	cmp	byte ptr [rsp + rcx + 576], 0
	jne	.LBB11_67
# %bb.8:                                #   in Loop: Header=BB11_2 Depth=2
	mov	byte ptr [rsp + rcx + 576], 1
	movzx	ecx, byte ptr [r15 + rax - 1]
	cmp	byte ptr [rsp + rcx + 576], 0
	jne	.LBB11_67
# %bb.9:                                #   in Loop: Header=BB11_2 Depth=2
	mov	byte ptr [rsp + rcx + 576], 1
	movzx	ecx, byte ptr [r15 + rax]
	cmp	byte ptr [rsp + rcx + 576], 0
	jne	.LBB11_67
# %bb.10:                               #   in Loop: Header=BB11_2 Depth=2
	add	rax, 8
	mov	byte ptr [rsp + rcx + 576], 1
	cmp	rax, 256
	jne	.LBB11_2
# %bb.11:                               #   in Loop: Header=BB11_1 Depth=1
	mov	ebx, 1
	xor	r12d, r12d
	mov	qword ptr [rsp + 272], rdi      # 8-byte Spill
	vmovdqa	ymmword ptr [rsp + 2240], ymm1  # 32-byte Spill
	mov	qword ptr [rsp + 2208], rsi     # 8-byte Spill
	mov	qword ptr [rsp + 2272], rdx     # 8-byte Spill
	.p2align	4
.LBB11_12:                              #   Parent Loop BB11_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB11_13 Depth 3
	mov	edx, 1024
	lea	rdi, [rsp + 576]
	xor	esi, esi
	vzeroupper
	call	memset@PLT
	xor	eax, eax
	.p2align	4
.LBB11_13:                              #   Parent Loop BB11_1 Depth=1
                                        #     Parent Loop BB11_12 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	mov	ecx, ebx
	xor	ecx, eax
	movzx	ecx, byte ptr [r14 + rcx]
	xor	cl, byte ptr [r15 + rax - 7]
	movzx	ecx, cl
	inc	dword ptr [rsp + 4*rcx + 576]
	lea	ecx, [rax + 1]
	xor	ecx, ebx
	movzx	ecx, byte ptr [r14 + rcx]
	xor	cl, byte ptr [r15 + rax - 6]
	movzx	ecx, cl
	inc	dword ptr [rsp + 4*rcx + 576]
	lea	ecx, [rax + 2]
	xor	ecx, ebx
	movzx	ecx, byte ptr [r14 + rcx]
	xor	cl, byte ptr [r15 + rax - 5]
	movzx	ecx, cl
	inc	dword ptr [rsp + 4*rcx + 576]
	lea	ecx, [rax + 3]
	xor	ecx, ebx
	movzx	ecx, byte ptr [r14 + rcx]
	xor	cl, byte ptr [r15 + rax - 4]
	movzx	ecx, cl
	inc	dword ptr [rsp + 4*rcx + 576]
	lea	ecx, [rax + 4]
	xor	ecx, ebx
	movzx	ecx, byte ptr [r14 + rcx]
	xor	cl, byte ptr [r15 + rax - 3]
	movzx	ecx, cl
	inc	dword ptr [rsp + 4*rcx + 576]
	lea	ecx, [rax + 5]
	xor	ecx, ebx
	movzx	ecx, byte ptr [r14 + rcx]
	xor	cl, byte ptr [r15 + rax - 2]
	movzx	ecx, cl
	inc	dword ptr [rsp + 4*rcx + 576]
	lea	ecx, [rax + 6]
	xor	ecx, ebx
	movzx	ecx, byte ptr [r14 + rcx]
	xor	cl, byte ptr [r15 + rax - 1]
	movzx	ecx, cl
	inc	dword ptr [rsp + 4*rcx + 576]
	lea	ecx, [rax + 7]
	xor	ecx, ebx
	movzx	ecx, byte ptr [r14 + rcx]
	xor	cl, byte ptr [r15 + rax]
	add	rax, 8
	movzx	ecx, cl
	inc	dword ptr [rsp + 4*rcx + 576]
	cmp	rax, 256
	jne	.LBB11_13
# %bb.14:                               #   in Loop: Header=BB11_12 Depth=2
	vmovd	xmm0, r12d
	inc	ebx
	vpbroadcastd	ymm0, xmm0
	vpmaxud	ymm1, ymm0, ymmword ptr [rsp + 576]
	vpmaxud	ymm2, ymm0, ymmword ptr [rsp + 608]
	vpmaxud	ymm3, ymm0, ymmword ptr [rsp + 640]
	vpmaxud	ymm0, ymm0, ymmword ptr [rsp + 672]
	vpmaxud	ymm1, ymm1, ymmword ptr [rsp + 704]
	vpmaxud	ymm2, ymm2, ymmword ptr [rsp + 736]
	vpmaxud	ymm3, ymm3, ymmword ptr [rsp + 768]
	vpmaxud	ymm0, ymm0, ymmword ptr [rsp + 800]
	vpmaxud	ymm1, ymm1, ymmword ptr [rsp + 832]
	vpmaxud	ymm2, ymm2, ymmword ptr [rsp + 864]
	vpmaxud	ymm3, ymm3, ymmword ptr [rsp + 896]
	vpmaxud	ymm0, ymm0, ymmword ptr [rsp + 928]
	vpmaxud	ymm1, ymm1, ymmword ptr [rsp + 960]
	vpmaxud	ymm2, ymm2, ymmword ptr [rsp + 992]
	vpmaxud	ymm3, ymm3, ymmword ptr [rsp + 1024]
	vpmaxud	ymm0, ymm0, ymmword ptr [rsp + 1056]
	vpmaxud	ymm1, ymm1, ymmword ptr [rsp + 1088]
	vpmaxud	ymm2, ymm2, ymmword ptr [rsp + 1120]
	vpmaxud	ymm3, ymm3, ymmword ptr [rsp + 1152]
	vpmaxud	ymm0, ymm0, ymmword ptr [rsp + 1184]
	vpmaxud	ymm1, ymm1, ymmword ptr [rsp + 1216]
	vpmaxud	ymm2, ymm2, ymmword ptr [rsp + 1248]
	vpmaxud	ymm3, ymm3, ymmword ptr [rsp + 1280]
	vpmaxud	ymm0, ymm0, ymmword ptr [rsp + 1312]
	vpmaxud	ymm1, ymm1, ymmword ptr [rsp + 1344]
	vpmaxud	ymm2, ymm2, ymmword ptr [rsp + 1376]
	vpmaxud	ymm3, ymm3, ymmword ptr [rsp + 1408]
	vpmaxud	ymm0, ymm0, ymmword ptr [rsp + 1440]
	vpmaxud	ymm1, ymm1, ymmword ptr [rsp + 1472]
	vpmaxud	ymm2, ymm2, ymmword ptr [rsp + 1504]
	vpmaxud	ymm3, ymm3, ymmword ptr [rsp + 1536]
	vpmaxud	ymm0, ymm0, ymmword ptr [rsp + 1568]
	vpmaxud	ymm1, ymm1, ymm2
	vpmaxud	ymm0, ymm3, ymm0
	vpmaxud	ymm0, ymm1, ymm0
	vextracti128	xmm1, ymm0, 1
	vpmaxud	xmm0, xmm0, xmm1
	vpshufd	xmm1, xmm0, 238                 # xmm1 = xmm0[2,3,2,3]
	vpmaxud	xmm0, xmm0, xmm1
	vpshufd	xmm1, xmm0, 85                  # xmm1 = xmm0[1,1,1,1]
	vpmaxud	xmm0, xmm0, xmm1
	vmovd	r12d, xmm0
	cmp	ebx, 256
	jne	.LBB11_12
# %bb.15:                               #   in Loop: Header=BB11_1 Depth=1
	cmp	r12d, 4
	jne	.LBB11_67
# %bb.16:                               #   in Loop: Header=BB11_1 Depth=1
	mov	r8, qword ptr [rsp + 2272]      # 8-byte Reload
	lea	r9, [rip + FROGBARD_SBOX_INV]
	xor	eax, eax
.LBB11_17:                              #   Parent Loop BB11_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzx	ecx, byte ptr [r8 + rax - 3]
	mov	r14d, 2
	cmp	rax, rcx
	je	.LBB11_68
# %bb.18:                               #   in Loop: Header=BB11_17 Depth=2
	mov	edx, ecx
	xor	edx, eax
	cmp	edx, 255
	je	.LBB11_68
# %bb.19:                               #   in Loop: Header=BB11_17 Depth=2
	lea	rdx, [r9 + r13]
	movzx	ecx, byte ptr [rcx + rdx]
	cmp	rax, rcx
	jne	.LBB11_68
# %bb.20:                               #   in Loop: Header=BB11_17 Depth=2
	movzx	esi, byte ptr [r8 + rax - 2]
	lea	rcx, [rax + 1]
	cmp	rcx, rsi
	je	.LBB11_68
# %bb.21:                               #   in Loop: Header=BB11_17 Depth=2
	mov	edi, esi
	xor	edi, ecx
	cmp	edi, 255
	je	.LBB11_68
# %bb.22:                               #   in Loop: Header=BB11_17 Depth=2
	movzx	esi, byte ptr [rsi + rdx]
	cmp	rcx, rsi
	jne	.LBB11_68
# %bb.23:                               #   in Loop: Header=BB11_17 Depth=2
	movzx	esi, byte ptr [r8 + rax - 1]
	inc	rcx
	cmp	rcx, rsi
	je	.LBB11_68
# %bb.24:                               #   in Loop: Header=BB11_17 Depth=2
	mov	edi, esi
	xor	edi, ecx
	cmp	edi, 255
	je	.LBB11_68
# %bb.25:                               #   in Loop: Header=BB11_17 Depth=2
	movzx	esi, byte ptr [rsi + rdx]
	cmp	rcx, rsi
	jne	.LBB11_68
# %bb.26:                               #   in Loop: Header=BB11_17 Depth=2
	movzx	eax, byte ptr [r8 + rax]
	inc	rcx
	cmp	rcx, rax
	je	.LBB11_68
# %bb.27:                               #   in Loop: Header=BB11_17 Depth=2
	mov	esi, eax
	xor	esi, ecx
	cmp	esi, 255
	je	.LBB11_68
# %bb.28:                               #   in Loop: Header=BB11_17 Depth=2
	movzx	eax, byte ptr [rax + rdx]
	cmp	rcx, rax
	jne	.LBB11_68
# %bb.29:                               #   in Loop: Header=BB11_17 Depth=2
	inc	rcx
	mov	rax, rcx
	cmp	rcx, 256
	jne	.LBB11_17
# %bb.30:                               #   in Loop: Header=BB11_1 Depth=1
	mov	r11, qword ptr [rsp + 2208]     # 8-byte Reload
	lea	rax, [rip + FROGBARD_SBOX_IN_XOR]
	movzx	ecx, byte ptr [r11 + rax]
	lea	rax, [rip + FROGBARD_SBOX_PIN]
	mov	rbx, qword ptr [rax + 8*r11]
	lea	rax, [rip + FROGBARD_SBOX_OUT_XOR]
	movzx	eax, byte ptr [r11 + rax]
	vmovd	xmm1, ecx
	vmovq	xmm0, rbx
	vpbroadcastd	ymm1, xmm1
	movzx	r14d, bl
	vpmovzxbd	ymm0, xmm0              # ymm0 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero,xmm0[2],zero,zero,zero,xmm0[3],zero,zero,zero,xmm0[4],zero,zero,zero,xmm0[5],zero,zero,zero,xmm0[6],zero,zero,zero,xmm0[7],zero,zero,zero
	mov	qword ptr [rsp + 496], r14      # 8-byte Spill
	vpsrlvd	ymm0, ymm1, ymm0
	vmovd	xmm1, eax
	vpslld	ymm0, ymm0, 31
	vpbroadcastd	xmm1, xmm1
	vpsllvd	xmm1, xmm1, xmmword ptr [rip + .LCPI11_0]
	vmovmskps	ecx, ymm0
	mov	esi, ecx
	mov	edi, ecx
	mov	r8d, ecx
	mov	r9d, ecx
	mov	r12d, ecx
	mov	r13d, ecx
	mov	r10d, ecx
	and	ecx, 1
	shr	r9b, 2
	shr	sil, 5
	shr	dil, 4
	shr	r8b, 3
	neg	rcx
	shr	r12b, 7
	shr	r13b, 6
	shr	r10b
	movzx	edx, r9b
	movzx	r9d, r8b
	movzx	r8d, dil
	movzx	edi, sil
	mov	esi, eax
	and	esi, 1
	mov	qword ptr [rsp + 504], rcx      # 8-byte Spill
	movzx	ecx, bh
	movzx	r14d, r10b
	mov	r10d, ebx
	shr	r10d, 24
	neg	esi
	mov	qword ptr [rsp + 488], rcx      # 8-byte Spill
	movzx	ecx, r12b
	and	r14d, 1
	and	edx, 1
	and	r9d, 1
	and	r8d, 1
	and	edi, 1
	mov	qword ptr [rsp + 320], r10      # 8-byte Spill
	vmovd	xmm0, esi
	mov	esi, eax
	shl	esi, 30
	neg	rcx
	neg	r14
	neg	r9
	neg	r8
	neg	rdi
	neg	rdx
	sar	esi, 31
	mov	qword ptr [rsp + 480], rcx      # 8-byte Spill
	mov	ecx, 2064
	mov	qword ptr [rsp + 344], r14      # 8-byte Spill
	mov	qword ptr [rsp + 328], r9       # 8-byte Spill
	mov	qword ptr [rsp + 312], r8       # 8-byte Spill
	mov	qword ptr [rsp + 304], rdi      # 8-byte Spill
	vpsrad	xmm1, xmm1, 31
	vpinsrd	xmm0, xmm0, esi, 1
	movzx	esi, r13b
	bextr	r13d, ebx, ecx
	mov	ecx, 2080
	bextr	r12, rbx, rcx
	mov	ecx, 2088
	and	esi, 1
	vpshufd	xmm0, xmm0, 80                  # xmm0 = xmm0[0,0,1,1]
	mov	qword ptr [rsp + 288], r13      # 8-byte Spill
	bextr	rcx, rbx, rcx
	neg	rsi
	mov	qword ptr [rsp + 280], r12      # 8-byte Spill
	mov	qword ptr [rsp + 472], rcx      # 8-byte Spill
	mov	ecx, 2096
	mov	qword ptr [rsp + 296], rsi      # 8-byte Spill
	bextr	rcx, rbx, rcx
	shr	rbx, 56
	mov	qword ptr [rsp + 464], rcx      # 8-byte Spill
	mov	ecx, eax
	shl	ecx, 29
	mov	qword ptr [rsp + 352], rbx      # 8-byte Spill
	sar	ecx, 31
	movsxd	rcx, ecx
	mov	qword ptr [rsp + 448], rcx      # 8-byte Spill
	mov	ecx, eax
	shl	eax, 25
	shl	ecx, 28
	sar	eax, 31
	sar	ecx, 31
	cdqe
	movsxd	rcx, ecx
	mov	qword ptr [rsp + 432], rax      # 8-byte Spill
	xor	eax, eax
	cmp	r11, 2
	mov	qword ptr [rsp + 440], rcx      # 8-byte Spill
	sete	al
	neg	rax
	mov	qword ptr [rsp + 424], rax      # 8-byte Spill
	lea	rax, [rip + FROGBARD_SBOX_POUT]
	movzx	ecx, byte ptr [rax + 8*r11]
	mov	qword ptr [rsp + 392], rcx      # 8-byte Spill
	movzx	ecx, byte ptr [rax + 8*r11 + 1]
	mov	qword ptr [rsp + 384], rcx      # 8-byte Spill
	movzx	ecx, byte ptr [rax + 8*r11 + 2]
	mov	qword ptr [rsp + 416], rcx      # 8-byte Spill
	movzx	ecx, byte ptr [rax + 8*r11 + 3]
	mov	qword ptr [rsp + 408], rcx      # 8-byte Spill
	movzx	ecx, byte ptr [rax + 8*r11 + 4]
	mov	qword ptr [rsp + 376], rcx      # 8-byte Spill
	movzx	ecx, byte ptr [rax + 8*r11 + 5]
	mov	qword ptr [rsp + 400], rcx      # 8-byte Spill
	movzx	ecx, byte ptr [rax + 8*r11 + 6]
	movzx	eax, byte ptr [rax + 8*r11 + 7]
	mov	r11, rdx
	mov	rdx, r10
	mov	qword ptr [rsp + 336], r11      # 8-byte Spill
	mov	qword ptr [rsp + 456], rax      # 8-byte Spill
	mov	rax, qword ptr [rsp + 272]      # 8-byte Reload
	mov	qword ptr [rsp + 368], rcx      # 8-byte Spill
	xor	ecx, ecx
	mov	qword ptr [rsp + 192], rax      # 8-byte Spill
.LBB11_31:                              #   Parent Loop BB11_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB11_32 Depth 3
	vmovd	xmm2, ecx
	mov	byte ptr [rsp + 1664], cl
	mov	eax, ecx
	vmovdqa	xmm8, xmmword ptr [rip + .LCPI11_5] # xmm8 = [12297829382473034410,6148914691236517205]
	vpbroadcastb	xmm10, byte ptr [rip + .LCPI11_68] # xmm10 = [204,204,204,204,204,204,204,204,204,204,204,204,204,204,204,204]
	vmovdqa	ymm11, ymmword ptr [rsp + 2240] # 32-byte Reload
	mov	qword ptr [rsp + 360], rcx      # 8-byte Spill
	vpbroadcastb	ymm2, xmm2
	vpor	ymm3, ymm2, ymmword ptr [rip + .LCPI11_1]
	or	al, 61
	vmovdqu	ymmword ptr [rsp + 1665], ymm3
	vpor	xmm3, xmm2, xmmword ptr [rip + .LCPI11_2]
	vmovdqu	xmmword ptr [rsp + 1697], xmm3
	vpor	xmm3, xmm2, xmmword ptr [rip + .LCPI11_3]
	vpor	xmm2, xmm2, xmmword ptr [rip + .LCPI11_4]
	vmovq	qword ptr [rsp + 1713], xmm3
	vmovd	dword ptr [rsp + 1721], xmm2
	mov	byte ptr [rsp + 1725], al
	mov	eax, ecx
	or	al, 62
	mov	byte ptr [rsp + 1726], al
	mov	eax, ecx
	mov	rcx, qword ptr [rsp + 472]      # 8-byte Reload
	or	al, 63
	mov	byte ptr [rsp + 1727], al
	movzx	eax, byte ptr [rsp + 1664]
	vmovups	xmm2, xmmword ptr [rsp + 1665]
	mov	byte ptr [rsp + 576], al
	mov	rax, qword ptr [rsp + 1681]
	vmovups	xmmword ptr [rsp + 577], xmm2
	vmovups	xmm2, xmmword ptr [rsp + 1696]
	mov	qword ptr [rsp + 593], rax
	mov	eax, dword ptr [rsp + 1689]
	mov	dword ptr [rsp + 601], eax
	movzx	eax, word ptr [rsp + 1693]
	vmovups	xmmword ptr [rsp + 608], xmm2
	vmovdqa	xmm2, xmmword ptr [rsp + 576]
	mov	word ptr [rsp + 605], ax
	movzx	eax, byte ptr [rsp + 1695]
	vpaddq	xmm4, xmm2, xmm2
	vpsrlq	xmm5, xmm2, 1
	vpandn	xmm2, xmm8, xmm2
	mov	byte ptr [rsp + 607], al
	mov	rax, qword ptr [rsp + 1712]
	vpalignr	xmm4, xmm5, xmm4, 8             # xmm4 = xmm4[8,9,10,11,12,13,14,15],xmm5[0,1,2,3,4,5,6,7]
	vpand	xmm4, xmm8, xmm4
	vpor	xmm2, xmm4, xmm2
	mov	qword ptr [rsp + 624], rax
	mov	eax, dword ptr [rsp + 1720]
	mov	dword ptr [rsp + 632], eax
	movzx	eax, byte ptr [rsp + 1724]
	mov	byte ptr [rsp + 636], al
	movzx	eax, byte ptr [rsp + 1725]
	mov	byte ptr [rsp + 637], al
	movzx	eax, byte ptr [rsp + 1726]
	mov	byte ptr [rsp + 638], al
	movzx	eax, byte ptr [rsp + 1727]
	mov	byte ptr [rsp + 639], al
	mov	rax, qword ptr [rsp + 488]      # 8-byte Reload
	vmovdqa	xmm3, xmmword ptr [rsp + 592]
	vpaddq	xmm4, xmm3, xmm3
	vpsrlq	xmm5, xmm3, 1
	vpandn	xmm3, xmm8, xmm3
	vpalignr	xmm4, xmm5, xmm4, 8             # xmm4 = xmm4[8,9,10,11,12,13,14,15],xmm5[0,1,2,3,4,5,6,7]
	vmovdqa	xmm5, xmmword ptr [rsp + 624]
	vpand	xmm4, xmm8, xmm4
	vpor	xmm3, xmm4, xmm3
	vmovdqa	xmm4, xmmword ptr [rsp + 608]
	vpaddq	xmm6, xmm4, xmm4
	vpsrlq	xmm7, xmm4, 1
	vpandn	xmm4, xmm8, xmm4
	vpalignr	xmm6, xmm7, xmm6, 8             # xmm6 = xmm6[8,9,10,11,12,13,14,15],xmm7[0,1,2,3,4,5,6,7]
	vpsrlq	xmm7, xmm5, 1
	vpand	xmm6, xmm8, xmm6
	vpor	xmm4, xmm6, xmm4
	vpaddq	xmm6, xmm5, xmm5
	vpandn	xmm5, xmm8, xmm5
	vpalignr	xmm6, xmm7, xmm6, 8             # xmm6 = xmm6[8,9,10,11,12,13,14,15],xmm7[0,1,2,3,4,5,6,7]
	vpandn	xmm7, xmm10, xmm2
	vpsrlq	xmm2, xmm2, 2
	vpand	xmm6, xmm8, xmm6
	vpandn	xmm2, xmm10, xmm2
	vpandn	xmm8, xmm10, xmm4
	vpor	xmm5, xmm6, xmm5
	vpsllq	xmm6, xmm3, 2
	vpand	xmm3, xmm10, xmm3
	vpand	xmm6, xmm10, xmm6
	vpor	xmm2, xmm3, xmm2
	vpsrlq	xmm3, xmm4, 2
	vpand	xmm4, xmm10, xmm5
	vpor	xmm6, xmm6, xmm7
	vpsllq	xmm7, xmm5, 2
	vpandn	xmm3, xmm10, xmm3
	vpandn	xmm5, xmm11, xmm2
	vpsrlq	xmm2, xmm2, 4
	vpand	xmm7, xmm10, xmm7
	vpor	xmm3, xmm4, xmm3
	vpandn	xmm9, xmm11, xmm6
	vpsrlq	xmm6, xmm6, 4
	vpandn	xmm2, xmm11, xmm2
	vpor	xmm7, xmm8, xmm7
	vpsllq	xmm4, xmm3, 4
	vpand	xmm3, xmm11, xmm3
	vpandn	xmm6, xmm11, xmm6
	vpsllq	xmm8, xmm7, 4
	vpand	xmm4, xmm11, xmm4
	vpand	xmm7, xmm11, xmm7
	vpor	xmm2, xmm3, xmm2
	vpand	xmm8, xmm8, xmm11
	vpor	xmm6, xmm7, xmm6
	vpor	xmm4, xmm4, xmm5
	vmovdqa	xmm7, xmmword ptr [rip + .LCPI11_6] # xmm7 = [6148914691236517205,12297829382473034410]
	vpor	xmm8, xmm8, xmm9
	vmovdqa	xmmword ptr [rsp + 576], xmm8
	vmovdqa	xmmword ptr [rsp + 608], xmm6
	vmovdqa	xmmword ptr [rsp + 592], xmm4
	vmovdqa	xmmword ptr [rsp + 624], xmm2
	vmovdqa	ymm8, ymmword ptr [rip + .LCPI11_9] # ymm8 = [14757395258967641292,3689348814741910323,14757395258967641292,14757395258967641292]
	mov	r10, qword ptr [rsp + 8*rax + 576]
	mov	rax, qword ptr [rsp + 8*r13 + 576]
	mov	r13, qword ptr [rsp + 8*rcx + 576]
	mov	rcx, qword ptr [rsp + 464]      # 8-byte Reload
	mov	r12, qword ptr [rsp + 8*r12 + 576]
	xor	r10, r14
	mov	r14, qword ptr [rsp + 8*rbx + 576]
	mov	rcx, qword ptr [rsp + 8*rcx + 576]
	xor	rax, r11
	mov	r11, qword ptr [rsp + 8*rdx + 576]
	xor	r12, r8
	xor	r13, rdi
	xor	r14, qword ptr [rsp + 480]      # 8-byte Folded Reload
	mov	rdx, r12
	xor	rdx, rax
	mov	rbx, rdx
	mov	qword ptr [rsp + 568], rdx      # 8-byte Spill
	xor	rcx, rsi
	xor	r11, r9
	mov	rsi, r14
	xor	rsi, r10
	xor	r13, rcx
	mov	r8, rsi
	xor	r8, rdx
	mov	qword ptr [rsp + 248], rsi      # 8-byte Spill
	mov	rsi, r14
	xor	rsi, r12
	xor	r11, r8
	mov	rdi, rsi
	mov	rsi, r14
	xor	rsi, rax
	mov	qword ptr [rsp + 160], r8       # 8-byte Spill
	mov	qword ptr [rsp + 560], rdi      # 8-byte Spill
	xor	rax, r11
	xor	r11, rcx
	mov	qword ptr [rsp + 552], rsi      # 8-byte Spill
	mov	rcx, rax
	xor	rcx, r13
	mov	r8, r11
	xor	r8, rdi
	mov	qword ptr [rsp + 528], rax      # 8-byte Spill
	mov	rdx, rcx
	xor	rdx, r8
	mov	r9, rcx
	mov	qword ptr [rsp + 544], r9       # 8-byte Spill
	mov	qword ptr [rsp + 176], r8       # 8-byte Spill
	mov	rcx, rdx
	mov	qword ptr [rsp + 256], rdx      # 8-byte Spill
	mov	rdx, r8
	and	rdx, rdi
	mov	rdi, rcx
	and	rdi, rbx
	mov	rcx, r9
	and	rcx, rsi
	mov	rbx, r9
	mov	r8, rsi
	xor	rdi, rdx
	xor	rcx, rdx
	mov	rdx, qword ptr [rsp + 496]      # 8-byte Reload
	mov	r9, qword ptr [rsp + 8*rdx + 576]
	mov	rdx, r13
	xor	r9, qword ptr [rsp + 504]       # 8-byte Folded Reload
	xor	rdx, r9
	xor	r10, rdx
	mov	qword ptr [rsp + 184], rdx      # 8-byte Spill
	mov	rdx, rax
	and	rdx, qword ptr [rsp + 160]      # 8-byte Folded Reload
	mov	qword ptr [rsp + 168], r10      # 8-byte Spill
	xor	r10, rsi
	mov	rsi, rax
	xor	rsi, r9
	mov	rax, qword ptr [rsp + 248]      # 8-byte Reload
	mov	qword ptr [rsp + 264], rsi      # 8-byte Spill
	mov	qword ptr [rsp + 536], r10      # 8-byte Spill
	and	rsi, r10
	mov	r10, qword ptr [rsp + 184]      # 8-byte Reload
	xor	r11, rdx
	xor	r11, rsi
	xor	r12, r10
	xor	r11, rdi
	mov	rsi, r12
	and	rsi, r9
	xor	rsi, r8
	mov	r8, qword ptr [rsp + 176]       # 8-byte Reload
	xor	rsi, rbx
	mov	rbx, qword ptr [rsp + 168]      # 8-byte Reload
	xor	rsi, rdx
	xor	rsi, rcx
	xor	r13, r8
	and	rbx, r10
	mov	rdx, r13
	and	rdx, rax
	xor	r10, r14
	mov	qword ptr [rsp + 512], r13      # 8-byte Spill
	xor	rbx, r13
	mov	qword ptr [rsp + 520], r10      # 8-byte Spill
	xor	rbx, rdx
	xor	rdx, r14
	mov	r14, r8
	xor	r14, r9
	xor	rbx, rax
	mov	rax, r14
	and	rax, r10
	mov	r14, r14
	xor	rax, r13
	xor	rbx, rdi
	mov	r13, qword ptr [rsp + 528]      # 8-byte Reload
	xor	rdx, rax
	xor	rdx, rcx
	mov	rcx, rbx
	and	rcx, r11
	xor	r11, rsi
	mov	r10, rdx
	xor	r10, rcx
	mov	rdi, rdx
	xor	rdi, rbx
	mov	rax, r10
	and	rax, r11
	xor	rax, rsi
	xor	rsi, rcx
	and	rsi, rdi
	and	r14, rax
	mov	rdi, rsi
	xor	rsi, rcx
	xor	rdi, rdx
	and	rsi, rdx
	and	r9, rdi
	xor	rbx, rsi
	xor	rsi, r10
	mov	r10, rax
	xor	r10, rdi
	and	rsi, rax
	mov	rcx, rbx
	xor	rcx, rdi
	and	rdi, r12
	and	r13, rbx
	and	rbx, qword ptr [rsp + 160]      # 8-byte Folded Reload
	mov	qword ptr [rsp + 160], r9       # 8-byte Spill
	mov	r9, qword ptr [rsp + 512]       # 8-byte Reload
	and	r8, r10
	xor	rsi, r11
	and	qword ptr [rsp + 264], rcx      # 8-byte Folded Spill
	mov	qword ptr [rsp + 176], r8       # 8-byte Spill
	mov	r8, qword ptr [rsp + 544]       # 8-byte Reload
	mov	r12, rsi
	xor	r12, rax
	and	rax, qword ptr [rsp + 520]      # 8-byte Folded Reload
	mov	r11, rsi
	and	qword ptr [rsp + 184], rsi      # 8-byte Folded Spill
	and	rsi, qword ptr [rsp + 168]      # 8-byte Folded Reload
	xor	r11, rcx
	and	rcx, qword ptr [rsp + 536]      # 8-byte Folded Reload
	mov	rdx, r11
	xor	rdx, r10
	and	r10, qword ptr [rsp + 560]      # 8-byte Folded Reload
	and	qword ptr [rsp + 256], rdx      # 8-byte Folded Spill
	and	rdx, qword ptr [rsp + 568]      # 8-byte Folded Reload
	and	r9, r12
	and	r12, qword ptr [rsp + 248]      # 8-byte Folded Reload
	and	r8, r11
	and	r11, qword ptr [rsp + 552]      # 8-byte Folded Reload
	mov	qword ptr [rsp + 168], rax      # 8-byte Spill
	mov	rax, qword ptr [rsp + 160]      # 8-byte Reload
	xor	rsi, r14
	xor	rdi, rcx
	xor	rcx, rbx
	xor	r10, rdx
	mov	rbx, r12
	xor	r12, rsi
	xor	r11, rdx
	xor	r14, rax
	xor	rbx, rax
	mov	rax, qword ptr [rsp + 256]      # 8-byte Reload
	mov	qword ptr [rsp + 160], r14      # 8-byte Spill
	mov	r14, r13
	mov	r13, qword ptr [rsp + 176]      # 8-byte Reload
	xor	r14, r9
	xor	rbx, r14
	xor	r8, rax
	xor	r13, r9
	mov	r9, qword ptr [rsp + 184]       # 8-byte Reload
	xor	r13, rax
	mov	rax, qword ptr [rsp + 168]      # 8-byte Reload
	xor	rax, rbx
	xor	rbx, rsi
	mov	rsi, qword ptr [rsp + 424]      # 8-byte Reload
	xor	rbx, r10
	xor	r10, r9
	xor	r9, r13
	xor	r8, r10
	xor	r10, rcx
	mov	rcx, qword ptr [rsp + 264]      # 8-byte Reload
	xor	r11, r9
	not	rbx
	xor	rax, r8
	xor	r12, r8
	xor	r11, rax
	xor	rdi, rax
	mov	rax, r9
	not	r12
	movabs	r9, -6148914691236517206
	not	r11
	xor	rcx, r10
	xor	r10, r13
	xor	r14, rcx
	xor	rcx, qword ptr [rsp + 160]      # 8-byte Folded Reload
	mov	qword ptr [rsp + 2360], r10
	movabs	r10, 6148914691236517205
	xor	rax, r14
	not	rax
	mov	qword ptr [rsp + 2352], rax
	mov	rax, qword ptr [rsp + 416]      # 8-byte Reload
	mov	qword ptr [rsp + 2344], r11
	mov	qword ptr [rsp + 2336], r14
	mov	qword ptr [rsp + 2328], rcx
	mov	qword ptr [rsp + 2320], rdi
	mov	qword ptr [rsp + 2312], r12
	mov	qword ptr [rsp + 2304], rbx
	mov	rdx, qword ptr [rsp + 8*rax + 2304]
	mov	rax, qword ptr [rsp + 448]      # 8-byte Reload
	xor	rdx, rax
	mov	rax, qword ptr [rsp + 408]      # 8-byte Reload
	mov	r8, rdx
	and	r8, r10
	shr	rdx
	and	rdx, r10
	mov	rcx, qword ptr [rsp + 8*rax + 2304]
	mov	rax, qword ptr [rsp + 440]      # 8-byte Reload
	xor	rcx, rax
	mov	rax, qword ptr [rsp + 368]      # 8-byte Reload
	lea	rbx, [rcx + rcx]
	and	rcx, r9
	and	rbx, r9
	or	rcx, rdx
	or	rbx, r8
	mov	rdi, qword ptr [rsp + 8*rax + 2304]
	mov	rax, qword ptr [rsp + 432]      # 8-byte Reload
	xor	rdi, rax
	mov	rax, qword ptr [rsp + 456]      # 8-byte Reload
	mov	r8, rdi
	and	r8, r10
	shr	rdi
	and	rdi, r10
	mov	rax, qword ptr [rsp + 8*rax + 2304]
	xor	rax, rsi
	mov	rsi, qword ptr [rsp + 400]      # 8-byte Reload
	lea	r11, [rax + rax]
	and	rax, r9
	and	r11, r9
	or	rax, rdi
	lea	rdi, [4*rcx]
	or	r11, r8
	mov	r8, qword ptr [rsp + 384]       # 8-byte Reload
	vmovq	xmm2, qword ptr [rsp + 8*r8 + 2304] # xmm2 = mem[0],zero
	mov	r8, qword ptr [rsp + 392]       # 8-byte Reload
	vmovq	xmm3, qword ptr [rsp + 8*r8 + 2304] # xmm3 = mem[0],zero
	vpunpcklqdq	xmm2, xmm3, xmm2        # xmm2 = xmm3[0],xmm2[0]
	vpxor	xmm2, xmm2, xmm0
	vpaddq	xmm3, xmm2, xmm2
	vpsrlq	xmm4, xmm2, 1
	vpand	xmm2, xmm2, xmm7
	vpalignr	xmm3, xmm4, xmm3, 8             # xmm3 = xmm3[8,9,10,11,12,13,14,15],xmm4[0,1,2,3,4,5,6,7]
	vmovq	xmm4, rbx
	vpandn	xmm3, xmm7, xmm3
	vpbroadcastq	ymm4, xmm4
	vpor	xmm3, xmm2, xmm3
	vpinsrq	xmm2, xmm3, rdi, 1
	vpsrlq	xmm5, xmm3, 2
	vinserti128	ymm2, ymm2, xmm5, 1
	vpsllq	xmm5, xmm4, 2
	vpblendd	xmm3, xmm3, xmm5, 3             # xmm3 = xmm5[0,1],xmm3[2,3]
	vpblendd	ymm3, ymm3, ymm4, 48            # ymm3 = ymm3[0,1,2,3],ymm4[4,5],ymm3[6,7]
	vmovq	xmm4, qword ptr [rsp + 8*rsi + 2304] # xmm4 = mem[0],zero
	mov	rsi, qword ptr [rsp + 376]      # 8-byte Reload
	vpandn	ymm2, ymm8, ymm2
	vmovq	xmm5, qword ptr [rsp + 8*rsi + 2304] # xmm5 = mem[0],zero
	vpunpcklqdq	xmm4, xmm5, xmm4        # xmm4 = xmm5[0],xmm4[0]
	vpxor	xmm4, xmm4, xmm1
	vpaddq	xmm5, xmm4, xmm4
	vpsrlq	xmm6, xmm4, 1
	vpand	xmm4, xmm4, xmm7
	vpalignr	xmm5, xmm6, xmm5, 8             # xmm5 = xmm5[8,9,10,11,12,13,14,15],xmm6[0,1,2,3,4,5,6,7]
	vmovq	xmm6, rcx
	lea	rcx, [4*rax]
	vpbroadcastq	ymm6, xmm6
	vpandn	xmm5, xmm7, xmm5
	vpor	xmm4, xmm4, xmm5
	vpblendd	ymm3, ymm3, ymm6, 192           # ymm3 = ymm3[0,1,2,3,4,5],ymm6[6,7]
	vpinsrq	xmm5, xmm4, rcx, 1
	vmovq	xmm6, r11
	vpand	ymm3, ymm8, ymm3
	vpor	ymm2, ymm3, ymm2
	vpsrlq	xmm3, xmm4, 2
	vinserti128	ymm3, ymm5, xmm3, 1
	vpbroadcastq	ymm5, xmm6
	vpsllq	xmm6, xmm5, 2
	vpandn	ymm3, ymm8, ymm3
	vpblendd	xmm4, xmm4, xmm6, 3             # xmm4 = xmm6[0,1],xmm4[2,3]
	vpblendd	ymm4, ymm4, ymm5, 48            # ymm4 = ymm4[0,1,2,3],ymm5[4,5],ymm4[6,7]
	vmovq	xmm5, rax
	vpbroadcastq	ymm5, xmm5
	vpblendd	ymm4, ymm4, ymm5, 192           # ymm4 = ymm4[0,1,2,3,4,5],ymm5[6,7]
	vpand	ymm4, ymm8, ymm4
	vpor	ymm3, ymm4, ymm3
	vextracti128	xmm4, ymm3, 1
	vmovq	rax, xmm4
	shl	rax, 4
	vmovq	xmm5, rax
	vpextrq	rax, xmm4, 1
	vpsllq	xmm4, xmm3, 4
	vpand	ymm3, ymm11, ymm3
	vpbroadcastq	ymm5, xmm5
	shl	rax, 4
	vpunpckhqdq	ymm5, ymm5, ymm2        # ymm5 = ymm5[1],ymm2[1],ymm5[3],ymm2[3]
	vpblendd	ymm4, ymm5, ymm4, 15            # ymm4 = ymm4[0,1,2,3],ymm5[4,5,6,7]
	vmovq	xmm5, rax
	vpand	ymm4, ymm4, ymmword ptr [rip + .LCPI11_11]
	mov	eax, 7
	vpbroadcastq	ymm5, xmm5
	vpblendd	ymm5, ymm2, ymm5, 192           # ymm5 = ymm2[0,1,2,3,4,5],ymm5[6,7]
	vpand	ymm5, ymm5, ymmword ptr [rip + .LCPI11_10]
	vpsrlq	ymm2, ymm2, 4
	vpandn	ymm2, ymm11, ymm2
	vpor	ymm2, ymm3, ymm2
	vmovdqa	ymmword ptr [rsp + 608], ymm2
	vmovaps	ymm3, ymmword ptr [rsp + 608]
	vpor	ymm4, ymm4, ymm5
	vmovdqa	ymmword ptr [rsp + 576], ymm4
	vmovdqa	ymm2, ymmword ptr [rsp + 576]
	vmovaps	ymmword ptr [rsp + 2784], ymm3
	vmovdqa	ymm3, ymmword ptr [rsp + 2784]
	vmovdqa	ymmword ptr [rsp + 2752], ymm2
	vmovdqa	ymm4, ymmword ptr [rsp + 2752]
	vmovdqa	ymmword ptr [rsp + 1696], ymm3
	vmovdqa	ymmword ptr [rsp + 1664], ymm4
.LBB11_32:                              #   Parent Loop BB11_1 Depth=1
                                        #     Parent Loop BB11_31 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	mov	r11, qword ptr [rsp + 192]      # 8-byte Reload
	movzx	ecx, byte ptr [rsp + rax + 1657]
	cmp	cl, byte ptr [r11 + rax - 7]
	jne	.LBB11_69
# %bb.33:                               #   in Loop: Header=BB11_32 Depth=3
	mov	r11, qword ptr [rsp + 192]      # 8-byte Reload
	movzx	ecx, byte ptr [rsp + rax + 1658]
	cmp	cl, byte ptr [r11 + rax - 6]
	jne	.LBB11_69
# %bb.34:                               #   in Loop: Header=BB11_32 Depth=3
	mov	r11, qword ptr [rsp + 192]      # 8-byte Reload
	movzx	ecx, byte ptr [rsp + rax + 1659]
	cmp	cl, byte ptr [r11 + rax - 5]
	jne	.LBB11_69
# %bb.35:                               #   in Loop: Header=BB11_32 Depth=3
	mov	r11, qword ptr [rsp + 192]      # 8-byte Reload
	movzx	ecx, byte ptr [rsp + rax + 1660]
	cmp	cl, byte ptr [r11 + rax - 4]
	jne	.LBB11_69
# %bb.36:                               #   in Loop: Header=BB11_32 Depth=3
	mov	r11, qword ptr [rsp + 192]      # 8-byte Reload
	movzx	ecx, byte ptr [rsp + rax + 1661]
	cmp	cl, byte ptr [r11 + rax - 3]
	jne	.LBB11_69
# %bb.37:                               #   in Loop: Header=BB11_32 Depth=3
	mov	r11, qword ptr [rsp + 192]      # 8-byte Reload
	movzx	ecx, byte ptr [rsp + rax + 1662]
	cmp	cl, byte ptr [r11 + rax - 2]
	jne	.LBB11_69
# %bb.38:                               #   in Loop: Header=BB11_32 Depth=3
	mov	r11, qword ptr [rsp + 192]      # 8-byte Reload
	movzx	ecx, byte ptr [rsp + rax + 1663]
	cmp	cl, byte ptr [r11 + rax - 1]
	jne	.LBB11_69
# %bb.39:                               #   in Loop: Header=BB11_32 Depth=3
	mov	r11, qword ptr [rsp + 192]      # 8-byte Reload
	movzx	ecx, byte ptr [rsp + rax + 1664]
	cmp	cl, byte ptr [r11 + rax]
	jne	.LBB11_69
# %bb.40:                               #   in Loop: Header=BB11_32 Depth=3
	add	rax, 8
	cmp	rax, 71
	jne	.LBB11_32
# %bb.41:                               #   in Loop: Header=BB11_31 Depth=2
	mov	rax, qword ptr [rsp + 360]      # 8-byte Reload
	add	qword ptr [rsp + 192], 64       # 8-byte Folded Spill
	mov	rbx, qword ptr [rsp + 352]      # 8-byte Reload
	mov	r14, qword ptr [rsp + 344]      # 8-byte Reload
	mov	r11, qword ptr [rsp + 336]      # 8-byte Reload
	mov	r9, qword ptr [rsp + 328]       # 8-byte Reload
	mov	rdx, qword ptr [rsp + 320]      # 8-byte Reload
	mov	r8, qword ptr [rsp + 312]       # 8-byte Reload
	mov	rdi, qword ptr [rsp + 304]      # 8-byte Reload
	mov	rsi, qword ptr [rsp + 296]      # 8-byte Reload
	mov	r13, qword ptr [rsp + 288]      # 8-byte Reload
	mov	r12, qword ptr [rsp + 280]      # 8-byte Reload
	lea	rcx, [rax + 64]
	cmp	rax, 192
	jb	.LBB11_31
# %bb.42:                               #   in Loop: Header=BB11_1 Depth=1
	vmovdqa	ymm1, ymmword ptr [rsp + 2240]  # 32-byte Reload
	mov	rsi, qword ptr [rsp + 2208]     # 8-byte Reload
	mov	rdx, qword ptr [rsp + 2272]     # 8-byte Reload
	mov	rdi, qword ptr [rsp + 272]      # 8-byte Reload
	add	r15, 256
	lea	rax, [rip + FROGBARD_SBOX]
	vpxor	xmm0, xmm0, xmm0
	inc	rsi
	add	rdx, 256
	add	rdi, 256
	cmp	rsi, 4
	jne	.LBB11_1
# %bb.43:
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+32]
	vmovdqa	ymmword ptr [rsp + 992], ymm0
	vmovdqa	ymmword ptr [rsp + 960], ymm0
	vmovdqa	ymmword ptr [rsp + 928], ymm0
	vmovdqa	ymmword ptr [rsp + 896], ymm0
	vmovdqa	ymmword ptr [rsp + 864], ymm0
	vmovdqa	ymmword ptr [rsp + 832], ymm0
	lea	rbx, [rsp + 576]
	mov	esi, 16
	mov	rdi, rbx
	vmovaps	ymmword ptr [rsp + 576], ymm2
	vmovaps	ymmword ptr [rsp + 608], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+64]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+96]
	vmovaps	ymmword ptr [rsp + 640], ymm2
	vmovaps	ymmword ptr [rsp + 672], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+128]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+160]
	vmovaps	ymmword ptr [rsp + 704], ymm2
	vmovaps	ymmword ptr [rsp + 736], ymm1
	vmovdqa	ymm2, ymmword ptr [rip + FROGBARD_IV+192]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+224]
	vmovdqa	ymmword ptr [rsp + 768], ymm2
	vmovaps	ymmword ptr [rsp + 800], ymm1
	vzeroupper
	call	frogbard_permute_rounds
	lea	rsi, [rsp + 32]
	mov	edx, 16
	mov	rdi, rbx
	call	final_rounds
	vmovdqu	ymm0, ymmword ptr [rsp + 32]
	vmovdqu	ymm1, ymmword ptr [rsp + 64]
	mov	r14d, 4
	vpxor	ymm1, ymm1, ymmword ptr [rip + .LCPI11_12]
	vpxor	ymm0, ymm0, ymmword ptr [rip + .LCPI11_13]
	vpor	ymm0, ymm0, ymm1
	vptest	ymm0, ymm0
	jne	.LBB11_68
# %bb.44:
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+32]
	vpxor	xmm0, xmm0, xmm0
	vmovdqa	ymmword ptr [rsp + 992], ymm0
	vmovdqa	ymmword ptr [rsp + 960], ymm0
	vmovdqa	ymmword ptr [rsp + 928], ymm0
	vmovdqa	ymmword ptr [rsp + 896], ymm0
	vmovdqa	ymmword ptr [rsp + 864], ymm0
	vmovdqa	ymmword ptr [rsp + 832], ymm0
	lea	rbx, [rsp + 576]
	mov	esi, 16
	mov	rdi, rbx
	vmovaps	ymmword ptr [rsp + 576], ymm2
	vmovaps	ymmword ptr [rsp + 608], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+64]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+96]
	vmovaps	ymmword ptr [rsp + 640], ymm2
	vmovaps	ymmword ptr [rsp + 672], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+128]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+160]
	vmovaps	ymmword ptr [rsp + 704], ymm2
	vmovaps	ymmword ptr [rsp + 736], ymm1
	vmovdqa	ymm2, ymmword ptr [rip + FROGBARD_IV+192]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+224]
	vmovdqa	ymmword ptr [rsp + 768], ymm2
	vmovaps	ymmword ptr [rsp + 800], ymm1
	vzeroupper
	call	frogbard_permute_rounds
	lea	rsi, [rip + .L.str.1]
	mov	edx, 3
	mov	ecx, 16
	mov	rdi, rbx
	call	update_rounds
	lea	rsi, [rsp + 32]
	mov	edx, 16
	mov	rdi, rbx
	call	final_rounds
	vmovdqu	ymm0, ymmword ptr [rsp + 32]
	vmovdqu	ymm1, ymmword ptr [rsp + 64]
	mov	r14d, 5
	vpxor	ymm1, ymm1, ymmword ptr [rip + .LCPI11_14]
	vpxor	ymm0, ymm0, ymmword ptr [rip + .LCPI11_15]
	vpor	ymm0, ymm0, ymm1
	vptest	ymm0, ymm0
	jne	.LBB11_68
# %bb.45:
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+32]
	vpxor	xmm0, xmm0, xmm0
	vmovdqa	ymmword ptr [rsp + 3168], ymm0
	vmovdqa	ymmword ptr [rsp + 3136], ymm0
	vmovdqa	ymmword ptr [rsp + 3104], ymm0
	vmovdqa	ymmword ptr [rsp + 3072], ymm0
	vmovdqa	ymmword ptr [rsp + 3040], ymm0
	vmovdqa	ymmword ptr [rsp + 3008], ymm0
	lea	rbx, [rsp + 2752]
	mov	esi, 16
	mov	rdi, rbx
	vmovaps	ymmword ptr [rsp + 2752], ymm2
	vmovaps	ymmword ptr [rsp + 2784], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+64]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+96]
	vmovaps	ymmword ptr [rsp + 2816], ymm2
	vmovaps	ymmword ptr [rsp + 2848], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+128]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+160]
	vmovaps	ymmword ptr [rsp + 2880], ymm2
	vmovaps	ymmword ptr [rsp + 2912], ymm1
	vmovdqa	ymm2, ymmword ptr [rip + FROGBARD_IV+192]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+224]
	vmovdqa	ymmword ptr [rsp + 2944], ymm2
	vmovaps	ymmword ptr [rsp + 2976], ymm1
	vzeroupper
	call	frogbard_permute_rounds
	lea	rsi, [rip + .L.str.2]
	mov	edx, 1
	mov	ecx, 16
	mov	rdi, rbx
	call	update_rounds
	lea	rsi, [rip + .L.str.3]
	mov	edx, 1
	mov	ecx, 16
	mov	rdi, rbx
	call	update_rounds
	lea	rsi, [rip + .L.str.4]
	mov	edx, 1
	mov	ecx, 16
	mov	rdi, rbx
	call	update_rounds
	lea	rsi, [rsp + 96]
	mov	edx, 16
	mov	rdi, rbx
	call	final_rounds
	vmovdqu	ymm0, ymmword ptr [rsp + 32]
	vmovdqu	ymm1, ymmword ptr [rsp + 64]
	mov	r14d, 6
	vpxor	ymm1, ymm1, ymmword ptr [rsp + 128]
	vpxor	ymm0, ymm0, ymmword ptr [rsp + 96]
	vpor	ymm0, ymm0, ymm1
	vptest	ymm0, ymm0
	jne	.LBB11_68
# %bb.46:
	vmovdqa	ymm0, ymmword ptr [rip + .LCPI11_16] # ymm0 = [17,148,23,154,29,160,35,166,41,172,47,178,53,184,59,190,65,196,71,202,77,208,83,214,89,220,95,226,101,232,107,238]
	vmovaps	ymm1, ymmword ptr [rip + .LCPI11_17] # ymm1 = [113,244,119,250,125,0,131,6,137,12,143,18,149,24,155,30,161,36,167,42,173,48,179,54,185,60,191,66,197,72,203,78]
	vmovaps	ymm2, ymmword ptr [rip + .LCPI11_18] # ymm2 = [209,84,215,90,221,96,227,102,233,108,239,114,245,120,251,126,1,132,7,138,13,144,19,150,25,156,31,162,37,168,43,174]
	lea	r13, [rsp + 2752]
	movabs	r15, 595056260442243601
	xor	r12d, r12d
	vmovdqu	ymmword ptr [rsp + 1664], ymm0
	vmovups	ymmword ptr [rsp + 1696], ymm1
	vmovaps	ymm1, ymmword ptr [rip + .LCPI11_19] # ymm1 = [49,180,55,186,61,192,67,198,73,204,79,210,85,216,91,222,97,228,103,234,109,240,115,246,121,252,127,2,133,8,139,14]
	vmovups	ymmword ptr [rsp + 1728], ymm2
	vmovaps	ymm2, ymmword ptr [rip + .LCPI11_20] # ymm2 = [145,20,151,26,157,32,163,38,169,44,175,50,181,56,187,62,193,68,199,74,205,80,211,86,217,92,223,98,229,104,235,110]
	vmovups	ymmword ptr [rsp + 1760], ymm1
	vmovaps	ymm1, ymmword ptr [rip + .LCPI11_21] # ymm1 = [241,116,247,122,253,128,3,134,9,140,15,146,21,152,27,158,33,164,39,170,45,176,51,182,57,188,63,194,69,200,75,206]
	vmovups	ymmword ptr [rsp + 1792], ymm2
	vmovdqa	ymm2, ymmword ptr [rip + .LCPI11_22] # ymm2 = [81,212,87,218,93,224,99,230,105,236,111,242,117,248,123,254,129,4,135,10,141,16,147,22,153,28,159,34,165,40,171,46]
	vmovups	ymmword ptr [rsp + 1824], ymm1
	vmovdqa	ymm1, ymmword ptr [rip + .LCPI11_23] # ymm1 = [177,52,183,58,189,64,195,70,201,76,207,82,213,88,219,94,225,100,231,106,237,112,243,118,249,124,255,130,5,136,11,142]
	vmovdqu	ymmword ptr [rsp + 1856], ymm2
	vmovdqu	ymmword ptr [rsp + 1888], ymm1
	mov	byte ptr [rsp + 1920], 17
.LBB11_47:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB11_49 Depth 2
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+32]
	lea	rax, [rsp + 832]
	vpxor	xmm0, xmm0, xmm0
	lea	rbx, [rsp + 576]
	mov	esi, 16
	vmovdqa	ymmword ptr [rax + 128], ymm0
	vmovdqa	ymmword ptr [rax + 64], ymm0
	vmovdqa	ymmword ptr [rax], ymm0
	vmovdqa	ymmword ptr [rax + 160], ymm0
	vmovdqa	ymmword ptr [rax + 96], ymm0
	vmovdqa	ymmword ptr [rax + 32], ymm0
	mov	rdi, rbx
	vmovaps	ymmword ptr [rsp + 576], ymm2
	vmovaps	ymmword ptr [rsp + 608], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+64]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+96]
	vmovaps	ymmword ptr [rsp + 640], ymm2
	vmovaps	ymmword ptr [rsp + 672], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+128]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+160]
	vmovaps	ymmword ptr [rsp + 704], ymm2
	vmovaps	ymmword ptr [rsp + 736], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+192]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+224]
	vmovaps	ymmword ptr [rsp + 768], ymm2
	vmovaps	ymmword ptr [rsp + 800], ymm1
	vzeroupper
	call	frogbard_permute_rounds
	lea	rsi, [rsp + 1664]
	mov	ecx, 16
	mov	rdi, rbx
	mov	rdx, r12
	call	update_rounds
	lea	rsi, [rsp + 32]
	mov	edx, 16
	mov	rdi, rbx
	call	final_rounds
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+32]
	lea	rax, [rsp + 3008]
	vpxor	xmm0, xmm0, xmm0
	mov	esi, 16
	mov	rdi, r13
	vmovdqa	ymmword ptr [rax + 128], ymm0
	vmovdqa	ymmword ptr [rax + 64], ymm0
	vmovdqa	ymmword ptr [rax], ymm0
	vmovdqa	ymmword ptr [rax + 160], ymm0
	vmovdqa	ymmword ptr [rax + 96], ymm0
	vmovdqa	ymmword ptr [rax + 32], ymm0
	vmovaps	ymmword ptr [rsp + 2752], ymm2
	vmovaps	ymmword ptr [rsp + 2784], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+64]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+96]
	vmovaps	ymmword ptr [rsp + 2816], ymm2
	vmovaps	ymmword ptr [rsp + 2848], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+128]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+160]
	vmovaps	ymmword ptr [rsp + 2880], ymm2
	vmovaps	ymmword ptr [rsp + 2912], ymm1
	vmovdqa	ymm2, ymmword ptr [rip + FROGBARD_IV+192]
	vmovdqa	ymm1, ymmword ptr [rip + FROGBARD_IV+224]
	vmovdqa	ymmword ptr [rsp + 2944], ymm2
	vmovdqa	ymmword ptr [rsp + 2976], ymm1
	vzeroupper
	call	frogbard_permute_rounds
	test	r12, r12
	je	.LBB11_50
# %bb.48:                               #   in Loop: Header=BB11_47 Depth=1
	xor	r14d, r14d
.LBB11_49:                              #   Parent Loop BB11_47 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lea	rax, [8*r14]
	mov	rbx, r12
	sub	rbx, r14
	lea	rsi, [rsp + r14 + 1664]
	mov	rdi, r13
	sub	rax, r14
	lea	rdx, [rax + 1]
	mulx	rcx, rcx, r15
	sub	rdx, rcx
	shr	rdx
	add	rdx, rcx
	shr	rdx, 4
	mov	rcx, rdx
	shl	rcx, 5
	sub	rdx, rcx
	lea	rcx, [rax + rdx + 1]
	lea	rax, [rax + rdx + 2]
	cmp	rcx, rbx
	mov	ecx, 16
	cmovb	rbx, rax
	mov	rdx, rbx
	call	update_rounds
	add	r14, rbx
	cmp	r14, r12
	jb	.LBB11_49
.LBB11_50:                              #   in Loop: Header=BB11_47 Depth=1
	lea	rsi, [rsp + 96]
	mov	edx, 16
	mov	rdi, r13
	call	final_rounds
	vmovdqu	ymm0, ymmword ptr [rsp + 32]
	vmovdqu	ymm1, ymmword ptr [rsp + 64]
	vpxor	ymm1, ymm1, ymmword ptr [rsp + 128]
	vpxor	ymm0, ymm0, ymmword ptr [rsp + 96]
	vpor	ymm0, ymm0, ymm1
	vptest	ymm0, ymm0
	jne	.LBB11_71
# %bb.51:                               #   in Loop: Header=BB11_47 Depth=1
	inc	r12
	cmp	r12, 258
	jne	.LBB11_47
# %bb.52:
	vbroadcastsd	ymm1, qword ptr [rip + .LCPI11_26] # ymm1 = [13787848793156543929,13787848793156543929,13787848793156543929,13787848793156543929]
	vpbroadcastq	ymm0, qword ptr [rip + .LCPI11_25] # ymm0 = [3210233709,3210233709,3210233709,3210233709]
	vpbroadcastq	ymm2, qword ptr [rip + .LCPI11_27] # ymm2 = [2496678331,2496678331,2496678331,2496678331]
	movabs	r13, 5076242219285967460
	mov	ebx, 1
	lea	r15, [rsp + 2304]
	vmovaps	ymmword ptr [rsp + 2272], ymm1  # 32-byte Spill
	vpbroadcastq	ymm1, qword ptr [rip + .LCPI11_28] # ymm1 = [10723151780598845931,10723151780598845931,10723151780598845931,10723151780598845931]
	vmovdqa	ymmword ptr [rsp + 192], ymm0   # 32-byte Spill
	vmovdqa	ymmword ptr [rsp + 2240], ymm2  # 32-byte Spill
	vmovdqa	ymmword ptr [rsp + 2208], ymm1  # 32-byte Spill
.LBB11_53:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB11_54 Depth 2
	mov	r14d, 8
	mov	r12d, 8
.LBB11_54:                              #   Parent Loop BB11_53 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovq	xmm0, r13
	vmovdqa	ymm10, ymmword ptr [rsp + 192]  # 32-byte Reload
	vmovdqa	ymm11, ymmword ptr [rsp + 2272] # 32-byte Reload
	vmovdqa	ymm12, ymmword ptr [rsp + 2240] # 32-byte Reload
	vmovdqa	ymm13, ymmword ptr [rsp + 2208] # 32-byte Reload
	mov	rdi, r15
	mov	esi, ebx
	vpbroadcastq	ymm1, xmm0
	vpaddq	ymm0, ymm1, ymmword ptr [rip + .LCPI11_24]
	vpsrlq	ymm2, ymm0, 30
	vpxor	ymm0, ymm2, ymm0
	vpsrlq	ymm3, ymm0, 32
	vpmuludq	ymm2, ymm10, ymm0
	vpmuludq	ymm0, ymm11, ymm0
	vpmuludq	ymm3, ymm11, ymm3
	vpaddq	ymm2, ymm2, ymm3
	vpsllq	ymm2, ymm2, 32
	vpaddq	ymm0, ymm0, ymm2
	vpsrlq	ymm2, ymm0, 27
	vpxor	ymm0, ymm2, ymm0
	vpsrlq	ymm3, ymm0, 32
	vpmuludq	ymm2, ymm12, ymm0
	vpmuludq	ymm0, ymm13, ymm0
	vpmuludq	ymm3, ymm13, ymm3
	vpaddq	ymm2, ymm2, ymm3
	vpsllq	ymm2, ymm2, 32
	vpaddq	ymm0, ymm0, ymm2
	vpaddq	ymm2, ymm1, ymmword ptr [rip + .LCPI11_29]
	vpsrlq	ymm3, ymm2, 30
	vpxor	ymm2, ymm3, ymm2
	vpsrlq	ymm4, ymm2, 32
	vpmuludq	ymm3, ymm10, ymm2
	vpmuludq	ymm2, ymm11, ymm2
	vpmuludq	ymm4, ymm11, ymm4
	vpaddq	ymm3, ymm3, ymm4
	vpsllq	ymm3, ymm3, 32
	vpaddq	ymm2, ymm2, ymm3
	vpsrlq	ymm3, ymm2, 27
	vpxor	ymm2, ymm3, ymm2
	vpsrlq	ymm4, ymm2, 32
	vpmuludq	ymm3, ymm12, ymm2
	vpmuludq	ymm2, ymm13, ymm2
	vpmuludq	ymm4, ymm13, ymm4
	vpaddq	ymm3, ymm3, ymm4
	vpsllq	ymm3, ymm3, 32
	vpaddq	ymm2, ymm2, ymm3
	vpaddq	ymm3, ymm1, ymmword ptr [rip + .LCPI11_30]
	vpsrlq	ymm4, ymm3, 30
	vpxor	ymm3, ymm4, ymm3
	vpsrlq	ymm5, ymm3, 32
	vpmuludq	ymm4, ymm10, ymm3
	vpmuludq	ymm3, ymm11, ymm3
	vpmuludq	ymm5, ymm11, ymm5
	vpaddq	ymm4, ymm4, ymm5
	vpsllq	ymm4, ymm4, 32
	vpaddq	ymm3, ymm3, ymm4
	vpsrlq	ymm4, ymm3, 27
	vpxor	ymm3, ymm4, ymm3
	vpsrlq	ymm5, ymm3, 32
	vpmuludq	ymm4, ymm12, ymm3
	vpmuludq	ymm3, ymm13, ymm3
	vpmuludq	ymm5, ymm13, ymm5
	vpaddq	ymm4, ymm4, ymm5
	vpsllq	ymm4, ymm4, 32
	vpaddq	ymm3, ymm3, ymm4
	vpaddq	ymm4, ymm1, ymmword ptr [rip + .LCPI11_31]
	vpsrlq	ymm5, ymm4, 30
	vpxor	ymm4, ymm5, ymm4
	vpsrlq	ymm6, ymm4, 32
	vpmuludq	ymm5, ymm10, ymm4
	vpmuludq	ymm4, ymm11, ymm4
	vpmuludq	ymm6, ymm11, ymm6
	vpaddq	ymm5, ymm5, ymm6
	vpsllq	ymm5, ymm5, 32
	vpaddq	ymm4, ymm4, ymm5
	vpsrlq	ymm5, ymm4, 27
	vpxor	ymm4, ymm5, ymm4
	vpsrlq	ymm6, ymm4, 32
	vpmuludq	ymm5, ymm12, ymm4
	vpmuludq	ymm4, ymm13, ymm4
	vpmuludq	ymm6, ymm13, ymm6
	vpaddq	ymm5, ymm5, ymm6
	vpsllq	ymm5, ymm5, 32
	vpaddq	ymm4, ymm4, ymm5
	vpaddq	ymm5, ymm1, ymmword ptr [rip + .LCPI11_32]
	vpsrlq	ymm6, ymm5, 30
	vpxor	ymm5, ymm6, ymm5
	vpsrlq	ymm7, ymm5, 32
	vpmuludq	ymm6, ymm10, ymm5
	vpmuludq	ymm5, ymm11, ymm5
	vpmuludq	ymm7, ymm11, ymm7
	vpaddq	ymm6, ymm6, ymm7
	vpsllq	ymm6, ymm6, 32
	vpaddq	ymm5, ymm5, ymm6
	vpsrlq	ymm6, ymm5, 27
	vpxor	ymm5, ymm6, ymm5
	vpsrlq	ymm7, ymm5, 32
	vpmuludq	ymm6, ymm12, ymm5
	vpmuludq	ymm5, ymm13, ymm5
	vpmuludq	ymm7, ymm13, ymm7
	vpaddq	ymm6, ymm6, ymm7
	vpsllq	ymm6, ymm6, 32
	vpaddq	ymm5, ymm5, ymm6
	vpaddq	ymm6, ymm1, ymmword ptr [rip + .LCPI11_33]
	vpsrlq	ymm7, ymm6, 30
	vpxor	ymm6, ymm7, ymm6
	vpsrlq	ymm8, ymm6, 32
	vpmuludq	ymm7, ymm10, ymm6
	vpmuludq	ymm6, ymm11, ymm6
	vpmuludq	ymm8, ymm8, ymm11
	vpaddq	ymm7, ymm8, ymm7
	vpsllq	ymm7, ymm7, 32
	vpaddq	ymm6, ymm6, ymm7
	vpsrlq	ymm7, ymm6, 27
	vpxor	ymm6, ymm7, ymm6
	vpsrlq	ymm8, ymm6, 32
	vpmuludq	ymm7, ymm12, ymm6
	vpmuludq	ymm6, ymm13, ymm6
	vpmuludq	ymm8, ymm8, ymm13
	vpaddq	ymm7, ymm8, ymm7
	vpsllq	ymm7, ymm7, 32
	vpaddq	ymm6, ymm6, ymm7
	vpaddq	ymm7, ymm1, ymmword ptr [rip + .LCPI11_34]
	vpaddq	ymm1, ymm1, ymmword ptr [rip + .LCPI11_35]
	vpsrlq	ymm8, ymm7, 30
	vpxor	ymm7, ymm8, ymm7
	vpsrlq	ymm9, ymm7, 32
	vpmuludq	ymm8, ymm10, ymm7
	vpmuludq	ymm7, ymm11, ymm7
	vpmuludq	ymm9, ymm9, ymm11
	vpaddq	ymm8, ymm8, ymm9
	vpsllq	ymm8, ymm8, 32
	vpaddq	ymm7, ymm8, ymm7
	vpsrlq	ymm8, ymm7, 27
	vpxor	ymm7, ymm8, ymm7
	vpsrlq	ymm9, ymm7, 32
	vpmuludq	ymm8, ymm12, ymm7
	vpmuludq	ymm7, ymm13, ymm7
	vpmuludq	ymm9, ymm9, ymm13
	vpaddq	ymm8, ymm8, ymm9
	vpsllq	ymm8, ymm8, 32
	vpaddq	ymm7, ymm8, ymm7
	vpsrlq	ymm8, ymm1, 30
	vpxor	ymm1, ymm8, ymm1
	vpsrlq	ymm9, ymm1, 32
	vpmuludq	ymm8, ymm10, ymm1
	vpmuludq	ymm1, ymm11, ymm1
	vpsrlq	ymm10, ymm3, 31
	vpmuludq	ymm9, ymm9, ymm11
	vpsrlq	ymm11, ymm0, 31
	vpxor	ymm3, ymm10, ymm3
	vpsrlq	ymm10, ymm7, 31
	vpxor	ymm0, ymm11, ymm0
	vpsrlq	ymm11, ymm5, 31
	vpxor	ymm7, ymm10, ymm7
	vpxor	ymm5, ymm11, ymm5
	vpaddq	ymm8, ymm8, ymm9
	vpsllq	ymm8, ymm8, 32
	vpaddq	ymm1, ymm8, ymm1
	vpsrlq	ymm8, ymm1, 27
	vpxor	ymm1, ymm8, ymm1
	vpsrlq	ymm9, ymm1, 32
	vpmuludq	ymm8, ymm12, ymm1
	vpmuludq	ymm1, ymm13, ymm1
	vinserti128	ymm12, ymm0, xmm3, 1
	vpmuludq	ymm9, ymm9, ymm13
	vpaddq	ymm8, ymm8, ymm9
	vpsrlq	ymm9, ymm2, 31
	vpsllq	ymm8, ymm8, 32
	vpxor	ymm2, ymm9, ymm2
	vpsrlq	ymm9, ymm6, 31
	vpaddq	ymm1, ymm8, ymm1
	vpsrlq	ymm8, ymm4, 31
	vpxor	ymm6, ymm9, ymm6
	vinserti128	ymm9, ymm5, xmm7, 1
	vpunpckhqdq	ymm14, ymm0, ymm2       # ymm14 = ymm0[1],ymm2[1],ymm0[3],ymm2[3]
	vpunpcklqdq	ymm0, ymm0, ymm2        # ymm0 = ymm0[0],ymm2[0],ymm0[2],ymm2[2]
	vpxor	ymm4, ymm8, ymm4
	vpsrlq	ymm8, ymm1, 31
	vinserti128	ymm11, ymm2, xmm4, 1
	vpxor	ymm1, ymm8, ymm1
	vinserti128	ymm8, ymm6, xmm1, 1
	vpunpckhqdq	ymm13, ymm12, ymm11     # ymm13 = ymm12[1],ymm11[1],ymm12[3],ymm11[3]
	vpunpcklqdq	ymm15, ymm12, ymm11     # ymm15 = ymm12[0],ymm11[0],ymm12[2],ymm11[2]
	vpunpckhqdq	ymm11, ymm7, ymm1       # ymm11 = ymm7[1],ymm1[1],ymm7[3],ymm1[3]
	vpunpckhqdq	ymm12, ymm5, ymm6       # ymm12 = ymm5[1],ymm6[1],ymm5[3],ymm6[3]
	vpunpcklqdq	ymm1, ymm7, ymm1        # ymm1 = ymm7[0],ymm1[0],ymm7[2],ymm1[2]
	vpunpcklqdq	ymm5, ymm5, ymm6        # ymm5 = ymm5[0],ymm6[0],ymm5[2],ymm6[2]
	vperm2i128	ymm1, ymm5, ymm1, 49    # ymm1 = ymm5[2,3],ymm1[2,3]
	vperm2i128	ymm11, ymm12, ymm11, 49 # ymm11 = ymm12[2,3],ymm11[2,3]
	vpunpckhqdq	ymm12, ymm3, ymm4       # ymm12 = ymm3[1],ymm4[1],ymm3[3],ymm4[3]
	vpunpckhqdq	ymm10, ymm9, ymm8       # ymm10 = ymm9[1],ymm8[1],ymm9[3],ymm8[3]
	vpunpcklqdq	ymm8, ymm9, ymm8        # ymm8 = ymm9[0],ymm8[0],ymm9[2],ymm8[2]
	vmovdqu	ymmword ptr [rsp + 2304], ymm15
	vpunpcklqdq	ymm3, ymm3, ymm4        # ymm3 = ymm3[0],ymm4[0],ymm3[2],ymm4[2]
	vmovdqu	ymmword ptr [rsp + 2368], ymm13
	vperm2i128	ymm12, ymm14, ymm12, 49 # ymm12 = ymm14[2,3],ymm12[2,3]
	vmovdqu	ymmword ptr [rsp + 2336], ymm8
	vperm2i128	ymm0, ymm0, ymm3, 49    # ymm0 = ymm0[2,3],ymm3[2,3]
	vmovdqu	ymmword ptr [rsp + 2400], ymm10
	vmovdqu	ymmword ptr [rsp + 2464], ymm1
	vmovdqu	ymmword ptr [rsp + 2528], ymm11
	vmovups	ymm1, ymmword ptr [rsp + 2464]
	vmovdqu	ymmword ptr [rsp + 2496], ymm12
	vmovdqu	ymmword ptr [rsp + 2432], ymm0
	vmovups	ymm2, ymmword ptr [rsp + 2496]
	vmovdqu	ymm0, ymmword ptr [rsp + 2432]
	vmovaps	ymmword ptr [rsp + 736], ymm1
	vmovups	ymm1, ymmword ptr [rsp + 2528]
	vmovaps	ymmword ptr [rsp + 768], ymm2
	vmovups	ymm2, ymmword ptr [rsp + 2304]
	vmovdqa	ymmword ptr [rsp + 704], ymm0
	vmovaps	ymmword ptr [rsp + 800], ymm1
	vmovups	ymm1, ymmword ptr [rsp + 2336]
	vmovaps	ymmword ptr [rsp + 576], ymm2
	vmovdqu	ymm2, ymmword ptr [rsp + 2368]
	vmovaps	ymmword ptr [rsp + 608], ymm1
	vmovdqu	ymm1, ymmword ptr [rsp + 2400]
	vmovdqa	ymmword ptr [rsp + 640], ymm2
	vmovdqa	ymmword ptr [rsp + 672], ymm1
	vzeroupper
	call	frogbard_permute_rounds
	mov	rdi, r15
	mov	esi, ebx
	call	frogbard_inverse_rounds
	mov	edx, 256
	lea	rdi, [rsp + 576]
	mov	rsi, r15
	call	bcmp@PLT
	test	eax, eax
	jne	.LBB11_68
# %bb.55:                               #   in Loop: Header=BB11_54 Depth=2
	movabs	rax, -4112007255848680800
	add	r13, rax
	dec	r12d
	jne	.LBB11_54
# %bb.56:                               #   in Loop: Header=BB11_53 Depth=1
	inc	ebx
	cmp	ebx, 17
	jne	.LBB11_53
# %bb.57:
	vmovdqa	ymm0, ymmword ptr [rip + .LCPI11_36] # ymm0 = [0,17,34,51,68,85,102,119,136,153,170,187,204,221,238,255,16,33,50,67,84,101,118,135,152,169,186,203,220,237,254,15]
	vmovaps	ymm1, ymmword ptr [rip + .LCPI11_37] # ymm1 = [32,49,66,83,100,117,134,151,168,185,202,219,236,253,14,31,48,65,82,99,116,133,150,167,184,201,218,235,252,13,30,47]
	vmovaps	ymm2, ymmword ptr [rip + .LCPI11_38] # ymm2 = [64,81,98,115,132,149,166,183,200,217,234,251,12,29,46,63,80,97,114,131,148,165,182,199,216,233,250,11,28,45,62,79]
	lea	rbx, [rsp + 2560]
	lea	r15, [rsp + 2304]
	lea	r12, [rsp + 32]
	xor	r13d, r13d
	vmovdqu	ymmword ptr [rsp + 576], ymm0
	vmovups	ymmword ptr [rsp + 608], ymm1
	vmovaps	ymm1, ymmword ptr [rip + .LCPI11_39] # ymm1 = [96,113,130,147,164,181,198,215,232,249,10,27,44,61,78,95,112,129,146,163,180,197,214,231,248,9,26,43,60,77,94,111]
	vmovups	ymmword ptr [rsp + 640], ymm2
	vmovaps	ymm2, ymmword ptr [rip + .LCPI11_40] # ymm2 = [128,145,162,179,196,213,230,247,8,25,42,59,76,93,110,127,144,161,178,195,212,229,246,7,24,41,58,75,92,109,126,143]
	vmovups	ymmword ptr [rsp + 672], ymm1
	vmovaps	ymm1, ymmword ptr [rip + .LCPI11_41] # ymm1 = [160,177,194,211,228,245,6,23,40,57,74,91,108,125,142,159,176,193,210,227,244,5,22,39,56,73,90,107,124,141,158,175]
	vmovups	ymmword ptr [rsp + 704], ymm2
	vmovaps	ymm2, ymmword ptr [rip + .LCPI11_42] # ymm2 = [192,209,226,243,4,21,38,55,72,89,106,123,140,157,174,191,208,225,242,3,20,37,54,71,88,105,122,139,156,173,190,207]
	vmovups	ymmword ptr [rsp + 736], ymm1
	vmovaps	ymm1, ymmword ptr [rip + .LCPI11_43] # ymm1 = [224,241,2,19,36,53,70,87,104,121,138,155,172,189,206,223,240,1,18,35,52,69,86,103,120,137,154,171,188,205,222,239]
	vmovups	ymmword ptr [rsp + 768], ymm2
	vmovaps	ymm2, ymmword ptr [rip + .LCPI11_44] # ymm2 = [31,50,69,88,107,126,145,164,183,202,221,240,3,22,41,60,79,98,117,136,155,174,193,212,231,250,13,32,51,70,89,108]
	vmovups	ymmword ptr [rsp + 800], ymm1
	vmovaps	ymm1, ymmword ptr [rip + .LCPI11_45] # ymm1 = [127,146,165,184,203,222,241,4,23,42,61,80,99,118,137,156,175,194,213,232,251,14,33,52,71,90,109,128,147,166,185,204]
	mov	byte ptr [rsp + 832], 0
	vmovups	ymmword ptr [rsp + 833], ymm2
	vmovaps	ymm2, ymmword ptr [rip + .LCPI11_46] # ymm2 = [223,242,5,24,43,62,81,100,119,138,157,176,195,214,233,252,15,34,53,72,91,110,129,148,167,186,205,224,243,6,25,44]
	vmovups	ymmword ptr [rsp + 865], ymm1
	vmovaps	ymm1, ymmword ptr [rip + .LCPI11_47] # ymm1 = [63,82,101,120,139,158,177,196,215,234,253,16,35,54,73,92,111,130,149,168,187,206,225,244,7,26,45,64,83,102,121,140]
	vmovups	ymmword ptr [rsp + 897], ymm2
	vmovaps	ymm2, ymmword ptr [rip + .LCPI11_48] # ymm2 = [159,178,197,216,235,254,17,36,55,74,93,112,131,150,169,188,207,226,245,8,27,46,65,84,103,122,141,160,179,198,217,236]
	vmovups	ymmword ptr [rsp + 929], ymm1
	vmovaps	ymm1, ymmword ptr [rip + .LCPI11_49] # ymm1 = [255,18,37,56,75,94,113,132,151,170,189,208,227,246,9,28,47,66,85,104,123,142,161,180,199,218,237,0,19,38,57,76]
	vmovups	ymmword ptr [rsp + 961], ymm2
	vmovaps	ymm2, ymmword ptr [rip + .LCPI11_50] # ymm2 = [95,114,133,152,171,190,209,228,247,10,29,48,67,86,105,124,143,162,181,200,219,238,1,20,39,58,77,96,115,134,153,172]
	vmovups	ymmword ptr [rsp + 993], ymm1
	vmovaps	ymm1, ymmword ptr [rip + .LCPI11_51] # ymm1 = [191,210,229,248,11,30,49,68,87,106,125,144,163,182,201,220,239,2,21,40,59,78,97,116,135,154,173,192,211,230,249,12]
	vmovups	ymmword ptr [rsp + 1025], ymm2
	vmovaps	ymm2, ymmword ptr [rip + .LCPI11_52] # ymm2 = [62,83,104,125,146,167,188,209,230,251,16,37,58,79,100,121,142,163,184,205,226,247,12,33,54,75,96,117,138,159,180,201]
	vmovups	ymmword ptr [rsp + 1057], ymm1
	vmovaps	ymm1, ymmword ptr [rip + .LCPI11_53] # ymm1 = [222,243,8,29,50,71,92,113,134,155,176,197,218,239,4,25,46,67,88,109,130,151,172,193,214,235,0,21,42,63,84,105]
	mov	byte ptr [rsp + 1089], 31
	vmovups	ymmword ptr [rsp + 1090], ymm2
	vmovaps	ymm2, ymmword ptr [rip + .LCPI11_54] # ymm2 = [126,147,168,189,210,231,252,17,38,59,80,101,122,143,164,185,206,227,248,13,34,55,76,97,118,139,160,181,202,223,244,9]
	vmovups	ymmword ptr [rsp + 1122], ymm1
	vmovaps	ymm1, ymmword ptr [rip + .LCPI11_55] # ymm1 = [30,51,72,93,114,135,156,177,198,219,240,5,26,47,68,89,110,131,152,173,194,215,236,1,22,43,64,85,106,127,148,169]
	vmovups	ymmword ptr [rsp + 1154], ymm2
	vmovaps	ymm2, ymmword ptr [rip + .LCPI11_56] # ymm2 = [190,211,232,253,18,39,60,81,102,123,144,165,186,207,228,249,14,35,56,77,98,119,140,161,182,203,224,245,10,31,52,73]
	vmovups	ymmword ptr [rsp + 1186], ymm1
	vmovaps	ymm1, ymmword ptr [rip + .LCPI11_57] # ymm1 = [94,115,136,157,178,199,220,241,6,27,48,69,90,111,132,153,174,195,216,237,2,23,44,65,86,107,128,149,170,191,212,233]
	vmovups	ymmword ptr [rsp + 1218], ymm2
	vmovaps	ymm2, ymmword ptr [rip + .LCPI11_58] # ymm2 = [254,19,40,61,82,103,124,145,166,187,208,229,250,15,36,57,78,99,120,141,162,183,204,225,246,11,32,53,74,95,116,137]
	vmovups	ymmword ptr [rsp + 1250], ymm1
	vmovaps	ymm1, ymmword ptr [rip + .LCPI11_59] # ymm1 = [158,179,200,221,242,7,28,49,70,91,112,133,154,175,196,217,238,3,24,45,66,87,108,129,150,171,192,213,234,255,20,41]
	vmovups	ymmword ptr [rsp + 1282], ymm2
	vmovaps	ymm2, ymmword ptr [rip + .LCPI11_60] # ymm2 = [93,116,139,162,185,208,231,254,21,44,67,90,113,136,159,182,205,228,251,18,41,64,87,110,133,156,179,202,225,248,15,38]
	vmovups	ymmword ptr [rsp + 1314], ymm1
	vmovaps	ymm1, ymmword ptr [rip + .LCPI11_61] # ymm1 = [61,84,107,130,153,176,199,222,245,12,35,58,81,104,127,150,173,196,219,242,9,32,55,78,101,124,147,170,193,216,239,6]
	mov	byte ptr [rsp + 1346], 62
	vmovups	ymmword ptr [rsp + 1347], ymm2
	vmovaps	ymm2, ymmword ptr [rip + .LCPI11_62] # ymm2 = [29,52,75,98,121,144,167,190,213,236,3,26,49,72,95,118,141,164,187,210,233,0,23,46,69,92,115,138,161,184,207,230]
	vmovups	ymmword ptr [rsp + 1379], ymm1
	vmovaps	ymm1, ymmword ptr [rip + .LCPI11_63] # ymm1 = [253,20,43,66,89,112,135,158,181,204,227,250,17,40,63,86,109,132,155,178,201,224,247,14,37,60,83,106,129,152,175,198]
	vmovups	ymmword ptr [rsp + 1411], ymm2
	vmovaps	ymm2, ymmword ptr [rip + .LCPI11_64] # ymm2 = [221,244,11,34,57,80,103,126,149,172,195,218,241,8,31,54,77,100,123,146,169,192,215,238,5,28,51,74,97,120,143,166]
	vmovups	ymmword ptr [rsp + 1443], ymm1
	vmovaps	ymm1, ymmword ptr [rip + .LCPI11_65] # ymm1 = [189,212,235,2,25,48,71,94,117,140,163,186,209,232,255,22,45,68,91,114,137,160,183,206,229,252,19,42,65,88,111,134]
	vmovups	ymmword ptr [rsp + 1475], ymm2
	vmovdqa	ymm2, ymmword ptr [rip + .LCPI11_66] # ymm2 = [157,180,203,226,249,16,39,62,85,108,131,154,177,200,223,246,13,36,59,82,105,128,151,174,197,220,243,10,33,56,79,102]
	vmovups	ymmword ptr [rsp + 1507], ymm1
	vmovdqa	ymm1, ymmword ptr [rip + .LCPI11_67] # ymm1 = [125,148,171,194,217,240,7,30,53,76,99,122,145,168,191,214,237,4,27,50,73,96,119,142,165,188,211,234,1,24,47,70]
	vmovdqu	ymmword ptr [rsp + 1539], ymm2
	vmovdqu	ymmword ptr [rsp + 1571], ymm1
	mov	byte ptr [rsp + 1603], 93
.LBB11_58:                              # =>This Inner Loop Header: Depth=1
	lea	r14, [rsp + 576]
	lea	rsi, [rsp + 833]
	lea	rdx, [rsp + 1090]
	lea	rcx, [rsp + 1347]
	lea	r9, [rsp + 1952]
	mov	r8, r13
	mov	rdi, r14
	vzeroupper
	call	frogbard_hash4_equal
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+32]
	vpxor	xmm0, xmm0, xmm0
	vmovdqa	ymmword ptr [rbx + 128], ymm0
	vmovdqa	ymmword ptr [rbx + 64], ymm0
	vmovdqa	ymmword ptr [rbx], ymm0
	vmovdqa	ymmword ptr [rbx + 160], ymm0
	vmovdqa	ymmword ptr [rbx + 96], ymm0
	vmovdqa	ymmword ptr [rbx + 32], ymm0
	mov	esi, 16
	mov	rdi, r15
	vmovaps	ymmword ptr [rsp + 2304], ymm2
	vmovaps	ymmword ptr [rsp + 2336], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+64]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+96]
	vmovaps	ymmword ptr [rsp + 2368], ymm2
	vmovaps	ymmword ptr [rsp + 2400], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+128]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+160]
	vmovaps	ymmword ptr [rsp + 2432], ymm2
	vmovaps	ymmword ptr [rsp + 2464], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+192]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+224]
	vmovaps	ymmword ptr [rsp + 2496], ymm2
	vmovaps	ymmword ptr [rsp + 2528], ymm1
	vzeroupper
	call	frogbard_permute_rounds
	mov	ecx, 16
	mov	rdi, r15
	mov	rsi, r14
	mov	rdx, r13
	call	update_rounds
	mov	edx, 16
	mov	rdi, r15
	mov	rsi, r12
	call	final_rounds
	vmovdqu	ymm0, ymmword ptr [rsp + 32]
	vmovdqu	ymm1, ymmword ptr [rsp + 64]
	mov	r14d, 9
	vpxor	ymm1, ymm1, ymmword ptr [rsp + 1984]
	vpxor	ymm0, ymm0, ymmword ptr [rsp + 1952]
	vpor	ymm0, ymm0, ymm1
	vptest	ymm0, ymm0
	jne	.LBB11_68
# %bb.59:                               #   in Loop: Header=BB11_58 Depth=1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+32]
	vpxor	xmm0, xmm0, xmm0
	vmovdqa	ymmword ptr [rbx + 128], ymm0
	vmovdqa	ymmword ptr [rbx + 64], ymm0
	vmovdqa	ymmword ptr [rbx], ymm0
	vmovdqa	ymmword ptr [rbx + 160], ymm0
	vmovdqa	ymmword ptr [rbx + 96], ymm0
	vmovdqa	ymmword ptr [rbx + 32], ymm0
	mov	esi, 16
	mov	rdi, r15
	vmovaps	ymmword ptr [rsp + 2304], ymm2
	vmovaps	ymmword ptr [rsp + 2336], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+64]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+96]
	vmovaps	ymmword ptr [rsp + 2368], ymm2
	vmovaps	ymmword ptr [rsp + 2400], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+128]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+160]
	vmovaps	ymmword ptr [rsp + 2432], ymm2
	vmovaps	ymmword ptr [rsp + 2464], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+192]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+224]
	vmovaps	ymmword ptr [rsp + 2496], ymm2
	vmovaps	ymmword ptr [rsp + 2528], ymm1
	vzeroupper
	call	frogbard_permute_rounds
	lea	rsi, [rsp + 833]
	mov	ecx, 16
	mov	rdi, r15
	mov	rdx, r13
	call	update_rounds
	mov	edx, 16
	mov	rdi, r15
	mov	rsi, r12
	call	final_rounds
	vmovdqu	ymm0, ymmword ptr [rsp + 32]
	vmovdqu	ymm1, ymmword ptr [rsp + 64]
	vpxor	ymm1, ymm1, ymmword ptr [rsp + 2048]
	vpxor	ymm0, ymm0, ymmword ptr [rsp + 2016]
	vpor	ymm0, ymm0, ymm1
	vptest	ymm0, ymm0
	jne	.LBB11_68
# %bb.60:                               #   in Loop: Header=BB11_58 Depth=1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+32]
	vpxor	xmm0, xmm0, xmm0
	vmovdqa	ymmword ptr [rbx + 128], ymm0
	vmovdqa	ymmword ptr [rbx + 64], ymm0
	vmovdqa	ymmword ptr [rbx], ymm0
	vmovdqa	ymmword ptr [rbx + 160], ymm0
	vmovdqa	ymmword ptr [rbx + 96], ymm0
	vmovdqa	ymmword ptr [rbx + 32], ymm0
	mov	esi, 16
	mov	rdi, r15
	vmovaps	ymmword ptr [rsp + 2304], ymm2
	vmovaps	ymmword ptr [rsp + 2336], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+64]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+96]
	vmovaps	ymmword ptr [rsp + 2368], ymm2
	vmovaps	ymmword ptr [rsp + 2400], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+128]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+160]
	vmovaps	ymmword ptr [rsp + 2432], ymm2
	vmovaps	ymmword ptr [rsp + 2464], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+192]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+224]
	vmovaps	ymmword ptr [rsp + 2496], ymm2
	vmovaps	ymmword ptr [rsp + 2528], ymm1
	vzeroupper
	call	frogbard_permute_rounds
	lea	rsi, [rsp + 1090]
	mov	ecx, 16
	mov	rdi, r15
	mov	rdx, r13
	call	update_rounds
	mov	edx, 16
	mov	rdi, r15
	mov	rsi, r12
	call	final_rounds
	vmovdqu	ymm0, ymmword ptr [rsp + 32]
	vmovdqu	ymm1, ymmword ptr [rsp + 64]
	vpxor	ymm1, ymm1, ymmword ptr [rsp + 2112]
	vpxor	ymm0, ymm0, ymmword ptr [rsp + 2080]
	vpor	ymm0, ymm0, ymm1
	vptest	ymm0, ymm0
	jne	.LBB11_68
# %bb.61:                               #   in Loop: Header=BB11_58 Depth=1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+32]
	vpxor	xmm0, xmm0, xmm0
	vmovdqa	ymmword ptr [rbx + 128], ymm0
	vmovdqa	ymmword ptr [rbx + 64], ymm0
	vmovdqa	ymmword ptr [rbx], ymm0
	vmovdqa	ymmword ptr [rbx + 160], ymm0
	vmovdqa	ymmword ptr [rbx + 96], ymm0
	vmovdqa	ymmword ptr [rbx + 32], ymm0
	mov	esi, 16
	mov	rdi, r15
	vmovaps	ymmword ptr [rsp + 2304], ymm2
	vmovaps	ymmword ptr [rsp + 2336], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+64]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+96]
	vmovaps	ymmword ptr [rsp + 2368], ymm2
	vmovaps	ymmword ptr [rsp + 2400], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+128]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+160]
	vmovaps	ymmword ptr [rsp + 2432], ymm2
	vmovaps	ymmword ptr [rsp + 2464], ymm1
	vmovdqa	ymm2, ymmword ptr [rip + FROGBARD_IV+192]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+224]
	vmovdqa	ymmword ptr [rsp + 2496], ymm2
	vmovaps	ymmword ptr [rsp + 2528], ymm1
	vzeroupper
	call	frogbard_permute_rounds
	lea	rsi, [rsp + 1347]
	mov	ecx, 16
	mov	rdi, r15
	mov	rdx, r13
	call	update_rounds
	mov	edx, 16
	mov	rdi, r15
	mov	rsi, r12
	call	final_rounds
	vmovdqu	ymm0, ymmword ptr [rsp + 32]
	vmovdqu	ymm1, ymmword ptr [rsp + 64]
	vpxor	ymm1, ymm1, ymmword ptr [rsp + 2176]
	vpxor	ymm0, ymm0, ymmword ptr [rsp + 2144]
	vpor	ymm0, ymm0, ymm1
	vptest	ymm0, ymm0
	jne	.LBB11_68
# %bb.62:                               #   in Loop: Header=BB11_58 Depth=1
	inc	r13
	cmp	r13, 258
	jne	.LBB11_58
# %bb.63:
	xor	eax, eax
.LBB11_64:                              # =>This Inner Loop Header: Depth=1
	mov	byte ptr [rsp + rax + 576], 0
	mov	byte ptr [rsp + rax + 577], 0
	mov	byte ptr [rsp + rax + 578], 0
	mov	byte ptr [rsp + rax + 579], 0
	add	rax, 4
	cmp	rax, 1028
	jne	.LBB11_64
# %bb.65:
	mov	byte ptr [rsp + 32], 0
	mov	byte ptr [rsp + 33], 0
	mov	byte ptr [rsp + 34], 0
	mov	byte ptr [rsp + 35], 0
	mov	byte ptr [rsp + 36], 0
	mov	byte ptr [rsp + 37], 0
	mov	byte ptr [rsp + 38], 0
	mov	byte ptr [rsp + 39], 0
	mov	byte ptr [rsp + 40], 0
	mov	byte ptr [rsp + 41], 0
	mov	byte ptr [rsp + 42], 0
	mov	byte ptr [rsp + 43], 0
	mov	byte ptr [rsp + 44], 0
	mov	byte ptr [rsp + 45], 0
	mov	byte ptr [rsp + 46], 0
	mov	byte ptr [rsp + 47], 0
	mov	byte ptr [rsp + 48], 0
	mov	byte ptr [rsp + 49], 0
	mov	byte ptr [rsp + 50], 0
	mov	byte ptr [rsp + 51], 0
	mov	byte ptr [rsp + 52], 0
	mov	byte ptr [rsp + 53], 0
	mov	byte ptr [rsp + 54], 0
	mov	byte ptr [rsp + 55], 0
	mov	byte ptr [rsp + 56], 0
	mov	byte ptr [rsp + 57], 0
	mov	byte ptr [rsp + 58], 0
	mov	byte ptr [rsp + 59], 0
	mov	byte ptr [rsp + 60], 0
	mov	byte ptr [rsp + 61], 0
	mov	byte ptr [rsp + 62], 0
	mov	byte ptr [rsp + 63], 0
	mov	byte ptr [rsp + 64], 0
	mov	byte ptr [rsp + 65], 0
	mov	byte ptr [rsp + 66], 0
	mov	byte ptr [rsp + 67], 0
	mov	byte ptr [rsp + 68], 0
	mov	byte ptr [rsp + 69], 0
	mov	byte ptr [rsp + 70], 0
	mov	byte ptr [rsp + 71], 0
	mov	byte ptr [rsp + 72], 0
	mov	byte ptr [rsp + 73], 0
	mov	byte ptr [rsp + 74], 0
	mov	byte ptr [rsp + 75], 0
	mov	byte ptr [rsp + 76], 0
	mov	byte ptr [rsp + 77], 0
	mov	byte ptr [rsp + 78], 0
	mov	byte ptr [rsp + 79], 0
	mov	byte ptr [rsp + 80], 0
	mov	byte ptr [rsp + 81], 0
	mov	byte ptr [rsp + 82], 0
	mov	byte ptr [rsp + 83], 0
	mov	byte ptr [rsp + 84], 0
	mov	byte ptr [rsp + 85], 0
	mov	byte ptr [rsp + 86], 0
	mov	byte ptr [rsp + 87], 0
	mov	byte ptr [rsp + 88], 0
	mov	byte ptr [rsp + 89], 0
	mov	byte ptr [rsp + 90], 0
	mov	byte ptr [rsp + 91], 0
	mov	byte ptr [rsp + 92], 0
	mov	byte ptr [rsp + 93], 0
	mov	byte ptr [rsp + 94], 0
	mov	byte ptr [rsp + 95], 0
	mov	byte ptr [rsp + 96], 0
	mov	byte ptr [rsp + 97], 0
	mov	byte ptr [rsp + 98], 0
	mov	byte ptr [rsp + 99], 0
	mov	byte ptr [rsp + 100], 0
	mov	byte ptr [rsp + 101], 0
	mov	byte ptr [rsp + 102], 0
	mov	byte ptr [rsp + 103], 0
	mov	byte ptr [rsp + 104], 0
	mov	byte ptr [rsp + 105], 0
	mov	byte ptr [rsp + 106], 0
	mov	byte ptr [rsp + 107], 0
	mov	byte ptr [rsp + 108], 0
	mov	byte ptr [rsp + 109], 0
	mov	byte ptr [rsp + 110], 0
	mov	byte ptr [rsp + 111], 0
	mov	byte ptr [rsp + 112], 0
	mov	byte ptr [rsp + 113], 0
	mov	byte ptr [rsp + 114], 0
	mov	byte ptr [rsp + 115], 0
	mov	byte ptr [rsp + 116], 0
	mov	byte ptr [rsp + 117], 0
	mov	byte ptr [rsp + 118], 0
	mov	byte ptr [rsp + 119], 0
	mov	byte ptr [rsp + 120], 0
	mov	byte ptr [rsp + 121], 0
	mov	byte ptr [rsp + 122], 0
	mov	byte ptr [rsp + 123], 0
	mov	byte ptr [rsp + 124], 0
	mov	byte ptr [rsp + 125], 0
	mov	byte ptr [rsp + 126], 0
	mov	byte ptr [rsp + 127], 0
	mov	byte ptr [rsp + 128], 0
	mov	byte ptr [rsp + 129], 0
	mov	byte ptr [rsp + 130], 0
	mov	byte ptr [rsp + 131], 0
	mov	byte ptr [rsp + 132], 0
	mov	byte ptr [rsp + 133], 0
	mov	byte ptr [rsp + 134], 0
	mov	byte ptr [rsp + 135], 0
	mov	byte ptr [rsp + 136], 0
	mov	byte ptr [rsp + 137], 0
	mov	byte ptr [rsp + 138], 0
	mov	byte ptr [rsp + 139], 0
	mov	byte ptr [rsp + 140], 0
	mov	byte ptr [rsp + 141], 0
	mov	byte ptr [rsp + 142], 0
	mov	byte ptr [rsp + 143], 0
	mov	byte ptr [rsp + 144], 0
	mov	byte ptr [rsp + 145], 0
	mov	byte ptr [rsp + 146], 0
	mov	byte ptr [rsp + 147], 0
	mov	byte ptr [rsp + 148], 0
	mov	byte ptr [rsp + 149], 0
	mov	byte ptr [rsp + 150], 0
	mov	byte ptr [rsp + 151], 0
	mov	byte ptr [rsp + 152], 0
	mov	byte ptr [rsp + 153], 0
	mov	byte ptr [rsp + 154], 0
	mov	byte ptr [rsp + 155], 0
	mov	byte ptr [rsp + 156], 0
	mov	byte ptr [rsp + 157], 0
	mov	byte ptr [rsp + 158], 0
	mov	byte ptr [rsp + 159], 0
	xor	r14d, r14d
	xor	eax, eax
.LBB11_66:                              # =>This Inner Loop Header: Depth=1
	mov	byte ptr [rsp + rax + 1952], 0
	mov	byte ptr [rsp + rax + 1953], 0
	mov	byte ptr [rsp + rax + 1954], 0
	mov	byte ptr [rsp + rax + 1955], 0
	mov	byte ptr [rsp + rax + 1956], 0
	mov	byte ptr [rsp + rax + 1957], 0
	mov	byte ptr [rsp + rax + 1958], 0
	mov	byte ptr [rsp + rax + 1959], 0
	mov	byte ptr [rsp + rax + 1960], 0
	mov	byte ptr [rsp + rax + 1961], 0
	mov	byte ptr [rsp + rax + 1962], 0
	mov	byte ptr [rsp + rax + 1963], 0
	mov	byte ptr [rsp + rax + 1964], 0
	mov	byte ptr [rsp + rax + 1965], 0
	mov	byte ptr [rsp + rax + 1966], 0
	mov	byte ptr [rsp + rax + 1967], 0
	mov	byte ptr [rsp + rax + 1968], 0
	mov	byte ptr [rsp + rax + 1969], 0
	mov	byte ptr [rsp + rax + 1970], 0
	mov	byte ptr [rsp + rax + 1971], 0
	mov	byte ptr [rsp + rax + 1972], 0
	mov	byte ptr [rsp + rax + 1973], 0
	mov	byte ptr [rsp + rax + 1974], 0
	mov	byte ptr [rsp + rax + 1975], 0
	mov	byte ptr [rsp + rax + 1976], 0
	mov	byte ptr [rsp + rax + 1977], 0
	mov	byte ptr [rsp + rax + 1978], 0
	mov	byte ptr [rsp + rax + 1979], 0
	mov	byte ptr [rsp + rax + 1980], 0
	mov	byte ptr [rsp + rax + 1981], 0
	mov	byte ptr [rsp + rax + 1982], 0
	mov	byte ptr [rsp + rax + 1983], 0
	add	rax, 32
	cmp	rax, 256
	jne	.LBB11_66
	jmp	.LBB11_68
.LBB11_67:
	mov	r14d, 1
.LBB11_68:
	mov	eax, r14d
	lea	rsp, [rbp - 40]
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	.cfi_def_cfa rsp, 8
	vzeroupper
	ret
.LBB11_69:
	.cfi_def_cfa rbp, 16
	mov	r14d, 3
	jmp	.LBB11_68
.LBB11_71:
	mov	r14d, 7
	jmp	.LBB11_68
.Lfunc_end11:
	.size	frogbard_self_test, .Lfunc_end11-frogbard_self_test
	.cfi_endproc
                                        # -- End function
	.globl	frogbard_hash4_equal            # -- Begin function frogbard_hash4_equal
	.p2align	4
	.type	frogbard_hash4_equal,@function
frogbard_hash4_equal:                   # @frogbard_hash4_equal
	.cfi_startproc
# %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	and	rsp, -64
	sub	rsp, 576
	.cfi_offset rbx, -56
	.cfi_offset r12, -48
	.cfi_offset r13, -40
	.cfi_offset r14, -32
	.cfi_offset r15, -24
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+32]
	vxorps	xmm0, xmm0, xmm0
	vmovaps	ymmword ptr [rsp + 480], ymm0
	vmovaps	ymmword ptr [rsp + 448], ymm0
	vmovaps	ymmword ptr [rsp + 416], ymm0
	vmovaps	ymmword ptr [rsp + 384], ymm0
	vmovaps	ymmword ptr [rsp + 352], ymm0
	vmovaps	ymmword ptr [rsp + 320], ymm0
	mov	r13, rsi
	lea	r12, [rsp + 64]
	mov	esi, 16
	mov	r15, rdi
	mov	rbx, r9
	mov	r14, r8
	mov	qword ptr [rsp + 56], rcx       # 8-byte Spill
	mov	qword ptr [rsp + 48], rdx       # 8-byte Spill
	mov	rdi, r12
	vmovaps	ymmword ptr [rsp + 64], ymm2
	vmovaps	ymmword ptr [rsp + 96], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+64]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+96]
	vmovaps	ymmword ptr [rsp + 128], ymm2
	vmovaps	ymmword ptr [rsp + 160], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+128]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+160]
	vmovaps	ymmword ptr [rsp + 192], ymm2
	vmovaps	ymmword ptr [rsp + 224], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+192]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+224]
	vmovaps	ymmword ptr [rsp + 256], ymm2
	vmovaps	ymmword ptr [rsp + 288], ymm1
	vzeroupper
	call	frogbard_permute_rounds
	mov	ecx, 16
	mov	rdi, r12
	mov	rsi, r15
	mov	rdx, r14
	call	update_rounds
	mov	edx, 16
	mov	rdi, r12
	mov	rsi, rbx
	call	final_rounds
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+32]
	vxorps	xmm0, xmm0, xmm0
	vmovaps	ymmword ptr [rsp + 480], ymm0
	vmovaps	ymmword ptr [rsp + 448], ymm0
	vmovaps	ymmword ptr [rsp + 416], ymm0
	vmovaps	ymmword ptr [rsp + 384], ymm0
	vmovaps	ymmword ptr [rsp + 352], ymm0
	vmovaps	ymmword ptr [rsp + 320], ymm0
	lea	r12, [rsp + 64]
	mov	esi, 16
	lea	r15, [rbx + 64]
	mov	rdi, r12
	vmovaps	ymmword ptr [rsp + 64], ymm2
	vmovaps	ymmword ptr [rsp + 96], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+64]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+96]
	vmovaps	ymmword ptr [rsp + 128], ymm2
	vmovaps	ymmword ptr [rsp + 160], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+128]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+160]
	vmovaps	ymmword ptr [rsp + 192], ymm2
	vmovaps	ymmword ptr [rsp + 224], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+192]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+224]
	vmovaps	ymmword ptr [rsp + 256], ymm2
	vmovaps	ymmword ptr [rsp + 288], ymm1
	vzeroupper
	call	frogbard_permute_rounds
	mov	ecx, 16
	mov	rdi, r12
	mov	rsi, r13
	mov	rdx, r14
	call	update_rounds
	mov	edx, 16
	mov	rdi, r12
	mov	rsi, r15
	call	final_rounds
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+32]
	vxorps	xmm0, xmm0, xmm0
	vmovaps	ymmword ptr [rsp + 480], ymm0
	vmovaps	ymmword ptr [rsp + 448], ymm0
	vmovaps	ymmword ptr [rsp + 416], ymm0
	vmovaps	ymmword ptr [rsp + 384], ymm0
	vmovaps	ymmword ptr [rsp + 352], ymm0
	vmovaps	ymmword ptr [rsp + 320], ymm0
	lea	r12, [rsp + 64]
	mov	esi, 16
	lea	r15, [rbx + 128]
	mov	rdi, r12
	vmovaps	ymmword ptr [rsp + 64], ymm2
	vmovaps	ymmword ptr [rsp + 96], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+64]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+96]
	vmovaps	ymmword ptr [rsp + 128], ymm2
	vmovaps	ymmword ptr [rsp + 160], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+128]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+160]
	vmovaps	ymmword ptr [rsp + 192], ymm2
	vmovaps	ymmword ptr [rsp + 224], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+192]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+224]
	vmovaps	ymmword ptr [rsp + 256], ymm2
	vmovaps	ymmword ptr [rsp + 288], ymm1
	vzeroupper
	call	frogbard_permute_rounds
	mov	rsi, qword ptr [rsp + 48]       # 8-byte Reload
	mov	ecx, 16
	mov	rdi, r12
	mov	rdx, r14
	call	update_rounds
	mov	edx, 16
	mov	rdi, r12
	mov	rsi, r15
	call	final_rounds
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+32]
	vxorps	xmm0, xmm0, xmm0
	vmovaps	ymmword ptr [rsp + 480], ymm0
	vmovaps	ymmword ptr [rsp + 448], ymm0
	vmovaps	ymmword ptr [rsp + 416], ymm0
	vmovaps	ymmword ptr [rsp + 384], ymm0
	vmovaps	ymmword ptr [rsp + 352], ymm0
	vmovaps	ymmword ptr [rsp + 320], ymm0
	lea	r15, [rsp + 64]
	mov	esi, 16
	add	rbx, 192
	mov	rdi, r15
	vmovaps	ymmword ptr [rsp + 64], ymm2
	vmovaps	ymmword ptr [rsp + 96], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+64]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+96]
	vmovaps	ymmword ptr [rsp + 128], ymm2
	vmovaps	ymmword ptr [rsp + 160], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+128]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+160]
	vmovaps	ymmword ptr [rsp + 192], ymm2
	vmovaps	ymmword ptr [rsp + 224], ymm1
	vmovaps	ymm2, ymmword ptr [rip + FROGBARD_IV+192]
	vmovaps	ymm1, ymmword ptr [rip + FROGBARD_IV+224]
	vmovaps	ymmword ptr [rsp + 256], ymm2
	vmovaps	ymmword ptr [rsp + 288], ymm1
	vzeroupper
	call	frogbard_permute_rounds
	mov	rsi, qword ptr [rsp + 56]       # 8-byte Reload
	mov	ecx, 16
	mov	rdi, r15
	mov	rdx, r14
	call	update_rounds
	mov	edx, 16
	mov	rdi, r15
	mov	rsi, rbx
	call	final_rounds
	lea	rsp, [rbp - 40]
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	.cfi_def_cfa rsp, 8
	ret
.Lfunc_end12:
	.size	frogbard_hash4_equal, .Lfunc_end12-frogbard_hash4_equal
	.cfi_endproc
                                        # -- End function
	.globl	frogbard_has_avx2_backend       # -- Begin function frogbard_has_avx2_backend
	.p2align	4
	.type	frogbard_has_avx2_backend,@function
frogbard_has_avx2_backend:              # @frogbard_has_avx2_backend
	.cfi_startproc
# %bb.0:
	xor	eax, eax
	ret
.Lfunc_end13:
	.size	frogbard_has_avx2_backend, .Lfunc_end13-frogbard_has_avx2_backend
	.cfi_endproc
                                        # -- End function
	.type	FROGBARD_SBOX,@object           # @FROGBARD_SBOX
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
FROGBARD_SBOX:
	.ascii	"\027\252d\023\336(G\212\313\253$/\225\020j\246@\260\272\377a\373c]#v'\f\216;\t\326\033\263\3622\265\034\001A\243\232\346\224\341\"\024uwW\354Z\b\3337\343l\005\251.\200\376N\315\230\375\022m\300\303E\334y\356O\307\007r%\203\314-Y\374\306k\254\235\241\250\256\370\342\276X0\002H\030\213p\320\026\227\332!\323\r\322\234F\335\035\247\264\003\352\210\361\242\275L^\255UM\217\304<\321\177\257i\312\201\302&\331\261\244\240o\215\337\214{_)\340Q\367\355\222\365n\220,\n?\233\226SR>1\372\204\327zt\3019\266\360\016\0138CV\310g\347b}T\211JK\324f\236\364\273`\02135\267\206\237\\x+\245\350B:6\363\202\270\000ID\305\353[\271 \262\006\3574P\205\277\311\345\325~\344\207\037*\371\032\366\017\221\317|\004h\025sq\330\031=\223e\231\274\036\316\351"
	.ascii	"X\226P\341\254\353\304]\360u\007\345\237w\365:f\0204_R\207\013\266\217\354\245t\001\321\n6\021s/y\243cb\230Tn,\362\344\274\247\r H\273\276K\022\272\346\036\231\030\265\376Vp\317\331\240\333\223\306Q\235^\372&+\261\311\340\3227\252\332\324\327{Y[\027z\364F\215.m\301\236\363U\255oq\356G\005\234\370\374\315\211\257\225#@3\031k1\032\222\314\201(~A\361\220\203\367\206JO\337\023\250\026\216\347\264vxZ'\310B\357\200W`\277d\343\000\227\202%9\006\246\302\260)\244\275ij\271E\253\305\312\326e\375\263\242}2\f\034\210\351r\025;\313\307\325?0\224\373\323\342\205*\316\300L-\377a\330\002\033D\004\\\232M\177!>\3555\024\352\016$\336l\037\350\366g\212\003\241\335S\262\t\303\270<\017\371\204I\221\233N\267=\035C\256\320\213\"\2518\b\334h|\214"
	.ascii	"%\364\224Ot\236K\331\233\276\256\241\267\307\277\211R\223\312\247G \260\254\f\213\001\020\377\253\017x\n\303\230\265/y\021s\3161\252\323\"\325\334\214\000I\301\235\360\362\026h\335\033\003<v\311)\025\217\262\013^\330\237f\356`\204X\222\030\327m\036\340\345(\244z\2015\234\264\226\177\351\3370;N\273u\370\200ZH{\315-PU\004\374\354\231M\006\205\232wJ\376\251\255\027a\243n\320$\007\2064\203\037k~:\306g\022\302C\245\240\332Y\357\310j\322\3507\005#o\313\372?!\271\207\035\266\r\274F]*\2029\343,+D\353\263\314\0323\210\034\347'B\344r\352p\355SEQ\342l\336\b\346>e\220\250\242\304\373\317\333&\375\225\275d\272@=\366L\2168}\t\227\324\367\300_\2156\024\\\023\031\326\341\212.\321[\016b\261i\246qA\270\363V\371c\257\365W2T\221\002\361\305|"
	.ascii	"\327\237@Yf\252\347\244\007\265\233\027\312\354\333\271^y[&\247\355\263U\213\376\331z\226\352\305\024C\330\230(\343\341\315>\377u\221\350\202\363\325\234%\304\242d\232tb\001h8J\037\036\220\273\223rDv\216!\334\255\033\345$\374\336wO+\272\264s\206\253\203\2050\034\227m1\256\r\364\335EM\\\310\373\326]\224\204\201\0265\375\231\300\207\035\212\360\021}#?I-N.\346k\344\tne~\313a\362_\370\314{\217\342\323H\276c\266j4L\241\367\301\332,)\277P\243\031\222\006\251\372K`gF7;*\351\210\267\270|\316\003V\317/\n\020\365\337\261\3569\235\177\321\017 \016\013\030\022l\023\262\254R\361\322\"\302T\245Z\0053\340'\215\366p6\246qoS\320\025<2i\324Q\307\306\002\275\257\004A\236\311\240G\260\200=\225\b\f\353\250W\211:xBX\000\371\357\274\032\303\214"
	.size	FROGBARD_SBOX, 1024

	.type	FROGBARD_SBOX_INV,@object       # @FROGBARD_SBOX_INV
	.p2align	6, 0x0
FROGBARD_SBOX_INV:
	.ascii	"\323&`s\3619\334L4\036\235\257\033k\256\355\r\302B\003.\363f\000b\367\353 %p\375\350\332i-\030\nN\210\032\005\223\351\312\234Q;\013_\244#\303\336\304\3176\260\253\316\035\200\370\243\236\020'\315\261\325Fn\006a\324\272\273y}>J\337\225\242\241\270|\2621^R3\330\310\027z\222\301\024\266\026\002\372\275\264\362\204\016U8C\232\215d\365M\364\251/\0310\311H\250\221\360\267\345\202<\206\321O\246\340\306\347u\271\007c\220\216\034~\233\356\230\371+\f\240g@\373)\237mW\276\307\214Xw(\213\313\017qY:\001\tV{Z\203\021\212\333!r$\254\305\322\331\022\300\374x]\341D\252\207E\177\326TK\263\342\205\bP?\376\357e\201lj\274\344\037\247\366\211h5Go\004\217\224,\\7\346\343*\265\314\377t\3272\227I\335\255v\"\320\277\231\354\226[\352\245\025SA=\023"
	.ascii	"\227\034\312\341\315g\234\n\373\346\036\026\261/\330\352\021 5\204\326\266\206W:ru\313\262\3638\3340\322\370o\331\232I\215y\240\302J*\306\\\"\274t\260q\022\325\037O\372\233\017\267\351\362\323\273p{\217\364\314\246Zf1\355\2014\305\320\360\202\002E\024\344(a=\222\000U\214V\316\007G\023\223\310&%\225\253\020\337\375\243\244s\333])c>d\265!\033\t\212\r\213#XT\376\257z\321\221x\231~\354\301\200\025\263l\340\367\377[\207\030}\356vC\275n\001\230'9\317\357hF_\fA\342\256$\241\032\235.\205\371P\247\004b\365m\237K\345\255\211;\027\361\350\24562-\2423\224\304^\236\347\006\250D\271\216L\251\270wk\303?\366\035N\277R\272\252S\311@QB\374\343\332\203M\003\300\226,\0137\210\335\264\327\005\031\324e\220\b|+`Y\016\336\177i\353H\276j\254<\307"
	.ascii	"0\032\374:k\225p~\300\330 B\030\240\352\036\033&\210\342\340?6xL\343\2569\261\236O\202\025\233,\226}\000\313\263R>\244\251\250h\347$])\371\257\200V\337\224\326\246\205^;\322\302\232\321\360\264\212\252\273\242\024e1t\006\324o_\003i\274\020\272\372j\363\370J\216d\351\341\243C\335Hy\353\365\317\303F\2077\355\221\203\276N{\227\270\357\266'\004a<s\037%Tf\377\327\204ZcU\245\201Iq\177\235\260\017\346\031/\336\325@\304\373K\021\002\315Y\331\"nr\bW3\005E\214\013\306zS\213\356\023\305v*\035\027w\n\366\026\354A\254X#\237\f\361\234\320`\241\316\t\016\3342\211!\307\376\206\r\220=\022\230\255g(\311|\350\222+\332-\344MD\007\215\312.8\277\\P\345\275\247\265Q\301\262\223[\267\253m\271G\2174\3755\362\001\367\323\333b\364\231\310l\314u\034"
	.ascii	"\3717\342\255\345\315\235\b\357}\261\276\360\\\275\273\262r\300\302\037\332i\013\277\233\375GWo<;\274D\310tI0\023\320#\227\246N\226wy\260VZ\334\316\220j\324\2449\267\365\245\333\355'u\002\346\367 A_\243\352\213v:\240\221`xM\231\337\305\330\312\027\256\363\370\003\314\022ae\020\204\241\2026\2153\177\004\2428\335\217{\301Y~\327\323\326@Q5)BL\366\021\033\207\253s\200\271\354h,TgURn\250\364p\030\377\321C\210=*\234?f\356\034X\"l4\n/\270\347\001\351\2222\232\007\313\325\024\362\236\005S\304F[\344\353\265\303\026P\t\216\251\252\017O>\374\343\214\230m\224\311\3761\036\341\340b\350\f\201\206&\254\257\331\272\307\212\336.d\000!\032\225\016E^K\264\317%\211$|Hz\006+\247\035\361\r\025\266\373q\306\203-]\263\322\223\205\372\237cJk\031("
	.size	FROGBARD_SBOX_INV, 1024

	.type	frogbard_self_test.expected_empty,@object # @frogbard_self_test.expected_empty
	.p2align	4, 0x0
frogbard_self_test.expected_empty:
	.ascii	"Zn\037V\221\265Q\322AP\223\025\024G\326\031\367\031\255\222\013\270\006\037\017\210\245\206\347\251\317`\262\bk\306]W}\272\274\316\335\nG\300\255\256\262R?\225J\311z\373\333\032\001\254\252=\331a"
	.size	frogbard_self_test.expected_empty, 64

	.type	frogbard_self_test.expected_abc,@object # @frogbard_self_test.expected_abc
	.p2align	4, 0x0
frogbard_self_test.expected_abc:
	.ascii	"\3274!\356\024\031\307\272\n]\251\035\236r\214[C\203\342c7\336\303\303w\312S\366V\265V\261\033\311$\270gqc\350\201\207\243\024\201\365S\342\301\304\253\304\217\342\023\316\021\241 \215qGA\023"
	.size	frogbard_self_test.expected_abc, 64

	.type	.L.str.1,@object                # @.str.1
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.1:
	.asciz	"abc"
	.size	.L.str.1, 4

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"a"
	.size	.L.str.2, 2

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"b"
	.size	.L.str.3, 2

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"c"
	.size	.L.str.4, 2

	.type	FROGBARD_RC,@object             # @FROGBARD_RC
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
FROGBARD_RC:
	.quad	4218652353794796143             # 0x3a8ba9f6e2cdea6f
	.quad	7639036579042992561             # 0x6a034f4b9812a1b1
	.quad	-3932332517782116797            # 0xc96d8c68d2e12643
	.quad	-1563742702303034507            # 0xea4c784c1d1e4375
	.quad	6964171890159533519             # 0x60a5b56fb3b83dcf
	.quad	3774514571189402213             # 0x3461c5011747ba65
	.quad	-1959982501918133450            # 0xe4ccbe4c87303336
	.quad	2564506366961975620             # 0x2396f4f412ff0144
	.quad	-483401786938639860             # 0xf94a9ca2cdbbba0c
	.quad	775202195893786001              # 0xac2124a3b5a1591
	.quad	-684700810319790573             # 0xf67f743d9f777e13
	.quad	-1404521324445882229            # 0xec82234c00f1288b
	.quad	8964054066059156011             # 0x7c66b7adf2da1a2b
	.quad	8417214847356376686             # 0x74cff44eaed2166e
	.quad	14547317580311401               # 0x33aeb550cf2b69
	.quad	-3210627967023275498            # 0xd3718edfe7a4a216
	.quad	-6304981865091201627            # 0xa88034661ff585a5
	.quad	3102729931163703024             # 0x2b0f1c6ef4fc16f0
	.quad	-7019682006262379708            # 0x9e9514683c878b44
	.quad	-5149229757979755902            # 0xb88a42d120befa82
	.quad	3717682791371411871             # 0x3397dccd3746919f
	.quad	4820270760645659541             # 0x42e50ab7c97c8b95
	.quad	2950461453994962102             # 0x28f2250f68da2cb6
	.quad	-766055728076229294             # 0xf55e6c5fc1dcf552
	.quad	4610173823427349301             # 0x3ffaa0aaaa310b35
	.quad	7952921691379947442             # 0x6e5e7424553357b2
	.quad	-2205557828824989777            # 0xe16448d7194dffaf
	.quad	53927607178083558               # 0xbf96df7d6fbce6
	.quad	-7651855935700644196            # 0x95cf259158194e9c
	.quad	5654439084148625004             # 0x4e789a6376c38e6c
	.quad	-2235755882157999902            # 0xe0f8ffdee77b78e2
	.quad	-6286664408393709674            # 0xa8c148075b9a0796
	.quad	-944947083900982836             # 0xf2e2dfa23c8a69cc
	.quad	-4779210476822442345            # 0xbdacd564862c4e97
	.quad	-2180529129987683077            # 0xe1bd344f28b14cfb
	.quad	-7769365117966456303            # 0x942dab96cd4c6a11
	.quad	-2484116856894331399            # 0xdd86a4e14c40e5f9
	.quad	-6135924866914036869            # 0xaad8d0d7d31a537b
	.quad	217677364150001957              # 0x3055868cdcde125
	.quad	-854938500499483515             # 0xf422a5f6a4ec5485
	.quad	1986629030961365120             # 0x1b91ec93faee4080
	.quad	1895684641141089136             # 0x1a4ed3232960e370
	.quad	6324836822802440604             # 0x57c655947573219c
	.quad	-5815675625348989534            # 0xaf4a91d4de2cfda2
	.quad	3191071260568305666             # 0x2c48f6678b21c002
	.quad	8902008345716597181             # 0x7b8a496cf20021bd
	.quad	-2899765016347358279            # 0xd7c1f714cc82cbb9
	.quad	-2880617258385595911            # 0xd805fddd9c1121f9
	.quad	70898804532657846               # 0xfbe2164b2b3eb6
	.quad	5377012037672284495             # 0x4a9efbf5aa74b14f
	.quad	-4898063424709384121            # 0xbc0695442add2847
	.quad	5034988761287688374             # 0x45dfdf9a14a300b6
	.quad	-6481778587783827219            # 0xa60c18b7626970ed
	.quad	-8787841695132108740            # 0x860b5089cb48b83c
	.quad	880899643920564618              # 0xc39958f16a7418a
	.quad	-8283597161014324293            # 0x8d0ac0453b4e93bb
	.quad	2302365909131558192             # 0x1ff3a5988cc17d30
	.quad	-818970709872713447             # 0xf4a26e7a7c966119
	.quad	3240208136982952581             # 0x2cf788221b32fa85
	.quad	2566218628330596371             # 0x239d0a3efda2a813
	.quad	967586897983112189              # 0xd6d8f283f9b03fd
	.quad	845437931479309879              # 0xbbb9951c1771e37
	.quad	1901123485772182529             # 0x1a6225bcdb9a7401
	.quad	-4492134628866503060            # 0xc1a8bb5afb2e4e6c
	.quad	8237727607861901054             # 0x7252499d2f0976fe
	.quad	-1159952065598753038            # 0xefe705bdf58176f2
	.quad	-5686618406964085074            # 0xb11512b017b53eae
	.quad	9096111778714482794             # 0x7e3be1782f85f86a
	.quad	-8430200316369658745            # 0x8b01e97a35669c87
	.quad	-3153005766053203608            # 0xd43e45f60ba3f168
	.quad	-8313911146272397959            # 0x8c9f0ddc8845e579
	.quad	-213077287131404513             # 0xfd0aff5616d4271f
	.quad	1492573973669067796             # 0x14b6b01efd89bc14
	.quad	5136420474350617731             # 0x47483b351eb64483
	.quad	-5507480660308062047            # 0xb3917f84f30110a1
	.quad	-4452635885029711025            # 0xc2350f40eea5a34f
	.quad	4212259300841999065             # 0x3a74f3844085cad9
	.quad	-8899233836652851874            # 0x847f91f9c92b8d5e
	.quad	-310154699653525971             # 0xfbb21bf1a5bbce2d
	.quad	4543818930490351731             # 0x3f0ee33e3b92a073
	.quad	3170712588170207130             # 0x2c00a24cbebe9f9a
	.quad	-5233046571929734594            # 0xb7607bde630d723e
	.quad	-8147271193735064465            # 0x8eef1403f0a6146f
	.quad	-5275641208153851783            # 0xb6c92845d193b879
	.quad	-3840020724356661094            # 0xcab5817f1a95409a
	.quad	-2240618085184544118            # 0xe0e7b9b90b42628a
	.quad	5562082647502074596             # 0x4d307cb2dfb9b2e4
	.quad	769898103640282723              # 0xaaf3a3f04b9d663
	.quad	7071927522436705792             # 0x6224889cec25ee00
	.quad	-5720422530062015598            # 0xb09cfa045a832392
	.quad	-4329701464722314927            # 0xc3e9cf7523bce951
	.quad	2659361136653073671             # 0x24e7f2dd27af7d07
	.quad	-8058430091759101851            # 0x902ab486e5615865
	.quad	8330398838548217122             # 0x739b859b78fe3d22
	.quad	1430579120698196246             # 0x13da7021784e8116
	.quad	6679056172420508415             # 0x5cb0c633a0012aff
	.quad	-5551429511325993546            # 0xb2f55c45adcb35b6
	.quad	-4607762252760606593            # 0xc00df0a4e2c0187f
	.quad	-9112534364370574053            # 0x8189c646a026e51b
	.quad	-1714507536905413447            # 0xe834d87aa205dcb9
	.quad	2979069625980241297             # 0x2957c80a81b54591
	.quad	-8581854337632204846            # 0x88e720f2d34987d2
	.quad	6093326406031685086             # 0x548fd8151c06b5de
	.quad	7773140906489475436             # 0x6bdfbe78785cf16c
	.quad	-3106325577883064960            # 0xd4e41d584d91e580
	.quad	5871904507443474185             # 0x517d3209f12eef09
	.quad	-7094204833274738690            # 0x9d8c524a74ccc7fe
	.quad	8501957475761003654             # 0x75fd054766361c86
	.quad	-7735800285933183743            # 0x94a4eaa03f965d01
	.quad	-675061824068590406             # 0xf6a1b2d8fef6e4ba
	.quad	8203831224248048929             # 0x71d9dd085e901d21
	.quad	-4741513048335879589            # 0xbe32c301100f725b
	.quad	7965935096487516939             # 0x6e8cafc3d1f49b0b
	.quad	-2229382223291438961            # 0xe10fa4ae0024a88f
	.quad	3613108158363123461             # 0x322456ba1a4cbf05
	.quad	-2922949711561263750            # 0xd76f98b94a0f757a
	.quad	3127973780287013159             # 0x2b68cb9498be4127
	.quad	-7294026199877419091            # 0x9ac669d10de9ffad
	.quad	-179536312651108483             # 0xfd8228acc425af7d
	.quad	7144866113559875910             # 0x6327a9e00a765146
	.quad	1006147740161637858             # 0xdf68e09f3e57de2
	.quad	-2863622197855930504            # 0xd8425ec87ddfb778
	.quad	4670249876821230493             # 0x40d00f84d83dc39d
	.quad	6396271604808022482             # 0x58c41f22bb7ff9d2
	.quad	7035768939232742253             # 0x61a41292b8b1cb6d
	.quad	-2725510460730996679            # 0xda2d0aad24848839
	.quad	-220761488650433747             # 0xfcefb29880e78b2d
	.quad	-3996579008576169078            # 0xc8894c910508db8a
	.quad	-8403685047082045136            # 0x8b601cf96c69b130
	.quad	-8446259098998134447            # 0x8ac8dc19834e2951
	.quad	-2945026235505414956            # 0xd7212a3e027e6cd4
	.quad	347930030084493742              # 0x4d41884d9e091ae
	.quad	-4914244519685471075            # 0xbbcd18a568bcc49d
	.quad	4125549503794460500             # 0x3940e56a64f53754
	.quad	-3359478452816531014            # 0xd160bc257d4ab1ba
	.quad	-5823229509268043088            # 0xaf2fbb9d36818ab0
	.quad	4866722741124721436             # 0x438a128c4d0deb1c
	.quad	-2552924244726475088            # 0xdc9230ece69896b0
	.quad	492556825527399295              # 0x6d5e9d2b941337f
	.quad	1579066367823140573             # 0x15e9f87ecadd56dd
	.quad	2674594957504396989             # 0x251e11f17819bebd
	.quad	1606367722786699329             # 0x164af6eed75ab841
	.quad	-8184899821231531363            # 0x8e6964fa61561a9d
	.quad	8530917603586705915             # 0x7663e85c99e989fb
	.quad	1670309003511599329             # 0x172e2130637210e1
	.quad	-8697445193756407630            # 0x874c77ad64b888b2
	.quad	-8897162909633927056            # 0x8486ed790e7d2870
	.quad	-7375544680717609499            # 0x99a4cd30b0ce15e5
	.quad	-1643393871872189015            # 0xe9317dfb09011da9
	.quad	4101614760538310349             # 0x38ebdce4b76286cd
	.quad	1342308353685522066             # 0x12a0d655f8770692
	.quad	2009894973314238474             # 0x1be494d4503d080a
	.quad	-4909954396300465648            # 0xbbdc567d9924aa10
	.quad	-5077355008372752763            # 0xb9899c8557643e85
	.quad	-8753191156764087634            # 0x86866b04f1fc6aae
	.quad	-5141283182842002738            # 0xb8a67e2f550342ce
	.quad	-8304969865716079172            # 0x8cbed1e8a3ab65bc
	.quad	-4688593357605269728            # 0xbeeec52eb7ae8f20
	.quad	-9083792209205227511            # 0x81efe31d1cdc9009
	.quad	-855499900526730687             # 0xf420a75f83b8e241
	.quad	167119840434273624              # 0x251ba9c04013d58
	.quad	-6589789725079559463            # 0xa48c5d28c41d22d9
	.quad	-2656928572737474918            # 0xdb20b18a4465ae9a
	.quad	-7294797955201632334            # 0x9ac3abe8c3f5f7b2
	.quad	-1391588209108582668            # 0xecb015e59275fef4
	.quad	687178403166060485              # 0x989591dea087fc5
	.quad	-868603248996166842             # 0xf3f219f274d55346
	.quad	3976688620990353522             # 0x3730093b3c77d072
	.quad	-3585264992582637035            # 0xce3e947c1b77ea15
	.quad	437600327409176085              # 0x612ab2de4d18e15
	.quad	-2456812311186808118            # 0xdde7a6383fe762ca
	.quad	2999412438460529718             # 0x29a00db8a153fc36
	.quad	7860640141335732598             # 0x6d169a8fa37e2176
	.quad	8768531691718961687             # 0x79b0151daea9ea17
	.quad	-4448279130639448357            # 0xc24489b2dc73c6db
	.quad	-8413881210227999194            # 0x8b3be39e3206be26
	.quad	-193883031850960598             # 0xfd4f3068e68c392a
	.quad	-5038881637933522220            # 0xba124bd8f1bbe2d4
	.quad	-8220675499102110080            # 0x8dea4b304642fe80
	.quad	3568928176241520458             # 0x318761446dc22f4a
	.quad	-7604858390740149362            # 0x96761d95fcc8db8e
	.quad	6064213690427596189             # 0x54286a38cbff5d9d
	.quad	5007861743342658649             # 0x457f7fb908352459
	.quad	-3251164691685082962            # 0xd2e18af035d178ae
	.quad	-8051699238091022173            # 0x90429e33e34d20a3
	.quad	-5022009592536489128            # 0xba4e3ce222422358
	.quad	-3538452501513536578            # 0xcee4e43288b17bbe
	.quad	696643767634944190              # 0x9aaf9d0d0dee0be
	.quad	-2704114446048281859            # 0xda790e3d034a3afd
	.quad	-5155313732594008385            # 0xb874a579670a7ebf
	.quad	-7325461004882207938            # 0x9a56bc072c051b3e
	.quad	5705113044279290098             # 0x4f2ca21637b6e8f2
	.quad	4669473964433839238             # 0x40cd4dd4aa039486
	.quad	3829757987559555004             # 0x352608994833bfbc
	.quad	1208067040595319684             # 0x10c3ea92a38a9b84
	.quad	-4179018859352451909            # 0xc601247d22a394bb
	.quad	-1415125933069333793            # 0xec5c767626f58adf
	.quad	-1887521844349337868            # 0xe5ce2ce211c47ef4
	.quad	2874595428781615653             # 0x27e49d4fed7d6a25
	.quad	7683114667204296767             # 0x6a9fe8153b4e403f
	.quad	-2156309426449636009            # 0xe213400052a4a557
	.quad	-8983052167162594557            # 0x8355c9a5f1787b03
	.quad	-6733339749775105692            # 0xa28e5f2c1ea32164
	.quad	-5391917211844289437            # 0xb52c0fdd09b4dc63
	.quad	5256726155023235539             # 0x48f3a4962faa39d3
	.quad	-9188633116276215700            # 0x807b6add3cf7306c
	.quad	-7920234196942354261            # 0x9215acf6095988ab
	.quad	-6035226244577014341            # 0xac3e91b4e0df4dbb
	.quad	-5960074226130326238            # 0xad499011b48a6d22
	.quad	-2567079508982593533            # 0xdc5fe6c99ce88803
	.quad	-3568825513063588226            # 0xce78fc1ab47e5e7e
	.quad	886873344026982165              # 0xc4ece9b877db715
	.quad	7951956925755604430             # 0x6e5b06b154debdce
	.quad	-7314315578160003118            # 0x9a7e54bc0caac7d2
	.quad	-3543773212350753069            # 0xced1fd0a0149d6d3
	.quad	1512922324958250623             # 0x14fefad6b7e5067f
	.quad	7651878266719793044             # 0x6a30eebe005d6f94
	.quad	-1621590554886003648            # 0xe97ef3fb5ce42440
	.quad	-7583116782939090732            # 0x96c35b76869cd0d4
	.quad	6639761026008365668             # 0x5c252b7964b63a64
	.quad	-454142982942750832             # 0xf9b28f5cf8760790
	.quad	-1332023134956723208            # 0xed83b404204d63f8
	.quad	4711976170924564396             # 0x41644d5cc2105fac
	.quad	-7064461857365441835            # 0x9df5fd5eae6fc2d5
	.quad	1820792268160727298             # 0x1944c0ebc17f7902
	.quad	-8033475524610347945            # 0x90835c92d3ce2c57
	.quad	8330684479620289181             # 0x739c896577a0929d
	.quad	1575676826334812257             # 0x15ddedb9aa805861
	.quad	-2063016760624196209            # 0xe35eb12fc151558f
	.quad	-7272038907526823191            # 0x9b1487247c0b42e9
	.quad	190809819222807994              # 0x2a5e485066e95ba
	.quad	-2348233829633118698            # 0xdf6965c5ff29ae16
	.quad	-3466764397855844640            # 0xcfe39425d9d4d6e0
	.quad	-3433641080708403104            # 0xd05941a11a2ff060
	.quad	-5853484189793737479            # 0xaec43f2478faa4f9
	.quad	-7506936467444720155            # 0x97d2010e6a881de5
	.quad	7630519326904161655             # 0x69e50ce64be01577
	.quad	-3043422487799645018            # 0xd5c3975f41443ca6
	.quad	-5688912097896923648            # 0xb10cec968e6e7e00
	.quad	1577166563359399478             # 0x15e338a218a91e36
	.quad	5225466260379412729             # 0x488495e0cbb428f9
	.quad	3522510952305563573             # 0x30e2790c4d9897b5
	.quad	2671650678994527462             # 0x25139c23356664e6
	.quad	9150418966942615600             # 0x7efcd191c69c8830
	.quad	2307543396467294708             # 0x20060a7e423b41f4
	.quad	-8215021446108012813            # 0x8dfe618512841ef3
	.quad	-2590177985398037392            # 0xdc0dd6d87b502470
	.quad	-5327558474080997045            # 0xb610b5cb6047b14b
	.quad	-4945574920449245403            # 0xbb5dc9d0088abf25
	.quad	9175174022405270828             # 0x7f54c42945dbad2c
	.quad	-4675914321245623791            # 0xbf1bd0b2e9fe2a11
	.quad	-6066466155904596466            # 0xabcf952c3760860e
	.quad	-7661246836304810492            # 0x95adc897e9776e04
	.quad	1112760087875960004             # 0xf7151677e143cc4
	.quad	5530412858504369971             # 0x4cbff9318467d733
	.quad	7926466369826203300             # 0x6e00772ac99226a4
	.quad	3353037784349488449             # 0x2e886219869d3541
	.quad	-7467314693684968705            # 0x985ec4d980da42ff
	.quad	3476035781936196668             # 0x303d5c2078daac3c
	.quad	-1759147746706085236            # 0xe7964071da27aa8c
	.quad	-8742797609900105440            # 0x86ab57e526c52120
	.quad	-2089307829699935130            # 0xe3014999384b0466
	.quad	4009122255460474520             # 0x37a3437339d59e98
	.quad	-2332756848442329537            # 0xdfa062017d3c363f
	.quad	-5426565684925283797            # 0xb4b0f742bfb4422b
	.quad	-2252313157816111667            # 0xe0be2d1dc16eadcd
	.quad	-8777749503567069281            # 0x862f2b554085ff9f
	.quad	-6391345660519971820            # 0xa74d60fc0bf90414
	.quad	-5316166794645411016            # 0xb6392e776e6eeb38
	.quad	-4482916491490043790            # 0xc1c97b33d6fed872
	.quad	3196492324831484847             # 0x2c5c38d56cd7dbaf
	.quad	3403216826305977331             # 0x2f3aa7ac29999bf3
	.quad	-7678490915579865547            # 0x95708531d5cc5635
	.quad	737748476126168036              # 0xa3d02548d1603e4
	.quad	-5316375779081076442            # 0xb63870657361c126
	.quad	-8883911778160785154            # 0x84b6014e86d148fe
	.quad	-60228239044365554              # 0xff2a06bc5650330e
	.quad	8739012531570357407             # 0x794735989ff0349f
	.quad	4345217821765812522             # 0x3c4d5096420c412a
	.quad	-4925208239269742837            # 0xbba62533857ff70b
	.quad	-2825206353687962482            # 0xd8cad9ca37409c8e
	.quad	5531923977151642514             # 0x4cc5578c3e96fb92
	.quad	3875593701443056894             # 0x35c8dff00c4134fe
	.quad	7339118784452570964             # 0x65d9c9a66fb12f54
	.quad	3694495313582158667             # 0x33457be9d668f34b
	.quad	9006976761539451856             # 0x7cff35a4c3c1dbd0
	.quad	-6080237069134334180            # 0xab9ea899a015f71c
	.quad	4428484982722340105             # 0x3d7523a0f0512509
	.quad	-5275564098468587243            # 0xb6c96e6750f9d915
	.quad	-5875439534620843711            # 0xae763edf67a36141
	.quad	-7995720207351435933            # 0x91097ed5a567ad63
	.quad	-7202359288752122517            # 0x9c0c1462f931d56b
	.quad	5497302379587009158             # 0x4c4a576366317a86
	.quad	-7727646258661882727            # 0x94c1e2abaa950499
	.quad	-9062239284533122665            # 0x823c75626fd02997
	.quad	6065821506919605949             # 0x542e2085bede26bd
	.quad	6574883216834227741             # 0x5b3ead735314ee1d
	.quad	5706368657872262502             # 0x4f31180f89e61566
	.quad	-6417280371003724858            # 0xa6f13d80b63c6bc6
	.quad	5247870567683236433             # 0x48d42e7a15fca251
	.quad	5077821417397208200             # 0x46780bacf8d4c488
	.quad	-7614934192468113624            # 0x965251b295f64728
	.quad	8426224164877606332             # 0x74eff63be1579dbc
	.quad	-3355253002874283236            # 0xd16fbf2bb81d9b1c
	.quad	-3792326543408578355            # 0xcb5ef319f3d8c0cd
	.quad	-6876741187848457249            # 0xa090e852fdfeb3df
	.quad	8426179804865657595             # 0x74efcde382967afb
	.quad	-338846049774404973             # 0xfb4c2d5021a6fa93
	.quad	1054238113598675147             # 0xea167fa8dba18cb
	.quad	8097866798062193390             # 0x706166f2d0ed4aee
	.quad	-7265114110251707624            # 0x9b2d21357dc4d318
	.quad	-918786614027255814             # 0xf33fd07146857ffa
	.quad	-7479330210108419272            # 0x983414cd14a3d338
	.quad	-6129777419732092524            # 0xaaeea7e9e8a87994
	.quad	-7557042287301599738            # 0x971ffe1420c85e06
	.quad	-3360308495443883746            # 0xd15dc93a2157091e
	.quad	8473655331653921525             # 0x759878a0f853aaf5
	.quad	2325301305762339502             # 0x20452137b5b75aae
	.quad	8164277191733227970             # 0x714d56d9851531c2
	.quad	-5329009630498185385            # 0xb60b8df9b1851f57
	.quad	3147563789211689379             # 0x2bae6496fbd861a3
	.quad	-568421041220202030             # 0xf81c90131b3651d2
	.quad	-5107638683171864002            # 0xb91e05add87f423e
	.quad	6392357190050193028             # 0x58b636ff065b1e84
	.quad	-9012817294425032045            # 0x82ec0a6c344c7a93
	.quad	-5359942348931902422            # 0xb59da8d4f357542a
	.quad	-6533780727219466246            # 0xa553590bc9ca4ffa
	.quad	1689853984201594410             # 0x1773913ed29d562a
	.quad	-5393082102256801440            # 0xb527ec66da776960
	.quad	6306670008025478694             # 0x5785caf547f7f626
	.quad	-6299748153214891005            # 0xa892cc6ea1340c03
	.quad	742522504522443050              # 0xa4df848a7cb292a
	.quad	4646229937700009072             # 0x407ab982f564f470
	.quad	226399390517769244              # 0x324550bd12d341c
	.quad	-7668276799120369710            # 0x9594cee1250f97d2
	.quad	808288679915234599              # 0xb379e459a512527
	.quad	4954601587613750396             # 0x44c247e4b14dd47c
	.quad	-6098548761534068725            # 0xab5d9a367f5d080b
	.quad	1506926752405847623             # 0x14e9ade5b3aefe47
	.quad	-1631279786050373066            # 0xe95c87ad6f313a36
	.quad	-5256545769222343811            # 0xb70cff7927eb737d
	.quad	3637640230771852239             # 0x327b7e844fd383cf
	.quad	5080770252355754143             # 0x468285a01d09589f
	.quad	-8156149199679380833            # 0x8ecf89841a06229f
	.quad	-4652820704192434848            # 0xbf6ddc38a306ed60
	.quad	-4250013075170978207            # 0xc504eba02bab1661
	.quad	-3465309966335269918            # 0xcfe8bef213f723e2
	.quad	-8465852016557766521            # 0x8a834071e80cc887
	.quad	-2873071313684318943            # 0xd820ccdcc57b3521
	.quad	294497295675397330              # 0x41643bae80b94d2
	.quad	2305314102074679398             # 0x1ffe1ef635dc2066
	.quad	-7040476042451328785            # 0x9e4b3457680a60ef
	.quad	7063184406320408590             # 0x620578cb91ce680e
	.quad	-7390633400685795179            # 0x996f32144efc6895
	.quad	-7934501710488278367            # 0x91e2fcbbac9deaa1
	.quad	1282336905956240657             # 0x11cbc69f31e52d11
	.quad	-5842423189906624945            # 0xaeeb8b10321c6e4f
	.quad	817884637507701013              # 0xb59b5be95e54915
	.quad	-8919174163536710917            # 0x8438ba5aa48d72fb
	.quad	-5550106691149640473            # 0xb2fa0f5ec081cce7
	.quad	813012132792143521              # 0xb48663a2d288ea1
	.quad	2136381337606728933             # 0x1da5f381ecd2ace5
	.quad	719065021122604702              # 0x9faa1d3b26bee9e
	.quad	833696300734894193              # 0xb91e25e4fdc5071
	.quad	-2840968366213104874            # 0xd892da52b1befb16
	.quad	7211324233606459209             # 0x6413c52ee8476f49
	.quad	-6981415928335671177            # 0x9f1d0733ca4c6077
	.quad	3305413135348656584             # 0x2ddf2fbbd85de9c8
	.quad	7532388794044145163             # 0x68886bb32b225e0b
	.quad	5656211977975309478             # 0x4e7ee6d3798724a6
	.quad	-8877275731576287461            # 0x84cd94c186330f1b
	.quad	508906233545967253              # 0x70fff85ea7d4695
	.quad	5320457231044157055             # 0x49d60fa9a30b9e7f
	.quad	5194350984697907346             # 0x48160ab3219e8892
	.quad	-5130872730919930816            # 0xb8cb7a6f8dc77440
	.quad	-8531336372154791929            # 0x899a9ac53e580807
	.quad	718250735342741698              # 0x9f7bd3d03c468c2
	.quad	-8237083183084188546            # 0x8db0007ca6ec4c7e
	.quad	-7249990285042725300            # 0x9b62dc3f72fece4c
	.quad	-9148270854375387424            # 0x810ad020a7e54ee0
	.quad	-6547918338842850918            # 0xa5211ef69301899a
	.quad	5693551462731326790             # 0x4f038ee3be81a546
	.quad	5561393805001047179             # 0x4d2e0a333b253c8b
	.quad	6466432124972803192             # 0x59bd61c1cd2da478
	.quad	-2175534359432776704            # 0xe1cef306cd5a3400
	.quad	-1576216485836951310            # 0xea2027751092f0f2
	.quad	-3995958274731034315            # 0xc88b811ee15fb935
	.quad	-4568073674692735273            # 0xc09af13210204ed7
	.quad	-4274262784907324330            # 0xc4aec4a4a4ed5456
	.quad	7799696076214505330             # 0x6c3e1641bac60f72
	.quad	-5666128142284974812            # 0xb15dde799b429524
	.quad	-1277234435035784549            # 0xee465a0c64cb9a9b
	.quad	-5592518684461902435            # 0xb26361e30ce9d59d
	.quad	-1817953028018623151            # 0xe6c5555a5a9aad51
	.quad	8800051604981503766             # 0x7a20104f60075716
	.quad	-2562509077114640074            # 0xdc70239234de2936
	.quad	1838402841651300485             # 0x198351a4eab1c885
	.quad	8750682680653583385             # 0x7970ab88f2851419
	.quad	7667758992184655637             # 0x6a695a2d88793f15
	.quad	171229141719840264              # 0x26053ff4767f608
	.quad	4398173011618892865             # 0x3d09730d32410c41
	.quad	7702528648903207370             # 0x6ae4e0ff162529ca
	.quad	-333981167030061360             # 0xfb5d75e5e980b6d0
	.quad	4076434952949912268             # 0x389267fde890d2cc
	.quad	8513310851424293958             # 0x76255b1d299f9446
	.quad	3048412926492676510             # 0x2a4e2367cc4e119e
	.quad	-469585047468316426             # 0xf97bb2e325d0e8f6
	.quad	1618491851278734881             # 0x167609c37b555621
	.quad	-4970663813691608881            # 0xbb04a798df05f0cf
	.quad	3556010568091535120             # 0x31597cc568a18710
	.quad	1828883868729391974             # 0x19618030530ebb66
	.quad	-34845445551813739              # 0xff8434407bd80b95
	.quad	1542888849359108157             # 0x1569713be1f5f83d
	.quad	6139418631961106529             # 0x553398b7bd74d861
	.quad	7174910925784032406             # 0x63926779026d2496
	.quad	3066228557242028740             # 0x2a8d6ea09291d2c4
	.quad	-2836980107092776389            # 0xd8a1059fa1e2aa3b
	.quad	-2813905437233871241            # 0xd8f2ffe9de228677
	.quad	2297830930689174454             # 0x1fe3890e99a22bb6
	.quad	-7869700442242902332            # 0x92c93524ab6096c4
	.quad	-8401828836097383863            # 0x8b66b53038c82249
	.quad	-6138772640447279615            # 0xaaceb2cee140ce01
	.quad	-2892397602823802180            # 0xd7dc23b46e7ef2bc
	.quad	-4734837591605130497            # 0xbe4a7a4bf335caff
	.quad	4319800213975156038             # 0x3bf3036846a54546
	.quad	-6747346936223735196            # 0xa25c9bb5e2106264
	.quad	-5391341945766769342            # 0xb52e1b109be88d42
	.quad	7470484790082753242             # 0x67ac7e5614d752da
	.quad	-7847849979096799602            # 0x9316d6061160e68e
	.quad	4362019906125708759             # 0x3c8901fe5fce3dd7
	.quad	-3998245855573323473            # 0xc8836093f5dfd12f
	.quad	-4061276774400642913            # 0xc7a3724a8f4e309f
	.quad	4945190749441092326             # 0x44a0d8c92efbeae6
	.quad	322800811041160002              # 0x47ad1a09b50fb42
	.quad	-5016300699970582423            # 0xba62851743b5c869
	.quad	-4595098633308150502            # 0xc03aee238dc8e51a
	.quad	6321933138484514871             # 0x57bc04b1c523d037
	.quad	-7041595470515490364            # 0x9e473a3a3fecb1c4
	.quad	111116256700316784              # 0x18ac3a59164bc70
	.quad	-5610604265848355425            # 0xb22321257ed1459f
	.quad	6083981670738182435             # 0x546ea51860564123
	.quad	-3221096525292714844            # 0xd34c5dc6beaec4a4
	.quad	4333468289108732907             # 0x3c23927301beebeb
	.quad	7888507960702818440             # 0x6d799c31f5885888
	.quad	7996103713347499501             # 0x6ef7ddf64d4275ed
	.quad	-2544107015005317716            # 0xdcb184262c0755ac
	.quad	-4486364573832070026            # 0xc1bd3b309bd7bc76
	.quad	8303905247009832174             # 0x733d65d38085fcee
	.quad	1595006692524783252             # 0x16229a22da4f7694
	.quad	4058500218990780670             # 0x3852b07241ca60fe
	.quad	-2215062900069698183            # 0xe14284073e32f579
	.quad	4552919830627188500             # 0x3f2f3876ab5d7f14
	.quad	5301725210030535910             # 0x499382fd209a74e6
	.quad	7666651638451160916             # 0x6a656b0ba68c4754
	.quad	-7986153809872988379            # 0x912b7b6c20e35725
	.quad	3968866883164190934             # 0x37143f66fbd038d6
	.quad	2858623199034543634             # 0x27abdea765250e12
	.quad	1649870560237363439             # 0x16e584887c52a0ef
	.quad	-3463961880106881211            # 0xcfed8905dcbc2f45
	.quad	6423986971288732841             # 0x5926961d596704a9
	.quad	-7723862278710903211            # 0x94cf542e2765be55
	.quad	-1739583687560691668            # 0xe7dbc1da55e1802c
	.quad	-969957346839482614             # 0xf28a04ee9e5a2f0a
	.quad	-131661358906310661             # 0xfe2c3eb10fbe7ffb
	.quad	-5061061430041663698            # 0xb9c37f71abefa72e
	.quad	957148168727808260              # 0xd487930326fc904
	.quad	5677813561153266687             # 0x4ecba559fd6fa3ff
	.quad	-1559445069485985045            # 0xea5bbcf8ba8db2eb
	.quad	-7941210913474748829            # 0x91cb26bf9fe1de63
	.quad	-6407061922338081903            # 0xa7158b20b11b7391
	.quad	4637379521801601434             # 0x405b481aeda7c19a
	.quad	6494579316382067070             # 0x5a21617a7e8d697e
	.quad	-2275476657914108999            # 0xe06be2091e5623b9
	.quad	3158224699997158982             # 0x2bd444a1b431fe46
	.quad	-4119293835634483700            # 0xc6d55414d98cde0c
	.quad	-174976463713385984             # 0xfd925bd5544f4200
	.quad	2792844090195992908             # 0x26c22ce7252e614c
	.quad	1438498904837014789             # 0x13f69321e8994505
	.quad	-8329987443895333989            # 0x8c65f08dcf278b9b
	.quad	1476995907390779576             # 0x147f57f3cabbb0b8
	.quad	487357780105947547              # 0x6c37151a1bce99b
	.quad	1032701892241692614             # 0xe54e4e645f097c6
	.quad	-4251425505429190957            # 0xc4ffe7071fdb86d3
	.quad	637480504042080859              # 0x8d8c92412aa4a5b
	.quad	5513725689353768170             # 0x4c84b04d2ee08cea
	.quad	6132827586651914623             # 0x551c2e326b1a817f
	.quad	4428939901950552582             # 0x3d76c1601350ea06
	.quad	696259917378675235              # 0x9a99cb4b6b2e223
	.quad	-837097111891253441             # 0xf462089ca337673f
	.quad	6379925032094153239             # 0x588a0c03af983a17
	.quad	-7928428343838028920            # 0x91f8906d8a654b88
	.quad	-5045133555291442222            # 0xb9fc15c3007333d2
	.quad	-650776797020403704             # 0xf6f7f9f379884808
	.quad	-1541511185832090968            # 0xea9b73be672fe2a8
	.quad	-5584241181476112077            # 0xb280ca3b66023933
	.quad	986014058367243493              # 0xdaf068fdc8554e5
	.quad	-8227657453923116528            # 0x8dd17d233d515a10
	.quad	-1571408568159956706            # 0xea313c3ba1d2111e
	.quad	4700407730598896856             # 0x413b33ed59d8e4d8
	.quad	5449823074692457348             # 0x4ba1a93647c56384
	.quad	4879039399901152612             # 0x43b5d47be43e4564
	.quad	-5988150091029217882            # 0xace5d138027afda6
	.quad	-7225508202213643088            # 0x9bb9d6928d626cb0
	.quad	-1829844145392335263            # 0xe69b1671d78fc661
	.quad	-5138165212804449482            # 0xb8b191f64d857b36
	.quad	7343994847412820673             # 0x65eb1c6750571ac1
	.quad	6476181400702925992             # 0x59e004abf1e3bca8
	.quad	-1724543523645574866            # 0xe81130cd6167b12e
	.quad	8415807990348894543             # 0x74caf4c742a3d14f
	.quad	3767387213406957112             # 0x344872b5ca786e38
	.quad	-8078727915948504045            # 0x8fe297c36cdb8c13
	.quad	-3971718978596873745            # 0xc8e19ea1cd0e59ef
	.size	FROGBARD_RC, 4096

	.type	voice_rotations.rot,@object     # @voice_rotations.rot
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0
voice_rotations.rot:
	.ascii	"\021\035)5"
	.ascii	"\027\037/;"
	.ascii	"\013%+9"
	.ascii	"\023\033-="
	.size	voice_rotations.rot, 16

	.type	FROGBARD_IV,@object             # @FROGBARD_IV
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
FROGBARD_IV:
	.quad	-3713163362495029904            # 0xcc783198517d1d70
	.quad	2422365921634760712             # 0x219df8f8b30d3808
	.quad	3485860529182711229             # 0x306043aeb27d9dbd
	.quad	-5238607278888300287            # 0xb74cba6f68165101
	.quad	-6724176679430909694            # 0xa2aeecefaf8e1102
	.quad	-4002000822335508359            # 0xc8760974a1def079
	.quad	1128767206446339523             # 0xfaa2fcb365815c3
	.quad	4679663374709083028             # 0x40f1810b9df0cb94
	.quad	5241868892676506334             # 0x48bedbfc3b2742de
	.quad	-2540665300091975456            # 0xdcbdbe5ededb48e0
	.quad	2826727257826162908             # 0x273a8d76dfa478dc
	.quad	4982133089669618708             # 0x452417a6097a1c14
	.quad	2132260498689602439             # 0x1d974fa058fdb387
	.quad	6172213453086044473             # 0x55a81b6f0d14b139
	.quad	1863621225422592281             # 0x19dce9a171311919
	.quad	463986347452716790              # 0x670691fec8cd6f6
	.quad	-196064190228097887             # 0xfd4770a8644794a1
	.quad	-2157668062748098215            # 0xe20e6c5428b1c159
	.quad	2305749863435466775             # 0x1fffab48cef9f817
	.quad	-5563683431358522552            # 0xb2c9d36597261b48
	.quad	-818547057788609482             # 0xf4a3efc9ac919c36
	.quad	6248127706951385325             # 0x56b5cf0ba41d00ed
	.quad	572938894745790209              # 0x7f37ce3a353e701
	.quad	-4293528415087484937            # 0xc46a52a791aa1ff7
	.quad	-5948432637203286761            # 0xad72ec0859287517
	.quad	-6514006734707037412            # 0xa59999633148eb1c
	.quad	4900431133697867331             # 0x4401d4270a537e43
	.quad	1073939581408545914             # 0xee7665bfc168c7a
	.quad	8232130340287527618             # 0x723e66edc58dbac2
	.quad	5433874813216058161             # 0x4b69005a4baf6b31
	.quad	8126587201565936936             # 0x70c77000d992cd28
	.quad	5216410478366829466             # 0x486469b13dae2b9a
	.size	FROGBARD_IV, 256

	.type	FROGBARD_SBOX_PIN,@object       # @FROGBARD_SBOX_PIN
	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	4, 0x0
FROGBARD_SBOX_PIN:
	.ascii	"\003\006\005\007\001\000\004\002"
	.ascii	"\003\007\006\000\002\004\001\005"
	.asciz	"\005\003\002\004\007\006\001"
	.asciz	"\005\007\004\002\003\001\006"
	.size	FROGBARD_SBOX_PIN, 32

	.type	FROGBARD_SBOX_POUT,@object      # @FROGBARD_SBOX_POUT
	.p2align	4, 0x0
FROGBARD_SBOX_POUT:
	.ascii	"\007\006\000\003\004\005\002\001"
	.ascii	"\003\000\002\005\006\004\001\007"
	.ascii	"\006\007\003\004\001\005\000\002"
	.ascii	"\001\003\006\002\007\000\004\005"
	.size	FROGBARD_SBOX_POUT, 32

	.type	FROGBARD_SBOX_IN_XOR,@object    # @FROGBARD_SBOX_IN_XOR
	.section	.rodata.cst4,"aM",@progbits,4
FROGBARD_SBOX_IN_XOR:
	.ascii	"\247r\217\212"
	.size	FROGBARD_SBOX_IN_XOR, 4

	.type	FROGBARD_SBOX_OUT_XOR,@object   # @FROGBARD_SBOX_OUT_XOR
FROGBARD_SBOX_OUT_XOR:
	.ascii	"qC\236v"
	.size	FROGBARD_SBOX_OUT_XOR, 4

	.ident	"Ubuntu clang version 21.1.8 (6ubuntu1)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym frogbard_self_test.expected_empty
	.addrsig_sym frogbard_self_test.expected_abc
