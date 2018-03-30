.equ ADDR_VGA, 0x08000000
.equ OFFSET, 0x0000008A
.align 2

.section .data
# essentially behaves as though you had .byte .... [many many bytes declared]...
BACKGROUND:
    .incbin "background.bmp"

.section .text
.global _start
_start:
    movia r2,ADDR_VGA
	
	movi r5, 240 # y max
    movi r6, -1 # y current
    movi r7, 320 # x max (added 1 to account for start at 1)
    movi r8, -1 # x current
	movi r12, OFFSET
	addi r12, r12, 30720
	addi r12, r12, 30720
	addi r12, r12, 30720
	addi r12, r12, 30720
	addi r12, r12, 30720
OUTER:
	bge r6, r5, END
	addi r6, r6, 1
    movi r8, -1
INNER:
	bge r8, r7, OUTER
    addi r8, r8, 1
	addi r12, r12, -2 
/*
    mov r9, r0
    add r9, r6, r8
	slli r9, r9, 1
    addi r9, r9, OFFSET #location of pixel information from .bmp file
*/
    slli r10, r8, 1	#mulitply by 2
    slli r11, r6, 10 # multiply by 1024
    add r10, r10, r11
    movi r11, 0x8
    slli r11, r11, 24
    add r10, r10, r11

	ldhu r4, BACKGROUND(r12)
    sthio r4, 0(r10)

    br INNER

END:
	br END