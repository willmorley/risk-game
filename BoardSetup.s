.section .data
.align 2

.global HEX_PATTERNS
.global SWITCH_PAIR

.global T_1
.global T_2
.global T_3
.global T_4
.global T_5
.global T_6
.global T_7
.global T_8
.global T_9
.global T_10
.global T_11
.global T_12
.global T_13
.global T_14
.global T_15
.global T_16
.global T_17
.global T_18
.global T_19
.global T_20
.global T_21
.global T_22
.global T_23
.global T_24
.global T_25
.global T_26
.global T_27
.global T_28
.global T_29
.global T_30
.global T_31
.global T_32
.global T_33
.global T_34
.global T_35
.global T_36
.global T_37
.global T_38
.global T_39
.global T_40
.global T_41
.global T_42
.global T_43

T_1:
	.byte 1     # Terriotry number
	.byte 0     # Player number (0/1)
	.hword 0    # Army count
    # List of Adjacent provinces:
    .word T_2
    .word T_5
    .word T_31
    .word 0     # End of province list
    .word T_2   # Pointer to next territory
T_2:
	.byte 2
	.byte 0
	.hword 0
    .word T_3
    .word T_6
    .word T_5
    .word T_1
    .word 0
    .word T_3
T_3:
	.byte 3
	.byte 0
	.hword 0
    .word T_4
    .word T_6
    .word T_2
    .word 0
    .word T_4
T_4:
	.byte 4
	.byte 0
	.hword 0
    .word T_15
    .word T_7
    .word T_3
    .word 0
    .word T_5
T_5:
	.byte 5
	.byte 0
	.hword 0
    .word T_6
    .word T_8
    .word T_1
    .word T_2
    .word 0
    .word T_6
T_6:
	.byte 6
	.byte 0
	.hword 0
    .word T_7
    .word T_9
    .word T_8
    .word T_5
    .word T_2
    .word T_3
    .word 0
    .word T_7
T_7:
    .byte 7
    .byte 0
    .hword 0
    .word T_4
    .word T_9
    .word T_6
    .word 0
    .word T_8
T_8:
    .byte 8
    .byte 0
    .hword 0
    .word T_9
    .word T_10
    .word T_5
    .word T_6
    .word 0
    .word T_9
T_9:
    .byte 9
    .byte 0
    .hword 0
    .word T_7
    .word T_10
    .word T_8
    .word T_6
    .word 0
    .word T_10
T_10:
    .byte 10
    .byte 1
    .hword 1
    .word T_9
    .word T_11
    .word T_8
    .word 0
    .word T_11
T_11:
    .byte 11
    .byte 1
    .hword 1
    .word T_13
    .word T_12
    .word T_10
    .word 0
    .word T_12
T_12:
    .byte 12
    .byte 1
    .hword 1
    .word T_13
    .word T_14
    .word T_11
    .word 0
    .word T_13
T_13:
    .byte 13
    .byte 1
    .hword 1
    .word T_22
    .word T_14
    .word T_12
    .word T_11
    .word 0
    .word T_14
T_14:
    .byte 14
    .byte 1
    .hword 1
    .word T_13
    .word T_12
    .word 0
    .word T_15
T_15:
    .byte 15
    .byte 1
    .hword 1
    .word T_16
    .word T_17
    .word T_4
    .word 0
    .word T_16
T_16:
    .byte 16
    .byte 1
    .hword 1
    .word T_19
    .word T_18
    .word T_17
    .word T_15
    .word 0
    .word T_17
T_17:
    .byte 17
    .byte 1
    .hword 1
    .word T_16
    .word T_18
    .word T_20
    .word T_15
    .word 0
    .word T_18
T_18:
    .byte 18
    .byte 1
    .hword 1
    .word T_19
    .word T_21
    .word T_20
    .word T_17
    .word T_16
    .word 0
    .word T_19
T_19:
    .byte 19
    .byte 1
    .hword 1
    .word T_28
    .word T_33
    .word T_37
    .word T_21
    .word T_18
    .word T_16
    .word 0
    .word T_20
