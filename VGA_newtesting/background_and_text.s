.equ ADDR_VGA, 0x08000000
.equ OFFSET, 0x0000008A
.equ SW_BASE, 0xFF200040

.section .data
.align 2

BACKGROUND:
   .incbin "background.bmp"
S_1:
   .incbin "S_1.bmp"
S_2:
    .incbin "S_2.bmp"
S_3:
    .incbin "S_3.bmp"
S_4:
    .incbin "S_4.bmp"
S_5:
   .incbin "S_5.bmp"
S_6:
    .incbin "S_6.bmp"
S_7:
    .incbin "S_7.bmp"
S_8:
    .incbin "S_8.bmp"
S_9:
   .incbin "S_9.bmp"
S_10:
   .incbin "S_10.bmp"
S_11:
   .incbin "S_11.bmp"
S_12:
    .incbin "S_12.bmp"
S_13:
    .incbin "S_13.bmp"
S_14:
    .incbin "S_14.bmp"
S_15:
   .incbin "S_15.bmp"
S_16:
    .incbin "S_16.bmp"
S_17:
    .incbin "S_17.bmp"
S_18:
    .incbin "S_18.bmp"
S_19:
   .incbin "S_19.bmp"
S_20:
   .incbin "S_20.bmp"
S_21:
   .incbin "S_21.bmp"
S_22:
    .incbin "S_22.bmp"
S_23:
    .incbin "S_23.bmp"
S_24:
    .incbin "S_24.bmp"
S_25:
   .incbin "S_25.bmp"
S_26:
    .incbin "S_26.bmp"
S_27:
    .incbin "S_27.bmp"
S_28:
    .incbin "S_28.bmp"
S_29:
   .incbin "S_29.bmp"
S_30:
   .incbin "S_30.bmp"
S_31:
   .incbin "S_31.bmp"
S_32:
    .incbin "S_32.bmp"
S_33:
    .incbin "S_33.bmp"
S_34:
    .incbin "S_34.bmp"
S_35:
   .incbin "S_35.bmp"
S_36:
    .incbin "S_36.bmp"
S_37:
    .incbin "S_37.bmp"
S_38:
    .incbin "S_38.bmp"
S_39:
   .incbin "S_39.bmp"
S_40:
   .incbin "S_40.bmp"
S_41:
   .incbin "S_41.bmp"
S_42:
    .incbin "S_42.bmp"
S_43:
    .incbin "S_43.bmp"
BLUE0:
   .incbin "blue0.bmp"
BLUE1:
   .incbin "blue1.bmp"
BLUE2:
   .incbin "blue2.bmp"
BLUE3:
   .incbin "blue3.bmp"
BLUE4:
   .incbin "blue4.bmp"
BLUE5:
   .incbin "blue5.bmp"
BLUE6:
   .incbin "blue6.bmp"
BLUE7:
   .incbin "blue7.bmp"
BLUE8:
   .incbin "blue8.bmp"
BLUE9:
   .incbin "blue9.bmp"
RED0:
   .incbin "red0.bmp"
RED1:
   .incbin "red1.bmp"
RED2:
   .incbin "red2.bmp"
RED3:
   .incbin "red3.bmp"
RED4:
   .incbin "red4.bmp"
RED5:
   .incbin "red5.bmp"
RED6:
   .incbin "red6.bmp"
RED7:
   .incbin "red7.bmp"
RED8:
   .incbin "red8.bmp"
RED9:
   .incbin "red9.bmp"
BLUES0:
   .incbin "blueS0.bmp"
BLUES1:
   .incbin "blueS1.bmp"
BLUES2:
   .incbin "blueS2.bmp"
BLUES3:
   .incbin "blueS3.bmp"
BLUES4:
   .incbin "blueS4.bmp"
BLUES5:
   .incbin "blueS5.bmp"
BLUES6:
   .incbin "blueS6.bmp"
BLUES7:
   .incbin "blueS7.bmp"
BLUES8:
   .incbin "blueS8.bmp"
BLUES9:
   .incbin "blueS9.bmp"
