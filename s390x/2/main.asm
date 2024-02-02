.data
read_int_format: .asciz		"%d"
	.align	2
read_float_format: .asciz	"%f"
	.align	2
print_Impossible: .asciz	"Impossible"
	.align	2
print_float_format: .asciz	"%.2f "
	.align	2
.text
.globl asm_main

asm_main:
	stmg	%r6,%r15,48(%r15)
	lay	%r15,-344(%r15)
	lgr	%r11,%r15
	lgr	%r10,%r15
	aghik	%r3,%r11,244				# 244(%r11) = n
	larl	%r2,read_int_format
	brasl	%r14,scanf
	l	%r1,244(%r11)
	ahik	%r4,%r1,1					# %r4 = n + 1
	l	%r5,244(%r11)					# %r5 = n
	lgfr	%r1,%r4
	lr	%r12,%r1					# %r12 = 4 * (n + 1)
	lgfr	%r2,%r4
	lgfr	%r1,%r5
	msgr	%r1,%r2
	sllg	%r1,%r1,2					# #r1 = 4 * n * (n + 1)
	aghi	%r1,4095
	srlg	%r1,%r1,12
	sllg	%r1,%r1,12					# %r1 = ceil(4 * n * (n + 1) / 4096) * 4096
	lr		%r2,%r1						# %r2 = %r1
	sgrk	%r2,%r15,%r2				# %r2 = %r15 - %r2
.loop_for_set_memory:
	cgr	%r15,%r2
	je	.set_matrix_begin_point
	aghi	%r15,-4096					# subtract %r15 to have enough space for save matrix
	j	.loop_for_set_memory
.set_matrix_begin_point:
	aghik	%r1,%r15,160
	stg	%r1,312(%r11)					# 312(%r11) = address(matrix[0][0])
	mvhi	248(%r11),0					# 248(%r11) = outer loop1 temp number = i
	j	.check_outer_loop1_condition
.outer_loop1_body:
	mvhi	252(%r11),0					# 252(%r11) = inner loop1 temp number = j
	j	.check_inner_loop1_condition
.inner_loop1_body:
	lr	%r1,%r12
	lgf	%r2,252(%r11)
	lgf	%r3,248(%r11)
	msgr	%r1,%r3
	agr	%r1,%r2
	sllg	%r1,%r1,2
	ag	%r1,312(%r11)
	lgr	%r3,%r1							# %r3 = matrix[i][j]
	larl	%r2,read_float_format
	brasl	%r14,scanf
	asi	252(%r11),1						# j++
.check_inner_loop1_condition:
	l	%r2,244(%r11)
	l	%r1,252(%r11)
	cr	%r1,%r2							# compare j and n
	jle	.inner_loop1_body
	asi	248(%r11),1						# i++
.check_outer_loop1_condition:
	l	%r2,244(%r11)
	l	%r1,248(%r11)
	cr	%r1,%r2							# compare i and n
	jl	.outer_loop1_body
										# in the loop in the down run RREF orders
	mvhi	256(%r11),0					# 256(%r11) = outer loop temp number = i
	j	.check_outer_loop2_condition
.outer_loop2_body:
	mvhi	260(%r11),0					# 260(%r11) = outer loop temp number = j
	j	.check_inner_loop2_condition
.inner_loop2_body:
	lr %r2,%r12
	lg	%r1,312(%r11)
	lgf	%r3,260(%r11)
	lgf	%r4,256(%r11)
	msgr	%r2,%r4
	agr	%r2,%r3
	sllg	%r2,%r2,2
	lde	%f0,0(%r2,%r1)					# %f0 = float(matrix[i][j])
	lzer	%f2							# %f2 = 0
	cebr	%f0,%f2						# compare %f0 and %f2
	je	.continue_inner_loop2
	ldebr	%f0,%f0						# %f0 = double(%f0)
	std	%f0,320(%r11)					# 320(%r11) = %f0
	mvhi	264(%r11),0					# 264(%r11) = loop3 temp number = k
	j	.check_loop3_condition
