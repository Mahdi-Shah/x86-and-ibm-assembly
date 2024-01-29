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
	sub	rsp, 184							; set registers
	mov	rax, rsp
	mov	QWORD -184[rbp], rax				; save rsp on -184[rbp]
	lea	rax, -148[rbp]						; -148[rbp] = n = number of rows
	mov	rsi, rax							; rsi = address(n)
	lea	rax, read_int_format
	mov	rdi, rax							; rdi = address(read_int_format)
	mov	eax, 0								; why it is zero
	call	scanf							; set n
	mov	eax, DWORD -148[rbp]
	lea	ecx, 1[rax]							; ecx = n + 1
	mov	esi, DWORD -148[rbp]				; esi = n
	movsxd	rax, ecx
	lea	rbx, [rax]							; rbx = n + 1
	movsxd	rax, esi
	mul	ecx									; rax = n * (n + 1)
	lea	rdx, [rax*4]						; rdx = 4 * n * (n + 1)
	mov	rax, 4095
	add	rax, rdx							; rax = 4095 + 4 * n * (n + 1)
	sar rax, 12
	sal rax, 12								; rax = ceil(4 * n * (n + 1) / 4096) * 4096
	mov	rcx, rax
	mov	rdx, rsp
	sub	rdx, rcx							; rdx = rsp - rsx
.loop_for_set_rsp:
	cmp	rsp, rdx
	je	.set_matrix_begin_point
	sub	rsp, 4096							; subtract rsp to have enough space for save matrix
	jmp	.loop_for_set_rsp
.set_matrix_begin_point:
	mov	QWORD -80[rbp], rsp					; -80[rbp] = address(matrix[0][0])
	mov	DWORD -144[rbp], 0					; -144[rbp] = outer loop temp number = i
	jmp	.check_outer_loop1_condition
.outer_loop1_body:
	mov	DWORD -140[rbp], 0					; -140[rbp] = inner loop temp number = j
											; in the loop in down initialize matrix[i][j]
	jmp	.check_inner_loop1_condition
.inner_loop1_body:
	mov	rcx, rbx
	mov	eax, DWORD -140[rbp]
	movsxd	rdx, eax						; rdx = j
	mov	eax, DWORD -144[rbp]
	cdqe
	imul	rax, rcx						; rax = i * (n + 1)
	add	rax, rdx							; rax = i * (n + 1) + j
	lea	rdx, [rax*4]						; rdx = (i * (n + 1) + j) * 4
	mov	rax, QWORD -80[rbp]
	add	rax, rdx							; rax = matrix[i][j]
	mov	rsi, rax
	lea	rdi, read_float_format
	mov	eax, 0
	call	scanf
	add	DWORD -140[rbp], 1					; j++
.check_inner_loop1_condition:
	mov	eax, DWORD -148[rbp]
	cmp	DWORD -140[rbp], eax				; compare i and n
	jle	.inner_loop1_body
	add	DWORD -144[rbp], 1					; i++
.check_outer_loop1_condition:
	mov	eax, DWORD -148[rbp]
	cmp	DWORD -144[rbp], eax				; compare i and n
	jl	.outer_loop1_body
											; in the loop in the down run RREF orders
	mov	DWORD -136[rbp], 0					; -136[rbp] = outer loop temp number = i
	jmp	.check_outer_loop2_condition
.outer_loop2_body:
	mov	DWORD -132[rbp], 0					; -132[rbp] = inner loop temp number = j
	jmp	.check_inner_loop2_condition
.inner_loop2_body:
	mov	rsi, rbx							; rsi = n + 1
	mov	rax, QWORD -80[rbp]					; rax = address(matrix[0][0])
	movsxd	rcx, DWORD -132[rbp]			; rcx = j
	movsxd	rdx, DWORD -136[rbp]			; rdx = i
	imul	rdx, rsi
	add	rdx, rcx
	movss	xmm0, DWORD [rax+rdx*4]			; xmm0 = matrix[i][j]
	pxor	xmm1, xmm1						; xmm1 = 0.0
	ucomiss	xmm0, xmm1						; compare xmm0 and xmm1 = 0
	je	.continue_inner_loop2
