# int i, j, f, g, h;
# if (i == j){
#	f = g + h;
# else{
#	f = g - h;}

beq x22, x23, end1
sub x19, x20, x21
beq x0, x0, exit
end1:
	add x19, x20, x21
exit: 
	# continua o programa aqui...

