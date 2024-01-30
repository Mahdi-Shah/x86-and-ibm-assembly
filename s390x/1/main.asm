.data
string: .asciz	"%d"
.text
.globl asm_main



asm_main:
	stmg	%r6,%r15,48(%r15)					# store return address
	lay	%r15,-632(%r15)							# create enough space for srore
	lgr	%r11,%r15								# r11 = r15
	j	.check_loop1_condition
.loop1_body_1:
	mvhi	176(%r11),1						# 176(%r11) = first number sign
	mvhi	184(%r11),1						# 184(%r11) = second number sign
	la	%r1,176(%r11)
	stg	%r1,192(%r11)						# 192(%r11) = address(first number sign)
	la	%r1,180(%r11)						# 180(%r11) = first number len
	stg	%r1,200(%r11)						# 200(%r11) = address(first number len)
	la	%r1,184(%r11)
	stg	%r1,208(%r11)						# 208(%r11) = address(second number sign)
	la	%r1,188(%r11)						# 188(%r11) = second number len
	stg	%r1,216(%r11)						# 216(%r11) = address(second number len)
	brasl	%r14,getchar					# get '\n'
	aghik	%r1,%r11,224					# 224(%r11) = address(first number[0])
	lg	%r4,200(%r11)						# 3rd parameter get number = address(first number len)
	lg	%r3,192(%r11)						# 2nd parameter get number = address(first number sign)
	lgr	%r2,%r1								# 1st parameter get number = address(first number[0])
	brasl	%r14,get_number
	aghik	%r1,%r11,424					# 424(%r11) = address(first number[0])
	lg	%r4,216(%r11)						# 3rd parameter get number = address(second number len)
	lg	%r3,208(%r11)						# 2nd parameter get number = address(second number sign)
	lgr	%r2,%r1								# 1st parameter get number = address(second number[0])
	brasl	%r14,get_number
	l	%r1,188(%r11)
	lgfr	%r1,%r1
	stg	%r1,160(%r15)						# 6th parameter func = second number len
	lr %r7, %r1
	aghik	%r0,%r11,184					
	lgr	%r6,%r0								# 5th parameter func = second number sign
	aghik	%r5,%r11,424					# 4th parameter func = address(second number[0])
	l	%r4,180(%r11)
	lgfr	%r4,%r4							# 3rd parameter func = first number len
	aghik	%r3,%r11,176					# 2nd parameter func = first number sign
	aghik	%r2,%r11,224					# 1st parameter func = address(first number[0])
	j .check_is_add
.check_is_add:
	llc	%r1,175(%r11)
	chi	%r1,43								# compare character and '+'
	jne	.check_is_sub
	brasl	%r14,add
	j	.check_loop1_condition
.check_is_sub:
	llc	%r1,175(%r11)
	chi	%r1,45								# compare character and '-'
	jne	.check_is_multiple
	brasl	%r14,subtract
	j	.check_loop1_condition
.check_is_multiple:
	llc	%r1,175(%r11)
	chi	%r1,120								# compare character and 'x'
	jne	.check_is_divide
	brasl	%r14,multiple
	j	.check_loop1_condition
.check_is_divide:
	llc	%r1,175(%r11)
	chi	%r1,47								# compare character and '/'
	jne	.check_loop1_condition
	brasl	%r14,divide
.check_loop1_condition:
	brasl	%r14,getchar
	lgr	%r1,%r2
	stc	%r1,175(%r11)						# 175(%r11) = character that is equal to operand
	chi	%r1,113								# compare character and 'q'
	jne	.loop1_body_1
	lmg	%r6,%r15,680(%r11)
	br	%r14