.matrix_i_j_ne_0:							; matrix[i][j] != 0
	cvtss2sd	xmm0, xmm0					; xmm0 = double(xmm0)
	movsd	QWORD -72[rbp], xmm0			; -72[rbp] = double(matrix[i][j])
	mov	DWORD -128[rbp], 0					; -128[rbp] = loop3 temp number = k
	jmp	.check_loop3_condition
.loop3_body:
	mov	rsi, rbx
	mov	rax, QWORD -80[rbp]
	mov	edx, DWORD -128[rbp]
	movsxd	rcx, edx
	mov	edx, DWORD -136[rbp]
	movsxd	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movss	xmm0, DWORD [rax+rdx*4]			; xmm0 = matrix[i][k]
	cvtss2sd	xmm0, xmm0
	divsd	xmm0, QWORD -72[rbp]			; xmm0 /= matrix[i][j]
	cvtsd2ss	xmm0, xmm0
	movss	DWORD [rax+rdx*4], xmm0			; matrix[i][k] /= matrix[i][j]
	add	DWORD -128[rbp], 1					; k++
.check_loop3_condition:
	mov	eax, DWORD -148[rbp]
	cmp	DWORD -128[rbp], eax				; compare k and n
	jle	.loop3_body
	mov	DWORD -124[rbp], 0					; now loop 3 end and matrix[i] /= matrix[i][j], 
											; -124[rbp] = loop4 temp number = k
	jmp	.check_loop4_condition
.loop4_body:
	mov	eax, DWORD -124[rbp]
	cmp	eax, DWORD -136[rbp]				; compare k and i
	je	.continue_loop4
	mov	rsi, rbx
	mov	rax, QWORD -80[rbp]
	mov	edx, DWORD -132[rbp]
	movsxd	rcx, edx
	mov	edx, DWORD -124[rbp]
	movsxd	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movss	xmm0, DWORD [rax+rdx*4]			; xmm0 = matrix[k][j]
	cvtss2sd	xmm0, xmm0					
	movsd	QWORD -64[rbp], xmm0			; -64[rbp] = double(matrix[k][j])
	mov	DWORD -120[rbp], 0					; -120[rbp] = loop5 temp number = s
	jmp	.check_loop5_condition
.loop5_body:
	mov	rsi, rbx
	mov	rax, QWORD -80[rbp]
	mov	edx, DWORD -120[rbp]
	movsxd	rcx, edx
	mov	edx, DWORD -124[rbp]
	movsxd	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movss	xmm0, DWORD [rax+rdx*4]			; xmm0 = matrix[k][s]
	cvtss2sd	xmm0, xmm0
	mov	rsi, rbx
	mov	rax, QWORD -80[rbp]
	mov	edx, DWORD -120[rbp]
	movsxd	rcx, edx
	mov	edx, DWORD -136[rbp]
	movsxd	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movss	xmm1, DWORD [rax+rdx*4]			; xmm1 = matrix[i][s]
	cvtss2sd	xmm1, xmm1
	mulsd	xmm1, QWORD -64[rbp]			; xmm1 = double(matrix[k][j]) * double(matrix[i][s])
	subsd	xmm0, xmm1						; xmm0 -= xmm1
	mov	rsi, rbx
	cvtsd2ss	xmm0, xmm0
	mov	rax, QWORD -80[rbp]
	mov	edx, DWORD -120[rbp]
	movsxd	rcx, edx
	mov	edx, DWORD -124[rbp]
	movsxd	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movss	DWORD [rax+rdx*4], xmm0			; matrix[k][s] = xmm0
	add	DWORD -120[rbp], 1					; s++
.check_loop5_condition:
	mov	eax, DWORD -148[rbp]
	cmp	DWORD -120[rbp], eax				; compare s and n
	jle	.loop5_body
.continue_loop4:
	add	DWORD -124[rbp], 1					; k++
.check_loop4_condition:
	mov	eax, DWORD -148[rbp]
	cmp	DWORD -124[rbp], eax				; compare k and n
	jl	.loop4_body
	jmp	.outer_loop2_continue
.continue_inner_loop2:
	add	DWORD -132[rbp], 1					; j++
.check_inner_loop2_condition:
	mov	eax, DWORD -148[rbp]
	cmp	DWORD -132[rbp], eax
	jl	.inner_loop2_body
.outer_loop2_continue:
	add	DWORD -136[rbp], 1					; i++
