#https://inst.eecs.berkeley.edu//~cs61cl/fa08/labs/lab25.html
            .eqv    RCR 0xffff0000      # Receiver Control Register     (Ready Bit)
            .eqv    RDR 0xffff0004      # Receiver Data Register        (Key Pressed - ASCII)
main:
	# sleep
	li	$a0, 2000
	li	$v0, 32
	syscall
	# input
	la	$t1, RCR
	lw	$t2, ($t1)
	beq	$t2, 1, handle_input
	# print
	la	$a0, string
	li	$v0, 4
	syscall
	j main
	
handle_input:
	# get asci values
	la	$t1, RDR
	lw	$t2, ($t1)
	
	# check
	beq	$t2, 122, z
	beq	$t2, 113, q
	beq	$t2, 115, s
	beq	$t2, 100, d
	beq	$t2, 120, x
x:
	li	$v0, 10
	syscall
z:
	la	$a0, up
	li	$v0, 4
	syscall
	j main
q:
	la	$a0, left
	li	$v0, 4
	syscall
	j main
s:
	la	$a0, down
	li	$v0, 4
	syscall
	j main
d:
	la	$a0, right
	li	$v0, 4
	syscall
	j main
	
	.data
string:	.asciiz "Please enter a character\n"
up: .asciiz	"up\n"
down: .asciiz 	"down\n"
left: .asciiz 	"left\n"
right: .asciiz 	"right\n"