add:
	stmg	%r6,%r15,48(%r15)
	lay	%r15,-928(%r15)
	lgr	%r11,%r15							# set registers
	stg	%r2,240(%r11)						# 240(%r11) = address(first number[0])
	lgr	%r1,%r3
	lgr	%r3,%r4
	stg	%r5,224(%r11)						# 224(%r11) = address(second number[0])
	st	%r1,236(%r11)						# 236(%r11) = first number sign
	lr	%r1,%r3
	st	%r1,232(%r11)						# 232(%r11) = first number len
	st	%r6,220(%r11)						# 220(%r11) = second number sign
	la	%r1,256(%r11)						# 256(%r11) = bigger number len
	stg	%r1,280(%r11)						# 280(%r11) = address(bigger number len)
	la	%r1,264(%r11)						# 264(%r11) = smaller number len				
	stg	%r1,288(%r11)						# 288(%r11) = address(smaller number len)
	la	%r1,260(%r11)
	stg	%r1,296(%r11)
	la	%r1,268(%r11)
	stg	%r1,304(%r11)
	lg	%r1,288(%r11)
	stg	%r1,208(%r11)						# 208(%r11) = address(smaller number len)
	lg	%r1,304(%r11)
	stg	%r1,200(%r11)
	la	%r1,720(%r11)						# 720(%r11) = smaller number[0]
	stg	%r1,192(%r11)						# 192(%r11) = address(smaller number[0])
	lg	%r1,280(%r11)
	stg	%r1,184(%r11)
	lg	%r1,296(%r11)
	stg	%r1,176(%r11)
	la	%r1,520(%r11)						# 520(%r11) = bigger number[0]
	stg	%r1,168(%r11)						# 168(%r11) = address(bigger number[0])
	lr	%r1,%r7								# 1092(%r11) = second number len
	stg	%r1,160(%r11)						# 160(%r11) = second number len
	lgf	%r6,220(%r11)						# 5th parameter func = second number sign
	lg	%r5,224(%r11)						# 4th parameter func = address(second number[0])
	lgf	%r4,232(%r11)						# 3th parameter func = first number len
	lgf	%r3,236(%r11)						# 2th parameter func = first number sign
	lg	%r2,240(%r11)						# 1st parameter func = address(first number[0])
	brasl	%r14,set_small_and_big_number
	la	%r1,256(%r11)
	stg	%r1,312(%r11)						# 312(%r11) = address(bigger number len)
	l	%r1,256(%r11)
	lgfr	%r1,%r1
	sllg	%r1,%r1,1						# 320(%r11) = address(output[0])
	la	%r1,320(%r1,%r11)
	mvhhi	0(%r1),0						# output[bigger number len] = 0
	l	%r1,236(%r11)
	c	%r1,220(%r11)						# compare first and second number sign
	# jne	.signs_isnt_equal					# TODO: problem
	mvhi	272(%r11),0						# 272(%r11) = loop2 temp number = i
	j	.check_loop2_condition
.loop2_body:
	lgf	%r1,272(%r11)
	sllg	%r1,%r1,1
	lh	%r2,520(%r1,%r11)					# %r2 = bigger number[i]
	sth	%r2,320(%r1,%r11)					# output[i] = bigger number[i]
	asi	272(%r11),1							# i++
.check_loop2_condition:
	l	%r2,256(%r11)
	l	%r1,272(%r11)
	cr	%r1,%r2								# compare i and bigger number len
	jl	.loop2_body
	mvhi	276(%r11),0						# 276(%r11) = loop3 temp number = i
	j	.check_loop3_condition
.loop3_body:
	lgf	%r1,276(%r11)
	sllg	%r1,%r1,1
	lh	%r2,320(%r1,%r11)					# %r2 = output[i]
	lh	%r3,720(%r1,%r11)					# %r3 = smaller number[i]				
	ar	%r2,%r3								# 
	sth	%r2,320(%r1,%r11)					# output[i] += smaller number[i]
	asi	276(%r11),1							# i++
.check_loop3_condition:
	l	%r2,264(%r11)
	l	%r1,276(%r11)
	cr	%r1,%r2								# compare i and smaller number len
	jl	.loop3_body
	lg	%r3,312(%r11)						# 2nd parameter func = address(output len)
	aghik	%r2,%r11,320					# 1st parameter func = address(output[0])
	brasl	%r14,normalize_array
	l	%r3,256(%r11)						
	lgfr	%r3,%r3							# 2nd parameter func = bigger number len
	aghik	%r2,%r11,320					# 1st parameter func = address(output[0])
	brasl	%r14,reverse_array
	l	%r3,256(%r11)
	lgfr	%r3,%r3							# 2nd parameter func = address(bigger number len)
	lgf	%r4,236(%r11)						# 3rd parameter func = address(bigger number sign)
	aghik	%r2,%r11,320					# 1st parameter func = address(output[0])
	brasl	%r14,print_array
	j	.add_end
.signs_isnt_equal:
	
	lghi	%r6,0							# 5th parameter func = 0
	l	%r5,264(%r11)
	lgfr	%r5,%r5							
	lgr	%r5,%r5								# 4th parameter func = smaller number len
	aghik	%r4,%r11,720					# 3rd parameter func = address(smaller number[0])
	lg	%r3,280(%r11)						# 2nd parameter func = address(bigger number len)
	aghik	%r2,%r11,520					# 1st parameter func = address(bigger number[0])
	brasl	%r14,subtract_first_element_from_second
	l	%r3,256(%r11)
	lgfr	%r3,%r3							# 2nd parameter func = bigger number len
	aghik	%r2,%r11,520					# 1st parameter func = address(bigger number[0])
	brasl	%r14,reverse_array
	l	%r4,260(%r11)
	lgfr	%r4,%r4							# 3rd parameter func = bigger number len
	l	%r3,256(%r11)
	lgfr	%r3,%r3							# 2nd parameter func = bigger number len
	aghik	%r2,%r11,520					# 1st parameter func = address(bigger number[0])
	brasl	%r14,print_array
