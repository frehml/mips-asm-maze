#https://stackoverflow.com/questions/47697600/get-address-of-pixel-in-bitmap-display-mips
li      $t1, 0x00ff0000     #Loading RED in register
	.data
width: .half 512
height: .half 512

	.text
main:
#test func
	li $a0, 31 # load coord into x
	li $a1, 15 # load coord into y
	jal coord_to_addy
	la $a0, ($v0)


coord_to_addy:
# x in a0
# y in a1
	# x = a0
	# y = a1

    sll     $t0, $a1, 5         # calculate offset in $at: at = y_pos * 32
    add     $t0, $t0, $a0       # at = y_pos * 32 + x_pos = "index"
    sll     $t0, $t0, 2         # at = (y_pos * 32 + x_pos)*4 = "offset"
    add     $v0, $t0, $gp       # at = gp + offset and save into return register