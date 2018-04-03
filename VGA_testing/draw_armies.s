.equ ADDR_CHAR, 0x09000000

.section .data
#.align 2
# essentially behaves as though you had .byte .... [many many bytes declared]...
BACKGROUND:
   .incbin "background.bmp"
BACKGROUND_T_1:
   .incbin "T_1.bmp"
BACKGROUND_T_2:
    .incbin "T_2.bmp"
BACKGROUND_T_3:
    .incbin "T_3.bmp"
BACKGROUND_T_4:
    .incbin "T_4.bmp"
BACKGROUND_T_5:
   .incbin "T_5.bmp"
BACKGROUND_T_6:
    .incbin "T_6.bmp"

.section .text
.global VGA
VGA:
	addi sp, sp, -4
	stw ra, 0(sp)
    movia r2,ADDR_VGA
    
    movi r5, 0 # y max
    movi r6, 240 # y current
    movi r7, 320 # x max (added 1 to account for start at 1)
    movi r8, -1 # x current
    movi r12, OFFSET

	# select correct image to draw
	movia r3, SW_BASE
    ldwio r4, 0(r3)
	andi r4, r4, 0b1111111111
	br SELECT_MAP

OUTER:
    ble r6, r5, DRAW_CHARS
    addi r6, r6, -1
    addi r12, r12, -2
    movi r8, -1
INNER:
    bge r8, r7, OUTER
    addi r8, r8, 1
    addi r12, r12, 2 

	# find location to store pixel
    slli r10, r8, 1 #mulitply by 2
    slli r11, r6, 10 # multiply by 1024
    add r10, r10, r11
    movi r11, 0x8
    slli r11, r11, 24
    add r10, r10, r11
	
	# clear pixel
    movui r4, 0xFFFF
    sthio r4, 0(r10)
	
	# Draw pixel
    ldhu r4, 0(r12)
    sthio r4, 0(r10)

    br INNER

DRAW_CHARS:
	#call character drawer

END:
	ldw ra, 0(sp)
	addi sp, sp, 4
    ret

SELECT_MAP:
	mov r3, r0
	beq r4, r3, DRAW_BACK
	
	addi r3, r3, 1
	beq r4, r3, DRAW_1

	addi r3, r3, 1
	beq r4, r3, DRAW_2

	addi r3, r3, 1
	beq r4, r3, DRAW_3

	addi r3, r3, 1
	beq r4, r3, DRAW_4

	addi r3, r3, 1
	beq r4, r3, DRAW_5

	addi r3, r3, 1
	beq r4, r3, DRAW_6
	br DRAW_BACK

DRAW_BACK:
	movia r3, BACKGROUND
	add r12, r12, r3
	br OUTER

DRAW_1:
	movia r3, BACKGROUND_T_1
	add r12, r12, r3
	br OUTER

DRAW_2:
	movia r3, BACKGROUND_T_2
	add r12, r12, r3
	br OUTER

DRAW_3:
	movia r3, BACKGROUND_T_3
	add r12, r12, r3
	br OUTER

DRAW_4:
	movia r3, BACKGROUND_T_4
	add r12, r12, r3
	br OUTER

DRAW_5:
	movia r3, BACKGROUND_T_5
	add r12, r12, r3
	br OUTER

DRAW_6:
	movia r3, BACKGROUND_T_6
	add r12, r12, r3
	br OUTER
	
	