.add_end:
	lmg	%r6,%r15,976(%r11)
	br	%r14

set_small_and_big_number:
	stmg	%r6,%r15,48(%r15)
	lay	%r15,-256(%r15)
	lgr	%r11,%r15
	stg	%r2,240(%r11)						# 240(%r11) = address(first number[0])
	lgr	%r1,%r3
	lgr	%r3,%r4
	stg	%r5,224(%r11)						# 224(%r11) = address(second number[0])
	lgr	%r2,%r6
	st	%r1,236(%r11)						# 236(%r11) = first number sign
	lr	%r1,%r3
	st	%r1,232(%r11)						# 232(%r11) = first number len
	lr	%r1,%r2			
	st	%r1,220(%r11)						# 220(%r11) = second number sign
	l	%r1,232(%r11)
	c	%r1,420(%r11)						# 420(%r11) = second number len
	jle	.check_lens								# compare first and second number len
	j .firsts_bigger
.check_lens:
	c	%r1,420(%r11)						# compare first and second number len
	jhe	.begin_loop4
	j .second_bigger
.begin_loop4:
	mvhi	252(%r11),0						# 252(%r11) = loop temp number = i
	j	.check_loop4_condition
.loop4_body_1:
	l	%r1,232(%r11)
	s	%r1,252(%r11)
	lgfr	%r1,%r1
	sllg	%r1,%r1,1
	aghi	%r1,-2
	ag	%r1,240(%r11)
	lh	%r3,0(%r1)							# %r3 = first number[first number len - i - 1]
	l	%r1,232(%r11)
	s	%r1,252(%r11)
	lgfr	%r1,%r1
	sllg	%r1,%r1,1
	aghi	%r1,-2
	ag	%r1,224(%r11)
	lh	%r2,0(%r1)							# %r2 = second number[second number len - i -1]
	lhr	%r1,%r3
	lhr	%r2,%r2
	cr	%r1,%r2								# compare %r3 and %r2
	jle	.loop4_body_2
	j .firsts_bigger
.loop4_body_2:
	cr	%r1,%r2								# compare %r3 and %r2
	jhe	.loop4_continue
	j .second_bigger
.loop4_continue:
	asi	252(%r11),1							# i++
.check_loop4_condition:
	l	%r1,252(%r11)
	c	%r1,232(%r11)
	jl	.loop4_body_1
.second_bigger:
	lgf	%r4,236(%r11)
	lgf	%r3,420(%r11)
	lgf	%r2,220(%r11)
	lg	%r1,464(%r11)					# 464(%r11) = address(smaller number len)
	stg	%r1,208(%r15)
	lg	%r1,456(%r11)					# 456(%r11) = address(smaller number sign)
	stg	%r1,200(%r15)
	lg	%r1,448(%r11)					# 448(%r11) = address(smaller number[0])
	stg	%r1,192(%r15)
	lg	%r1,440(%r11)					# 440(%r11) = address(bigger number len)
	stg	%r1,184(%r15)
	lg	%r1,432(%r11)					# 432(%r11) = address(bigger number sign)
	stg	%r1,176(%r15)
	lg	%r1,424(%r11)					# 424(%r11) = address(bigger number[0])
	stg	%r1,168(%r15)
	lgf	%r1,232(%r11)
	stg	%r1,160(%r15)
	lgr	%r6,%r4
	lg	%r5,240(%r11)
	lgr	%r4,%r3
	lgr	%r3,%r2
	lg	%r2,224(%r11)					# set second number as bigger
	brasl	%r14,first_input_is_bigger
	j	.set_end
.firsts_bigger:
	lg	%r1,464(%r11)			
	stg	%r1,208(%r15)
	lg	%r1,456(%r11)
	stg	%r1,200(%r15)
	lg	%r1,448(%r11)					
	stg	%r1,192(%r15)
	lg	%r1,440(%r11)				
	stg	%r1,184(%r15)
	lg	%r1,432(%r11)					
	stg	%r1,176(%r15)
	lg	%r1,424(%r11)					
	stg	%r1,168(%r15)
	lgf	%r1,420(%r11)
	stg	%r1,160(%r15)
	lgf	%r6,220(%r11)
	lgr	%r6,%r6
	lg	%r5,224(%r11)
	lgf	%r4,232(%r11)
	lgr	%r4,%r4
	lgf	%r3,236(%r11)
	lgr	%r3,%r3
	lg	%r2,240(%r11)					# set first number as bigger
	brasl	%r14,first_input_is_bigger
.set_end:
	lmg	%r6,%r15,304(%r11)
	br	%r14