.loop3_body:
	lr %r2,%r12
	lg	%r1,312(%r11)
	lgf	%r3,264(%r11)
	lgf	%r4,256(%r11)
	msgr	%r2,%r4
	agr	%r2,%r3
	sllg	%r2,%r2,2
	lde	%f0,0(%r2,%r1)					# %f0 = matrix[i][k]
	ldebr	%f0,%f0						# %f0 = double(%f0)
	ddb	%f0,320(%r11)					# %f0 /= matrix[i][j]
	ledbr	%f0,%f0						# %f0 = float(%f0)
	ste	%f0,0(%r2,%r1)					# matrix[i][k] /= matrix[i][j]
	asi	264(%r11),1						# k++
.check_loop3_condition:
	l	%r2,244(%r11)
	l	%r1,264(%r11)
	cr	%r1,%r2							# compare k and n
	jle	.loop3_body
	mvhi	268(%r11),0					# now loop 3 end and matrix[i] /= matrix[i][j],
										# 268(%r11) = loop4 temp number = k
	j	.check_loop4_condition
.loop4_body:
	l	%r1,268(%r11)
	c	%r1,256(%r11)
	je	.continue_loop4					# compare k and i
	lr %r2,%r12
	lg	%r1,312(%r11)
	lgf	%r3,260(%r11)
	lgf	%r4,268(%r11)
	msgr	%r2,%r4
	agr	%r2,%r3
	sllg	%r2,%r2,2
	lde	%f0,0(%r2,%r1)					# %f0 = matrix[k][j]
	ldebr	%f0,%f0
	std	%f0,328(%r11)					# 328(%r11) = matrix[k][j]
	mvhi	272(%r11),0					# 272(%r11) = loop5 temp number = s
	j	.check_loop5_condition
.loop5_body:
	lr %r2,%r12
	lg	%r1,312(%r11)
	lgf	%r3,272(%r11)
	lgf	%r4,268(%r11)
	msgr	%r2,%r4
	agr	%r2,%r3
	sllg	%r2,%r2,2
	lde	%f0,0(%r2,%r1)					# %f0 = matrix[k][s]
	ldebr	%f0,%f0
	lr %r2,%r12
	lg	%r1,312(%r11)
	lgf	%r3,272(%r11)
	lgf	%r4,256(%r11)
	msgr	%r2,%r4
	agr	%r2,%r3
	sllg	%r2,%r2,2
	lde	%f2,0(%r2,%r1)					# %f2 = matrix[i][s]
	ldebr	%f2,%f2
	mdb	%f2,328(%r11)					# %f2 = double(matrix[k][j]) * double(matrix[i][s])
	sdbr	%f0,%f2						# %f0 -= %f2
	lr %r2,%r12
	ledbr	%f0,%f0
	lg	%r1,312(%r11)
	lgf	%r3,272(%r11)
	lgf	%r4,268(%r11)
	msgr	%r2,%r4
	agr	%r2,%r3
	sllg	%r2,%r2,2
	ste	%f0,0(%r2,%r1)					# matrix[k][s] = %f0
	asi	272(%r11),1						# s++
.check_loop5_condition:
	l	%r2,244(%r11)
	l	%r1,272(%r11)
	cr	%r1,%r2							# compare s and n
	jle	.loop5_body
.continue_loop4:
	asi	268(%r11),1						# k++
.check_loop4_condition:
	l	%r2,244(%r11)
	l	%r1,268(%r11)
	cr	%r1,%r2							# compare k and n
	jl	.loop4_body
	j	.outer_loop2_continue			# break
.continue_inner_loop2:
	asi	260(%r11),1						# j++
.check_inner_loop2_condition:
	l	%r2,244(%r11)
	l	%r1,260(%r11)
	cr	%r1,%r2							# compare j and n
	jl	.inner_loop2_body
