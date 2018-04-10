.equ ADDR_VGA, 0x08000000
.equ OFFSET_NUMBERS, 0x0000008A

.section .text
.global VGA_PURPLE_NUMBERS

VGA_PURPLE_NUMBERS:
	addi sp, sp, -36
	stw ra, 0(sp)
	stw r16, 4(sp)
	stw r17, 8(sp)
	stw r18, 12(sp)
	stw r19, 16(sp)
	stw r20, 20(sp)
	stw r21, 24(sp)
	stw r22, 28(sp)
	stw r23, 32(sp)
    movia r2, ADDR_VGA
    ########
    # Change below: Get the territory to draw from game loop
    ########
    # for actual, change to 43 + 1
    movi r21, 44 # downcounter

MOST_OUTER:
    addi r21, r21, -1
	beq r21, r0, END

	# reset to original
	movi r17, 0 # y max
    movi r18, 5 # y current
    movi r19, 3 # x max (added 1 to account for start at 1)
    movi r20, 0 # x current
    movi r23, OFFSET_NUMBERS
    mov r4, r21
    call SELECT_PURPLE_T_NUMBER
    mov r9, r2
    add r23, r23, r3
    addi r23, r23, -4

OUTER:
    ble r18, r17, MOST_OUTER
    addi r18, r18, -1
    addi r23, r23, 2
    movi r20, 0
    
INNER:
    bge r20, r19, OUTER
    addi r20, r20, 1
    addi r23, r23, 2 

	# find location to store pixel
	# change start value

    slli r22, r20, 1 #mulitply by 2
    #add r22, r9, r22
    slli r11, r18, 10 # multiply by 1024
    add r22, r22, r11
    movi r11, 0x8
    slli r11, r11, 24
    add r22, r22, r11
    add r22, r22, r9
	
	# clear pixel
    movui r16, 0xFFFF
    sthio r16, 0(r22)
	
	# Draw pixel
    ldhu r16, 0(r23)
    sthio r16, 0(r22)

    br INNER

END:
	ldw r16, 4(sp)
	ldw r17, 8(sp)
	ldw r18, 12(sp)
	ldw r19, 16(sp)
	ldw r20, 20(sp)
	ldw r21, 24(sp)
	ldw r22, 28(sp)
	ldw r23, 32(sp)
	ldw ra, 0(sp)
	addi sp, sp, 36
    ret
