.equ ADDR_VGA, 0x08000000
.equ OFFSET, 0x0000008A
.equ SW_BASE, 0xFF200040

.section .data
.align 2

BACKGROUND:
   .incbin "background.bmp"
H_1:
   .incbin "H_1.bmp"
H_2:
   .incbin "H_2.bmp"
H_3:
   .incbin "H_3.bmp"
H_4:
   .incbin "H_4.bmp"
H_5:
   .incbin "H_5.bmp"
H_6:
   .incbin "H_6.bmp"
H_7:
   .incbin "H_7.bmp"
H_8:
   .incbin "H_8.bmp"
H_9:
   .incbin "H_9.bmp"
H_10:
   .incbin "H_10.bmp"
H_11:
   .incbin "H_11.bmp"
H_12:
   .incbin "H_12.bmp"
H_13:
   .incbin "H_13.bmp"
H_14:
   .incbin "H_14.bmp"
H_15:
   .incbin "H_15.bmp"
H_16:
   .incbin "H_16.bmp"
H_17:
   .incbin "H_17.bmp"
H_18:
   .incbin "H_18.bmp"
H_19:
   .incbin "H_19.bmp"
H_20:
   .incbin "H_20.bmp"
H_21:
   .incbin "H_21.bmp"
H_22:
   .incbin "H_22.bmp"
H_23:
   .incbin "H_23.bmp"
H_24:
   .incbin "H_24.bmp"
H_25:
   .incbin "H_25.bmp"
H_26:
   .incbin "H_26.bmp"
H_27:
   .incbin "H_27.bmp"
H_28:
   .incbin "H_28.bmp"
H_29:
   .incbin "H_29.bmp"
H_30:
   .incbin "H_30.bmp"
H_31:
   .incbin "H_31.bmp"
H_32:
   .incbin "H_32.bmp"
H_33:
   .incbin "H_33.bmp"
H_34:
   .incbin "H_34.bmp"
H_35:
   .incbin "H_35.bmp"
H_36:
   .incbin "H_36.bmp"
H_37:
   .incbin "H_37.bmp"
H_38:
   .incbin "H_38.bmp"
H_39:
   .incbin "H_39.bmp"
H_40:
   .incbin "H_40.bmp"
H_41:
   .incbin "H_41.bmp"
H_42:
   .incbin "H_42.bmp"
H_43:
   .incbin "H_43.bmp"

.section .text
.global VGA

VGA:
	addi sp, sp, -4
	stw ra, 0(sp)
    movia r2, ADDR_VGA
    
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
    ble r6, r5, DRAW_NUMBERS
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

DRAW_NUMBERS:
	call VGA_NUMBERS

END:
	ldw ra, 0(sp)
	addi sp, sp, 4
    ret

SELECT_MAP:
	mov r3, r0
	beq r4, r3, DRAW_BACK
	addi r3, r3, 1
	#br DRAW_BACK
	
	beq r4, r3, DRAW_H_1
	addi r3, r3, 1
	beq r4, r3, DRAW_H_2
	addi r3, r3, 1
	beq r4, r3, DRAW_H_3
	addi r3, r3, 1
	beq r4, r3, DRAW_H_4
	addi r3, r3, 1
	beq r4, r3, DRAW_H_5
	addi r3, r3, 1
	beq r4, r3, DRAW_H_6
	addi r3, r3, 1
	beq r4, r3, DRAW_H_7
	addi r3, r3, 1
	beq r4, r3, DRAW_H_8
	addi r3, r3, 1
	beq r4, r3, DRAW_H_9
	addi r3, r3, 1
	beq r4, r3, DRAW_H_10
	addi r3, r3, 1
	beq r4, r3, DRAW_H_11
	addi r3, r3, 1
	beq r4, r3, DRAW_H_12
	addi r3, r3, 1
	beq r4, r3, DRAW_H_13
	addi r3, r3, 1
	beq r4, r3, DRAW_H_14
	addi r3, r3, 1
	beq r4, r3, DRAW_H_15
	addi r3, r3, 1
	beq r4, r3, DRAW_H_16
	addi r3, r3, 1
	beq r4, r3, DRAW_H_17
	addi r3, r3, 1
	beq r4, r3, DRAW_H_18
	addi r3, r3, 1
	beq r4, r3, DRAW_H_19
	addi r3, r3, 1
	beq r4, r3, DRAW_H_20
	addi r3, r3, 1
	beq r4, r3, DRAW_H_21
	addi r3, r3, 1
	beq r4, r3, DRAW_H_22
	addi r3, r3, 1
	beq r4, r3, DRAW_H_23
	addi r3, r3, 1
	beq r4, r3, DRAW_H_24
	addi r3, r3, 1
	beq r4, r3, DRAW_H_25
	addi r3, r3, 1
	beq r4, r3, DRAW_H_26
	addi r3, r3, 1
	beq r4, r3, DRAW_H_27
	addi r3, r3, 1
	beq r4, r3, DRAW_H_28
	addi r3, r3, 1
	beq r4, r3, DRAW_H_29
	addi r3, r3, 1
	beq r4, r3, DRAW_H_30
	addi r3, r3, 1
	beq r4, r3, DRAW_H_31
	addi r3, r3, 1
	beq r4, r3, DRAW_H_32
	addi r3, r3, 1
	beq r4, r3, DRAW_H_33
	addi r3, r3, 1
	beq r4, r3, DRAW_H_34
	addi r3, r3, 1
	beq r4, r3, DRAW_H_35
	addi r3, r3, 1
	beq r4, r3, DRAW_H_36
	addi r3, r3, 1
	beq r4, r3, DRAW_H_37
	addi r3, r3, 1
	beq r4, r3, DRAW_H_38
	addi r3, r3, 1
	beq r4, r3, DRAW_H_39
	addi r3, r3, 1
	beq r4, r3, DRAW_H_40
	addi r3, r3, 1
	beq r4, r3, DRAW_H_41
	addi r3, r3, 1
	beq r4, r3, DRAW_H_42
	addi r3, r3, 1
	beq r4, r3, DRAW_H_43
	br DRAW_BACK

