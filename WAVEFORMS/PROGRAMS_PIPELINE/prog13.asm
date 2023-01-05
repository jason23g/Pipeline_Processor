addi	R5,	R0, 4		# R5 = 4
sw		R5,	4[R0]		# MEM[257] = 0x4
lw		R10,-4[R5]		# R10 = MEM[257] = 0xABCD