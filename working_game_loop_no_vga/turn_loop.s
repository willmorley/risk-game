.equ ADDR_PUSHBUTTON, 0xFF200050
.section .text
.global TURN_LOOP
TURN_LOOP:
	# store callee registers to stack
    addi sp, sp, -36
    stw ra, 0(sp)
    stw r16, 4(sp) # current territory pointer
    stw r17, 8(sp) #
    stw r18, 12(sp) # current player's turn
    stw r19, 16(sp)
    stw r20, 20(sp)
    stw r21, 24(sp)
    stw r22, 28(sp)
    stw r23, 32(sp)

	# r18 holds current player's turn
    mov r18, r4
    
    # start at first territory
    movia r16, T_1

SKIP_TO_OWNED:
	# update display
    mov r4, r16
    call DISPLAY
    # loop until player matches r18 (current player)
    ldw r17, 0(r16)
    srli r17, r17, 8
    andi r17, r17, 0b1
    beq r17, r18, TER_SELECT_POLL_SETUP # may need to change to draw subroutine
NEXT_TER:    
    # move to next territory and try again
    mov r4, r16
    call NEXT_TERRITORY
    mov r16, r2
    br SKIP_TO_OWNED
    
    # highlight that territory
    
TER_SELECT_POLL_SETUP:
 	# 0: go to next province
    # 2: go to next stage (ARMY_SELECT)
    # TODO: make 1 go to previous province
    mov r4, r16
    call DISPLAY
    mov r4, r16
	call VGA
	movia r11, BUTTON_ACTION #r19
    movia r12, WHICH_BUTTON #r20
    movia r13, ADDR_PUSHBUTTON #r21
    
    # enable interupts
    movi r8, 0b101
	stwio r8, 0x8(r13)
    movi r8, 0b1111
	stwio r8, 0xc(r13)
    
    # enable Nios II interupts
    movi r8, 0b0010
    wrctl ctl3, r8
    movi r8, 1
    wrctl ctl0, r8
    
TER_SELECT_POLL:
	# Poll for push button 0/2 to be pressed
	ldw r9, 0(r11)
	andi r9, r9, 0b1
	beq r9, r0, TER_SELECT_POLL
    
    # disable interupts
    movi r8, 0
    wrctl ctl0, r8
    
    # reset global vars and get which button was pressed
    stw r0, 0(r11)
	ldw r9, 0(r12) # button pressed is stored in r9
    stw r0, 0(r12)
    
    # check for go to next province
    andi r10, r9, 0b001
    bne r10, r0, NEXT_TER
    andi r10, r9, 0b100
    bne r10, r0, ARMY_SELECT_PREP # TODO: add armysize 0/1 check
    br TER_SELECT_POLL_SETUP
    
ARMY_SELECT_PREP:
	#not sure if I need this

ARMY_SELECT:
	# r17: number of selected troops (default to 1)
    movi r17, 1
    # r19: number of available troops
    ldw r19, 0(r16)
    srli r19, r19, 16
    
    # poll buttons 0/1 to add/subtract selected army
    # poll button 2 to continue to next stage
    # TODO: use ps/2 keyboard to select army size
    
ARMY_POLL_SETUP:
    # setup pointers to global vars
	movia r11, BUTTON_ACTION
    movia r12, WHICH_BUTTON
    movia r13, ADDR_PUSHBUTTON
	movia r14, 0xff200000
    stwio r17, 0(r14)
    # enable interupts
    movi r8, 0b111
	stwio r8, 0x8(r13)
    movi r8, 0b1111
	stwio r8, 0xc(r13)
    
    # enable Nios II interupts
    movi r8, 0b0010
    wrctl ctl3, r8
    movi r8, 1
    wrctl ctl0, r8
    
ARMY_POLL:
	ldw r9, 0(r11)
	andi r9, r9, 0b1
	beq r9, r0, ARMY_POLL

	movia r14, 0xff200000
    stwio r17, 0(r14)
    
    # disable interupts
    movi r8, 0
    wrctl ctl0, r8
    
    # reset global vars and get which button was pressed
    stw r0, 0(r11)
	ldw r9, 0(r12) # button pressed is stored in r9
    stw r0, 0(r12)
    
    # check for add or subract or continue
    andi r10, r9, 0b001
    bne r10, r0, ADD_ARMY
    andi r10, r9, 0b010
    bne r10, r0, MINUS_ARMY
    andi r10, r9, 0b100
    bne r10, r0, ADJACENT_SELECT
    br ARMY_POLL_SETUP
    
