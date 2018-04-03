.section .data
.align 2
.global T_1
.global T_2
.global T_3
.global T_4
.global T_5
.global T_6
.global HEX_PATTERNS
.global SWITCH_PAIR

T_1:
	.byte 1     # Terriotry number
	.byte 0     # Player number (0/1)
	.hword 3    # Army count
    # List of Adjacent provinces:
    .word T_2
    .word T_4
    .word 0     # End of province list
    .word T_2   # Pointer to next territory
T_2:
	.byte 2
	.byte 0
	.hword 1
    .word T_3
    .word T_5
    .word T_1
    .word 0
    .word T_3
T_3:
	.byte 3
	.byte 1
	.hword 0
    .word T_6
    .word T_2
    .word 0
    .word T_4
T_4:
	.byte 4
	.byte 0
	.hword 0
    .word T_5
    .word T_1
    .word 0
    .word T_5
T_5:
	.byte 5
	.byte 0
	.hword 0
    .word T_6
    .word T_4
    .word T_2
    .word 0
    .word T_6
T_6:
	.byte 6
	.byte 1
	.hword 4
    .word T_5
    .word T_3
    .word 0
    .word T_1   # Last Territory Loops back to beginning (T_1)

HEX_PATTERNS:
    .byte  0x3f           		/* 0 */
    .byte  0x06           		/* 1 */
    .byte  0x5b           		/* 2 */
    .byte  0x4f           		/* 3 */
    .byte  0x66           		/* 4 */
    .byte  0x6d           		/* 5 */
    .byte  0x7d           		/* 6 */
    .byte  0x07           		/* 7 */
    .byte  0xff           		/* 8 */
    .byte  0x6f           		/* 9 */
    .byte  0x77           		/* A */
    .byte  0xfc           		/* B */
    .byte  0x39           		/* C */
    .byte  0x5e           		/* D */
    .byte  0xf9           		/* E */
    .byte  0xf1           		/* F */

SWITCH_PAIR:
	.word T_1
    .word T_1
    .word T_2
    .word T_3
    .word T_4
    .word T_5
    .word T_6