first_input_is_bigger:
	ldgr	%f2,%r11
	lay	%r15,-200(%r15)
	lgr	%r11,%r15
	stg	%r2,184(%r11)
	lgr	%r1,%r3
	lgr	%r3,%r4
	stg	%r5,168(%r11)
	lgr	%r2,%r6
	st	%r1,180(%r11)
	lr	%r1,%r3
	st	%r1,176(%r11)
	lr	%r1,%r2
	st	%r1,164(%r11)
	lg	%r1,384(%r11)
	l	%r2,176(%r11)
	st	%r2,0(%r1)
	lg	%r1,376(%r11)
	l	%r2,180(%r11)
	st	%r2,0(%r1)
	lg	%r1,408(%r11)
	l	%r2,364(%r11)
	st	%r2,0(%r1)
	lg	%r1,400(%r11)
	l	%r2,164(%r11)
	st	%r2,0(%r1)
	mvhi	192(%r11),0					# loop 5 temp number = i
	j	.check_loop5_condition
.loop5_body:
	lgf	%r1,192(%r11)
	sllg	%r1,%r1,1
	ag	%r1,184(%r11)
	lgr	%r2,%r1
	lgf	%r1,192(%r11)
	sllg	%r1,%r1,1
	ag	%r1,368(%r11)
	lh	%r2,0(%r2)
	sth	%r2,0(%r1)						# bigger number[i] = first number[i]
	asi	192(%r11),1
.check_loop5_condition:
	l	%r1,192(%r11)
	c	%r1,176(%r11)					# compare i and first number len
	jl	.loop5_body
	mvhi	196(%r11),0					# loop6 temp number = i
	j	.check_loop6_condition
.loop6_body:
	lgf	%r1,196(%r11)
	sllg	%r1,%r1,1
	ag	%r1,168(%r11)
	lgr	%r2,%r1
	lgf	%r1,196(%r11)
	sllg	%r1,%r1,1
	ag	%r1,392(%r11)
	lh	%r2,0(%r2)
	sth	%r2,0(%r1)						# smaller number[i] = second number[i]
	asi	196(%r11),1						# i++
.check_loop6_condition:
	l	%r1,196(%r11)
	c	%r1,364(%r11)					# compare i and second number len
	jl	.loop6_body
	lay	%r15,200(%r15)
	lgdr	%r11,%f2
	br	%r14

subtract:
	stmg	%r6,%r15,48(%r15)
	lay	%r15,-200(%r15)
	lgr	%r11,%r15
	#stg	%r2,192(%r11)
	#lgr	%r1,%r3
	#lgr	%r3,%r4
	#stg	%r5,176(%r11)
	#lgr	%r2,%r6
	#st	%r1,188(%r11)
	#lr	%r1,%r3
	#st	%r1,184(%r11)
	#lr	%r1,%r2
	#st	%r1,172(%r11)
	#l	%r1,172(%r11)
	#lcr	%r1,%r1
	lcr	%r6,%r6								# second number sign *= -1
	#lgf	%r3,184(%r11)
	#lgf	%r2,188(%r11)
	lgf	%r1,364(%r11)
	stg	%r1,160(%r11)						# 160(%r11) = second number len
	#lg	%r5,176(%r11)
	#lgr	%r4,%r3
	#lgr	%r3,%r2
	#lg	%r2,192(%r11)
	brasl	%r14,add
	lmg	%r6,%r15,248(%r11)
	br	%r14

multiple:
	stmg	%r11,%r15,88(%r15)
	lay	%r15,-424(%r15)
	lgr	%r11,%r15
	stg	%r2,184(%r11)					# 184(%r11) = address(first number[0])
	st	%r3,180(%r11)					# 180(%r11) = first number sign
	st	%r4,176(%r11)					# 176(%r11) = first number len
	stg	%r5,168(%r11)					# 168(%r11) = address(second number[0])
	st	%r6,164(%r11)					# 164(%r11) = second number sign
										# 588(%r11) = second number len
	l	%r1,176(%r11)
	a	%r1,588(%r11)
	ahi	%r1,1
	st	%r1,192(%r11)					# 192(%r11) = output len = first number len +
										# second number len + 1
	la	%r1,192(%r11)
	stg	%r1,208(%r11)					# 208(%r11) = address(output len)
	mvhi	196(%r11),0					# loop temp number = i
	j	.check_loop7_condition
.loop7_body:
	lgf	%r1,196(%r11)
	sllg	%r1,%r1,1
	la	%r1,216(%r1,%r11)
	mvhhi	0(%r1),0					# output[i] = 0
	asi	196(%r11),1
.check_loop7_condition:
	l	%r1,196(%r11)
	chi	%r1,99							# compare i and 99
	jle	.loop7_body
	mvhi	200(%r11),0					# 200(%r11) = outer loop8 temp = i
	j	.check_outer_loop8_condition
.outer_loop8_body:
	mvhi	204(%r11),0					# 204(%r11) = inner loop8 temp = j
	j	.check_inner_loop8_condition
