addi x1, x1,24
loop: 
	lb x10, 0(x1)
	sb x10, 1024(x0)
	addi x1,x1, 1

jal x2, loop

halt

str1: .string "Hello World"
