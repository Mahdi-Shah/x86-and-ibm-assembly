segment .data
LC0: db		"%d", 0
LC1: db		"%lf", 0
LC5: db 	"Impossible", 0
LC6: db 	"%.2f ", 0
segment .LC3
long1: dq	0.0001
long3: dq	-0.0001
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
	sub	rsp, 200
	mov	rax, QWORD fs:40
	mov	QWORD -56[rbp], rax
	xor	eax, eax
	mov	rax, rsp
	mov	QWORD -216[rbp], rax
	lea	rax, -164[rbp]
	mov	rsi, rax
	lea	rax, LC0
	mov	rdi, rax
	mov	eax, 0
	call	scanf
	mov	eax, DWORD -164[rbp]
	lea	ecx, 1[rax]
	mov	esi, DWORD -164[rbp]
	movsx	rax, ecx
	sub	rax, 1
	mov	QWORD -104[rbp], rax
	movsx	rax, ecx
	mov	QWORD -240[rbp], rax
	mov	QWORD -232[rbp], 0
	movsx	rax, ecx
	lea	rbx, 0[0+rax*8]
	movsx	rax, esi
	sub	rax, 1
	mov	QWORD -96[rbp], rax
	movsx	rax, ecx
	mov	QWORD -192[rbp], rax
	mov	QWORD -184[rbp], 0
	movsx	rax, esi
	mov	QWORD -208[rbp], rax
	mov	QWORD -200[rbp], 0
	mov	r8, QWORD -192[rbp]
	mov	r9, QWORD -184[rbp]
	mov	rdx, r9
	mov	r10, QWORD -208[rbp]
	mov	r11, QWORD -200[rbp]
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
	lea	rdx, 0[0+rax*8]
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
	add	rax, 7
	shr	rax, 3
	sal	rax, 3
	mov	QWORD -88[rbp], rax
	mov	DWORD -160[rbp], 0
	jmp	.L5
.L8:
	mov	DWORD -156[rbp], 0
	jmp	.L6
.L7:
	mov	rcx, rbx
	shr	rcx, 3
	mov	eax, DWORD -156[rbp]
	movsx	rdx, eax
	mov	eax, DWORD -160[rbp]
	cdqe
	imul	rax, rcx
	add	rax, rdx
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD -88[rbp]
	add	rax, rdx
	mov	rsi, rax
	lea	rax, LC1
	mov	rdi, rax
	mov	eax, 0
	call	scanf
	add	DWORD -156[rbp], 1
.L6:
	mov	eax, DWORD -164[rbp]
	cmp	DWORD -156[rbp], eax
	jle	.L7
	add	DWORD -160[rbp], 1
.L5:
	mov	eax, DWORD -164[rbp]
	cmp	DWORD -160[rbp], eax
	jl	.L8
	mov	DWORD -152[rbp], 0
	jmp	.L9
.L30:
	mov	DWORD -148[rbp], 0
	jmp	.L10
.L29:
	mov	rsi, rbx
	shr	rsi, 3
	mov	rax, QWORD -88[rbp]
	mov	edx, DWORD -148[rbp]
	movsx	rcx, edx
	mov	edx, DWORD -152[rbp]
	movsx	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movsd	xmm0, QWORD [rax+rdx*8]
	pxor	xmm1, xmm1
	ucomisd	xmm0, xmm1
	jp	.L48
	pxor	xmm1, xmm1
	ucomisd	xmm0, xmm1
	je	.L11
.L48:
	mov	rsi, rbx
	shr	rsi, 3
	mov	rax, QWORD -88[rbp]
	mov	edx, DWORD -148[rbp]
	movsx	rcx, edx
	mov	edx, DWORD -152[rbp]
	movsx	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movsd	xmm0, QWORD [rax+rdx*8]
	movsd	QWORD -80[rbp], xmm0
	mov	DWORD -144[rbp], 0
	jmp	.L13
