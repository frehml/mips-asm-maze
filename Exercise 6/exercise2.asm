#https://stackoverflow.com/questions/47602199/color-specific-row-in-bitmap-asm   
li      $t1, 0x00ff0000     #Loading RED in register
li      $t2, 0x00ffff00     #Loading YELLOW in register

# top row + first column
move    $a0, $gp            # pointer to write to
li      $a1, 33             # 32 pixels for first row, +1 for left column
move    $a2, $t2            # yellow
jal     setPixels
# 16 red rows with yellow endings+starts
li      $t0, 16

red_rows_loop:
    li      $a1, 30
    move    $a2, $t1
    jal     setPixels           # set 30 red pixels in middle
    sw      $t2, ($a0)          # set 1 yellow at end, and 1 at start of next row
    sw      $t2, 4($a0)
    addi    $a0, $a0, 8
    addi    $t0, $t0, -1
    bnez    $t0, red_rows_loop
    # finish last row to be full yellow
    li      $a1, 31             # 31 pixels more needed (1 is already there)
    move    $a2, $t2            # yellow
    jal     setPixels

    li      $v0, 32             # MARS service delay(ms)
    li      $a0, 40             # 40ms = ~25 FPS if the draw would be instant
    syscall

# Sets $a1 pixels to $a2 value starting at $a0 (memory fill)
# a0 = pointer to write to, a1 = count of pixels, a2 = value of pixel to set
# a0 will be updated to point right after the last written word
setPixels:
    sw      $a2, ($a0)      # set pixel (or simply memory word)
    addi    $a0, $a0, 4     # advance memory pointer
    addi    $a1, $a1, -1    # count-down loop
    bnez    $a1, setPixels
    jr      $ra             # return