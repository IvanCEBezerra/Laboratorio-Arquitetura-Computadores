a: .word 6
b: .word 15
m: .word 0
lw x9, a
lw x10, b
lw x11, m
lw x21, m
blt x10, x11, end1
sub x21, x9, x10
beq x0, x0, end2
end1: 
	add x21, x9, x10
end2:
	sw x21, m 


