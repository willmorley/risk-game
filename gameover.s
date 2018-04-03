.text
.global TEST_GAMEOVER

TEST_GAMEOVER:
	addi sp, sp, -20
    stw r16,  0(sp) # Player 1's counter
    stw r17,  4(sp) # Player 2's counter
    stw r18,  8(sp) # End of loop address
    stw r19, 12(sp) # pointer to correct memory
    stw r20, 16(sp) # store current player bit

    #initialize registers
    mov r16, r0
    mov r17, r0
    movia r18, T_1
    movia r19, T_1

CHECK_PLAYER:
	ldw r20, 0(r19) # get player word
    # expose player bit
    srli r20, r20, 8
    andi r20, r20, 1

    # Go to relevent player
    beq r20, r0, PLAYER_1_ADD
    br PLAYER_2_ADD

# Increment player 1's counter
PLAYER_1_ADD:
	addi r16, r16, 1
	br LOOP_TO_NEXT

# Increment player 2's counter
PLAYER_2_ADD:
	addi r17, r17, 1
	br LOOP_TO_NEXT

# Set r19 to next territory
LOOP_TO_NEXT:
	ldw r20, 4(r19)
    beq r20, r0, INCREMENT_AND_CONT
    addi r19, r19, 4
    br LOOP_TO_NEXT

# Check if end of list is reached. Either continue or go to game logic
INCREMENT_AND_CONT:
	ldw r19, 8(r19)	# r19 points to next territory
    beq r19, r18, GAMEOVER_LOGIC
    br CHECK_PLAYER

# Check if either player counter is equal to zero
# If yes: other player wins
# If no: game continues
GAMEOVER_LOGIC:
	beq r16, r0, GAME_ENDS_P2_WINS
    beq r17, r0, GAME_ENDS_P1_WINS
	# otherwise fall through to GAME_CONTINUES

# Set registers as required by main.s
GAME_CONTINUES:
	mov r2, r0
    br CLEANUP

# Set registers as required by main.s
GAME_ENDS_P1_WINS:
	movi r2, 1
    mov r3, r0
    br CLEANUP

# Set registers as required by main.s
GAME_ENDS_P2_WINS:
	movi r2, 1
	movi r3, 1
    br CLEANUP

# Restore registers, clear stack, and return
CLEANUP:
    ldw r16,  0(sp)
    ldw r17,  4(sp)
    ldw r18,  8(sp)
    ldw r19, 12(sp)
    ldw r20, 16(sp)
	addi sp, sp, 20
ret