.L14:
	mov	rsi, rbx
	shr	rsi, 3
	mov	rax, QWORD -88[rbp]
	mov	edx, DWORD -144[rbp]
	movsx	rcx, edx
	mov	edx, DWORD -152[rbp]
	movsx	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movsd	xmm0, QWORD [rax+rdx*8]
	mov	rsi, rbx
	shr	rsi, 3
	divsd	xmm0, QWORD -80[rbp]
	mov	rax, QWORD -88[rbp]
	mov	edx, DWORD -144[rbp]
	movsx	rcx, edx
	mov	edx, DWORD -152[rbp]
	movsx	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movsd	QWORD [rax+rdx*8], xmm0
	add	DWORD -144[rbp], 1
.L13:
	mov	eax, DWORD -164[rbp]
	cmp	DWORD -144[rbp], eax
	jle	.L14
	mov	DWORD -140[rbp], 0
	jmp	.L15
.L20:
	mov	eax, DWORD -140[rbp]
	cmp	eax, DWORD -152[rbp]
	je	.L53
	mov	rsi, rbx
	shr	rsi, 3
	mov	rax, QWORD -88[rbp]
	mov	edx, DWORD -148[rbp]
	movsx	rcx, edx
	mov	edx, DWORD -140[rbp]
	movsx	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movsd	xmm0, QWORD [rax+rdx*8]
	movsd	QWORD -64[rbp], xmm0
	mov	DWORD -136[rbp], 0
	jmp	.L18
.L19:
	mov	rsi, rbx
	shr	rsi, 3
	mov	rax, QWORD -88[rbp]
	mov	edx, DWORD -136[rbp]
	movsx	rcx, edx
	mov	edx, DWORD -140[rbp]
	movsx	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movsd	xmm0, QWORD [rax+rdx*8]
	mov	rsi, rbx
	shr	rsi, 3
	mov	rax, QWORD -88[rbp]
	mov	edx, DWORD -136[rbp]
	movsx	rcx, edx
	mov	edx, DWORD -152[rbp]
	movsx	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movsd	xmm1, QWORD [rax+rdx*8]
	mulsd	xmm1, QWORD -64[rbp]
	mov	rsi, rbx
	shr	rsi, 3
	subsd	xmm0, xmm1
	mov	rax, QWORD -88[rbp]
	mov	edx, DWORD -136[rbp]
	movsx	rcx, edx
	mov	edx, DWORD -140[rbp]
	movsx	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movsd	QWORD [rax+rdx*8], xmm0
	add	DWORD -136[rbp], 1
.L18:
	mov	eax, DWORD -164[rbp]
	cmp	DWORD -136[rbp], eax
	jle	.L19
	jmp	.L17
.L53:
	nop
.L17:
	add	DWORD -140[rbp], 1
.L15:
	mov	eax, DWORD -164[rbp]
	cmp	DWORD -140[rbp], eax
	jl	.L20
	mov	DWORD -132[rbp], 0
	jmp	.L21
.L27:
	mov	DWORD -128[rbp], 0
	jmp	.L22
.L26:
	mov	rsi, rbx
	shr	rsi, 3
	mov	rax, QWORD -88[rbp]
	mov	edx, DWORD -128[rbp]
	movsx	rcx, edx
	mov	edx, DWORD -132[rbp]
	movsx	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movsd	xmm0, QWORD [rax+rdx*8]
	movsd	QWORD -72[rbp], xmm0
	movsd	xmm0, QWORD -72[rbp]
	comisd	xmm0, QWORD [long1]
	jbe	.L23
	movsd	xmm0, QWORD [long3]
	comisd	xmm0, QWORD -72[rbp]
	jbe	.L23
	mov	rsi, rbx
	shr	rsi, 3
	mov	rax, QWORD -88[rbp]
	mov	edx, DWORD -128[rbp]
	movsx	rcx, edx
	mov	edx, DWORD -132[rbp]
	movsx	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	pxor	xmm0, xmm0
	movsd	QWORD [rax+rdx*8], xmm0