T_20:
    .byte 20
    .byte 0
    .hword 2
    .word T_18
    .word T_21
    .word T_22
    .word T_17
    .word 0
    .word T_21
T_21:
    .byte 21
    .byte 0
    .hword 2
    .word T_19
    .word T_37
    .word T_23
    .word T_22
    .word T_20
    .word T_18
    .word 0
    .word T_22
T_22:
    .byte 22
    .byte 0
    .hword 2
    .word T_23
    .word T_25
    .word T_24
    .word T_13
    .word T_20
    .word T_21
    .word 0
    .word T_23
T_23:
    .byte 23
    .byte 0
    .hword 2
    .word T_37
    .word T_25
    .word T_22
    .word T_21
    .word 0
    .word T_24
T_24:
    .byte 24
    .byte 0
    .hword 2
    .word T_25
    .word T_26
    .word T_22
    .word 0
    .word T_25
T_25:
    .byte 25
    .byte 0
    .hword 2
    .word T_37
    .word T_27
    .word T_26
    .word T_24
    .word T_22
    .word T_23
    .word 0
    .word T_26
T_26:
    .byte 26
    .byte 0
    .hword 2
    .word T_27
    .word T_24
    .word T_25
    .word 0
    .word T_27
T_27:
    .byte 27
    .byte 0
    .hword 2
    .word T_26
    .word T_25
    .word 0
    .word T_28
T_28:
    .byte 28
    .byte 0
    .hword 2
    .word T_29
    .word T_34
    .word T_33
    .word T_19
    .word 0
    .word T_29
T_29:
    .byte 29
    .byte 0
    .hword 2
    .word T_30
    .word T_32
    .word T_35
    .word T_34
    .word T_28
    .word 0
    .word T_30 
T_30:
    .byte 30
    .byte 1
    .hword 3
    .word T_31
    .word T_32
    .word T_29
    .word 0
    .word T_31
T_31:
    .byte 31
    .byte 1
    .hword 3
    .word T_1
    .word T_36
    .word T_35
    .word T_32
    .word T_30
    .word 0
    .word T_32
T_32:
    .byte 32
    .byte 1
    .hword 3
    .word T_31
    .word T_35
    .word T_29
    .word T_30
    .word 0
    .word T_33
T_33:
    .byte 33
    .byte 1
    .hword 3
    .word T_28
    .word T_34
    .word T_38
    .word T_37
    .word T_19
    .word 0
    .word T_34
T_34:
    .byte 34
    .byte 1
    .hword 3
    .word T_35
    .word T_39
    .word T_38
    .word T_33
    .word T_28
    .word T_29
    .word 0
    .word T_35
T_35:
    .byte 35
    .byte 1
    .hword 3
    .word T_31
    .word T_36
    .word T_34
    .word T_29
    .word T_32
    .word 0
    .word T_36
T_36:
    .byte 36
    .byte 1
    .hword 3
    .word T_35
    .word T_31
    .word 0
    .word T_37
T_37:
    .byte 37
    .byte 1
    .hword 3
    .word T_33
    .word T_38
    .word T_25
    .word T_23
    .word T_21
    .word T_19
    .word 0
    .word T_38
T_38:
    .byte 38
    .byte 1
    .hword 3
    .word T_34
    .word T_39
    .word T_37
    .word T_33
    .word 0
    .word T_39
T_39:
    .byte 39
    .byte 1
    .hword 3
    .word T_34
    .word T_40
    .word T_38
    .word 0
    .word T_40
T_40:
    .byte 40
    .byte 0
    .hword 4
    .word T_41
    .word T_42
    .word T_39
    .word 0
    .word T_41
T_41:
    .byte 41
    .byte 0
    .hword 4
    .word T_43
    .word T_42
    .word T_40
    .word 0
    .word T_42
T_42:
    .byte 42
    .byte 0
    .hword 4
    .word T_43
    .word T_40
    .word T_41
    .word 0
    .word T_43
T_43:
    .byte 43
    .byte 0
    .hword 4
    .word T_42
    .word T_41
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
