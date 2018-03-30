/*
 Basic Risk Gameplay:
 Limited to two players
*/

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
    addi sp, r0, 0x1000 # comment when running on board
    movi r16, 0  # player 1 goes first

MAIN:
    # setup main turn loop
    # r4 holds current player turn
    mov r4, r16
    # Executes main gameplay functionality
    call TURN_LOOP

    # No arguments sent, nothing returned. Based off switches
    # Displays selected territory info on seg7 displays
    call DISPLAY # used for testing

    # No arguments needed
    # r2 returns 1 if game over else return 0
    # r3 returns winning player if r2 is 1
    call TEST_GAMEOVER

    # Branch to end if game is over
    bne r2, r0, END_GAME

    # setup switch player arguments
    mov r4, r16
    # call switch player
    call SWITCH_PLAYER

    br MAIN

END_GAME:
    # send Game_Over winning player
    mov r4, r3
    # Game_Over function implements different VGA
    # background depending on winner
    call GAME_OVER
END:
    br END
