addi x5,x5,0x2a


loop:
	lb x10, 1025(x0)
	bne x10, x4, print
	beq x10,x4, loop
	
 	
print:
	sb x10, 1024(x0)
	bne x10, x5, loop

stop:
	halt



jal x1, loop
jal x2, stop
jal x3, print

