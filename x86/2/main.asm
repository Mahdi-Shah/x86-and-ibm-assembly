segment .data
read_int_format: db		"%d", 0
read_float_format: db		"%f", 0
print_Impossible: db 	"Impossible", 0
print_float_format: db 	"%.2f ", 0
segment .text
	extern printf
    extern puts
    extern scanf
    extern getchar
	global asm_main
asm_main:
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 184
	mov	rax, rsp
	mov	QWORD -200[rbp], rax
	lea	rax, -148[rbp]
	mov	rsi, rax
	lea	rax, read_int_format
	mov	rdi, rax
	mov	eax, 0
	call	scanf
	mov	eax, DWORD -148[rbp]
	lea	ecx, 1[rax]
	mov	esi, DWORD -148[rbp]
	movsx	rax, ecx
	sub	rax, 1
	mov	QWORD -96[rbp], rax
	movsx	rax, ecx
	mov	QWORD -224[rbp], rax
	mov	QWORD -216[rbp], 0
	movsx	rax, ecx
	lea	rbx, 0[0+rax*4]
	movsx	rax, esi
	sub	rax, 1
	mov	QWORD -88[rbp], rax
	movsx	rax, ecx
	mov	QWORD -176[rbp], rax
	mov	QWORD -168[rbp], 0
	movsx	rax, esi
	mov	QWORD -192[rbp], rax
	mov	QWORD -184[rbp], 0
	mov	r8, QWORD -176[rbp]
	mov	r9, QWORD -168[rbp]
	mov	rdx, r9
	mov	r10, QWORD -192[rbp]
	mov	r11, QWORD -184[rbp]
	mov	rax, r10
	imul	rdx, rax
	mov	rax, r11
	mov	rdi, r8
	imul	rax, rdi
	lea	rdi, [rdx+rax]
	mov	rax, r8
	mul	r10
	add	rdi, rdx
	mov	rdx, rdi
	movsx	rax, ecx
	mov	r14, rax
	mov	r15d, 0
	movsx	rax, esi
	mov	r12, rax
	mov	r13d, 0
	mov	rdx, r15
	imul	rdx, r12
	mov	rax, r13
	imul	rax, r14
	lea	rdi, [rdx+rax]
	mov	rax, r14
	mul	r12
	add	rdi, rdx
	mov	rdx, rdi
	movsx	rdx, ecx
	movsx	rax, esi
	imul	rax, rdx
	lea	rdx, 0[0+rax*4]
	mov	eax, 16
	sub	rax, 1
	add	rax, rdx
	mov	edi, 16
	mov	edx, 0
	div	rdi
	imul	rax, rax, 16
	mov	rcx, rax
	and	rcx, -4096
	mov	rdx, rsp
	sub	rdx, rcx
.L2:
	cmp	rsp, rdx
	je	.L3
	sub	rsp, 4096
	or	QWORD 4088[rsp], 0
	jmp	.L2
.L3:
	mov	rdx, rax
	and	edx, 4095
	sub	rsp, rdx
	mov	rdx, rax
	and	edx, 4095
	test	rdx, rdx
	je	.L4
	and	eax, 4095
	sub	rax, 8
	add	rax, rsp
	or	QWORD [rax], 0
.L4:
	mov	rax, rsp
	add	rax, 3
	shr	rax, 2
	sal	rax, 2
	mov	QWORD -80[rbp], rax
	mov	DWORD -144[rbp], 0
	jmp	.L5
.L8:
	mov	DWORD -140[rbp], 0
	jmp	.L6
.L7:
	mov	rcx, rbx
	shr	rcx, 2
	mov	eax, DWORD -140[rbp]
	movsx	rdx, eax
	mov	eax, DWORD -144[rbp]
	cdqe
	imul	rax, rcx
	add	rax, rdx
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD -80[rbp]
	add	rax, rdx
	mov	rsi, rax
	lea	rax, read_float_format
	mov	rdi, rax
	mov	eax, 0
	call	scanf
	add	DWORD -140[rbp], 1
