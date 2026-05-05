# Sum of Absolute Differences Algorithm

.text
main:
	# Initialize memory
	addi	$t0	$zero	5	# left_image[0]
	sw	$t0	0x0000
	addi	$t0	$zero	16	# left_image[1]
	sw	$t0	0x0004
	addi	$t0	$zero	7	# left_image[2]
	sw	$t0	0x0008
	addi	$t0	$zero	1	# left_image[3]
	sw	$t0	0x000C
	addi	$t0	$zero	1	# left_image[4]
	sw	$t0	0x0010
	addi	$t0	$zero	13	# left_image[5]
	sw	$t0	0x0014
	addi	$t0	$zero	2	# left_image[6]
	sw	$t0	0x0018
	addi	$t0	$zero	8	# left_image[7]
	sw	$t0	0x001C
	addi	$t0	$zero	10	# left_image[8]
	sw	$t0	0x0020

	addi	$t0	$zero	4	# right_image[0]
	sw	$t0	0x0024
	addi	$t0	$zero	15	# right_image[1]
	sw	$t0	0x0028
	addi	$t0	$zero	8	# right_image[2]
	sw	$t0	0x002C
	addi	$t0	$zero	0	# right_image[3]
	sw	$t0	0x0030
	addi	$t0	$zero	2	# right_image[4]
	sw	$t0	0x0034
	addi	$t0	$zero	12	# right_image[5]
	sw	$t0	0x0038
	addi	$t0	$zero	3	# right_image[6]
	sw	$t0	0x003C
	addi	$t0	$zero	7	# right_image[7]
	sw	$t0	0x0040
	addi	$t0	$zero	11	# right_image[8]
	sw	$t0	0x0044

	addi	$s0	$zero	0	# $s0 = i = 0

	loop:
	addi	$t0	$zero	9	# $t0 = image_size = 9
	beq	$s0	$t0	end_loop

	sll	$s1	$s0	2	# $s1 = 4 * i
	lw	$a0	($s1)		# $a0 = left_image[i]
	lw	$a1	0x0024($s1)	# $a1 = right_image[i]
	jal	abs_diff
	sw	$v0	0x0048($s1)	# sad_array[i] = $v0

	addi	$s0	$s0	1	# i++
	j	loop

	end_loop:
	addi	$a0	$zero	0x0048	# t2 = recursive_sum(sad_array, 9)
	addi	$a1	$zero	9
	jal	recursive_sum
	addi	$t2	$v0	0

	end:
	j	end	# Infinite loop at the end of the program.

abs_diff:
	sub	$v0	$a0	$a1
	slti	$t0	$v0	0	# $t0 = pixel_left - pixel_right < 0
	beq	$t0	$zero	abs_diff_return
	sub	$v0	$zero	$v0
	abs_diff_return:		# $v0 = abs($a0 - $a1) here
	jr	$ra

recursive_sum:
	bne	$a1	$zero	recursive_sum_non_zero
	addi	$v0	$zero	0	# return 0
	jr	$ra

	recursive_sum_non_zero:
	addi	$sp	$sp	-8
	sw	$ra	4($sp)		# Push $ra to the stack
	sw	$s0	($sp)		# Push $s0 to the stack

	addi	$a1	$a1	-1	# $a1 = size - 1

	sll	$t0	$a1	2	# $t0 = 4 * (size - 1)
	add	$s0	$a0	$t0	# $s0 = arr[size - 1] pointer

	jal	recursive_sum

	lw	$t0	($s0)		# $t0 = arr[size - 1]
	add	$v0	$v0	$t0	# return $v0 + $t0

	lw	$s0	($sp)		# Pop $s0 off the stack
	lw	$ra	4($sp)		# Pop $ra off the stack
	addi	$sp	$sp	8
	jr	$ra