.inner_loop8_body:
	l	%r1,200(%r11)
	a	%r1,204(%r11)
	lgfr	%r1,%r1
	sllg	%r1,%r1,1
	lh	%r1,216(%r1,%r11)
	lr	%r2,%r1						# %r2 = output[i + j]
	lgf	%r1,200(%r11)
	sllg	%r1,%r1,1
	ag	%r1,184(%r11)
	lh	%r1,0(%r1)
	lr	%r3,%r1						# %r3 = first number[i]
	lgf	%r1,204(%r11)
	sllg	%r1,%r1,1
	ag	%r1,168(%r11)
	lh	%r1,0(%r1)					# %r1 = second number[j]
	msr	%r1,%r3
	ar	%r1,%r2						# %r1 = output[i + j] + first number[i] * second number[j]
	lr	%r2,%r1
	l	%r1,200(%r11)
	a	%r1,204(%r11)
	lgfr	%r1,%r1
	sllg	%r1,%r1,1
	sth	%r2,216(%r1,%r11)			# output[i + j] += first number[i] * second number[j]
	asi	204(%r11),1					# j++
.check_inner_loop8_condition:
	l	%r1,204(%r11)
	c	%r1,588(%r11)				# compare j and second number len
	jl	.inner_loop8_body
	asi	200(%r11),1					# i++
.check_outer_loop8_condition:
	l	%r1,200(%r11)
	c	%r1,176(%r11)				# compare i and first number len
	jl	.outer_loop8_body
	aghik	%r1,%r11,216
	lg	%r3,208(%r11)
	lgr	%r2,%r1
	brasl	%r14,normalize_array	# normalize array
	l	%r1,192(%r11)
	lgfr	%r2,%r1
	aghik	%r1,%r11,216
	lgr	%r3,%r2
	lgr	%r2,%r1
	brasl	%r14,reverse_array		# reverse array
	l	%r2,180(%r11)
	ms	%r2,164(%r11)				# fix output sign
	lgfr	%r4,%r2
	l	%r1,192(%r11)
	lgfr	%r3,%r1
	aghik	%r2,%r11,216
	brasl	%r14,print_array		# print
	lmg	%r11,%r15,512(%r11)
	br	%r14


print_array:
	stmg	%r11,%r15,88(%r15)
	lay	%r15,-184(%r15)
	lgr	%r11,%r15
	stg	%r2,168(%r11)
	lgr	%r1,%r3
	lgr	%r2,%r4
	st	%r1,164(%r11)
	lr	%r1,%r2
	st	%r1,160(%r11)
	l	%r1,164(%r11)
	chi	%r1,1
	jne	.L2
	lg	%r1,168(%r11)
	lh	%r1,0(%r1)
	lhr	%r1,%r1
	ltr	%r1,%r1
	jne	.L2
	mvhi	160(%r11),1
.L2:
	l	%r1,160(%r11)
	chi	%r1,-1
	jne	.L3
	lghi	%r2,45
	brasl	%r14,putchar
.L3:
	mvhi	180(%r11),0
	j	.L4
.L5:
	lgf	%r1,180(%r11)
	sllg	%r1,%r1,1
	ag	%r1,168(%r11)
	lh	%r1,0(%r1)
	lhr	%r1,%r1
	lgfr	%r1,%r1
	lgr	%r3,%r1
	larl	%r2, string
	brasl	%r14,printf
	asi	180(%r11),1
.L4:
	l	%r1,180(%r11)
	c	%r1,164(%r11)
	jl	.L5
	lghi	%r2,10
	brasl	%r14,putchar
	nopr	%r0
	lmg	%r11,%r15,272(%r11)
	br	%r14

reverse_array:
	ldgr	%f2,%r11
	ldgr	%f0,%r15
	lay	%r15,-184(%r15)
	cg	%r0,176(%r15)
	lgr	%r11,%r15
	stg	%r2,168(%r11)
	lgr	%r1,%r3
	st	%r1,164(%r11)
	mvhi	180(%r11),0
	j	.L8
.L9:
	lgf	%r1,180(%r11)
	sllg	%r1,%r1,1
	ag	%r1,168(%r11)
	lh	%r1,0(%r1)
	sth	%r1,178(%r11)
	l	%r1,164(%r11)
	s	%r1,180(%r11)
	lgfr	%r1,%r1
	sllg	%r1,%r1,1
	aghi	%r1,-2
	ag	%r1,168(%r11)
	lgr	%r2,%r1
	lgf	%r1,180(%r11)
	sllg	%r1,%r1,1
	ag	%r1,168(%r11)
	lh	%r2,0(%r2)
	sth	%r2,0(%r1)
	l	%r1,164(%r11)
	s	%r1,180(%r11)
	lgfr	%r1,%r1
	sllg	%r1,%r1,1
	aghi	%r1,-2
	ag	%r1,168(%r11)
	lh	%r2,178(%r11)
	sth	%r2,0(%r1)
	asi	180(%r11),1
