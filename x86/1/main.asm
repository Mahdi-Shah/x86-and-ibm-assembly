segment .data
	string: db	"%d"
segment .text
segment .text
	extern printf
    extern puts
    extern scanf
    extern getchar
	extern putchar
	global asm_main

asm_main:
	push	rbp						; 
	mov	rbp, rsp					;
	sub	rsp, 480					; set rsp and rbp
	mov	rax, QWORD fs:40
	mov	QWORD -8[rbp], rax
	xor	eax, eax
	jmp	.L87
.L92:
	mov	DWORD -464[rbp], 1			; -464[rbp] = first number sign = 1
	mov	DWORD -456[rbp], 1			; -456[rbp] = second number sign  = 1
	lea	rax, -464[rbp]				; rax = -464[rbp] = address(first number sign)
	mov	QWORD -448[rbp], rax		; -448[rbp] = rax =  address(first number sign)
	lea	rax, -460[rbp]				; rax = -460[rbp] = address(first number lentgh)
	mov	QWORD -440[rbp], rax		; -440[rbp] = rax =  address(first number lentgh)
	lea	rax, -456[rbp]				; rax = -456[rbp] = address(second number sign)
	mov	QWORD -432[rbp], rax		; -432[rbp] = rax =  address(second number sign)
	lea	rax, -452[rbp]				; rax = -452[rbp] = address(second number lentgh)
	mov	QWORD -424[rbp], rax		; -424[rbp] = rax =  address(second number lentgh)
	call	getchar					; get char, this char is equal to + or - or x or / or q
	mov	rdx, QWORD -440[rbp]		; 3rd parameter of get_number = address(first number lentgh)				
	mov	rsi, QWORD -448[rbp]		; 2nd parameter of get_number = address(first number sign)
	lea	rdi, -416[rbp]				; 1st parameter of get_number = address(first number array[0]) = -416[rbp]
	call	get_number				; initialize first number; first number[i] = [-416[rbp] + 2 * i]
	mov	rdx, QWORD -424[rbp]
	mov	rcx, QWORD -432[rbp]
	lea	rax, -208[rbp]
	mov	rsi, rcx
	mov	rdi, rax
	call	get_number
	cmp	BYTE -465[rbp], 43			; character equal to '+'
	jne	.L88
	mov	r8d, DWORD -452[rbp]
	mov	edi, DWORD -456[rbp]
	mov	edx, DWORD -460[rbp]
	mov	esi, DWORD -464[rbp]
	lea	rcx, -208[rbp]
	lea	rax, -416[rbp]
	mov	r9d, r8d
	mov	r8d, edi
	mov	rdi, rax
	call	add
	jmp	.L87
.L88:
	cmp	BYTE -465[rbp], 45
	jne	.L90
	mov	r8d, DWORD -452[rbp]
	mov	edi, DWORD -456[rbp]
	mov	edx, DWORD -460[rbp]
	mov	esi, DWORD -464[rbp]
	lea	rcx, -208[rbp]
	lea	rax, -416[rbp]
	mov	r9d, r8d
	mov	r8d, edi
	mov	rdi, rax
	call	subtract
	jmp	.L87
.L90:
	cmp	BYTE -465[rbp], 120
	jne	.L91
	mov	r8d, DWORD -452[rbp]
	mov	edi, DWORD -456[rbp]
	mov	edx, DWORD -460[rbp]
	mov	esi, DWORD -464[rbp]
	lea	rcx, -208[rbp]
	lea	rax, -416[rbp]
	mov	r9d, r8d
	mov	r8d, edi
	mov	rdi, rax
	call	multiple
	jmp	.L87
.L91:
	cmp	BYTE -465[rbp], 47
	jne	.L87
	mov	r8d, DWORD -452[rbp]
	mov	edi, DWORD -456[rbp]
	mov	edx, DWORD -460[rbp]
	mov	esi, DWORD -464[rbp]
	lea	rcx, -208[rbp]
	lea	rax, -416[rbp]
	mov	r9d, r8d
	mov	r8d, edi
	mov	rdi, rax
	call	divide
