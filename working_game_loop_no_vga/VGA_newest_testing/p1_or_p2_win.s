.equ ADDR_VGA, 0x08000000
.equ OFFSET, 0x0000008A

.section .data
.align 2

P1_ENDSCREEN:
   .incbin "p1win.bmp"
P2_ENDSCREEN:
   .incbin "p2win.bmp"


.section .text
.global GAME_OVER

GAME_OVER:
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

    movi r16, 0 # y max
    movi r17, 240 # y current
    movi r18, 320 # x max (added 1 to account for start at 1)
    movi r19, -1 # x current
    movi r23, OFFSET

	# select correct image to draw
	bne r4, r0, P2_SELECT
P1_SELECT:
	movia r3, P1_ENDSCREEN
	add r23, r23, r3
	br OUTER
P2_SELECT:
    movia r3, P2_ENDSCREEN
	add r23, r23, r3

OUTER:
    ble r17, r16, END
    addi r17, r17, -1
    addi r23, r23, -2
    movi r19, -1
INNER:
    bge r19, r18, OUTER
    addi r19, r19, 1
    addi r23, r23, 2 

	# find location to store pixel
    slli r22, r19, 1  # mulitply by 2
    slli r21, r17, 10 # multiply by 1024
    add r22, r22, r21
    movi r21, 0x8
    slli r21, r21, 24
    add r22, r22, r21
	
	# clear pixel
    movui r4, 0xFFFF
    sthio r4, 0(r22)
	
	# Draw pixel
    ldhu r4, 0(r23)
    sthio r4, 0(r22)

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
