.equ ADDR_VGA, 0x08000000
.equ OFFSET, 0x0000008A
.equ ADDR_PUSHBUTTON, 0xFF200050

.section .data
.align 2

TITLE_SCREEN:
   .incbin "titlepage.bmp"
FIRST_INST_SCREEN:
   .incbin "instr1.bmp"
SECOND_INST_SCREEN:
   .incbin "instr2.bmp"
THIRD_INST_SCREEN:
   .incbin "instr3.bmp"


.section .text
.global INTRO_SCREENS

INTRO_SCREENS:
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
	
	# counter for screen that we're on
	mov r15, r0

SCREEN_SELECT:
 	movi r23, OFFSET

	beq r15, r0, TITLE
	movi r5, 1
	beq r15, r5, FIRST_INST
	movi r5, 2
	beq r15, r5, SECOND_INST
	movi r5, 3
	beq r15, r5, THIRD_INST
	br END

TITLE:
	movia r3, TITLE_SCREEN
	add r23, r23, r3
	br VGA_SETUP
FIRST_INST:
	movia r3, FIRST_INST_SCREEN
	add r23, r23, r3
	br VGA_SETUP
SECOND_INST:
	movia r3, SECOND_INST_SCREEN
	add r23, r23, r3
	br VGA_SETUP
THIRD_INST:
	movia r3, THIRD_INST_SCREEN
	add r23, r23, r3

VGA_SETUP:
    movi r16, 0 # y max
    movi r17, 240 # y current
    movi r18, 320 # x max (added 1 to account for start at 1)
    movi r19, -1 # x current

OUTER:
    ble r17, r16, NEXT_POLL_SETUP:
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

NEXT_POLL_SETUP:
	movia r11, BUTTON_ACTION
    movia r12, WHICH_BUTTON
    movia r13, ADDR_PUSHBUTTON
    
    # enable interupts
    movi r8, 0b1111
	stwio r8, 0x8(r13)
	stwio r8, 0xc(r13)
    
    # enable Nios II interupts
    movi r8, 0b0010
    wrctl ctl3, r8
    movi r8, 1
    wrctl ctl0, r8
    
NEXT_POLL:
	# Poll for push button to be pressed
	ldw r9, 0(r11)
	andi r9, r9, 0b1
	beq r9, r0, NEXT_POLL
    
    # disable interupts
    movi r8, 0
    wrctl ctl0, r8

	# disable interupts
    movi r8, 0b0000
	stwio r8, 0x8(r13)
    
    # reset global vars
    stw r0, 0(r11)
    stw r0, 0(r12)
    
	addi r15, r15, 1
    br SCREEN_SELECT

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