REDS0:
   .incbin "redS0.bmp"
REDS1:
   .incbin "redS1.bmp"
REDS2:
   .incbin "redS2.bmp"
REDS3:
   .incbin "redS3.bmp"
REDS4:
   .incbin "redS4.bmp"
REDS5:
   .incbin "redS5.bmp"
REDS6:
   .incbin "redS6.bmp"
REDS7:
   .incbin "redS7.bmp"
REDS8:
   .incbin "redS8.bmp"
REDS9:
   .incbin "redS9.bmp"

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
	addi r3, r3, 1
	beq r4, r3, DRAW_S_1
	addi r3, r3, 1
	beq r4, r3, DRAW_S_2
	addi r3, r3, 1
	beq r4, r3, DRAW_S_3
	addi r3, r3, 1
	beq r4, r3, DRAW_S_4
	addi r3, r3, 1
	beq r4, r3, DRAW_S_5
	addi r3, r3, 1
	beq r4, r3, DRAW_S_6
	addi r3, r3, 1
	beq r4, r3, DRAW_S_7
	addi r3, r3, 1
	beq r4, r3, DRAW_S_8
	addi r3, r3, 1
	beq r4, r3, DRAW_S_9
	addi r3, r3, 1
	beq r4, r3, DRAW_S_10
	addi r3, r3, 1
	beq r4, r3, DRAW_S_11
	addi r3, r3, 1
	beq r4, r3, DRAW_S_12
	addi r3, r3, 1
	beq r4, r3, DRAW_S_13
	addi r3, r3, 1
	beq r4, r3, DRAW_S_14
	addi r3, r3, 1
	beq r4, r3, DRAW_S_15
	addi r3, r3, 1
	beq r4, r3, DRAW_S_16
	addi r3, r3, 1
	beq r4, r3, DRAW_S_17
	addi r3, r3, 1
	beq r4, r3, DRAW_S_18
	addi r3, r3, 1
	beq r4, r3, DRAW_S_19
	addi r3, r3, 1
	beq r4, r3, DRAW_S_20
	addi r3, r3, 1
	beq r4, r3, DRAW_S_21
	addi r3, r3, 1
	beq r4, r3, DRAW_S_22
	addi r3, r3, 1
	beq r4, r3, DRAW_S_23
	addi r3, r3, 1
	beq r4, r3, DRAW_S_24
	addi r3, r3, 1
	beq r4, r3, DRAW_S_25
	addi r3, r3, 1
	beq r4, r3, DRAW_S_26
	addi r3, r3, 1
	beq r4, r3, DRAW_S_27
	addi r3, r3, 1
	beq r4, r3, DRAW_S_28
	addi r3, r3, 1
	beq r4, r3, DRAW_S_29
	addi r3, r3, 1
	beq r4, r3, DRAW_S_30
	addi r3, r3, 1
	beq r4, r3, DRAW_S_31
	addi r3, r3, 1
	beq r4, r3, DRAW_S_32
	addi r3, r3, 1
	beq r4, r3, DRAW_S_33
	addi r3, r3, 1
	beq r4, r3, DRAW_S_34
	addi r3, r3, 1
	beq r4, r3, DRAW_S_35
	addi r3, r3, 1
	beq r4, r3, DRAW_S_36
	addi r3, r3, 1
	beq r4, r3, DRAW_S_37
	addi r3, r3, 1
	beq r4, r3, DRAW_S_38
	addi r3, r3, 1
	beq r4, r3, DRAW_S_39
	addi r3, r3, 1
	beq r4, r3, DRAW_S_40
	addi r3, r3, 1
	beq r4, r3, DRAW_S_41
	addi r3, r3, 1
	beq r4, r3, DRAW_S_42
	addi r3, r3, 1
	beq r4, r3, DRAW_S_43
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
DRAW_S_1:
	movia r3, S_1
	add r12, r12, r3
	br OUTER
DRAW_S_2:
	movia r3, S_2
	add r12, r12, r3
	br OUTER