.L87:
	call	getchar
	mov	BYTE -465[rbp], al
	cmp	BYTE -465[rbp], 113
	jne	.L92
	mov	eax, 0
	mov	rdx, QWORD -8[rbp]
	sub	rdx, QWORD fs:40
	leave
	ret


print_array:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD -24[rbp], rdi
	mov	DWORD -28[rbp], esi
	mov	DWORD -32[rbp], edx
	cmp	DWORD -28[rbp], 1
	jne	.L2
	mov	rax, QWORD -24[rbp]
	movzx	eax, WORD [rax]
	test	ax, ax
	jne	.L2
	mov	DWORD -32[rbp], 1
.L2:
	cmp	DWORD -32[rbp], -1
	jne	.L3
	mov	edi, 45
	call	putchar
.L3:
	mov	DWORD -4[rbp], 0
	jmp	.L4
.L5:
	mov	eax, DWORD -4[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]
	cwde
	mov	esi, eax
	lea	rax, string
	mov	rdi, rax
	mov	eax, 0
	call	printf
	add	DWORD -4[rbp], 1
.L4:
	mov	eax, DWORD -4[rbp]
	cmp	eax, DWORD -28[rbp]
	jl	.L5
	mov	edi, 10
	call	putchar
	leave
	ret

reverse_array:
	push	rbp
	mov	rbp, rsp
	mov	QWORD -24[rbp], rdi
	mov	DWORD -28[rbp], esi
	mov	DWORD -4[rbp], 0
	jmp	.L7