ADD_ARMY:
	# check size limit
    subi r8, r19, 1
    bge r17, r8, ARMY_POLL_SETUP
	# if possible, add one to the selected army
    addi r17, r17, 1
    br ARMY_POLL_SETUP
    # update display

MINUS_ARMY:
    # ensure not smaller than 1
    movi r8, 1
    ble r17, r8, ARMY_POLL_SETUP
    # if not, subtract one from the selected army
	addi r17, r17, -1
    br ARMY_POLL_SETUP
    # update display
    
ADJACENT_SELECT:
	# read first adjacent province
    # use counter to cycle through
    movi r20, 4
    add r8, r20, r16
   	ldw r19, 0(r8)

	movia r14, 0xff200000
    stwio r17, 0(r14)
        
ADJACENT_POLL_SETUP:
	# update display with that province
    mov r4, r19
    call DISPLAY
    mov r4, r19
	call VGA
    
    # setup pointers to global vars
	movia r11, BUTTON_ACTION
    movia r12, WHICH_BUTTON
    movia r13, ADDR_PUSHBUTTON
    
    # enable interupts
    movi r8, 0b101
	stwio r8, 0x8(r13)
    movi r8, 0b1111
	stwio r8, 0xc(r13)
    
    # enable Nios II interupts
    movi r8, 0b0010
    wrctl ctl3, r8
    movi r8, 1
    wrctl ctl0, r8
    
ADJACENT_POLL:	
	# poll for buttons 0/2 (next province/select province)
	ldw r9, 0(r11)
	andi r9, r9, 0b1
	beq r9, r0, ADJACENT_POLL
    
    # disable interupts
    movi r8, 0
    wrctl ctl0, r8
    
    # reset global vars and get which button was pressed
    stw r0, 0(r11)
	ldw r9, 0(r12) # button pressed is stored in r9
    stw r0, 0(r12)
    
    # check for add or subract or continue
    andi r10, r9, 0b001
    bne r10, r0, NEXT_ADJACENT
    andi r10, r9, 0b100
    bne r10, r0, CHECK_OWNERSHIP
    br ADJACENT_POLL_SETUP
    
NEXT_ADJACENT:
	# move pointer to next province in list
    addi r20, r20, 4
    # check if 0, go back to first one if 0
    add r8, r20, r16
	ldw r19, 0(r8)
    bne r19, r0, ADJACENT_POLL_SETUP
    
    movi r20, 4
    add r8, r20, r16
   	ldw r19, 0(r8)
    # update display with that province
    
    br ADJACENT_POLL_SETUP
    
CHECK_OWNERSHIP:
	# check who owns the selected territory
    ldw r20, 0(r19)
    srli r20, r20, 8
    andi r20, r20, 1
    
    # if equal to same player
    beq r20, r18, SAME_PLAYER
    br OTHER_PLAYER
SAME_PLAYER:
    # same player, move troops to adj territory
    
 	# get selected ter army count
    # sub r17 from that and write back to that ter (NOTE: CAREFUL MASKING) 
    ldw r8, 0(r16)
    andi r9, r8, 0xffff
    srli r8, r8, 16
    sub r8, r8, r17
    slli r8, r8, 16
    add r8, r8, r9
    stw r8, 0(r16)
    
    # get adj ter army count
    # add r17 to that and write that value to adj ter (NOTE: CAREFUL MASKING)
    ldw r8, 0(r19)
    andi r9, r8, 0xffff
    srli r8, r8, 16
    add r8, r8, r17
    slli r8, r8, 16
    add r8, r8, r9
    stw r8, 0(r19)
    
    br GAME_LOOP_EPILOGUE # this would be where you can make multiple moves per turn
    
