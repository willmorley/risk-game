.equ HEX3_0_BASE, 0xFF200020
.equ HEX5_4_BASE, 0xFF200030
.equ LED_BASE, 0xFF200000

.text
.global DISPLAY
DISPLAY:
    # r4 is mem addr of element to display
    # store registers to stack
    addi sp, sp, -24
    stwio r16, 0(sp) # hex3-0 addr
    stwio r17, 4(sp) 
    stwio r18, 8(sp) # final converted value
    stwio r19, 12(sp)
    stwio r20, 16(sp)
    stwio r21, 20(sp)
    movia r16, HEX3_0_BASE
    # format values
FIVE_FOUR:
    ldwio r19, 0(r4) 
    srli r20, r19, 24
    ldbu r21, HEX_PATTERNS(r20)

    slli r18, r21, 8
    
    srli r20, r19, 16
    mov r21, r0
    ldbu r21, HEX_PATTERNS(r20)

    or r18, r18, r21

    movia r16, HEX5_4_BASE
    stwio r18, 0(r16)

THREE_ZERO:

    andi r20, r19, 0b11111111
    ldbu r21, HEX_PATTERNS(r20)
    
    slli r18, r21, 24
    
    ldwio r19, 4(r4)
    ldwio r20, 0(r19)
    srli r20, r20, 24
    ldbu r21, HEX_PATTERNS(r20) 

    slli r21, r21, 16

    or r18, r21, r18

    ldwio r19, 8(r4)
    ldwio r20, 0(r19)
    srli r20, r20, 24
    ldbu r21, HEX_PATTERNS(r20) 

    slli r21, r21, 16
    
    or r18, r18, r21

    ldwio r19, 12(r4)
    ldwio r20, 0(r19)
    srli r20, r20, 24
    ldbu r21, HEX_PATTERNS(r20) 

    slli r21, r21, 16
    
    or r18, r18, r21


    movia r16, HEX3_0_BASE
    stwio r18, 0(r16)
    # Load to memory

    # restore registers from stack
    ldwio r16, 0(sp)
    ldwio r17, 4(sp)
    ldwio r18, 8(sp)
    ldwio r19, 12(sp)
    ldwio r20, 16(sp)
    ldwio r21, 20(sp)
    addi sp, sp, 24
ret    

