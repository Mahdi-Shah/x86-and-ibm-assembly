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
.check_loop_condition:
	call	getchar					; get character and send it on rax
	mov	BYTE -465[rbp], al			; save character on -465[rbp]; operand = -465[rbp]
	cmp	BYTE -465[rbp], 113			; compare operand with 'q'
	jne	.loop_body
	leave
	ret
.loop_body:
	mov	DWORD -464[rbp], 1			; -464[rbp] = first number sign = 1
	mov	DWORD -456[rbp], 1			; -456[rbp] = second number sign  = 1
	lea	rax, -464[rbp]				; rax = address(-464[rbp]) = address(first number sign)
	mov	QWORD -448[rbp], rax		; -448[rbp] = rax =  address(first number sign)
	lea	rax, -460[rbp]				; rax = address(-460[rbp]) = address(first number lentgh)
	mov	QWORD -440[rbp], rax		; -440[rbp] = rax =  address(first number lentgh)
	lea	rax, -456[rbp]				; rax = address(-456[rbp]) = address(second number sign)
	mov	QWORD -432[rbp], rax		; -432[rbp] = rax =  address(second number sign)
	lea	rax, -452[rbp]				; rax = address(-452[rbp]) = address(second number lentgh)
	mov	QWORD -424[rbp], rax		; -424[rbp] = rax =  address(second number lentgh)
	call	getchar					; get blank line bitween operand and numbers
	mov	rdx, QWORD -440[rbp]		; 3rd parameter of get_number = address(first number lentgh)				
	mov	rsi, QWORD -448[rbp]		; 2nd parameter of get_number = address(first number sign)
	lea	rdi, -416[rbp]				; 1st parameter of get_number = address(first number array[0]) = -416[rbp]
	call	get_number				; initialize first number; first number[i] = [-416[rbp] + 2 * i]
	mov	rdx, QWORD -424[rbp]		; 3rd parameter of get_number = address(second number lentgh)
	mov	rsi, QWORD -432[rbp]		; 2nd parameter of get_number = address(second number sign)
	lea	rdi, -208[rbp]				; 1st parameter of get_number = address(second number array[0]) = -208[rbp]
	call	get_number				; initialize first number; first number[i] = [-208[rbp] + 2 * i]
	mov	r9, QWORD -452[rbp]			; 6th parameter of function = second number lentgh
	mov	r8, QWORD -456[rbp]			; 5th parameter of function = second number sign
	lea	rcx, -208[rbp]				; 4th parameter of function = address(second number array[0])
	mov	rdx, QWORD -460[rbp]		; 3rd parameter of function = first number lentgh
	mov	rsi, QWORD -464[rbp]		; 2nd parameter of function = first number sign
	lea	rdi, -416[rbp]				; 1st parameter of function = address(first number array[0])
	cmp	BYTE -465[rbp], 43			; compare -465[rbp] = operand with '+'
	jne	.continue_loop_body1						
.add_numbers:
	call	add						; add numbers and print result
	jmp	.check_loop_condition		; continue loop
.continue_loop_body1:
	cmp	BYTE -465[rbp], 45			; compare -465[rbp] = operand with '-'
	jne	.continue_loop_body2		; continue loop body
	call	subtract				; subtract numbers and print result
	jmp	.check_loop_condition		; continue loop
.continue_loop_body2:
	cmp	BYTE -465[rbp], 120			; compare -465[rbp] = operand with 'x'
	jne	.continue_loop_body3		; continue loop body
.mutiple_numbers:
	call	multiple				; multiple numbers and print result
	jmp	.check_loop_condition		; continue loop
.continue_loop_body3:
	cmp	BYTE -465[rbp], 47			; compare -465[rbp] = operand with '/'
	jne	.check_loop_condition		; character was'nt equal to any operand. back to loop condition
.divide_numbers:
	call	divide					; divide numbers and print result
	jmp	.check_loop_condition		; continue loop


add:
									; print add of two number
	push	rbp						;
	mov	rbp, rsp					;
	sub	rsp, 736					; set rbp and rsp
	lea	rax, -688[rbp]				; -688[rbp] = bigger number lentgh
	mov	QWORD -664[rbp], rax		; -664[rbp] = address(bigger number lentgh)
	lea	rax, -680[rbp]				; -680[rbp] = smaller number lentgh
	mov	QWORD -656[rbp], rax		; -656[rbp] = address(smaller number lentgh)
	lea	rax, -684[rbp]				; -684[rbp] = bigger number sign
	mov	QWORD -648[rbp], rax		; -648[rbp] = address(bigger number sign)
	lea	rax, -676[rbp]				; -676[rbp] = smaller number sign
	mov	QWORD -640[rbp], rax		; -640[rbp] = address(smaller number sign)
	push	QWORD -656[rbp]			; 12th parameter of set_small_and_big_number = address(smaller number lentgh)
	push	QWORD -640[rbp]			; 11th parameter of set_small_and_big_number = address(smaller number sign)
	lea	rax, -208[rbp]				; rax = -208[rbp] = smaller number[0]
	push	rax						; 10th parameter of set_small_and_big_number = rax = address(smaller number[0])
	push	QWORD -664[rbp]			; 9th parameter of set_small_and_big_number = address(bigger number lentgh)
	push	QWORD -648[rbp]			; 8th parameter of set_small_and_big_number = address(bigger number sign)
	lea	rax, -416[rbp]				; rax = -416[rbp] = bigger number[0]	
	push	rax						; 7th parameter of set_small_and_big_number = rax = address(bigger number[0])
									; first six parameter of set_small_and_big_number is equal to add function so don't change them
	call	set_small_and_big_number; bigger number = max(first number, second number), smaller number = min(first number, second number), ...
	add	rsp, 48						; in place of pushes for set_small_and_big_number
	mov	eax, DWORD -684[rbp]		; eax = bigger number sign
	cmp	eax, DWORD -676[rbp]		; compare signs of numbers equal or not, -676[rbp] = smaller number sign
	jne	.signs_are_differnt
