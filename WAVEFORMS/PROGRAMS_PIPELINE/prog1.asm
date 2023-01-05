addi	R5,	R0, 4		# R5 = 4
sw		R5,	4[R0]		# MEM[257] = 0x4
lw		R10,-4[R5]		# R10 = MEM[257] = 0xABCD
ori		R3,	R0, 0xABCD	# R3 = 0xABCD
li		R16,0xCD		# R16 = 0xCD

nand	R4, R10, R16	# R4 = kati...
10000001010001001000000000110101

#lb		R16, 4[R0]