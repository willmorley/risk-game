.equ ADDR_VGA, 0x08000000
.equ OFFSET, 0x00000000

.align 2
# essentially behaves as though you had .byte .... [many many bytes declared]...
BACKGROUND:
    .incbin "background.bmp"

.text
.global _start
_start:
    movia r2,ADDR_VGA

    movui r4,0xffff  /* White pixel */
    sthio r4,1032(r2) /* pixel (4,1) is x*2 + y*1024 so (8 + 1024 = 1032) */

	movi r5, 240 # y max
    movi r6, 0 # y current
    movi r7, 320 # x max (added 1 to account for start at 1)
    movi r8, 0 # x current

OUTER:
	bge r6, r5, END
	addi r6, 1
    movi r8, 0
INNER:
	bge r8, r7, OUTER
    addi r8, 1

    mov r9, r0
    add r9, r6, r8
    addi r9, OFFSET #location of pixel information from .bmp file

    slli r10, r8, 2	#mulitply by 2
    slli r11, r6, 10 # multiply by 1024
    add r10, r10, r11

	ldhuio r4, BACKGROUND(r9)
    sthio r4, ADDR_VGA(r10)

    br INNER

END:
	br END