.signa_are_same:
	mov	DWORD -668[rbp], 0			; -668[rbp] is temp value of loop
	jmp	.check_loop_condition2
.loop_body2:
	mov	eax, DWORD -668[rbp]
	cdqe
	movzx	eax, WORD -416[rbp+rax*2]
	mov	edx, eax					; edx = bigger number[i]
	mov	eax, DWORD -668[rbp]
	cdqe
	movzx	eax, WORD -208[rbp+rax*2]	; eax = smaller number[i]
	add	eax, edx
	mov	edx, eax
	mov	eax, DWORD -668[rbp]
	cdqe
	mov	WORD -416[rbp+rax*2], dx	; bigger number[i] = smaller number[i] + bigger number[i]
	add	DWORD -668[rbp], 1
.check_loop_condition2:
	mov	eax, DWORD -680[rbp]
	cmp	DWORD -668[rbp], eax		; compare temp value of loop and smaller number lentgh
	jl	.loop_body2	
.normalizing_number:
	mov	rsi, QWORD -664[rbp]		; 2nd parameter of normalize array = address(bigger number lentgh)
	lea	rdi, -416[rbp]				; 1st parameter of normalize array = address(bigger number[0])
	call	normalize_array
.reverse:
	mov	esi, DWORD -688[rbp]		; 2nd parameter of raverse array = bigger number lentgh
	lea	rdi, -416[rbp]				; 1st parameter of reverse array = address(bigger number[0])
	call	reverse_array
.print:
	mov	edx, DWORD -684[rbp]		; 3rd parameter of print array = bigger number sign
	mov	esi, DWORD -688[rbp]		; 2nd parameter of print array = bigger number lentgh
	lea	rdi, -416[rbp]				; 1st parameter of print array = address(bigger number[0])
	call	print_array
	jmp	.add_end
.signs_are_differnt:
	mov	r8d, 0						; 5th parameter of subtract_first_element_from_second = 0
	mov	ecx, DWORD -680[rbp]		; 4th parameter of subtract_first_element_from_second = smaller number lentgh
	lea	rdx, -208[rbp]				; 3rd parameter of subtract_first_element_from_second = address(smaller number[0])
	mov	rsi, QWORD -664[rbp]		; 2nd parameter of subtract_first_element_from_second = address(bigger number lentgh)
	lea	rdi, -416[rbp]				; 1st parameter of subtract_first_element_from_second = address(bigger number[0])
	call	subtract_first_element_from_second
	mov	esi, DWORD -688[rbp]		; 2nd parameter of raverse array = bigger number lentgh
	lea	rdi, -416[rbp]				; 1st parameter of reverse array = address(bigger number[0])
	call	reverse_array
	mov	edx, DWORD -684[rbp]		; 3rd parameter of print array = bigger number sign
	mov	esi, DWORD -688[rbp]		; 2nd parameter of print array = bigger number lentgh
	lea	rdi, -416[rbp]				; 1st parameter of print array = address(bigger number[0])
	call	print_array
.add_end:
	leave
	ret

subtract:
	push	rbp						;
	mov	rbp, rsp					; 
	sub	rsp, 8						; set rsp and rbp
	neg	r8d							; negate second number sign
	call	add						; add a + (-b) and print
	leave
	ret

multiple:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 272
	mov	QWORD -248[rbp], rdi		; 1st parameter of function = -248[rbp] = address(first number array[0])
	mov	DWORD -252[rbp], esi		; 2nd parameter of function = -252[rbp] = first number sign
	mov	DWORD -256[rbp], edx		; 3rd parameter of function = -256[rbp] = first number lentgh
	mov	QWORD -264[rbp], rcx		; 4th parameter of function = -264[rbp] = address(second number array[0])
	mov	DWORD -268[rbp], r8d		; 5th parameter of function = -268[rbp] = second number sign
	mov	DWORD -272[rbp], r9d		; 6th parameter of function = -272[rbp] = second number lentgh
	mov	eax, DWORD -272[rbp]
	add	eax, edx
	add	eax, 1
	mov	DWORD -232[rbp], eax		; -232[rbp] = output lentgh = first number lentgh + second number lentgh
	lea	rax, -232[rbp]
	mov	QWORD -216[rbp], rax		; -216[rbp] = address(output lentgh)
	mov	DWORD -228[rbp], 0			; -228[rbp] = loop temp number = i
	jmp	.check_loop_condition3