.outer_loop2_continue:
	asi	256(%r11),1						# i++
.check_outer_loop2_condition:
	l	%r2,244(%r11)
	l	%r1,256(%r11)
	cr	%r1,%r2							# compare i and n
	jl	.outer_loop2_body
	mvhi	276(%r11),0					# 276(%r11) = outer loop6 temp number = i
	j	.check_outer_loop6_condition
.outer_loop6_body:
	mvhi	280(%r11),1					# 280(%r11)=flag check Imposs.flag==1 -> matrix is Impo
	mvhi	284(%r11),0					# 284(%r11) = inner loop6 temp number = j
	j	.check_inner_loop6_condition
.inner_loop6_body:
	lr %r2,%r12
	lg	%r1,312(%r11)
	lgf	%r3,284(%r11)
	lgf	%r4,276(%r11)
	msgr	%r2,%r4
	agr	%r2,%r3
	sllg	%r2,%r2,2
	lde	%f0,0(%r2,%r1)					# %f0 = matrix[i][j]
	lzer	%f2							# %f2 = 0
	cebr	%f0,%f2						# compare matrix[i][j] and 0
	je	.inner_loop6_continue
	mvhi	280(%r11),0					# make flag zero
	j	.break_inner_loop
.inner_loop6_continue:
	asi	284(%r11),1						# j++
.check_inner_loop6_condition:
	l	%r2,244(%r11)
	l	%r1,284(%r11)
	cr	%r1,%r2							# compare j and n
	jl	.inner_loop6_body
.break_inner_loop:
	l	%r1,280(%r11)
	chi	%r1,0
	je	.outer_loop6_continue
	larl	%r2,print_Impossible
	brasl	%r14,puts
	j	.end_program
.outer_loop6_continue:
	asi	276(%r11),1						# i++
.check_outer_loop6_condition:
	l	%r2,244(%r11)
	l	%r1,276(%r11)
	cr	%r1,%r2							# compare i and n
	jl	.outer_loop6_body
										# now matrix isnt Impossible and values will print
	mvhi	288(%r11),0					# outer loop7 temp number = i
	j	.check_outer_loop7_condition
.outer_loop7_body:
	mvhi	292(%r11),0					# 292(%r11) = inner loop7 temp number
	j	.check_inner_loop7_condition
.inner_loop7_body:
	lr %r2,%r12
	lg	%r1,312(%r11)
	lgf	%r3,288(%r11)
	lgf	%r4,292(%r11)
	msgr	%r2,%r4
	agr	%r2,%r3
	sllg	%r2,%r2,2
	lde	%f0,0(%r2,%r1)					# %f0 = matrix[j][i]
	lzer	%f2
	cebr	%f0,%f2						# compare %f0 and 0
	je	.inner_loop7_continue
	lr %r2,%r12
	l	%r3,244(%r11)
	lg	%r1,312(%r11)
	lgfr	%r3,%r3
	lgf	%r4,292(%r11)
	msgr	%r2,%r4
	agr	%r2,%r3
	sllg	%r2,%r2,2
	lde	%f0,0(%r2,%r1)					# %f0 = matrix[j][n]
	ldebr	%f0,%f0
	larl	%r2,print_float_format
	brasl	%r14,printf
	j	.outer_loop7_continue
.inner_loop7_continue:
	asi	292(%r11),1						# j++
.check_inner_loop7_condition:
	l	%r2,244(%r11)
	l	%r1,292(%r11)
	cr	%r1,%r2							# compare j and n
	jl	.inner_loop7_body
.outer_loop7_continue:
	asi	288(%r11),1						# i++
.check_outer_loop7_condition:
	l	%r2,244(%r11)
	l	%r1,288(%r11)
	cr	%r1,%r2							# compare i and n
	jl	.outer_loop7_body
.end_program:
	lgr	%r15,%r10
	lmg	%r6,%r15,392(%r11)
	br	%r14