.L6:
	mov	eax, DWORD -148[rbp]
	cmp	DWORD -140[rbp], eax
	jle	.L7
	add	DWORD -144[rbp], 1
.L5:
	mov	eax, DWORD -148[rbp]
	cmp	DWORD -144[rbp], eax
	jl	.L8
	mov	DWORD -136[rbp], 0
	jmp	.L9
.L23:
	mov	DWORD -132[rbp], 0
	jmp	.L10
.L22:
	mov	rsi, rbx
	shr	rsi, 2
	mov	rax, QWORD -80[rbp]
	mov	edx, DWORD -132[rbp]
	movsx	rcx, edx
	mov	edx, DWORD -136[rbp]
	movsx	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movss	xmm0, DWORD [rax+rdx*4]
	pxor	xmm1, xmm1
	ucomiss	xmm0, xmm1
	jp	.L41
	pxor	xmm1, xmm1
	ucomiss	xmm0, xmm1
	je	.L11
.L41:
	mov	rsi, rbx
	shr	rsi, 2
	mov	rax, QWORD -80[rbp]
	mov	edx, DWORD -132[rbp]
	movsx	rcx, edx
	mov	edx, DWORD -136[rbp]
	movsx	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movss	xmm0, DWORD [rax+rdx*4]
	cvtss2sd	xmm0, xmm0
	movsd	QWORD -72[rbp], xmm0
	mov	DWORD -128[rbp], 0
	jmp	.L13
.L14:
	mov	rsi, rbx
	shr	rsi, 2
	mov	rax, QWORD -80[rbp]
	mov	edx, DWORD -128[rbp]
	movsx	rcx, edx
	mov	edx, DWORD -136[rbp]
	movsx	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movss	xmm0, DWORD [rax+rdx*4]
	cvtss2sd	xmm0, xmm0
	divsd	xmm0, QWORD -72[rbp]
	mov	rsi, rbx
	shr	rsi, 2
	cvtsd2ss	xmm0, xmm0
	mov	rax, QWORD -80[rbp]
	mov	edx, DWORD -128[rbp]
	movsx	rcx, edx
	mov	edx, DWORD -136[rbp]
	movsx	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movss	DWORD [rax+rdx*4], xmm0
	add	DWORD -128[rbp], 1
.L13:
	mov	eax, DWORD -148[rbp]
	cmp	DWORD -128[rbp], eax
	jle	.L14
	mov	DWORD -124[rbp], 0
	jmp	.L15
.L20:
	mov	eax, DWORD -124[rbp]
	cmp	eax, DWORD -136[rbp]
	je	.L44
	mov	rsi, rbx
	shr	rsi, 2
	mov	rax, QWORD -80[rbp]
	mov	edx, DWORD -132[rbp]
	movsx	rcx, edx
	mov	edx, DWORD -124[rbp]
	movsx	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movss	xmm0, DWORD [rax+rdx*4]
	cvtss2sd	xmm0, xmm0
	movsd	QWORD -64[rbp], xmm0
	mov	DWORD -120[rbp], 0
	jmp	.L18
.L19:
	mov	rsi, rbx
	shr	rsi, 2
	mov	rax, QWORD -80[rbp]
	mov	edx, DWORD -120[rbp]
	movsx	rcx, edx
	mov	edx, DWORD -124[rbp]
	movsx	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movss	xmm0, DWORD [rax+rdx*4]
	cvtss2sd	xmm0, xmm0
	mov	rsi, rbx
	shr	rsi, 2
	mov	rax, QWORD -80[rbp]
	mov	edx, DWORD -120[rbp]
	movsx	rcx, edx
	mov	edx, DWORD -136[rbp]
	movsx	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movss	xmm1, DWORD [rax+rdx*4]
	cvtss2sd	xmm1, xmm1
	mulsd	xmm1, QWORD -64[rbp]
	subsd	xmm0, xmm1
	mov	rsi, rbx
	shr	rsi, 2
	cvtsd2ss	xmm0, xmm0
	mov	rax, QWORD -80[rbp]
	mov	edx, DWORD -120[rbp]
	movsx	rcx, edx
	mov	edx, DWORD -124[rbp]
	movsx	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movss	DWORD [rax+rdx*4], xmm0
	add	DWORD -120[rbp], 1