.loop_body3:						; -208[rbp] = address(output number[0])
	mov	eax, DWORD -228[rbp]		; 
	cdqe
	mov	WORD -208[rbp+rax*2], 0		; output number[i] = 0
	add	DWORD -228[rbp], 1			; i++
.check_loop_condition3:
	cmp	DWORD -228[rbp], 99			; compare i , 99
	jle	.loop_body3
.next_loop:							; this loop has inner loop
	mov	DWORD -224[rbp], 0			; -224[rbp] = outer loop temp number = i
	jmp	.check_outer_loop_condition
.inner_loop:						; this loop is in the above loop
	mov	DWORD -220[rbp], 0			; -220[rbp] = inner loop temp number = j
	jmp	.check_inner_loop_condition
.inner_loop_body:
	mov	edx, DWORD -224[rbp]
	mov	eax, DWORD -220[rbp]
	add	eax, edx
	cdqe
	movzx eax, WORD -208[rbp + rax * 2]	; eax = output[i + j]
	mov	esi, eax					; esi = output[i + j]
	mov	eax, DWORD -224[rbp]
	cdqe
	lea	rdx, [rax + rax]
	mov	rax, QWORD -248[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]			; eax = first number[i]
	mov	ecx, eax					; ecx = first number[i]
	mov	eax, DWORD -220[rbp]
	cdqe
	lea	rdx, [rax + rax]
	mov	rax, QWORD -264[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]			; eax = second number[i]
	imul	eax, ecx				; rax = first number[i] * second number[i]
	lea	ecx, [rsi + rax]
	mov	edx, DWORD -224[rbp]
	mov	eax, DWORD -220[rbp]
	add	eax, edx
	mov	edx, ecx
	cdqe
	mov	WORD -208[rbp+rax*2], dx	; output number[i + j] = first number[i] * second number[i]
	add	DWORD -220[rbp], 1			; j++
.check_inner_loop_condition:
	mov	eax, DWORD -220[rbp]
	cmp	eax, DWORD -272[rbp]		; compare j , second number lentgh
	jl	.inner_loop_body
	add	DWORD -224[rbp], 1			; i++
.check_outer_loop_condition:
	mov	eax, DWORD -224[rbp]
	cmp	eax, DWORD -256[rbp]		; compare i , first number lentgh
	jl	.inner_loop
	mov	rsi, QWORD -216[rbp]		; 2nd parameter of normalize array = address(output number lentgh)
	lea	rdi, -208[rbp]				; 1st parameter of normalize array = address(output number[0])
	call	normalize_array
	mov	esi, DWORD -232[rbp]		; 2nd parameter of raverse array = address(output number lentgh)
	lea	rdi, -208[rbp]				; 1st parameter of reverse array = address(output number[0])
	call	reverse_array
	mov	eax, DWORD -252[rbp]
	imul	eax, DWORD -268[rbp]	; eax = first number sign * second number sign
	mov	edx, eax					; 3rd parameter of print array = output number sign = first number sign * second number sign
	mov	esi, DWORD -232[rbp]		; 2nd parameter of print array = output number lentgh
	lea	rdi, -208[rbp]				; 1st parameter of print array = address(output number[0])
	call	print_array
	leave
	ret

divide:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 276					; set rsp and rbp
	mov	QWORD -248[rbp], rdi		; 1st parameter of function = -248[rbp] = address(first number array[0])
	mov	DWORD -252[rbp], esi		; 2nd parameter of function = -252[rbp] = first number sign
	mov	DWORD -256[rbp], edx		; 3rd parameter of function = -256[rbp] = first number lentgh
	mov	QWORD -264[rbp], rcx		; 4th parameter of function = -264[rbp] = address(second number array[0])
	mov	DWORD -268[rbp], r8d		; 5th parameter of function = -268[rbp] = second number sign
	mov	DWORD -272[rbp], r9d		; 6th parameter of function = -272[rbp] = second number lentgh
	mov DWORD -276[rbp], edx		; copy of first number lentgh
	mov	DWORD -236[rbp], 0			; loop temp number = i
	jmp	.check_loop_condition4
.loop_body4:
	mov	eax, DWORD -236[rbp]
	cdqe
	mov	WORD -208[rbp+rax*2], 0		; output number[i] = 0
	add	DWORD -236[rbp], 1			; i++
.check_loop_condition4:
	cmp	DWORD -236[rbp], 99
	jle	.loop_body4
	lea	rax, -256[rbp]
	mov	QWORD -224[rbp], rax		; -224[rbp] = address(first number lentgh)
	jmp	.check_loop_condition5