DRAW_S_3:
	movia r3, S_3
	add r12, r12, r3
	br OUTER
DRAW_S_4:
	movia r3, S_4
	add r12, r12, r3
	br OUTER
DRAW_S_5:
	movia r3, S_5
	add r12, r12, r3
	br OUTER
DRAW_S_6:
	movia r3, S_6
	add r12, r12, r3
	br OUTER
DRAW_S_7:
	movia r3, S_7
	add r12, r12, r3
	br OUTER
DRAW_S_8:
	movia r3, S_8
	add r12, r12, r3
	br OUTER
DRAW_S_9:
	movia r3, S_9
	add r12, r12, r3
	br OUTER
DRAW_S_10:
	movia r3, S_10
	add r12, r12, r3
	br OUTER
DRAW_S_11:
	movia r3, S_11
	add r12, r12, r3
	br OUTER
DRAW_S_12:
	movia r3, S_12
	add r12, r12, r3
	br OUTER
DRAW_S_13:
	movia r3, S_13
	add r12, r12, r3
	br OUTER
DRAW_S_14:
	movia r3, S_14
	add r12, r12, r3
	br OUTER
DRAW_S_15:
	movia r3, S_15
	add r12, r12, r3
	br OUTER
DRAW_S_16:
	movia r3, S_16
	add r12, r12, r3
	br OUTER
DRAW_S_17:
	movia r3, S_17
	add r12, r12, r3
	br OUTER
DRAW_S_18:
	movia r3, S_18
	add r12, r12, r3
	br OUTER
DRAW_S_19:
	movia r3, S_19
	add r12, r12, r3
	br OUTER
DRAW_S_20:
	movia r3, S_20
	add r12, r12, r3
	br OUTER
DRAW_S_21:
	movia r3, S_21
	add r12, r12, r3
	br OUTER
DRAW_S_22:
	movia r3, S_22
	add r12, r12, r3
	br OUTER
DRAW_S_23:
	movia r3, S_23
	add r12, r12, r3
	br OUTER
DRAW_S_24:
	movia r3, S_24
	add r12, r12, r3
	br OUTER
DRAW_S_25:
	movia r3, S_25
	add r12, r12, r3
	br OUTER
DRAW_S_26:
	movia r3, S_26
	add r12, r12, r3
	br OUTER
DRAW_S_27:
	movia r3, S_27
	add r12, r12, r3
	br OUTER
DRAW_S_28:
	movia r3, S_28
	add r12, r12, r3
	br OUTER
DRAW_S_29:
	movia r3, S_29
	add r12, r12, r3
	br OUTER
DRAW_S_30:
	movia r3, S_30
	add r12, r12, r3
	br OUTER
DRAW_S_31:
	movia r3, S_31
	add r12, r12, r3
	br OUTER
DRAW_S_32:
	movia r3, S_32
	add r12, r12, r3
	br OUTER
DRAW_S_33:
	movia r3, S_33
	add r12, r12, r3
	br OUTER
DRAW_S_34:
	movia r3, S_34
	add r12, r12, r3
	br OUTER
DRAW_S_35:
	movia r3, S_35
	add r12, r12, r3
	br OUTER
DRAW_S_36:
	movia r3, S_36
	add r12, r12, r3
	br OUTER
DRAW_S_37:
	movia r3, S_37
	add r12, r12, r3
	br OUTER
DRAW_S_38:
	movia r3, S_38
	add r12, r12, r3
	br OUTER
DRAW_S_39:
	movia r3, S_39
	add r12, r12, r3
	br OUTER
DRAW_S_40:
	movia r3, S_40
	add r12, r12, r3
	br OUTER
DRAW_S_41:
	movia r3, S_41
	add r12, r12, r3
	br OUTER
DRAW_S_42:
	movia r3, S_42
	add r12, r12, r3
	br OUTER
DRAW_S_43:
	movia r3, S_43
	add r12, r12, r3
	br OUTER

SELECT_NUMBER:
	# access province army number and team check

DRAW_BLUE0:
	movia r3, BLUE0
	add r12, r12, r3
	br OUTER

