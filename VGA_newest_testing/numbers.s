.equ ADDR_VGA, 0x08000000
.equ OFFSET_NUMBERS, 0x00000094

.section .data
.align 2

# numbers are 3x5
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
PURPLE0:
   .incbin "purple0.bmp"
PURPLE1:
   .incbin "purple1.bmp"
PURPLE2:
   .incbin "purple2.bmp"
PURPLE3:
   .incbin "purple3.bmp"
PURPLE4:
   .incbin "purple4.bmp"
PURPLE5:
   .incbin "purple5.bmp"
PURPLE6:
   .incbin "purple6.bmp"
PURPLE7:
   .incbin "purple7.bmp"
PURPLE8:
   .incbin "purple8.bmp"
PURPLE9:
   .incbin "purple9.bmp"
BLUEH0:
   .incbin "blueH0.bmp"
BLUEH1:
   .incbin "blueH1.bmp"
BLUEH2:
   .incbin "blueH2.bmp"
BLUEH3:
   .incbin "blueH3.bmp"
BLUEH4:
   .incbin "blueH4.bmp"
BLUEH5:
   .incbin "blueH5.bmp"
BLUEH6:
   .incbin "blueH6.bmp"
BLUEH7:
   .incbin "blueH7.bmp"
BLUEH8:
   .incbin "blueH8.bmp"
BLUEH9:
   .incbin "blueH9.bmp"
REDH0:
   .incbin "redH0.bmp"
REDH1:
   .incbin "redH1.bmp"
REDH2:
   .incbin "redH2.bmp"
REDH3:
   .incbin "redH3.bmp"
REDH4:
   .incbin "redH4.bmp"
REDH5:
   .incbin "redH5.bmp"
REDH6:
   .incbin "redH6.bmp"
REDH7:
   .incbin "redH7.bmp"
REDH8:
   .incbin "redH8.bmp"
REDH9:
   .incbin "redH9.bmp"

.section .text
.global VGA_NUMBERS

VGA_NUMBERS:

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
    # for actual, change to 42 (+1 (i.e. 43)!!!)
    movi r21, 5 # downcounter

MOST_OUTER:
	
    addi r21, r21, -1
	beq r21, r0, END

	# reset to original
	movi r17, 0 # y max
    movi r18, 5 # y current
    movi r19, 3 # x max (added 1 to account for start at 1)
    movi r20, -1 # x current
    movi r23, OFFSET_NUMBERS
    call SELECT_T_NUMBER
    mov r9, r2

    # select which colour/number will be drawn to current ter.
    # will be a fn that knows which ter. we on
    # prev. addi will screw up
    br DRAW_RED1

OUTER:
    ble r18, r17, MOST_OUTER
    addi r18, r18, -1
    addi r23, r23, -2
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

/*
SELECT_NUMBERS:
	mov r3, r0
	beq r16, r3, DRAW_RED0
	addi r3, r3, 1	

	beq r16, r3, DRAW_RED1
	addi r3, r3, 1	

	beq r16, r3, DRAW_RED2
	addi r3, r3, 1	

	beq r16, r3, DRAW_BLUE0
	addi r3, r3, 1	

	beq r16, r3, DRAW_BLUE1
	addi r3, r3, 1	

	beq r16, r3, DRAW_BLUE2
	addi r3, r3, 1	

	beq r16, r3, DRAW_PURPLE0
	addi r3, r3, 1	

	beq r16, r3, DRAW_PURPLE1
	addi r3, r3, 1	

	beq r16, r3, DRAW_PURPLE2
	addi r3, r3, 1	

	beq r16, r3, DRAW_REDH0
	addi r3, r3, 1	

	beq r16, r3, DRAW_REDH1
	addi r3, r3, 1	

	beq r16, r3, DRAW_REDH2
	addi r3, r3, 1	

	beq r16, r3, DRAW_BLUEH0
	addi r3, r3, 1	

	beq r16, r3, DRAW_BLUEH1
	addi r3, r3, 1	

	beq r16, r3, DRAW_BLUEH2
	addi r3, r3, 1
	br DRAW_RED0
*/

#SELECT_NUMBER:
	# access province army number and team check

DRAW_BLUE0:
	movia r3, BLUE0
	add r23, r23, r3
	br OUTER

DRAW_BLUE1:
	movia r3, BLUE1
	add r23, r23, r3
	br OUTER

DRAW_BLUE2:
	movia r3, BLUE2
	add r23, r23, r3
	br OUTER

DRAW_BLUE3:
	movia r3, BLUE3
	add r23, r23, r3
	br OUTER

DRAW_BLUE4:
	movia r3, BLUE4
	add r23, r23, r3
	br OUTER

