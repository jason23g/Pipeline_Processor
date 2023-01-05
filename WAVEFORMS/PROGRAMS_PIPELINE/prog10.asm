li	R3, kati	# R3 = kati
li	R6, 16		# R6 = kati
sw	R3,	12[R6]	# MEM[256 + 12/4 + 16/4] = MEM[263] = kati
lw	R10,12[R6]	# R10 = MEM[256 + 12/4 + 16/4] = MEM[263] = kati