.L8:
	mov	eax, DWORD -4[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]
	mov	WORD -6[rbp], ax
	mov	eax, DWORD -28[rbp]
	sub	eax, DWORD -4[rbp]
	cdqe
	add	rax, rax
	lea	rdx, -2[rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	mov	edx, DWORD -4[rbp]
	movsx	rdx, edx
	lea	rcx, [rdx+rdx]
	mov	rdx, QWORD -24[rbp]
	add	rdx, rcx
	movzx	eax, WORD [rax]
	mov	WORD [rdx], ax
	mov	eax, DWORD -28[rbp]
	sub	eax, DWORD -4[rbp]
	cdqe
	add	rax, rax
	lea	rdx, -2[rax]
	mov	rax, QWORD -24[rbp]
	add	rdx, rax
	movzx	eax, WORD -6[rbp]
	mov	WORD [rdx], ax
	add	DWORD -4[rbp], 1
.L7:
	mov	eax, DWORD -28[rbp]
	mov	edx, eax
	shr	edx, 31
	add	eax, edx
	sar	eax, 1
	cmp	DWORD -4[rbp], eax
	jl	.L8
	pop	rbp
	ret

get_number:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD -24[rbp], rdi
	mov	QWORD -32[rbp], rsi
	mov	QWORD -40[rbp], rdx
	mov	DWORD -4[rbp], 0
	jmp	.L10
.L11:
	mov	eax, DWORD -4[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	mov	WORD [rax], 0
	add	DWORD -4[rbp], 1
.L10:
	cmp	DWORD -4[rbp], 99
	jle	.L11
	mov	DWORD -4[rbp], 0
	jmp	.L12
.L16:
	cmp	BYTE -5[rbp], 45
	jne	.L13
	mov	rax, QWORD -32[rbp]
	mov	DWORD [rax], -1
	sub	DWORD -4[rbp], 1
	jmp	.L14
.L13:
	movsx	ax, BYTE -5[rbp]
	lea	ecx, -48[rax]
	mov	eax, DWORD -4[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	mov	edx, ecx
	mov	WORD [rax], dx
.L14:
	add	DWORD -4[rbp], 1
.L12:
	call	getchar
	mov	BYTE -5[rbp], al
	cmp	BYTE -5[rbp], 32
	je	.L15
	cmp	BYTE -5[rbp], 10
	jne	.L16
.L15:
	mov	rax, QWORD -40[rbp]
	mov	edx, DWORD -4[rbp]
	mov	DWORD [rax], edx
	mov	rax, QWORD -40[rbp]
	mov	edx, DWORD [rax]
	mov	rax, QWORD -24[rbp]
	mov	esi, edx
	mov	rdi, rax
	call	reverse_array
	leave
	ret

first_input_is_bigger:
	push	rbp
	mov	rbp, rsp
	mov	QWORD -24[rbp], rdi
	mov	DWORD -28[rbp], esi
	mov	DWORD -32[rbp], edx
	mov	QWORD -40[rbp], rcx
	mov	DWORD -44[rbp], r8d
	mov	DWORD -48[rbp], r9d
	mov	rax, QWORD 32[rbp]
	mov	edx, DWORD -32[rbp]
	mov	DWORD [rax], edx
	mov	rax, QWORD 24[rbp]
	mov	edx, DWORD -28[rbp]
	mov	DWORD [rax], edx
	mov	rax, QWORD 56[rbp]
	mov	edx, DWORD -48[rbp]
	mov	DWORD [rax], edx
	mov	rax, QWORD 48[rbp]
	mov	edx, DWORD -44[rbp]
	mov	DWORD [rax], edx
	mov	DWORD -8[rbp], 0
	jmp	.L18
.L19:
	mov	eax, DWORD -8[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	mov	edx, DWORD -8[rbp]
	movsx	rdx, edx
	lea	rcx, [rdx+rdx]
	mov	rdx, QWORD 16[rbp]
	add	rdx, rcx
	movzx	eax, WORD [rax]
	mov	WORD [rdx], ax
	add	DWORD -8[rbp], 1
.L18:
	mov	eax, DWORD -8[rbp]
	cmp	eax, DWORD -32[rbp]
	jl	.L19
	mov	DWORD -4[rbp], 0
	jmp	.L20
.L21:
	mov	eax, DWORD -4[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -40[rbp]
	add	rax, rdx
	mov	edx, DWORD -4[rbp]
	movsx	rdx, edx
	lea	rcx, [rdx+rdx]
	mov	rdx, QWORD 40[rbp]
	add	rdx, rcx
	movzx	eax, WORD [rax]
	mov	WORD [rdx], ax
	add	DWORD -4[rbp], 1
.L20:
	mov	eax, DWORD -4[rbp]
	cmp	eax, DWORD -48[rbp]
	jl	.L21
	pop	rbp
	ret

set_small_and_big_number:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD -24[rbp], rdi
	mov	DWORD -28[rbp], esi
	mov	DWORD -32[rbp], edx
	mov	QWORD -40[rbp], rcx
	mov	DWORD -44[rbp], r8d
	mov	DWORD -48[rbp], r9d
	mov	eax, DWORD -32[rbp]
	cmp	eax, DWORD -48[rbp]
	jle	.L24
	mov	r8d, DWORD -48[rbp]
	mov	edi, DWORD -44[rbp]
	mov	rcx, QWORD -40[rbp]
	mov	edx, DWORD -32[rbp]
	mov	esi, DWORD -28[rbp]
	mov	rax, QWORD -24[rbp]
	push	QWORD 56[rbp]
	push	QWORD 48[rbp]
	push	QWORD 40[rbp]
	push	QWORD 32[rbp]
	push	QWORD 24[rbp]
	push	QWORD 16[rbp]
	mov	r9d, r8d
	mov	r8d, edi
	mov	rdi, rax
	call	first_input_is_bigger
	add	rsp, 48
	jmp	.L23
.L24:
	mov	eax, DWORD -48[rbp]
	cmp	eax, DWORD -32[rbp]
	jle	.L26
	mov	r8d, DWORD -32[rbp]
	mov	edi, DWORD -28[rbp]
	mov	rcx, QWORD -24[rbp]
	mov	edx, DWORD -48[rbp]
	mov	esi, DWORD -44[rbp]
	mov	rax, QWORD -40[rbp]
	push	QWORD 56[rbp]
	push	QWORD 48[rbp]
	push	QWORD 40[rbp]
	push	QWORD 32[rbp]
	push	QWORD 24[rbp]
	push	QWORD 16[rbp]
	mov	r9d, r8d
	mov	r8d, edi
	mov	rdi, rax
	call	first_input_is_bigger
	add	rsp, 48
	jmp	.L23
.L26:
	mov	DWORD -4[rbp], 0
	jmp	.L27
.L30:
	mov	eax, DWORD -32[rbp]
	sub	eax, DWORD -4[rbp]
	cdqe
	add	rax, rax
	lea	rdx, -2[rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	movzx	edx, WORD [rax]
	mov	eax, DWORD -32[rbp]
	sub	eax, DWORD -4[rbp]
	cdqe
	add	rax, rax
	lea	rcx, -2[rax]
	mov	rax, QWORD -40[rbp]
	add	rax, rcx
	movzx	eax, WORD [rax]
	cmp	dx, ax
	jle	.L28
	mov	r8d, DWORD -48[rbp]
	mov	edi, DWORD -44[rbp]
	mov	rcx, QWORD -40[rbp]
	mov	edx, DWORD -32[rbp]
	mov	esi, DWORD -28[rbp]
	mov	rax, QWORD -24[rbp]
	push	QWORD 56[rbp]
	push	QWORD 48[rbp]
	push	QWORD 40[rbp]
	push	QWORD 32[rbp]
	push	QWORD 24[rbp]
	push	QWORD 16[rbp]
	mov	r9d, r8d
	mov	r8d, edi
	mov	rdi, rax
	call	first_input_is_bigger
	add	rsp, 48
	jmp	.L23
.L28:
	mov	eax, DWORD -32[rbp]
	sub	eax, DWORD -4[rbp]
	cdqe
	add	rax, rax
	lea	rdx, -2[rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	movzx	edx, WORD [rax]
	mov	eax, DWORD -32[rbp]
	sub	eax, DWORD -4[rbp]
	cdqe
	add	rax, rax
	lea	rcx, -2[rax]
	mov	rax, QWORD -40[rbp]
	add	rax, rcx
	movzx	eax, WORD [rax]
	cmp	dx, ax
	jge	.L29
	mov	r8d, DWORD -32[rbp]
	mov	edi, DWORD -28[rbp]
	mov	rcx, QWORD -24[rbp]
	mov	edx, DWORD -48[rbp]
	mov	esi, DWORD -44[rbp]
	mov	rax, QWORD -40[rbp]
	push	QWORD 56[rbp]
	push	QWORD 48[rbp]
	push	QWORD 40[rbp]
	push	QWORD 32[rbp]
	push	QWORD 24[rbp]
	push	QWORD 16[rbp]
	mov	r9d, r8d
	mov	r8d, edi
	mov	rdi, rax
	call	first_input_is_bigger
	add	rsp, 48
	jmp	.L23
.L29:
	add	DWORD -4[rbp], 1
.L27:
	mov	eax, DWORD -4[rbp]
	cmp	eax, DWORD -32[rbp]
	jl	.L30
	mov	r8d, DWORD -32[rbp]
	mov	edi, DWORD -28[rbp]
	mov	rcx, QWORD -24[rbp]
	mov	edx, DWORD -48[rbp]
	mov	esi, DWORD -44[rbp]
	mov	rax, QWORD -40[rbp]
	push	QWORD 56[rbp]
	push	QWORD 48[rbp]
	push	QWORD 40[rbp]
	push	QWORD 32[rbp]
	push	QWORD 24[rbp]
	push	QWORD 16[rbp]
	mov	r9d, r8d
	mov	r8d, edi
	mov	rdi, rax
	call	first_input_is_bigger
	add	rsp, 48
.L23:
	leave
	ret

normalize_array:
	push	rbp
	mov	rbp, rsp
	mov	QWORD -24[rbp], rdi
	mov	QWORD -32[rbp], rsi
	mov	DWORD -8[rbp], 0
	jmp	.L32
.L34:
	mov	eax, DWORD -8[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]
	lea	ecx, 10[rax]
	mov	eax, DWORD -8[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	mov	edx, ecx
	mov	WORD [rax], dx
	mov	eax, DWORD -8[rbp]
	cdqe
	add	rax, 1
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]
	lea	ecx, -1[rax]
	mov	eax, DWORD -8[rbp]
	cdqe
	add	rax, 1
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	mov	edx, ecx
	mov	WORD [rax], dx
.L33:
	mov	eax, DWORD -8[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]
	test	ax, ax
	js	.L34
	jmp	.L35
.L37:
	mov	eax, DWORD -8[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]
	lea	ecx, -10[rax]
	mov	eax, DWORD -8[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	mov	edx, ecx
	mov	WORD [rax], dx
	mov	eax, DWORD -8[rbp]
	cdqe
	add	rax, 1
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]
	lea	ecx, 1[rax]
	mov	eax, DWORD -8[rbp]
	cdqe
	add	rax, 1
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	mov	edx, ecx
	mov	WORD [rax], dx
	mov	rax, QWORD -32[rbp]
	mov	eax, DWORD [rax]
	sub	eax, 1
	cmp	DWORD -8[rbp], eax
	jne	.L35
	mov	eax, DWORD -8[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]
	cmp	ax, 9
	jg	.L35
	mov	rax, QWORD -32[rbp]
	mov	eax, DWORD [rax]
	lea	edx, 1[rax]
	mov	rax, QWORD -32[rbp]
	mov	DWORD [rax], edx
.L35:
	mov	eax, DWORD -8[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]
	cmp	ax, 9
	jg	.L37
	add	DWORD -8[rbp], 1
.L32:
	mov	rax, QWORD -32[rbp]
	mov	eax, DWORD [rax]
	cmp	DWORD -8[rbp], eax
	jl	.L33
	mov	rax, QWORD -32[rbp]
	mov	eax, DWORD [rax]
	sub	eax, 1
	mov	DWORD -4[rbp], eax
	jmp	.L39
.L43:
	mov	eax, DWORD -4[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]
	test	ax, ax
	jne	.L45
	mov	rax, QWORD -32[rbp]
	mov	eax, DWORD [rax]
	lea	edx, -1[rax]
	mov	rax, QWORD -32[rbp]
	mov	DWORD [rax], edx
	sub	DWORD -4[rbp], 1
.L39:
	cmp	DWORD -4[rbp], 0
	jg	.L43
.L45:
	pop	rbp
	ret

subtract_first_element_from_second:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD -24[rbp], rdi
	mov	QWORD -32[rbp], rsi
	mov	QWORD -40[rbp], rdx
	mov	DWORD -44[rbp], ecx
	mov	DWORD -48[rbp], r8d
	mov	DWORD -4[rbp], 0
	jmp	.L47
.L48:
	mov	edx, DWORD -4[rbp]
	mov	eax, DWORD -48[rbp]
	add	eax, edx
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]
	mov	ecx, eax
	mov	eax, DWORD -4[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -40[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]
	sub	ecx, eax
	mov	edx, DWORD -4[rbp]
	mov	eax, DWORD -48[rbp]
	add	eax, edx
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	mov	edx, ecx
	mov	WORD [rax], dx
	add	DWORD -4[rbp], 1
.L47:
	mov	eax, DWORD -4[rbp]
	cmp	eax, DWORD -44[rbp]
	jl	.L48
	mov	rdx, QWORD -32[rbp]
	mov	rax, QWORD -24[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	normalize_array
	leave
	ret

add:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 736
	mov	QWORD -712[rbp], rdi
	mov	DWORD -716[rbp], esi
	mov	DWORD -720[rbp], edx
	mov	QWORD -728[rbp], rcx
	mov	DWORD -732[rbp], r8d
	mov	DWORD -736[rbp], r9d
	mov	rax, QWORD fs:40
	mov	QWORD -8[rbp], rax
	xor	eax, eax
	lea	rax, -688[rbp]
	mov	QWORD -664[rbp], rax
	lea	rax, -680[rbp]
	mov	QWORD -656[rbp], rax
	lea	rax, -684[rbp]
	mov	QWORD -648[rbp], rax
	lea	rax, -676[rbp]
	mov	QWORD -640[rbp], rax
	mov	r9d, DWORD -736[rbp]
	mov	r8d, DWORD -732[rbp]
	mov	rcx, QWORD -728[rbp]
	mov	edx, DWORD -720[rbp]
	mov	esi, DWORD -716[rbp]
	mov	rax, QWORD -712[rbp]
	push	QWORD -656[rbp]
	push	QWORD -640[rbp]
	lea	rdi, -208[rbp]
	push	rdi
	push	QWORD -664[rbp]
	push	QWORD -648[rbp]
	lea	rdi, -416[rbp]
	push	rdi
	mov	rdi, rax
	call	set_small_and_big_number
	add	rsp, 48
	mov	eax, DWORD -688[rbp]
	mov	DWORD -692[rbp], eax
	lea	rax, -692[rbp]
	mov	QWORD -632[rbp], rax
	mov	eax, DWORD -688[rbp]
	cdqe
	mov	WORD -624[rbp+rax*2], 0
	mov	eax, DWORD -716[rbp]
	cmp	eax, DWORD -732[rbp]
	jne	.L50
	mov	DWORD -672[rbp], 0
	jmp	.L51
.L52:
	mov	eax, DWORD -672[rbp]
	cdqe
	movzx	edx, WORD -416[rbp+rax*2]
	mov	eax, DWORD -672[rbp]
	cdqe
	mov	WORD -624[rbp+rax*2], dx
	add	DWORD -672[rbp], 1
.L51:
	mov	eax, DWORD -688[rbp]
	cmp	DWORD -672[rbp], eax
	jl	.L52
	mov	DWORD -668[rbp], 0
	jmp	.L53
.L54:
	mov	eax, DWORD -668[rbp]
	cdqe
	movzx	eax, WORD -624[rbp+rax*2]
	mov	edx, eax
	mov	eax, DWORD -668[rbp]
	cdqe
	movzx	eax, WORD -208[rbp+rax*2]
	add	eax, edx
	mov	edx, eax
	mov	eax, DWORD -668[rbp]
	cdqe
	mov	WORD -624[rbp+rax*2], dx
	add	DWORD -668[rbp], 1
.L53:
	mov	eax, DWORD -680[rbp]
	cmp	DWORD -668[rbp], eax
	jl	.L54
	mov	rdx, QWORD -632[rbp]
	lea	rax, -624[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	normalize_array
	mov	edx, DWORD -692[rbp]
	lea	rax, -624[rbp]
	mov	esi, edx
	mov	rdi, rax
	call	reverse_array
	mov	ecx, DWORD -692[rbp]
	mov	edx, DWORD -716[rbp]
	lea	rax, -624[rbp]
	mov	esi, ecx
	mov	rdi, rax
	call	print_array
	jmp	.L57
.L50:
	mov	ecx, DWORD -680[rbp]
	lea	rdx, -208[rbp]
	mov	rsi, QWORD -664[rbp]
	lea	rax, -416[rbp]
	mov	r8d, 0
	mov	rdi, rax
	call	subtract_first_element_from_second
	mov	edx, DWORD -688[rbp]
	lea	rax, -416[rbp]
	mov	esi, edx
	mov	rdi, rax
	call	reverse_array
	mov	edx, DWORD -684[rbp]
	mov	ecx, DWORD -688[rbp]
	lea	rax, -416[rbp]
	mov	esi, ecx
	mov	rdi, rax
	call	print_array
.L57:
	mov	rax, QWORD -8[rbp]
	sub	rax, QWORD fs:40
	je	.L56
.L56:
	leave
	ret

subtract:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD -8[rbp], rdi
	mov	DWORD -12[rbp], esi
	mov	DWORD -16[rbp], edx
	mov	QWORD -24[rbp], rcx
	mov	DWORD -28[rbp], r8d
	mov	DWORD -32[rbp], r9d
	mov	eax, DWORD -28[rbp]
	neg	eax
	mov	r8d, eax
	mov	edi, DWORD -32[rbp]
	mov	rcx, QWORD -24[rbp]
	mov	edx, DWORD -16[rbp]
	mov	esi, DWORD -12[rbp]
	mov	rax, QWORD -8[rbp]
	mov	r9d, edi
	mov	rdi, rax
	call	add
	leave
	ret

multiple:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 272
	mov	QWORD -248[rbp], rdi
	mov	DWORD -252[rbp], esi
	mov	DWORD -256[rbp], edx
	mov	QWORD -264[rbp], rcx
	mov	DWORD -268[rbp], r8d
	mov	DWORD -272[rbp], r9d
	mov	rax, QWORD fs:40
	mov	QWORD -8[rbp], rax
	xor	eax, eax
	mov	edx, DWORD -256[rbp]
	mov	eax, DWORD -272[rbp]
	add	eax, edx
	add	eax, 1
	mov	DWORD -232[rbp], eax
	lea	rax, -232[rbp]
	mov	QWORD -216[rbp], rax
	mov	DWORD -228[rbp], 0
	jmp	.L60
.L61:
	mov	eax, DWORD -228[rbp]
	cdqe
	mov	WORD -208[rbp+rax*2], 0
	add	DWORD -228[rbp], 1
.L60:
	cmp	DWORD -228[rbp], 99
	jle	.L61
	mov	DWORD -224[rbp], 0
	jmp	.L62
.L65:
	mov	DWORD -220[rbp], 0
	jmp	.L63
.L64:
	mov	edx, DWORD -224[rbp]
	mov	eax, DWORD -220[rbp]
	add	eax, edx
	cdqe
	movzx	eax, WORD -208[rbp+rax*2]
	mov	esi, eax
	mov	eax, DWORD -224[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -248[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]
	mov	ecx, eax
	mov	eax, DWORD -220[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -264[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]
	imul	eax, ecx
	lea	ecx, [rsi+rax]
	mov	edx, DWORD -224[rbp]
	mov	eax, DWORD -220[rbp]
	add	eax, edx
	mov	edx, ecx
	cdqe
	mov	WORD -208[rbp+rax*2], dx
	add	DWORD -220[rbp], 1
.L63:
	mov	eax, DWORD -220[rbp]
	cmp	eax, DWORD -272[rbp]
	jl	.L64
	add	DWORD -224[rbp], 1
.L62:
	mov	eax, DWORD -224[rbp]
	cmp	eax, DWORD -256[rbp]
	jl	.L65
	mov	rdx, QWORD -216[rbp]
	lea	rax, -208[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	normalize_array
	mov	edx, DWORD -232[rbp]
	lea	rax, -208[rbp]
	mov	esi, edx
	mov	rdi, rax
	call	reverse_array
	mov	eax, DWORD -252[rbp]
	imul	eax, DWORD -268[rbp]
	mov	edx, eax
	mov	ecx, DWORD -232[rbp]
	lea	rax, -208[rbp]
	mov	esi, ecx
	mov	rdi, rax
	call	print_array
	mov	rax, QWORD -8[rbp]
	sub	rax, QWORD fs:40
	je	.L66
.L66:
	leave
	ret

divide:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 272
	mov	QWORD -248[rbp], rdi
	mov	DWORD -252[rbp], esi
	mov	DWORD -256[rbp], edx
	mov	QWORD -264[rbp], rcx
	mov	DWORD -268[rbp], r8d
	mov	DWORD -272[rbp], r9d
	mov	rax, QWORD fs:40
	mov	QWORD -8[rbp], rax
	xor	eax, eax
	mov	DWORD -236[rbp], 0
	jmp	.L68
.L69:
	mov	eax, DWORD -236[rbp]
	cdqe
	mov	WORD -208[rbp+rax*2], 0
	add	DWORD -236[rbp], 1
.L68:
	cmp	DWORD -236[rbp], 99
	jle	.L69
	lea	rax, -256[rbp]
	mov	QWORD -224[rbp], rax
	jmp	.L70
.L71:
	mov	eax, DWORD -256[rbp]
	sub	eax, DWORD -272[rbp]
	sub	eax, 1
	cdqe
	movzx	eax, WORD -208[rbp+rax*2]
	lea	edx, 1[rax]
	mov	eax, DWORD -256[rbp]
	sub	eax, DWORD -272[rbp]
	sub	eax, 1
	cdqe
	mov	WORD -208[rbp+rax*2], dx
	mov	eax, DWORD -256[rbp]
	sub	eax, DWORD -272[rbp]
	lea	edi, -1[rax]
	mov	ecx, DWORD -272[rbp]
	mov	rdx, QWORD -264[rbp]
	mov	rsi, QWORD -224[rbp]
	mov	rax, QWORD -248[rbp]
	mov	r8d, edi
	mov	rdi, rax
	call	subtract_first_element_from_second
.L70:
	mov	eax, DWORD -256[rbp]
	cmp	DWORD -272[rbp], eax
	jl	.L71
	jmp	.L72
.L73:
	mov	eax, DWORD -256[rbp]
	sub	eax, DWORD -272[rbp]
	cdqe
	movzx	eax, WORD -208[rbp+rax*2]
	lea	edx, 1[rax]
	mov	eax, DWORD -256[rbp]
	sub	eax, DWORD -272[rbp]
	cdqe
	mov	WORD -208[rbp+rax*2], dx
	mov	ecx, DWORD -272[rbp]
	mov	rdx, QWORD -264[rbp]
	mov	rsi, QWORD -224[rbp]
	mov	rax, QWORD -248[rbp]
	mov	r8d, 0
	mov	rdi, rax
	call	subtract_first_element_from_second
.L72:
	mov	eax, DWORD -272[rbp]
	cdqe
	add	rax, rax
	lea	rdx, -2[rax]
	mov	rax, QWORD -248[rbp]
	add	rax, rdx
	movzx	edx, WORD [rax]
	mov	eax, DWORD -272[rbp]
	cdqe
	add	rax, rax
	lea	rcx, -2[rax]
	mov	rax, QWORD -264[rbp]
	add	rax, rcx
	movzx	eax, WORD [rax]
	cmp	dx, ax
	jg	.L73
	movzx	eax, WORD -208[rbp]
	add	eax, 1
	mov	WORD -208[rbp], ax
	mov	eax, DWORD -272[rbp]
	sub	eax, 1
	mov	DWORD -232[rbp], eax
	jmp	.L74
.L78:
	mov	eax, DWORD -232[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -264[rbp]
	add	rax, rdx
	movzx	edx, WORD [rax]
	mov	eax, DWORD -232[rbp]
	cdqe
	lea	rcx, [rax+rax]
	mov	rax, QWORD -248[rbp]
	add	rax, rcx
	movzx	eax, WORD [rax]
	cmp	dx, ax
	jle	.L75
	movzx	eax, WORD -208[rbp]
	sub	eax, 1
	mov	WORD -208[rbp], ax
	jmp	.L76
.L75:
	mov	eax, DWORD -232[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -248[rbp]
	add	rax, rdx
	movzx	edx, WORD [rax]
	mov	eax, DWORD -232[rbp]
	cdqe
	lea	rcx, [rax+rax]
	mov	rax, QWORD -264[rbp]
	add	rax, rcx
	movzx	eax, WORD [rax]
	cmp	dx, ax
	jg	.L76
	sub	DWORD -232[rbp], 1
.L74:
	cmp	DWORD -232[rbp], 0
	jns	.L78
.L76:
	mov	DWORD -228[rbp], 100
	jmp	.L79
.L82:
	mov	eax, DWORD -228[rbp]
	cdqe
	movzx	eax, WORD -208[rbp+rax*2]
	test	ax, ax
	jg	.L81
	sub	DWORD -228[rbp], 1
.L79:
	cmp	DWORD -228[rbp], 0
	jg	.L82
.L81:
	mov	eax, DWORD -228[rbp]
	add	eax, 1
	mov	DWORD -240[rbp], eax
	lea	rax, -240[rbp]
	mov	QWORD -216[rbp], rax
	mov	rdx, QWORD -216[rbp]
	lea	rax, -208[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	normalize_array
	mov	edx, DWORD -240[rbp]
	lea	rax, -208[rbp]
	mov	esi, edx
	mov	rdi, rax
	call	reverse_array
	mov	eax, DWORD -252[rbp]
	imul	eax, DWORD -268[rbp]
	mov	edx, eax
	mov	ecx, DWORD -240[rbp]
	lea	rax, -208[rbp]
	mov	esi, ecx
	mov	rdi, rax
	call	print_array
	mov	rax, QWORD -8[rbp]
	sub	rax, QWORD fs:40
	leave
	ret