.loop_body5:
	mov	eax, DWORD -256[rbp]
	sub	eax, DWORD -272[rbp]
	sub	eax, 1
	cdqe
	movzx	eax, WORD -208[rbp + rax * 2]	; eax = output number[first number lentgh - second number lentgh - 1]
	lea	edx, 1[rax]					; edx = rax + 1
	mov	eax, DWORD -256[rbp]
	sub	eax, DWORD -272[rbp]
	sub	eax, 1
	cdqe
	mov	WORD -208[rbp + rax * 2], dx	; output number[first number lentgh - second number lentgh - 1] += 1
	mov	eax, DWORD -256[rbp]
	sub	eax, DWORD -272[rbp]
	lea	r8d, -1[rax]				; 5th parameter of subtract_first_element_from_second = first number lentgh - second number lentgh - 1
	mov	ecx, DWORD -272[rbp]		; 4th parameter of subtract_first_element_from_second = second number lentgh
	mov	rdx, QWORD -264[rbp]		; 3rd parameter of subtract_first_element_from_second = address(second number[0])
	mov	rsi, QWORD -224[rbp]		; 2nd parameter of subtract_first_element_from_second = address(first number lentgh)
	mov	rdi, QWORD -248[rbp]		; 1st parameter of subtract_first_element_from_second = address(first number[0])
	call	subtract_first_element_from_second
.check_loop_condition5:
	mov	eax, DWORD -256[rbp]
	cmp	DWORD -272[rbp], eax		; compare second number lentgh with first number lentgh
	jl	.loop_body5
	jmp	.check_loop_condition6		; now second number lentgh with first number lentgh
.loop_body6:
	movzx	eax, WORD -208[rbp]		; eax = output number[0]
	cdqe
	lea	edx, 1[rax]					; edx = output number[0] + 1
	cdqe
	mov	WORD -208[rbp], dx			; output number[0] += 1
	mov	r8d, 0						; 5th parameter of subtract_first_element_from_second = 0
	mov	ecx, DWORD -272[rbp]		; 4th parameter of subtract_first_element_from_second = second number lentgh
	mov	rdx, QWORD -264[rbp]		; 3rd parameter of subtract_first_element_from_second = address(second number[0])
	mov	rsi, QWORD -224[rbp]		; 2nd parameter of subtract_first_element_from_second = address(first number lentgh)
	mov	rdi, QWORD -248[rbp]		; 1st parameter of subtract_first_element_from_second = address(first number[0])
	call	subtract_first_element_from_second
.check_loop_condition6:
	mov	eax, DWORD -272[rbp]
	cdqe
	add	rax, rax
	lea	rdx, -2[rax]
	mov	rax, QWORD -248[rbp]
	movzx	edx, WORD [rax + rdx]	; edx = first number[second number lentgh - 1]
	mov	eax, DWORD -272[rbp]
	cdqe
	add	rax, rax
	lea	rcx, -2[rax]
	mov	rax, QWORD -264[rbp]
	movzx	eax, WORD [rax + rcx]	; ecx = second number[second number lentgh - 1]
	cmp	dx, ax
	jg	.loop_body6
	movzx	eax, WORD -208[rbp]
	add	eax, 1
	mov	WORD -208[rbp], ax			; output number[0] += 1
	mov	eax, DWORD -272[rbp]
	sub	eax, 1
	mov	DWORD -232[rbp], eax		; -232[rbp] = temp number of loop = second number lentgh - 1
	jmp	.heck_loop_condition7