.L8:
	l	%r1,164(%r11)
	srlk	%r2,%r1,31
	ar	%r1,%r2
	sra	%r1,1
	lr	%r2,%r1
	l	%r1,180(%r11)
	cr	%r1,%r2
	jl	.L9
	nopr	%r0
	nopr	%r0
	lgdr	%r15,%f0
	lgdr	%r11,%f2
	br	%r14

get_number:
	stmg	%r11,%r15,88(%r15)
	lay	%r15,-192(%r15)
	lgr	%r11,%r15
	stg	%r2,176(%r11)
	stg	%r3,168(%r11)
	stg	%r4,160(%r11)
	mvhi	188(%r11),0
	j	.L12
.L13:
	lgf	%r1,188(%r11)
	sllg	%r1,%r1,1
	ag	%r1,176(%r11)
	mvhhi	0(%r1),0
	asi	188(%r11),1
.L12:
	l	%r1,188(%r11)
	chi	%r1,99
	jle	.L13
	mvhi	188(%r11),0
	j	.L14
.L18:
	llc	%r1,187(%r11)
	chi	%r1,45
	jne	.L15
	lg	%r1,168(%r11)
	mvhi	0(%r1),-1
	asi	188(%r11),-1
	j	.L16
.L15:
	llc	%r1,187(%r11)
	ahi	%r1,-48
	lr	%r2,%r1
	lgf	%r1,188(%r11)
	sllg	%r1,%r1,1
	ag	%r1,176(%r11)
	sth	%r2,0(%r1)
.L16:
	asi	188(%r11),1
.L14:
	brasl	%r14,getchar
	lgr	%r1,%r2
	stc	%r1,187(%r11)
	llc	%r1,187(%r11)
	chi	%r1,32
	je	.L17
	llc	%r1,187(%r11)
	chi	%r1,10
	jne	.L18
.L17:
	lg	%r1,160(%r11)
	l	%r2,188(%r11)
	st	%r2,0(%r1)
	lg	%r1,160(%r11)
	l	%r1,0(%r1)
	lgfr	%r1,%r1
	lgr	%r3,%r1
	lg	%r2,176(%r11)
	brasl	%r14,reverse_array
	nopr	%r0
	lmg	%r11,%r15,280(%r11)
	br	%r14

normalize_array:

	ldgr	%f2,%r11
	ldgr	%f0,%r15
	lay	%r15,-184(%r15)
	cg	%r0,176(%r15)
	lgr	%r11,%r15
	stg	%r2,168(%r11)
	stg	%r3,160(%r11)
	mvhi	176(%r11),0
	j	.L37
.L39:
	lgf	%r1,176(%r11)
	sllg	%r1,%r1,1
	ag	%r1,168(%r11)
	lh	%r1,0(%r1)
	ahi	%r1,10
	lr	%r2,%r1
	lgf	%r1,176(%r11)
	sllg	%r1,%r1,1
	ag	%r1,168(%r11)
	sth	%r2,0(%r1)
	lgf	%r1,176(%r11)
	aghi	%r1,1
	sllg	%r1,%r1,1
	ag	%r1,168(%r11)
	lh	%r1,0(%r1)
	ahi	%r1,-1
	lr	%r2,%r1
	lgf	%r1,176(%r11)
	aghi	%r1,1
	sllg	%r1,%r1,1
	ag	%r1,168(%r11)
	sth	%r2,0(%r1)
.L38:
	lgf	%r1,176(%r11)
	sllg	%r1,%r1,1
	ag	%r1,168(%r11)
	lh	%r1,0(%r1)
	lhr	%r1,%r1
	ltr	%r1,%r1
	jl	.L39
	j	.L40
.L42:
	lgf	%r1,176(%r11)
	sllg	%r1,%r1,1
	ag	%r1,168(%r11)
	lh	%r1,0(%r1)
	ahi	%r1,-10
	lr	%r2,%r1
	lgf	%r1,176(%r11)
	sllg	%r1,%r1,1
	ag	%r1,168(%r11)
	sth	%r2,0(%r1)
	lgf	%r1,176(%r11)
	aghi	%r1,1
	sllg	%r1,%r1,1
	ag	%r1,168(%r11)
	lh	%r1,0(%r1)
	ahi	%r1,1
	lr	%r2,%r1
	lgf	%r1,176(%r11)
	aghi	%r1,1
	sllg	%r1,%r1,1
	ag	%r1,168(%r11)
	sth	%r2,0(%r1)
	lg	%r1,160(%r11)
	l	%r1,0(%r1)
	ahik	%r2,%r1,-1
	l	%r1,176(%r11)
	cr	%r1,%r2
	jne	.L40
	lgf	%r1,176(%r11)
	sllg	%r1,%r1,1
	ag	%r1,168(%r11)
	lh	%r1,0(%r1)
	lhr	%r1,%r1
	chi	%r1,9
	jh	.L40
	lg	%r1,160(%r11)
	l	%r1,0(%r1)
	ahik	%r2,%r1,1
	lg	%r1,160(%r11)
	st	%r2,0(%r1)