DRAW_BLUE5:
	movia r3, BLUE5
	add r23, r23, r3
	br OUTER

DRAW_BLUE6:
	movia r3, BLUE6
	add r23, r23, r3
	br OUTER

DRAW_BLUE7:
	movia r3, BLUE7
	add r23, r23, r3
	br OUTER

DRAW_BLUE8:
	movia r3, BLUE8
	add r23, r23, r3
	br OUTER

DRAW_BLUE9:
	movia r3, BLUE9
	add r23, r23, r3
	br OUTER

DRAW_RED0:
	movia r3, RED0
	add r23, r23, r3
	br OUTER

DRAW_RED1:
	movia r3, RED1
	add r23, r23, r3
	br OUTER

DRAW_RED2:
	movia r3, RED2
	add r23, r23, r3
	br OUTER

DRAW_RED3:
	movia r3, RED3
	add r23, r23, r3
	br OUTER

DRAW_RED4:
	movia r3, RED4
	add r23, r23, r3
	br OUTER

DRAW_RED5:
	movia r3, RED5
	add r23, r23, r3
	br OUTER

DRAW_RED6:
	movia r3, RED6
	add r23, r23, r3
	br OUTER

DRAW_RED7:
	movia r3, RED7
	add r23, r23, r3
	br OUTER

DRAW_RED8:
	movia r3, RED8
	add r23, r23, r3
	br OUTER

DRAW_RED9:
	movia r3, RED9
	add r23, r23, r3
	br OUTER

DRAW_PURPLE0:
	movia r3, PURPLE0
	add r23, r23, r3
	br OUTER

DRAW_PURPLE1:
	movia r3, PURPLE1
	add r23, r23, r3
	br OUTER

DRAW_PURPLE2:
	movia r3, PURPLE2
	add r23, r23, r3
	br OUTER

DRAW_PURPLE3:
	movia r3, PURPLE3
	add r23, r23, r3
	br OUTER

DRAW_PURPLE4:
	movia r3, PURPLE4
	add r23, r23, r3
	br OUTER

DRAW_PURPLE5:
	movia r3, PURPLE5
	add r23, r23, r3
	br OUTER

DRAW_PURPLE6:
	movia r3, PURPLE6
	add r23, r23, r3
	br OUTER

DRAW_PURPLE7:
	movia r3, PURPLE7
	add r23, r23, r3
	br OUTER

DRAW_PURPLE8:
	movia r3, PURPLE8
	add r23, r23, r3
	br OUTER

DRAW_PURPLE9:
	movia r3, PURPLE9
	add r23, r23, r3
	br OUTER
	
DRAW_BLUEH0:
	movia r3, BLUEH0
	add r23, r23, r3
	br OUTER

DRAW_BLUEH1:
	movia r3, BLUEH1
	add r23, r23, r3
	br OUTER

DRAW_BLUEH2:
	movia r3, BLUEH2
	add r23, r23, r3
	br OUTER

DRAW_BLUEH3:
	movia r3, BLUEH3
	add r23, r23, r3
	br OUTER

DRAW_BLUEH4:
	movia r3, BLUEH4
	add r23, r23, r3
	br OUTER

DRAW_BLUEH5:
	movia r3, BLUEH5
	add r23, r23, r3
	br OUTER

DRAW_BLUEH6:
	movia r3, BLUEH6
	add r23, r23, r3
	br OUTER

DRAW_BLUEH7:
	movia r3, BLUEH7
	add r23, r23, r3
	br OUTER

DRAW_BLUEH8:
	movia r3, BLUEH8
	add r23, r23, r3
	br OUTER

DRAW_BLUEH9:
	movia r3, BLUEH9
	add r23, r23, r3
	br OUTER

DRAW_REDH0:
	movia r3, REDH0
	add r23, r23, r3
	br OUTER

DRAW_REDH1:
	movia r3, REDH1
	add r23, r23, r3
	br OUTER

DRAW_REDH2:
	movia r3, REDH2
	add r23, r23, r3
	br OUTER

DRAW_REDH3:
	movia r3, REDH3
	add r23, r23, r3
	br OUTER

DRAW_REDH4:
	movia r3, REDH4
	add r23, r23, r3
	br OUTER

DRAW_REDH5:
	movia r3, REDH5
	add r23, r23, r3
	br OUTER

DRAW_REDH6:
	movia r3, REDH6
	add r23, r23, r3
	br OUTER

DRAW_REDH7:
	movia r3, REDH7
	add r23, r23, r3
	br OUTER

DRAW_REDH8:
	movia r3, REDH8
	add r23, r23, r3
	br OUTER

DRAW_REDH9:
	movia r3, REDH9
	add r23, r23, r3
	br OUTER	