OTHER_PLAYER:
    # other player, call attack subroutine
    # attack logic setup
    
    # r4 will hold attacking army size
    mov r4, r17
    # r5 will hold pointer to territory being attacked
    mov r5, r19
    
    call ATTACK_LOGIC
    # r2 will hold failed/success (0/1)
    # r3 on failed will hold defensive troops lost
    # r3 on success will hold offensive troops remaining
    
    
    # based on outcome, edit ownership and army counts of selected (r16) and adj (r19)
 	beq r2, r0, FAILED_ATTACK

 SUCCESSFUL_ATTACK:
    # get selected ter army count
    # sub r17 from that and write back to that ter (NOTE: CAREFUL MASKING) 
    ldw r8, 0(r16)
    andi r9, r8, 0xffff
    srli r8, r8, 16
    sub r8, r8, r17
    slli r8, r8, 16
    add r8, r8, r9
    stw r8, 0(r16)
    
    # change attacking territory ownership
    # place resulting troops in it (NOTE: CAREFUL MASKING)
    ldw r8, 0(r19)
    andi r9, r8, 0xff
   	slli r10, r18, 8
    add r9, r10, r9  
    mov r8, r3
    slli r8, r8, 16
    add r8, r8, r9
    stw r8, 0(r19)
    
    br GAME_LOOP_EPILOGUE
     
FAILED_ATTACK:
    
    # get selected ter army count
    # sub r17 from that and write back to that ter (NOTE: CAREFUL MASKING) 
    ldw r8, 0(r16)
    andi r9, r8, 0xffff
    srli r8, r8, 16
    sub r8, r8, r17
    slli r8, r8, 16
    add r8, r8, r9
    stw r8, 0(r16)
    
    # get adj ter army count
    # sub r3 from that and write that value to adj ter (NOTE: CAREFUL MASKING)
    ldw r8, 0(r19)
    andi r9, r8, 0xffff
    srli r8, r8, 16
    sub r8, r8, r3
    slli r8, r8, 16
    add r8, r8, r9
    stw r8, 0(r19) 
    
    br GAME_LOOP_EPILOGUE # this would be where you can make multiple moves per turn

GAME_LOOP_EPILOGUE:
	mov r4, r0
	call VGA
	movia r14, 0xff200000
    stwio r0, 0(r14)    
    ldw ra, 0(sp)
    ldw r16, 4(sp)
    ldw r17, 8(sp)
    ldw r18, 12(sp)
    ldw r19, 16(sp)
    ldw r20, 20(sp)
    ldw r21, 24(sp)
    ldw r22, 28(sp)
    ldw r23, 32(sp)
	addi sp, sp, 36
ret
  
NEXT_TERRITORY:
	# r4 points to current territory
	addi sp, sp, -4
    stw r16, 0(sp)
    addi r4, r4, 4
    
INCREMENT_TO_NEXT:    
    # r4 is incremented to cycle through territory struct
    ldw r16, 0(r4)
    addi r4, r4, 4
	beq r16, r0, NEXT_ONE
    br INCREMENT_TO_NEXT
    
NEXT_ONE:
	ldw r2, 0(r4) # returns address of next variable
    ldw r16, 0(sp)
  	addi sp, sp, 4
ret

ATTACK_LOGIC: 
	# get army count of defending territory
   	ldw r8, 0(r5)
    srli r8, r8, 16
    
    # attack only succeeds if attacker has more troops
    # attack goes "perfectly" if defender has no troops
    beq r8, r0, NO_TROOPS
    ble r4, r8, ATTACK_FAILURE 
    
ATTACK_SUCCESS:
	movi r2, 1 # signifies successful attack
    # defender loses everything
    # attacker loses defender's troop count minus attacker/defender troops
	div r9, r4, r8
    sub r9, r8, r9
    sub r3, r4, r9
	br LOGIC_EPILOGUE
    
    
ATTACK_FAILURE:
	mov r2, r0 # signifies failed attack
    # attacker loses everything
    # defender loses attacker's troops - 10% - 1
	movi r10, 10
	divu r9, r4, r10
    sub r9, r4, r9
    subi r9, r9, 1
    
    mov r3, r9
	br LOGIC_EPILOGUE

NO_TROOPS:
	movi r2, 1 # signifies successful attack
    mov r3, r4 # attacker loses no troops

LOGIC_EPILOGUE:
ret