DRAW_BLUE1:
	movia r3, BLUE1
	add r12, r12, r3
	br OUTER

DRAW_BLUE2:
	movia r3, BLUE2
	add r12, r12, r3
	br OUTER

DRAW_BLUE3:
	movia r3, BLUE3
	add r12, r12, r3
	br OUTER

DRAW_BLUE4:
	movia r3, BLUE4
	add r12, r12, r3
	br OUTER

DRAW_BLUE5:
	movia r3, BLUE5
	add r12, r12, r3
	br OUTER

DRAW_BLUE6:
	movia r3, BLUE6
	add r12, r12, r3
	br OUTER

DRAW_BLUE7:
	movia r3, BLUE7
	add r12, r12, r3
	br OUTER

DRAW_BLUE8:
	movia r3, BLUE8
	add r12, r12, r3
	br OUTER

DRAW_BLUE9:
	movia r3, BLUE9
	add r12, r12, r3
	br OUTER

DRAW_RED0:
	movia r3, RED0
	add r12, r12, r3
	br OUTER

DRAW_RED1:
	movia r3, RED1
	add r12, r12, r3
	br OUTER

DRAW_RED2:
	movia r3, RED2
	add r12, r12, r3
	br OUTER

DRAW_RED3:
	movia r3, RED3
	add r12, r12, r3
	br OUTER

DRAW_RED4:
	movia r3, RED4
	add r12, r12, r3
	br OUTER

DRAW_RED5:
	movia r3, RED5
	add r12, r12, r3
	br OUTER

DRAW_RED6:
	movia r3, RED6
	add r12, r12, r3
	br OUTER

DRAW_RED7:
	movia r3, RED7
	add r12, r12, r3
	br OUTER

DRAW_RED8:
	movia r3, RED8
	add r12, r12, r3
	br OUTER

DRAW_RED9:
	movia r3, RED9
	add r12, r12, r3
	br OUTER
	
DRAW_BLUSE0:
	movia r3, BLUSE0
	add r12, r12, r3
	br OUTER

DRAW_BLUSE1:
	movia r3, BLUSE1
	add r12, r12, r3
	br OUTER

DRAW_BLUSE2:
	movia r3, BLUSE2
	add r12, r12, r3
	br OUTER

DRAW_BLUSE3:
	movia r3, BLUSE3
	add r12, r12, r3
	br OUTER

DRAW_BLUSE4:
	movia r3, BLUSE4
	add r12, r12, r3
	br OUTER

DRAW_BLUSE5:
	movia r3, BLUSE5
	add r12, r12, r3
	br OUTER

DRAW_BLUSE6:
	movia r3, BLUSE6
	add r12, r12, r3
	br OUTER

DRAW_BLUSE7:
	movia r3, BLUSE7
	add r12, r12, r3
	br OUTER

DRAW_BLUSE8:
	movia r3, BLUSE8
	add r12, r12, r3
	br OUTER

DRAW_BLUSE9:
	movia r3, BLUSE9
	add r12, r12, r3
	br OUTER

DRAW_REDS0:
	movia r3, REDS0
	add r12, r12, r3
	br OUTER

DRAW_REDS1:
	movia r3, REDS1
	add r12, r12, r3
	br OUTER

DRAW_REDS2:
	movia r3, REDS2
	add r12, r12, r3
	br OUTER

DRAW_REDS3:
	movia r3, REDS3
	add r12, r12, r3
	br OUTER

DRAW_REDS4:
	movia r3, REDS4
	add r12, r12, r3
	br OUTER

DRAW_REDS5:
	movia r3, REDS5
	add r12, r12, r3
	br OUTER

DRAW_REDS6:
	movia r3, REDS6
	add r12, r12, r3
	br OUTER

DRAW_REDS7:
	movia r3, REDS7
	add r12, r12, r3
	br OUTER

DRAW_REDS8:
	movia r3, REDS8
	add r12, r12, r3
	br OUTER

DRAW_REDS9:
	movia r3, REDS9
	add r12, r12, r3
	br OUTER	
