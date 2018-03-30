.section .text
.global _start

_start:
    movia r4, T_1
    addi sp, r0, 0x1000
    call DISPLAY
END:
    br END
