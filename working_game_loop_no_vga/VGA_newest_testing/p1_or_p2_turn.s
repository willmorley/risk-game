.equ ADDR_VGA, 0x08000000
.equ OFFSET_NUMBERS, 0x0000008A

.section .data
.align 2
P1_TURN:
	.incbin "player1.bmp"
P2_TURN:
	.incbin "player2.bmp"

.section .text
.global DRAW_PLAYER_TURN

DRAW_PLAYER_TURN:
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

LOOP_PREP:
	movi r17, 0 # y max
    movi r18, 19 # y current
    movi r19, 120 # x max (added 1 to account for start at 1)
    movi r20, -1 # x current
    movi r23, OFFSET_NUMBERS
    
	bne r5, r0, P2_SELECT
P1_SELECT:
	movia r3, P1_TURN
	br SECONDARY_PREP
P2_SELECT:
	movia r3, P2_TURN

SECONDARY_PREP:	
    add r23, r23, r3
    #addi r23, r23, -4
	# set coordinate
	movi r9, 200
	slli r9, r9, 1

OUTER:
    ble r18, r17, END
    addi r18, r18, -1
    addi r23, r23,-2
    movi r20, -1
    
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
