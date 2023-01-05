li	R5,	8		# R5 = 8
li	R7,	-4		# R7 = -4
li	R9,	8		# R9 = 8
add	R15,R5,	R5	# R15 = 16
sw	R5,	8[R7]	# MEM[257] = 8
lw	R18,8[R7]	# R18 = MEM[257] = 8