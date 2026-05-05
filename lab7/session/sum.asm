# Calculates the sum from A to B

.text
main:
	addi	$t0	$zero	2
	addi	$t1	$zero	5

	addi	$t2	$zero	0
	slt	$t3	$t1	$t0
	bne	$t3	$zero	end

loop:
	add	$t2	$t2	$t0
	beq	$t0	$t1	end
	addi	$t0	$t0	1
	j	loop

end:
	j	end