.L18:
	mov	eax, DWORD -148[rbp]
	cmp	DWORD -120[rbp], eax
	jle	.L19
	jmp	.L17
.L44:
	nop
.L17:
	add	DWORD -124[rbp], 1
.L15:
	mov	eax, DWORD -148[rbp]
	cmp	DWORD -124[rbp], eax
	jl	.L20
	jmp	.L21
.L11:
	add	DWORD -132[rbp], 1
.L10:
	mov	eax, DWORD -148[rbp]
	cmp	DWORD -132[rbp], eax
	jl	.L22
.L21:
	add	DWORD -136[rbp], 1
.L9:
	mov	eax, DWORD -148[rbp]
	cmp	DWORD -136[rbp], eax
	jl	.L23
	mov	DWORD -116[rbp], 0
	jmp	.L24
.L32:
	mov	DWORD -112[rbp], 1
	mov	DWORD -108[rbp], 0
	jmp	.L25
.L29:
	mov	rsi, rbx
	shr	rsi, 2
	mov	rax, QWORD -80[rbp]
	mov	edx, DWORD -108[rbp]
	movsx	rcx, edx
	mov	edx, DWORD -116[rbp]
	movsx	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movss	xmm0, DWORD [rax+rdx*4]
	pxor	xmm1, xmm1
	ucomiss	xmm0, xmm1
	jp	.L42
	pxor	xmm1, xmm1
	ucomiss	xmm0, xmm1
	je	.L26
.L42:
	mov	DWORD -112[rbp], 0
	jmp	.L28
.L26:
	add	DWORD -108[rbp], 1
.L25:
	mov	eax, DWORD -148[rbp]
	cmp	DWORD -108[rbp], eax
	jl	.L29
.L28:
	cmp	DWORD -112[rbp], 0
	je	.L30
	lea	rax, print_Impossible
	mov	rdi, rax
	call	puts
	mov	eax, 0
	mov	rsp, QWORD -200[rbp]
	jmp	.L31
.L30:
	add	DWORD -116[rbp], 1
.L24:
	mov	eax, DWORD -148[rbp]
	cmp	DWORD -116[rbp], eax
	jl	.L32
	mov	DWORD -104[rbp], 0
	jmp	.L33
.L39:
	mov	DWORD -100[rbp], 0
	jmp	.L34
.L38:
	mov	rsi, rbx
	shr	rsi, 2
	mov	rax, QWORD -80[rbp]
	mov	edx, DWORD -104[rbp]
	movsx	rcx, edx
	mov	edx, DWORD -100[rbp]
	movsx	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movss	xmm0, DWORD [rax+rdx*4]
	pxor	xmm1, xmm1
	ucomiss	xmm0, xmm1
	jp	.L43
	pxor	xmm1, xmm1
	ucomiss	xmm0, xmm1
	je	.L35
.L43:
	mov	rsi, rbx
	shr	rsi, 2
	mov	edx, DWORD -148[rbp]
	mov	rax, QWORD -80[rbp]
	movsx	rcx, edx
	mov	edx, DWORD -100[rbp]
	movsx	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movss	xmm0, DWORD [rax+rdx*4]
	pxor	xmm2, xmm2
	cvtss2sd	xmm2, xmm0
	movq	rax, xmm2
	movq	xmm0, rax
	lea	rax, print_float_format
	mov	rdi, rax
	mov	eax, 1
	call	printf
	jmp	.L37
.L35:
	add	DWORD -100[rbp], 1
.L34:
	mov	eax, DWORD -148[rbp]
	cmp	DWORD -100[rbp], eax
	jl	.L38
.L37:
	add	DWORD -104[rbp], 1
.L33:
	mov	eax, DWORD -148[rbp]
	cmp	DWORD -104[rbp], eax
	jl	.L39
	mov	rsp, QWORD -200[rbp]
	mov	eax, 0
.L31:
.L40:
	lea	rsp, -40[rbp]
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	ret