.loop_body7_1:
	mov	eax, DWORD -232[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -264[rbp]
	add	rax, rdx
	movzx	edx, WORD [rax]			; edx = second number[i]
	mov	eax, DWORD -232[rbp]
	cdqe
	lea	rcx, [rax+rax]
	mov	rax, QWORD -248[rbp]
	add	rax, rcx
	movzx	eax, WORD [rax]			; eax = first number[i]
	cmp	dx, ax
	jle	.loop_body7_2
	movzx	eax, WORD -208[rbp]		; -> second number[i] > first number[i]
	sub	eax, 1
	mov	WORD -208[rbp], ax			; output number[0] -= 1
	jmp	.break_loop7
.loop_body7_2:
	mov	eax, DWORD -232[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -248[rbp]
	add	rax, rdx
	movzx	edx, WORD [rax]			; edx = first number[i]
	mov	eax, DWORD -232[rbp]
	cdqe
	lea	rcx, [rax+rax]
	mov	rax, QWORD -264[rbp]
	add	rax, rcx
	movzx	eax, WORD [rax]			; eax = second number[i]
	cmp	dx, ax
	jg	.break_loop7
	sub	DWORD -232[rbp], 1			; i--
.heck_loop_condition7:
	cmp	DWORD -232[rbp], 0			; compare i , 0
	jns	.loop_body7_1
.break_loop7:
	mov	eax, DWORD -276[rbp]
	sub eax, DWORD -272[rbp]
	add	eax, 1
	mov	DWORD -240[rbp], eax		; eax = first number lentgh - second number lentgh + 1
	lea	rax, -240[rbp]
	mov	QWORD -216[rbp], rax		; -216[rbp] = address(output number lentgh)
	mov	rsi, QWORD -216[rbp]		; 2nd parameter of normalize array = address(output number lentgh)
	lea	rdi, -208[rbp]				; 1st parameter of normalize array = address(output number[0])
	call	normalize_array
	mov	esi, DWORD -240[rbp]		; 2nd parameter of raverse array = address(output number lentgh)
	lea	rdi, -208[rbp]				; 1st parameter of reverse array = address(output number[0])
	call	reverse_array
	mov	eax, DWORD -252[rbp]
	imul	eax, DWORD -268[rbp]	; eax = first number sign * second number sign
	mov	edx, eax					; 3rd parameter of print array = output number sign = first number sign * second number sign
	mov	esi, DWORD -240[rbp]		; 2nd parameter of print array = output number lentgh
	lea	rdi, -208[rbp]				; 1st parameter of print array = address(output number[0])
	call	print_array
	leave
	ret

print_array:
	push	rbp						;
	mov	rbp, rsp					;
	sub	rsp, 32						; set rsp and rbp
	mov	QWORD -24[rbp], rdi			; -24[rbp] = address(output[0])
	mov	DWORD -28[rbp], esi			; -28[rbp] = output number lentgh
	mov	DWORD -32[rbp], edx			; -32[rbp] = output number sign
	cmp	DWORD -28[rbp], 1			; compare sign and 1
	jne	.check_if_negative_print_negative
	mov	rax, QWORD -24[rbp]
	movzx	eax, WORD [rax]			; eax = output[0]
	cmp	ax, 0
	jne	.check_if_negative_print_negative
	mov	DWORD -32[rbp], 1			; lentgh = 1 and output[0] = 0 -> sign = 1. prevent print '-0'
.check_if_negative_print_negative:
	cmp	DWORD -32[rbp], -1
	jne	.print_loop
	mov	edi, 45						; sign == -1 -> print(-)
	call	putchar
.print_loop:
	mov	DWORD -4[rbp], 0			; -4[rbp] = loop temp number  = i
	jmp	.check_print_loop_condition
.print_loop_body:
	mov	eax, DWORD -4[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]			; eax = output[i]
	cwde
	mov	esi, eax
	lea	rax, string
	mov	rdi, rax
	mov	eax, 0
	call	printf					; print output[i]
	add	DWORD -4[rbp], 1			; i++
.check_print_loop_condition:
	mov	eax, DWORD -4[rbp]
	cmp	eax, DWORD -28[rbp]			; compare i and lentgh
	jl	.print_loop_body
	mov	edi, 10
	call	putchar					; print new line
	leave
	ret

reverse_array:
	push	rbp						;
	mov	rbp, rsp					; set rbp and rsp
	mov	QWORD -24[rbp], rdi			; -24[rbp] = address(input[0])
	mov	DWORD -28[rbp], esi			; -28[rbp] = input number lentgh
	mov	DWORD -4[rbp], 0			; -4[rbp] = loop temp number = i
	jmp	.check_loop_condition8
.loop_body8:
	mov	eax, DWORD -4[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]			; eax = input[i]
	mov	WORD -6[rbp], ax			; -6[rbp] = input[i]
	mov	eax, DWORD -28[rbp]
	sub	eax, DWORD -4[rbp]			; eax = lentgh - i
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
	movzx	eax, WORD [rax]			; eax = input[lentgh - i - 1]
	mov	WORD [rdx], ax				; [rdx] = input[i] = input[lentgh - i - 1]
	mov	eax, DWORD -28[rbp]
	sub	eax, DWORD -4[rbp]
	cdqe
	add	rax, rax
	lea	rdx, -2[rax]
	mov	rax, QWORD -24[rbp]
	add	rdx, rax
	movzx	eax, WORD -6[rbp]
	mov	WORD [rdx], ax				; [rdx] = input[lentgh - i - 1] = -6[rbp] = input[i]
	add	DWORD -4[rbp], 1			; i++
.check_loop_condition8:
	mov	eax, DWORD -28[rbp]
	sar	eax, 1						; eax = lentgh / 2
	cmp	DWORD -4[rbp], eax			; compare i , lentgh / 2
	jl	.loop_body8
	pop	rbp
	ret

get_number:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48						; set rbp and rsp
	mov	QWORD -24[rbp], rdi			; -24[rbp] = address(output[0])
	mov	QWORD -32[rbp], rsi			; -32[rbp] = address(input sign)
	mov	QWORD -40[rbp], rdx			; -40[rbp] = address(input lentgh)
	mov	DWORD -4[rbp], 0			; -4[rbp] = temp number of loop = i
	jmp	.check_loop_condition9
.loop_body9:
	mov	eax, DWORD -4[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]			; rax = address(output[0])
	add	rax, rdx
	mov	WORD [rax], 0				; output[i] = 0
	add	DWORD -4[rbp], 1			; i++
.check_loop_condition9:
	cmp	DWORD -4[rbp], 99			; compare i and 99
	jle	.loop_body9
	mov	DWORD -4[rbp], 0			; -4[rbp] = temp number of loop = i
	jmp	.check_initialize_loop_condition
.initialize_number_1:
	cmp	BYTE -5[rbp], 45			; compare character and '-'
	jne	.initialize_number_2
	mov	rax, QWORD -32[rbp]			; rax = address(output sign)
	mov	DWORD [rax], -1				; [rax] = sign = -1
	sub	DWORD -4[rbp], 1			; i--
	jmp	.continue_loop
.initialize_number_2:
	movsx	ax, BYTE -5[rbp]		; ax = character
	lea	ecx, -48[rax]				; ecx = rax - 48. convert charcter number to integer number
	mov	eax, DWORD -4[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	mov	edx, ecx
	mov	WORD [rax], dx				; output[i] = dx = ecx
.continue_loop:
	add	DWORD -4[rbp], 1
.check_initialize_loop_condition:
	call	getchar
	mov	BYTE -5[rbp], al			; input character and save it in -5[rbp]
	cmp	BYTE -5[rbp], 32			; compare character and ' '
	je	.set_lentgh_and_reverse
	cmp	BYTE -5[rbp], 10			; compare character and '\n'
	jne	.initialize_number_1
.set_lentgh_and_reverse:
	mov	rax, QWORD -40[rbp]
	mov	edx, DWORD -4[rbp]			; edx = -4[rbp] = lentgh
	mov	DWORD [rax], edx			; [rax] = input lentgh
	mov	rax, QWORD -40[rbp] 
	mov	esi, DWORD [rax]			; 2nd parameter of reverse array = address(input lentgh)
	mov	rdi, QWORD -24[rbp]			; 1st parameter of reverse array = address(input[0])
	call	reverse_array
	leave
	ret

normalize_array:
	push	rbp
	mov	rbp, rsp					; set rbp and rsp
	mov	QWORD -24[rbp], rdi			; -24[rbp] = address(input[0])
	mov	QWORD -32[rbp], rsi			; -32[rbp] = address(input lentgh)
	mov	DWORD -8[rbp], 0			; -8[rbp] = loop temp number = i
	jmp	.check_loop_condition10
.sign_is_negative:
	mov	eax, DWORD -8[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]			; eax = input[i]
	lea	ecx, 10[rax]				; ecx = eax + 10
	mov	eax, DWORD -8[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	mov	edx, ecx
	mov	WORD [rax], dx				; input[i] += 10
	mov	eax, DWORD -8[rbp]
	cdqe
	add	rax, 1
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]			; eax = input[i + 1]
	lea	ecx, -1[rax]				; ecx = iax - 1
	mov	eax, DWORD -8[rbp]
	cdqe
	add	rax, 1
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	mov	edx, ecx
	mov	WORD [rax], dx				; input[i + 1] -= 1
.check_negativity_loop:
	mov	eax, DWORD -8[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]			; eax = input[i]
	test	ax, ax					; update SP fucus on ax
	js	.sign_is_negative
	jmp	.check_bigger_than9_loop
.bigger_than9:
	mov	eax, DWORD -8[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]			; eax = input[i]
	lea	ecx, -10[rax]				; ecx = eax - 10
	mov	eax, DWORD -8[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	mov	edx, ecx
	mov	WORD [rax], dx				; input[i] -= 10
	mov	eax, DWORD -8[rbp]
	cdqe
	add	rax, 1
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]			; eax = input[i + 1]
	lea	ecx, 1[rax]					; ecx = input[i + 1] + 1
	mov	eax, DWORD -8[rbp]
	cdqe
	add	rax, 1
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	mov	edx, ecx
	mov	WORD [rax], dx				; input[i + 1] += 1
	mov	rax, QWORD -32[rbp]
	mov	eax, DWORD [rax]
	sub	eax, 1						; eax = lentgh - 1
	cmp	DWORD -8[rbp], eax			; compare i and lentgh - 1
	jne	.check_bigger_than9_loop
	mov	eax, DWORD -8[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]			; eax = input[i]
	cmp	ax, 9
	jg	.check_bigger_than9_loop
	mov	rax, QWORD -32[rbp]			; in this place i = lentgh - 1 and 0 <= input[i] < 10 so lentgh must be increase
	mov	eax, DWORD [rax]			; eax = input lentgh
	lea	edx, 1[rax]
	mov	rax, QWORD -32[rbp]
	mov	DWORD [rax], edx			; input lentgh += 1
.check_bigger_than9_loop:
	mov	eax, DWORD -8[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]			; eax = input[i]
	cmp	ax, 9						; compare input[i] and eax
	jg	.bigger_than9
	add	DWORD -8[rbp], 1
.check_loop_condition10:
	mov	rax, QWORD -32[rbp]
	mov	eax, DWORD [rax]			; eax = input lentgh
	cmp	DWORD -8[rbp], eax			; compare i and lentgh
	jl	.check_negativity_loop
	mov	rax, QWORD -32[rbp]
	mov	eax, DWORD [rax]
	sub	eax, 1
	mov	DWORD -4[rbp], eax			; -4[rbp] = loop temp number = i = lentgh - 1
	jmp	.check_delete_adition_zeros_loop_condition
.delete_adition_zeros_loop_body:
	mov	eax, DWORD -4[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]			; eax = input[i]
	test	ax, ax
	jne	.normalize_end
	mov	rax, QWORD -32[rbp]
	mov	eax, DWORD [rax]
	lea	edx, -1[rax]
	mov	rax, QWORD -32[rbp]
	mov	DWORD [rax], edx			; lentgh -= 1
	sub	DWORD -4[rbp], 1
.check_delete_adition_zeros_loop_condition:
	cmp	DWORD -4[rbp], 0			; cmpare i and 0
	jg	.delete_adition_zeros_loop_body
.normalize_end:
	pop	rbp
	ret

set_small_and_big_number:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48						; set rsp and rbp
	mov	QWORD -24[rbp], rdi			; -24[rbp] = address(first number array[0])
	mov	DWORD -28[rbp], esi			; -28[rbp] = first number sign
	mov	DWORD -32[rbp], edx			; -32[rbp] = first number lentgh
	mov	QWORD -40[rbp], rcx			; -40[rbp] = address(second number array[0])
	mov	DWORD -44[rbp], r8d			; -44[rbp] = second number sign
	mov	DWORD -48[rbp], r9d			; -48[rbp] = second number lentgh
	mov	eax, DWORD -32[rbp]
	cmp	eax, DWORD -48[rbp]			; compare lentgh of numbers
	jle	.check_second_is_bigger
	jmp .first_is_bigger_end
.check_second_is_bigger:
	mov	eax, DWORD -48[rbp]
	cmp	eax, DWORD -32[rbp]
	jle	.loop_begin
	jmp .second_is_bigger_end
.loop_begin:						; in this place first number lentgh = second number lentgh
	mov	DWORD -4[rbp], 0			; -4[rbp] = loop temp number = i
	jmp	.check_loop_condition11
.loop_body11_1:
	mov	eax, DWORD -32[rbp]
	sub	eax, DWORD -4[rbp]
	cdqe
	add	rax, rax
	lea	rdx, -2[rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	movzx	edx, WORD [rax]			; edx = first number[first number lentgh - i - 1]
	mov	eax, DWORD -32[rbp]
	sub	eax, DWORD -4[rbp]
	cdqe
	add	rax, rax
	lea	rcx, -2[rax]
	mov	rax, QWORD -40[rbp]
	add	rax, rcx
	movzx	eax, WORD [rax]			; eax = second number[first number lentgh - i - 1]
	cmp	dx, ax
	jle	.loop_body11_2
	jmp .first_is_bigger_end
.loop_body11_2:
	mov	eax, DWORD -32[rbp]
	sub	eax, DWORD -4[rbp]
	cdqe
	add	rax, rax
	lea	rdx, -2[rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	movzx	edx, WORD [rax]			; edx = first number[first number lentgh - i - 1]
	mov	eax, DWORD -32[rbp]
	sub	eax, DWORD -4[rbp]
	cdqe
	add	rax, rax
	lea	rcx, -2[rax]
	mov	rax, QWORD -40[rbp]
	add	rax, rcx
	movzx	eax, WORD [rax]			; eax = second number[first number lentgh - i - 1]
	cmp	dx, ax
	jge	.continue_loop11
	jmp .second_is_bigger_end
.continue_loop11:
	add	DWORD -4[rbp], 1
.check_loop_condition11:
	mov	eax, DWORD -4[rbp]
	cmp	eax, DWORD -32[rbp]			; compare i and first number lentgh
	jl	.loop_body11_1
	jmp .second_is_bigger_end
.first_is_bigger_end:
	mov	rdi, QWORD -24[rbp]			; 1st parameter of first_input_is_bigger = -24[rbp] = address(first number array[0])
	mov	esi, DWORD -28[rbp]			; 2nd parameter of first_input_is_bigger = -28[rbp] = first number sign
	mov	edx, DWORD -32[rbp]			; 3rd parameter of first_input_is_bigger = -32[rbp] = first number lentgh
	mov	rcx, QWORD -40[rbp]			; 4th parameter of first_input_is_bigger = -40[rbp] = address(second number array[0])
	mov	r8d, DWORD -44[rbp]			; 5th parameter of first_input_is_bigger = -44[rbp] = second number sign
	mov	r9d, DWORD -48[rbp]			; 6th parameter of first_input_is_bigger = -48[rbp] = second number lentgh
	jmp	.func_end
.second_is_bigger_end:
	mov	rdi, QWORD -40[rbp]			; 1st parameter of first_input_is_bigger = -40[rbp] = address(second number array[0])
	mov	esi, DWORD -44[rbp]			; 2nd parameter of first_input_is_bigger = -44[rbp] = second number sign
	mov	edx, DWORD -48[rbp]			; 3rd parameter of first_input_is_bigger = -48[rbp] = second number lentgh
	mov	rcx, QWORD -24[rbp]			; 4th parameter of first_input_is_bigger = -24[rbp] = address(first number array[0])
	mov	r8d, DWORD -28[rbp]			; 5th parameter of first_input_is_bigger = -28[rbp] = first number sign
	mov	r9d, DWORD -32[rbp]			; 6th parameter of first_input_is_bigger = -32[rbp] = first number lentgh
.func_end:
	push	QWORD 56[rbp]			; 7th parameter of first_input_is_bigger = 56[rbp] = address(smaller number lentgh)
	push	QWORD 48[rbp]			; 8th parameter of first_input_is_bigger = 48[rbp] = address(smaller number sign)
	push	QWORD 40[rbp]			; 9th parameter of first_input_is_bigger = 40[rbp] = address(smaller number[0])
	push	QWORD 32[rbp]			; 10th parameter of first_input_is_bigger = 32[rbp] = address(bigger number lentgh)
	push	QWORD 24[rbp]			; 11th parameter of first_input_is_bigger = 24[rbp] = address(bigger number sign)
	push	QWORD 16[rbp]			; 12th parameter of first_input_is_bigger = 16[rbp] = address(bigger number[0])
	call	first_input_is_bigger
	add	rsp, 48
	leave
	ret


first_input_is_bigger:
	push	rbp
	mov	rbp, rsp
	mov	QWORD -24[rbp], rdi			; -24[rbp] = address(first number array[0])
	mov	DWORD -28[rbp], esi			; -28[rbp] = first number sign
	mov	DWORD -32[rbp], edx			; -32[rbp] = first number lentgh
	mov	QWORD -40[rbp], rcx			; -40[rbp] = address(second number array[0])
	mov	DWORD -44[rbp], r8d			; -44[rbp] = second number sign
	mov	DWORD -48[rbp], r9d			; -48[rbp] = second number lentgh
	mov	rax, QWORD 32[rbp]			; rax = address(bigger number lentgh)
	mov	edx, DWORD -32[rbp]			; edx = first number lentgh
	mov	DWORD [rax], edx			; [rax] = bigger number lentgh = first number lentgh
	mov	rax, QWORD 24[rbp]			; rax = address(bigger number sign)
	mov	edx, DWORD -28[rbp]
	mov	DWORD [rax], edx			; [rax] = bigger number sign = first number sign
	mov	rax, QWORD 56[rbp]
	mov	edx, DWORD -48[rbp]
	mov	DWORD [rax], edx			; [rax] = smaller number lentgh = second number lentgh
	mov	rax, QWORD 48[rbp]
	mov	edx, DWORD -44[rbp]
	mov	DWORD [rax], edx			; [rax] = smaller number sign = second number sign
	mov	DWORD -8[rbp], 0			; -8[rbp] = loop temp number = i 
	jmp	.initialize_big_number_loop
.initialize_big_number_i:
	mov	eax, DWORD -8[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	mov	edx, DWORD -8[rbp]			; eax = address(first number[i])
	movsx	rdx, edx
	lea	rcx, [rdx+rdx]
	mov	rdx, QWORD 16[rbp]
	add	rdx, rcx					; rdx = address(bigger number[i])
	movzx	eax, WORD [rax]
	mov	WORD [rdx], ax				; [rdx] = bigger number[i] = first number[i]
	add	DWORD -8[rbp], 1			; i++
.initialize_big_number_loop:
	mov	eax, DWORD -8[rbp]
	cmp	eax, DWORD -32[rbp]			; compare i and first number lentgh
	jl	.initialize_big_number_i
	mov	DWORD -4[rbp], 0			; -4[rbp] = loop temp number = i
	jmp	.initialize_small_number_loop
.initialize_small_number_i:
	mov	eax, DWORD -4[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -40[rbp]
	add	rax, rdx
	mov	edx, DWORD -4[rbp]			; eax = address(second number[i])
	movsx	rdx, edx
	lea	rcx, [rdx+rdx]
	mov	rdx, QWORD 40[rbp]			
	add	rdx, rcx					; rdx = address(smaller number[i])
	movzx	eax, WORD [rax]
	mov	WORD [rdx], ax				; [rdx] = smaller number[i] = second number[i]
	add	DWORD -4[rbp], 1			; i++
.initialize_small_number_loop:
	mov	eax, DWORD -4[rbp]
	cmp	eax, DWORD -48[rbp]			; compare i and second number lentgh
	jl	.initialize_small_number_i
	pop	rbp
	ret

subtract_first_element_from_second:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD -24[rbp], rdi			; -24[rbp] = address(bigger number[0])
	mov	QWORD -32[rbp], rsi			; -32[rbp] = address(bigger number lentgh)
	mov	QWORD -40[rbp], rdx			; -40[rbp] = address(smaller number[0])
	mov	DWORD -44[rbp], ecx			; -44[rbp] = smaller number lentgh
	mov	DWORD -48[rbp], r8d			; -48[rbp] = from
	mov	DWORD -4[rbp], 0			; -4[rbp] = loop temp number = i
	jmp	.check_loop_condition12
.loop_body12:
	mov	edx, DWORD -4[rbp]
	mov	eax, DWORD -48[rbp]
	add	eax, edx
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]			; eax = bigger number[i + from]
	mov	ecx, eax					; ecx = bigger number[i + from]
	mov	eax, DWORD -4[rbp]
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -40[rbp]
	add	rax, rdx
	movzx	eax, WORD [rax]			; eax = smaller number[i]
	sub	ecx, eax
	mov	edx, DWORD -4[rbp]
	mov	eax, DWORD -48[rbp]
	add	eax, edx
	cdqe
	lea	rdx, [rax+rax]
	mov	rax, QWORD -24[rbp]
	add	rax, rdx
	mov	edx, ecx
	mov	WORD [rax], dx				; bigger number[i + from] -= smaller number[i]
	add	DWORD -4[rbp], 1			; i++
.check_loop_condition12:
	mov	eax, DWORD -4[rbp]
	cmp	eax, DWORD -44[rbp]			; compare i and smaler number lentgh
	jl	.loop_body12
	mov	rsi, QWORD -32[rbp]			; 2nd parameter of normalize array = address(bigger number lentgh)		
	mov	rdi, QWORD -24[rbp]			; 1st parameter of normalize array = address(bigger number[0])
	call	normalize_array
	leave
	ret


