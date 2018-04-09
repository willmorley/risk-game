.equ LED_BASE,      0xFF200000
.equ HEX3_0_BASE,   0xFF200020
.equ HEX5_4_BASE,   0xFF200030
.equ SW_BASE,       0xFF200040

.section .text # comment this when using simulator
.global DISPLAY
DISPLAY:
    # store registers to stack
    addi sp, sp, -24
    stw r16, 0(sp) # hex3-0 addr
    stw r17, 4(sp) # Sw register
    stw r18, 8(sp) # final converted value
    # registers for preparing displayed values
    stw r19, 12(sp)
    stw r20, 16(sp)
    stw r21, 20(sp)

    # format values
SWITCH_READ:/*
    movia r17, SW_BASE
    ldwio r4, 0(r17)
    mov r19, r0
    movi r19, 7 # 
    bge r4, r19, LIMIT_DISPLAY
    slli r4, r4, 2
    andi r4, r4, 0b111111111
    mov r19, r0
    ldw r4, SWITCH_PAIR(r4)
*/
FIVE_FOUR:
    ldw r19, 0(r4)
    andi r20, r19, 0b11111111
    ldbu r21, HEX_PATTERNS(r20)

    slli r18, r21, 8

    srli r20, r19, 8
    andi r20, r20, 0b11111111
    mov r21, r0
    ldbu r21, HEX_PATTERNS(r20)

    or r18, r18, r21

    movia r16, HEX5_4_BASE
    stwio r18, 0(r16)

THREE_ZERO:

    srli r20, r19, 16
    andi r20, r20, 0b11111111
    ldbu r21, HEX_PATTERNS(r20)

    slli r18, r21, 24

    ldw r19, 4(r4)
    ldw r20, 0(r19)
    andi r20, r20, 0b11111111
    ldbu r21, HEX_PATTERNS(r20)

    slli r21, r21, 16

    or r18, r21, r18

    ldw r19, 8(r4)
    ldw r20, 0(r19)
    andi r20, r20, 0b11111111
    ldbu r21, HEX_PATTERNS(r20)

    slli r21, r21, 8

    or r18, r18, r21

    ldw r19, 12(r4)
    ldw r20, 0(r19)
    andi r20, r20, 0b11111111
    ldbu r21, HEX_PATTERNS(r20)

    or r18, r18, r21


    movia r16, HEX3_0_BASE
    stwio r18, 0(r16)
    # Load to memory

    # restore registers from stack
    ldw r16, 0(sp)
    ldw r17, 4(sp)
    ldw r18, 8(sp)
    ldw r19, 12(sp)
    ldw r20, 16(sp)
    ldw r21, 20(sp)
    addi sp, sp, 24
ret

LIMIT_DISPLAY:
    movia r4, T_1
    mov r19, r0
    br FIVE_FOUR