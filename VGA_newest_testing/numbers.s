.equ ADDR_VGA, 0x08000000
.equ OFFSET_NUMBERS, 0x0000008A

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
    call SELECT_T_NUMBER
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

# temp storage
/*
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
*/
