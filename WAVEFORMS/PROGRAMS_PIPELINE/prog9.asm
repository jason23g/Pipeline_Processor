li	R1,0x4		# R1 = 0x4
sw	R1,4[R1]	# MEM[256 + 4/4 + 4/4] = MEM[258] = 4
li	R16,0xAB	# R16 = 0xAB
li	R17,0x22	# R17 = 0x22
li	R18,0xCD	# R18 = 0xCD
lw	R2,4[R1]	# R2 = MEM[256 + 4/4 + 4/4] = MEM[258] = 4