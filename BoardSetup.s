.section .data
.align 2
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