.L40:
	lgf	%r1,176(%r11)
	sllg	%r1,%r1,1
	ag	%r1,168(%r11)
	lh	%r1,0(%r1)
	lhr	%r1,%r1
	chi	%r1,9
	jh	.L42
	asi	176(%r11),1
.L37:
	lg	%r1,160(%r11)
	l	%r2,0(%r1)
	l	%r1,176(%r11)
	cr	%r1,%r2
	jl	.L38
	lg	%r1,160(%r11)
	l	%r1,0(%r1)
	ahi	%r1,-1
	st	%r1,180(%r11)
	j	.L44
.L48:
	lgf	%r1,180(%r11)
	sllg	%r1,%r1,1
	ag	%r1,168(%r11)
	lh	%r1,0(%r1)
	lhr	%r1,%r1
	ltr	%r1,%r1
	jne	.L49
	lg	%r1,160(%r11)
	l	%r1,0(%r1)
	ahik	%r2,%r1,-1
	lg	%r1,160(%r11)
	st	%r2,0(%r1)
	asi	180(%r11),-1
.L44:
	l	%r1,180(%r11)
	ltr	%r1,%r1
	jh	.L48
	j	.L50
.L49:
	nopr	%r0
.L50:
	nopr	%r0
	lgdr	%r15,%f0
	lgdr	%r11,%f2
	br	%r14

subtract_first_element_from_second:

	stmg	%r11,%r15,88(%r15)
	lay	%r15,-200(%r15)
	lgr	%r11,%r15
	stg	%r2,184(%r11)
	stg	%r3,176(%r11)
	stg	%r4,168(%r11)
	lgr	%r1,%r5
	lgr	%r2,%r6
	st	%r1,164(%r11)
	lr	%r1,%r2
	st	%r1,160(%r11)
	mvhi	196(%r11),0
	j	.L53
.L54:
	l	%r1,196(%r11)
	a	%r1,160(%r11)
	lgfr	%r1,%r1
	sllg	%r1,%r1,1
	ag	%r1,184(%r11)
	lh	%r1,0(%r1)
	lr	%r2,%r1
	lgf	%r1,196(%r11)
	sllg	%r1,%r1,1
	ag	%r1,168(%r11)
	lh	%r1,0(%r1)
	srk	%r1,%r2,%r1
	lr	%r2,%r1
	l	%r1,196(%r11)
	a	%r1,160(%r11)
	lgfr	%r1,%r1
	sllg	%r1,%r1,1
	ag	%r1,184(%r11)
	sth	%r2,0(%r1)
	asi	196(%r11),1
.L53:
	l	%r1,196(%r11)
	c	%r1,164(%r11)
	jl	.L54
	lg	%r3,176(%r11)
	lg	%r2,184(%r11)
	brasl	%r14,normalize_array
	nopr	%r0
	lmg	%r11,%r15,288(%r11)
	br	%r14

divide:

	stmg	%r6,%r15,48(%r15)
	lay	%r15,-432(%r15)
	lgr	%r11,%r15
	stg	%r2,184(%r11)
	lgr	%r1,%r3
	lgr	%r3,%r4
	stg	%r5,168(%r11)
	lgr	%r2,%r6
	st	%r1,180(%r11)
	lr	%r1,%r3
	st	%r1,176(%r11)
	lr	%r1,%r2
	st	%r1,164(%r11)
	ear	%r1,%a0
	sllg	%r1,%r1,32
	ear	%r1,%a1
	mvc	424(8,%r11),40(%r1)
	mvhi	196(%r11),0
	j	.L78
.L79:
	lgf	%r1,196(%r11)
	sllg	%r1,%r1,1
	la	%r1,224(%r1,%r11)
	mvhhi	0(%r1),0
	asi	196(%r11),1
.L78:
	l	%r1,196(%r11)
	chi	%r1,99
	jle	.L79
	la	%r1,176(%r11)
	stg	%r1,208(%r11)
	j	.L80
.L81:
	l	%r1,176(%r11)
	s	%r1,596(%r11)
	ahi	%r1,-1
	lgfr	%r1,%r1
	sllg	%r1,%r1,1
	lh	%r1,224(%r1,%r11)
	ahi	%r1,1
	lr	%r2,%r1
	l	%r1,176(%r11)
	s	%r1,596(%r11)
	ahi	%r1,-1
	lgfr	%r1,%r1
	sllg	%r1,%r1,1
	sth	%r2,224(%r1,%r11)
	l	%r1,176(%r11)
	s	%r1,596(%r11)
	ahi	%r1,-1
	lgfr	%r2,%r1
	lgf	%r1,596(%r11)
	lgr	%r6,%r2
	lgr	%r5,%r1
	lg	%r4,168(%r11)
	lg	%r3,208(%r11)
	lg	%r2,184(%r11)
	brasl	%r14,subtract_first_element_from_second