.check_outer_loop2_condition:
	mov	eax, DWORD -148[rbp]
	cmp	DWORD -136[rbp], eax				; compare i and n
	jl	.outer_loop2_body
	mov	DWORD -116[rbp], 0					; -116[rbp] = outer loop6 temp number = i
	jmp	.check_outer_loop6_condition
.outer_loop6_body:
	mov	DWORD -112[rbp], 1					; -112[rbp] = flag for check Impossiblity. if flag = 1 -> matrix is Impossible
	mov	DWORD -108[rbp], 0					; -108[rbp] = inner loop6 temp number = j
	jmp	.check_inner_loop6_condition
.inner_loop6_body:
	mov	rsi, rbx
	mov	rax, QWORD -80[rbp]
	mov	edx, DWORD -108[rbp]
	movsxd	rcx, edx
	mov	edx, DWORD -116[rbp]
	movsxd	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movss	xmm0, DWORD [rax+rdx*4]			; xmm0 = matrix[i][j]
	pxor	xmm1, xmm1						; xmm1 = 0
	ucomiss	xmm0, xmm1						; compare xmm0 and xmm1
	je	.inner_loop6_continue
	jmp	.make_flag_0
	
.make_flag_0:
	mov	DWORD -112[rbp], 0					; flag = 0
	jmp	.break_inner_loop6
.inner_loop6_continue:
	add	DWORD -108[rbp], 1
.check_inner_loop6_condition:
	mov	eax, DWORD -148[rbp]
	cmp	DWORD -108[rbp], eax				; compare j and n
	jl	.inner_loop6_body
.break_inner_loop6:
	cmp	DWORD -112[rbp], 0					; compare flag and 0
	je	.outer_loop6_continue				; if flag != 0 -> matrix is Impossible
	lea	rax, print_Impossible
	mov	rdi, rax
	call	puts							; print 'Impossible'
	jmp	.func_end
.outer_loop6_continue:
	add	DWORD -116[rbp], 1					; i++
.check_outer_loop6_condition:
	mov	eax, DWORD -148[rbp]
	cmp	DWORD -116[rbp], eax				; compare i and n
	jl	.outer_loop6_body
											; now matrix isnt Impossible and values will print
	mov	DWORD -104[rbp], 0					; outer loop7 temp number = i
	jmp	.check_outer_loop7_condition
.outer_loop7_body:
	mov	DWORD -100[rbp], 0					; -100[rbp] = inner loop7 temp number
	jmp	.check_inner_loop7_condition
.inner_loop7_body:
	mov	rsi, rbx
	mov	rax, QWORD -80[rbp]
	mov	edx, DWORD -104[rbp]
	movsxd	rcx, edx
	mov	edx, DWORD -100[rbp]
	movsxd	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movss	xmm0, DWORD [rax+rdx*4]			; xmm0 = matrix[j][i]
	pxor	xmm1, xmm1						; xmm1 = 0
	ucomiss	xmm0, xmm1						; compare xmm0 and xmm1
	je	.inner_loop7_continue
											; now matrix[j][i] != 0 -> x_i = matrix[j][n]
	mov	rsi, rbx
	mov	edx, DWORD -148[rbp]
	mov	rax, QWORD -80[rbp]
	movsxd	rcx, edx
	mov	edx, DWORD -100[rbp]
	movsxd	rdx, edx
	imul	rdx, rsi
	add	rdx, rcx
	movss	xmm0, DWORD [rax+rdx*4]			; xmm0 = matrix[j][n]
	cvtss2sd	xmm0, xmm0
	lea	rax, print_float_format
	mov	rdi, rax
	mov	eax, 1
	call	printf							; print matrix[j][n]
	jmp	.outer_loop7_continue
.inner_loop7_continue:
	add	DWORD -100[rbp], 1					; j++
.check_inner_loop7_condition:
	mov	eax, DWORD -148[rbp]
	cmp	DWORD -100[rbp], eax				; compare j and n
	jl	.inner_loop7_body
.outer_loop7_continue:
	add	DWORD -104[rbp], 1					; i++
.check_outer_loop7_condition:
	mov	eax, DWORD -148[rbp]
	cmp	DWORD -104[rbp], eax				; compare i and n
	jl	.outer_loop7_body
.func_end:
	mov	rsp, QWORD -184[rbp]
	lea	rsp, -40[rbp]
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	ret