.L23:
	add	DWORD -128[rbp], 1
.L22:
	mov	eax, DWORD -164[rbp]
	cmp	DWORD -128[rbp], eax
	jle	.L26
	add	DWORD -132[rbp], 1
.L21:
	mov	eax, DWORD -164[rbp]
	cmp	DWORD -132[rbp], eax
	jl	.L27
	jmp	.L28
.L11:
	add	DWORD -148[rbp], 1
.L10:
	mov	eax, DWORD -164[rbp]
	cmp	DWORD -148[rbp], eax
	jl	.L29
.L28:
	add	DWORD -152[rbp], 1
.L9:
	mov	eax, DWORD -164[rbp]
	cmp	DWORD -152[rbp], eax
	jl	.L30
	mov	DWORD -124[rbp], 0
	jmp	.L31
.L39:
	mov	DWORD -120[rbp], 1
	mov	DWORD -116[rbp], 0
	jmp	.L32
.L36:
	mov	rsi, rbx
	shr	rsi, 3
	mov	rax, QWORD -88[rbp]
	mov	edx, DWORD -116[rbp]
	movsx	rcx, edx
	mov	edx, DWORD -124[rbp]
	movsx	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movsd	xmm0, QWORD [rax+rdx*8]
	pxor	xmm1, xmm1
	ucomisd	xmm0, xmm1
	jp	.L51
	pxor	xmm1, xmm1
	ucomisd	xmm0, xmm1
	je	.L33
.L51:
	mov	DWORD -120[rbp], 0
	jmp	.L35
.L33:
	add	DWORD -116[rbp], 1
.L32:
	mov	eax, DWORD -164[rbp]
	cmp	DWORD -116[rbp], eax
	jl	.L36
.L35:
	cmp	DWORD -120[rbp], 0
	je	.L37
	lea	rax, LC5
	mov	rdi, rax
	call	puts
	mov	eax, 0
	mov	rsp, QWORD -216[rbp]
	jmp	.L38
.L37:
	add	DWORD -124[rbp], 1
.L31:
	mov	eax, DWORD -164[rbp]
	cmp	DWORD -124[rbp], eax
	jl	.L39
	mov	DWORD -112[rbp], 0
	jmp	.L40
.L46:
	mov	DWORD -108[rbp], 0
	jmp	.L41
.L45:
	mov	rsi, rbx
	shr	rsi, 3
	mov	rax, QWORD -88[rbp]
	mov	edx, DWORD -112[rbp]
	movsx	rcx, edx
	mov	edx, DWORD -108[rbp]
	movsx	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movsd	xmm0, QWORD [rax+rdx*8]
	pxor	xmm1, xmm1
	ucomisd	xmm0, xmm1
	jp	.L52
	pxor	xmm1, xmm1
	ucomisd	xmm0, xmm1
	je	.L42
.L52:
	mov	rsi, rbx
	shr	rsi, 3
	mov	edx, DWORD -164[rbp]
	mov	rax, QWORD -88[rbp]
	movsx	rcx, edx
	mov	edx, DWORD -108[rbp]
	movsx	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	mov	rax, QWORD [rax+rdx*8]
	movq	xmm0, rax
	lea	rax, LC6
	mov	rdi, rax
	mov	eax, 1
	call	printf
	jmp	.L44
.L42:
	add	DWORD -108[rbp], 1
.L41:
	mov	eax, DWORD -164[rbp]
	cmp	DWORD -108[rbp], eax
	jl	.L45
.L44:
	add	DWORD -112[rbp], 1
.L40:
	mov	eax, DWORD -164[rbp]
	cmp	DWORD -112[rbp], eax
	jl	.L46
	mov	rsp, QWORD -216[rbp]
	mov	eax, 0
.L38:
	mov	rdx, QWORD -56[rbp]
	sub	rdx, QWORD fs:40
	je	.L47
	ret
.L47:
	lea	rsp, -40[rbp]
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	ret

