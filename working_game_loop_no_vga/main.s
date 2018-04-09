/*
 Basic Risk Gameplay:
 Limited to two players
*/

#.include "BoardSetup.s"

.section .text
.global _start

##########################
# ==== REGISTERS ====
# r16: player turn variable (player 1 = 0, player 2 = 1)
# r17:
# r18:
#
#
#
#
##########################

_start:
    movia sp, 0x04000000 # comment when running on board
    movi r16, 0  # player 1 goes first

MAIN:
    # setup main turn loop
    # r4 holds current player turn
    mov r4, r16
    # Executes main gameplay functionality
    call TURN_LOOP

    # No arguments sent, nothing returned. Based off switches
    # Displays selected territory info on seg7 displays
    #movia r4, T_1
    #call DISPLAY # used for testing
	
	#call VGA
    # No arguments needed
    # r2 returns 1 if game over else return 0
    # r3 returns winning player if r2 is 1

    call TEST_GAMEOVER

    # Branch to end if game is over
    bne r2, r0, END_GAME

    # switch player
    # call SWITCH_PLAYER
	beq r16, r0, MAKE_P2
    mov r16, r0
    br MAIN
    
MAKE_P2:    
    movi r16, 1
    br MAIN

END_GAME:
    # send Game_Over winning player
    mov r4, r3
    # Game_Over function implements different VGA
    # background depending on winner
    #call GAME_OVER
END:
    br END

.section .reset, "ax"
movia r2, _start
jmp r2

.section .exceptions, "ax"
.global EXCEPTION_HANDLER
EXCEPTION_HANDLER:
addi sp, sp, -20
stw r16, 0(sp)
stw r17, 4(sp)
stw r18, 8(sp)
stw ea, 12(sp)
stw ra, 16(sp)

rdctl r16, ctl4
andi r16, r16, 0b10
beq r16, r0, EPILOGUE
call PUSH_BUTTON_ISR

EPILOGUE:
ldw ra, 16(sp)
ldw ea, 12(sp)
ldw r18, 8(sp)
ldw r17, 4(sp)
ldw r16, 0(sp)
addi sp, sp, 20
addi ea, ea, -4
eret

.global PUSH_BUTTON_ISR
PUSH_BUTTON_ISR:
subi sp, sp, 20 
stw ra, 0(sp) 
stw r10, 4(sp) 
stw r11, 8(sp) 
stw r12, 12(sp) 
stw r13, 16(sp)

movia r10, 0xff200050 # pushbutton base address
# read and clear interupt
ldwio r11, 0xc(r10)
movi r13, 0b1111 #clears all buttons pushed
stwio r13, 0xc(r10)

movia r10, BUTTON_ACTION
movi r12, 1
stw r12, 0(r10)

movia r10, WHICH_BUTTON
andi r11, r11, 0b1111
stw r11, 0(r10)

ldw ra, 0(sp)
ldw r10, 4(sp)
ldw r11, 8(sp)
ldw r12, 12(sp) 
ldw r13, 16(sp) 
addi sp, sp, 20
ret