DRAW_BACK:
	movia r3, BACKGROUND
	add r12, r12, r3
	br OUTER
DRAW_H_1:
	movia r3, H_1
	add r12, r12, r3
	br OUTER
DRAW_H_2:
	movia r3, H_2
	add r12, r12, r3
	br OUTER
DRAW_H_3:
	movia r3, H_3
	add r12, r12, r3
	br OUTER
DRAW_H_4:
	movia r3, H_4
	add r12, r12, r3
	br OUTER
DRAW_H_5:
	movia r3, H_5
	add r12, r12, r3
	br OUTER
DRAW_H_6:
	movia r3, H_6
	add r12, r12, r3
	br OUTER
DRAW_H_7:
	movia r3, H_7
	add r12, r12, r3
	br OUTER
DRAW_H_8:
	movia r3, H_8
	add r12, r12, r3
	br OUTER
DRAW_H_9:
	movia r3, H_9
	add r12, r12, r3
	br OUTER
DRAW_H_10:
	movia r3, H_10
	add r12, r12, r3
	br OUTER
DRAW_H_11:
	movia r3, H_11
	add r12, r12, r3
	br OUTER
DRAW_H_12:
	movia r3, H_12
	add r12, r12, r3
	br OUTER
DRAW_H_13:
	movia r3, H_13
	add r12, r12, r3
	br OUTER
DRAW_H_14:
	movia r3, H_14
	add r12, r12, r3
	br OUTER
DRAW_H_15:
	movia r3, H_15
	add r12, r12, r3
	br OUTER
DRAW_H_16:
	movia r3, H_16
	add r12, r12, r3
	br OUTER
DRAW_H_17:
	movia r3, H_17
	add r12, r12, r3
	br OUTER
DRAW_H_18:
	movia r3, H_18
	add r12, r12, r3
	br OUTER
DRAW_H_19:
	movia r3, H_19
	add r12, r12, r3
	br OUTER
DRAW_H_20:
	movia r3, H_20
	add r12, r12, r3
	br OUTER
DRAW_H_21:
	movia r3, H_21
	add r12, r12, r3
	br OUTER
DRAW_H_22:
	movia r3, H_22
	add r12, r12, r3
	br OUTER
DRAW_H_23:
	movia r3, H_23
	add r12, r12, r3
	br OUTER
DRAW_H_24:
	movia r3, H_24
	add r12, r12, r3
	br OUTER
DRAW_H_25:
	movia r3, H_25
	add r12, r12, r3
	br OUTER
DRAW_H_26:
	movia r3, H_26
	add r12, r12, r3
	br OUTER
DRAW_H_27:
	movia r3, H_27
	add r12, r12, r3
	br OUTER
DRAW_H_28:
	movia r3, H_28
	add r12, r12, r3
	br OUTER
DRAW_H_29:
	movia r3, H_29
	add r12, r12, r3
	br OUTER
DRAW_H_30:
	movia r3, H_30
	add r12, r12, r3
	br OUTER
DRAW_H_31:
	movia r3, H_31
	add r12, r12, r3
	br OUTER
DRAW_H_32:
	movia r3, H_32
	add r12, r12, r3
	br OUTER
DRAW_H_33:
	movia r3, H_33
	add r12, r12, r3
	br OUTER
DRAW_H_34:
	movia r3, H_34
	add r12, r12, r3
	br OUTER
DRAW_H_35:
	movia r3, H_35
	add r12, r12, r3
	br OUTER
DRAW_H_36:
	movia r3, H_36
	add r12, r12, r3
	br OUTER
DRAW_H_37:
	movia r3, H_37
	add r12, r12, r3
	br OUTER
DRAW_H_38:
	movia r3, H_38
	add r12, r12, r3
	br OUTER
DRAW_H_39:
	movia r3, H_39
	add r12, r12, r3
	br OUTER
DRAW_H_40:
	movia r3, H_40
	add r12, r12, r3
	br OUTER
DRAW_H_41:
	movia r3, H_41
	add r12, r12, r3
	br OUTER
DRAW_H_42:
	movia r3, H_42
	add r12, r12, r3
	br OUTER
DRAW_H_43:
	movia r3, H_43
	add r12, r12, r3
	br OUTER