.L80:
	l	%r2,176(%r11)
	l	%r1,596(%r11)
	cr	%r1,%r2
	jl	.L81
	j	.L82
.L83:
	l	%r1,176(%r11)
	s	%r1,596(%r11)
	lgfr	%r1,%r1
	sllg	%r1,%r1,1
	lh	%r1,224(%r1,%r11)
	ahi	%r1,1
	lr	%r2,%r1
	l	%r1,176(%r11)
	s	%r1,596(%r11)
	lgfr	%r1,%r1
	sllg	%r1,%r1,1
	sth	%r2,224(%r1,%r11)
	lgf	%r1,596(%r11)
	lghi	%r6,0
	lgr	%r5,%r1
	lg	%r4,168(%r11)
	lg	%r3,208(%r11)
	lg	%r2,184(%r11)
	brasl	%r14,subtract_first_element_from_second
.L82:
	lgf	%r1,596(%r11)
	sllg	%r1,%r1,1
	aghi	%r1,-2
	ag	%r1,184(%r11)
	lh	%r3,0(%r1)
	lgf	%r1,596(%r11)
	sllg	%r1,%r1,1
	aghi	%r1,-2
	ag	%r1,168(%r11)
	lh	%r2,0(%r1)
	lhr	%r1,%r3
	lhr	%r2,%r2
	cr	%r1,%r2
	jh	.L83
	lh	%r1,224(%r11)
	ahi	%r1,1
	sth	%r1,224(%r11)
	l	%r1,596(%r11)
	ahi	%r1,-1
	st	%r1,200(%r11)
	j	.L84
.L88:
	lgf	%r1,200(%r11)
	sllg	%r1,%r1,1
	ag	%r1,168(%r11)
	lh	%r3,0(%r1)
	lgf	%r1,200(%r11)
	sllg	%r1,%r1,1
	ag	%r1,184(%r11)
	lh	%r2,0(%r1)
	lhr	%r1,%r3
	lhr	%r2,%r2
	cr	%r1,%r2
	jle	.L85
	lh	%r1,224(%r11)
	ahi	%r1,-1
	sth	%r1,224(%r11)
	j	.L86
.L85:
	lgf	%r1,200(%r11)
	sllg	%r1,%r1,1
	ag	%r1,184(%r11)
	lh	%r3,0(%r1)
	lgf	%r1,200(%r11)
	sllg	%r1,%r1,1
	ag	%r1,168(%r11)
	lh	%r2,0(%r1)
	lhr	%r1,%r3
	lhr	%r2,%r2
	cr	%r1,%r2
	jh	.L94
	asi	200(%r11),-1
.L84:
	l	%r1,200(%r11)
	ltr	%r1,%r1
	jhe	.L88
	j	.L86
.L94:
	nopr	%r0
.L86:
	mvhi	204(%r11),100
	j	.L89
.L92:
	lgf	%r1,204(%r11)
	sllg	%r1,%r1,1
	lh	%r1,224(%r1,%r11)
	lhr	%r1,%r1
	ltr	%r1,%r1
	jh	.L95
	asi	204(%r11),-1
.L89:
	l	%r1,204(%r11)
	ltr	%r1,%r1
	jh	.L92
	j	.L91
.L95:
	nopr	%r0
.L91:
	l	%r1,204(%r11)
	ahi	%r1,1
	st	%r1,192(%r11)
	la	%r1,192(%r11)
	stg	%r1,216(%r11)
	aghik	%r1,%r11,224
	lg	%r3,216(%r11)
	lgr	%r2,%r1
	brasl	%r14,normalize_array
	l	%r1,192(%r11)
	lgfr	%r2,%r1
	aghik	%r1,%r11,224
	lgr	%r3,%r2
	lgr	%r2,%r1
	brasl	%r14,reverse_array
	l	%r1,192(%r11)
	l	%r2,180(%r11)
	ms	%r2,164(%r11)
	lgfr	%r3,%r2
	lgfr	%r2,%r1
	aghik	%r1,%r11,224
	lgr	%r4,%r3
	lgr	%r3,%r2
	lgr	%r2,%r1
	brasl	%r14,print_array
	nopr	%r0
	ear	%r1,%a0
	sllg	%r1,%r1,32
	ear	%r1,%a1
	clc	424(8,%r11),40(%r1)
.L93:
	lmg	%r6,%r15,480(%r11)
	br	%r14

