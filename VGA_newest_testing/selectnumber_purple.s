.section .data
.align 2

# numbers are 3x5
PURPLE0:
   .incbin "purple0.bmp"
PURPLE1:
   .incbin "purple1.bmp"
PURPLE2:
   .incbin "purple2.bmp"
PURPLE3:
   .incbin "purple3.bmp"
PURPLE4:
   .incbin "purple4.bmp"
PURPLE5:
   .incbin "purple5.bmp"
PURPLE6:
   .incbin "purple6.bmp"
PURPLE7:
   .incbin "purple7.bmp"
PURPLE8:
   .incbin "purple8.bmp"
PURPLE9:
   .incbin "purple9.bmp"

.section .text
.global SELECT_PURPLE_T_NUMBER

SELECT_PURPLE_T_NUMBER:
# reg save
	addi sp, sp, -24
	stw ra, 0(sp)
	stw r16, 4(sp)
	stw r17, 8(sp)
	stw r18, 12(sp)
	stw r19, 16(sp)
	stw r20, 20(sp)

	# number in: r4
	mov r5, r0
	beq r4, r5, END # should never happen
	addi r5, r5, 1

	beq r4, r5, POS_T_1
	addi r5, r5, 1

	beq r4, r5, POS_T_2
	addi r5, r5, 1

	beq r4, r5, POS_T_3
	addi r5, r5, 1

	beq r4, r5, POS_T_4
	addi r5, r5, 1

	beq r4, r5, POS_T_5
	addi r5, r5, 1

	beq r4, r5, POS_T_6
	addi r5, r5, 1

	beq r4, r5, POS_T_7
	addi r5, r5, 1

	beq r4, r5, POS_T_8
	addi r5, r5, 1

	beq r4, r5, POS_T_9
	addi r5, r5, 1

	beq r4, r5, POS_T_10
	addi r5, r5, 1

	beq r4, r5, POS_T_11
	addi r5, r5, 1

	beq r4, r5, POS_T_12
	addi r5, r5, 1

	beq r4, r5, POS_T_13
	addi r5, r5, 1

	beq r4, r5, POS_T_14
	addi r5, r5, 1

	beq r4, r5, POS_T_15
	addi r5, r5, 1

	beq r4, r5, POS_T_16
	addi r5, r5, 1

	beq r4, r5, POS_T_17
	addi r5, r5, 1

	beq r4, r5, POS_T_18
	addi r5, r5, 1

	beq r4, r5, POS_T_19
	addi r5, r5, 1

	beq r4, r5, POS_T_20
	addi r5, r5, 1

	beq r4, r5, POS_T_21
	addi r5, r5, 1

	beq r4, r5, POS_T_22
	addi r5, r5, 1

	beq r4, r5, POS_T_23
	addi r5, r5, 1

	beq r4, r5, POS_T_24
	addi r5, r5, 1

	beq r4, r5, POS_T_25
	addi r5, r5, 1

	beq r4, r5, POS_T_26
	addi r5, r5, 1

	beq r4, r5, POS_T_27
	addi r5, r5, 1

	beq r4, r5, POS_T_28
	addi r5, r5, 1

	beq r4, r5, POS_T_29
	addi r5, r5, 1

	beq r4, r5, POS_T_30
	addi r5, r5, 1

	beq r4, r5, POS_T_31
	addi r5, r5, 1

	beq r4, r5, POS_T_32
	addi r5, r5, 1

	beq r4, r5, POS_T_33
	addi r5, r5, 1

	beq r4, r5, POS_T_34
	addi r5, r5, 1

	beq r4, r5, POS_T_35
	addi r5, r5, 1

	beq r4, r5, POS_T_36
	addi r5, r5, 1

	beq r4, r5, POS_T_37
	addi r5, r5, 1

	beq r4, r5, POS_T_38
	addi r5, r5, 1

	beq r4, r5, POS_T_39
	addi r5, r5, 1

	beq r4, r5, POS_T_40
	addi r5, r5, 1

	beq r4, r5, POS_T_41
	addi r5, r5, 1

	beq r4, r5, POS_T_42
	addi r5, r5, 1

	beq r4, r5, POS_T_43

ARMY_COUNT_GET:
	# r19 store word
	# r18 store ter.
	ldw r19, 0(r18)
	srli r19, r19, 16
	br COLOUR_GET

COLOUR_GET:
	# r20 player numebr
	ldw r20, 0(r18)
	srli r20, r20, 8
	andi r20, r20, 1

PURPLE_OR_PURPLE:
	beq r20, r0, SELECT_PURPLE_NUMBERS

SELECT_PURPLE_NUMBERS:
	mov r3, r0
	beq r19, r3, DRAW_PURPLE0
	addi r3, r3, 1	

	beq r19, r3, DRAW_PURPLE1
	addi r3, r3, 1	

	beq r19, r3, DRAW_PURPLE2
	addi r3, r3, 1	

	beq r19, r3, DRAW_PURPLE3
	addi r3, r3, 1	
	
	beq r19, r3, DRAW_PURPLE4
	addi r3, r3, 1	

	beq r19, r3, DRAW_PURPLE5
	addi r3, r3, 1	

	beq r19, r3, DRAW_PURPLE6
	addi r3, r3, 1	
	
	beq r19, r3, DRAW_PURPLE7
	addi r3, r3, 1	

	beq r19, r3, DRAW_PURPLE8
	addi r3, r3, 1	

	beq r19, r3, DRAW_PURPLE9
	addi r3, r3, 1	

	subi r19, r19, 10
	br SELECT_PURPLE_NUMBERS

POS_T_1:
	movi r16, 22 # x
	slli r16, r16, 1
	movi r17, 58 # y
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_1
	br ARMY_COUNT_GET
POS_T_2:
	movi r16, 46 # x
	slli r16, r16, 1
	movi r17, 58 # y
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_2
	br ARMY_COUNT_GET
POS_T_3:
	movi r16, 69 # x
	slli r16, r16, 1
	movi r17, 58 # y
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_3
	br ARMY_COUNT_GET
POS_T_4:
	movi r16, 116 # x
	slli r16, r16, 1
	movi r17, 35 # y
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_4
	br ARMY_COUNT_GET
POS_T_5:
	movi r16, 51
	slli r16, r16, 1
	movi r17, 79
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_5
	br ARMY_COUNT_GET
POS_T_6:
	movi r16, 70
	slli r16, r16, 1
	movi r17, 79
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_6
	br ARMY_COUNT_GET
POS_T_7:
	movi r16, 90
	slli r16, r16, 1
	movi r17, 79
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_7
	br ARMY_COUNT_GET
POS_T_8:
	movi r16, 54
	slli r16, r16, 1
	movi r17, 100
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_8
	br ARMY_COUNT_GET
POS_T_9:
	movi r16, 74
	slli r16, r16, 1
	movi r17, 105
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_9
	br ARMY_COUNT_GET
POS_T_10:
	movi r16, 63
	slli r16, r16, 1
	movi r17, 126
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_10
	br ARMY_COUNT_GET
POS_T_11:
	movi r16, 89
	slli r16, r16, 1
	movi r17, 146
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_11
	br ARMY_COUNT_GET
POS_T_12:
	movi r16, 91
	slli r16, r16, 1
	movi r17, 173
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_12
	br ARMY_COUNT_GET
POS_T_13:
	movi r16, 106
	slli r16, r16, 1
	movi r17, 166
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_13
	br ARMY_COUNT_GET
POS_T_14:
	movi r16, 94
	slli r16, r16, 1
	movi r17, 198
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_14
	br ARMY_COUNT_GET
POS_T_15:
	movi r16, 134
	slli r16, r16, 1
	movi r17, 58
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_15
	br ARMY_COUNT_GET
POS_T_16:
	movi r16, 159
	slli r16, r16, 1
	movi r17, 64
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_16
	br ARMY_COUNT_GET
POS_T_17:
	movi r16, 145
	slli r16, r16, 1
	movi r17, 76
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_17
	br ARMY_COUNT_GET
POS_T_18:
	movi r16, 161
	slli r16, r16, 1
	movi r17, 83
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_18
	br ARMY_COUNT_GET
POS_T_19:
	movi r16, 180
	slli r16, r16, 1
	movi r17, 76
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_19
	br ARMY_COUNT_GET
POS_T_20:
	movi r16, 150
	slli r16, r16, 1
	movi r17, 91
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_20
	br ARMY_COUNT_GET
POS_T_21:
	movi r16, 167
	slli r16, r16, 1
	movi r17, 93
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_21
	br ARMY_COUNT_GET
POS_T_22:
	movi r16, 149
	slli r16, r16, 1
	movi r17, 131
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_22
	br ARMY_COUNT_GET
POS_T_23:
	movi r16, 168
	slli r16, r16, 1
	movi r17, 120
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_23
	br ARMY_COUNT_GET
POS_T_24:
	movi r16, 167
	slli r16, r16, 1
	movi r17, 156
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_24
	br ARMY_COUNT_GET
POS_T_25:
	movi r16, 179
	slli r16, r16, 1
	movi r17, 144
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_25
	br ARMY_COUNT_GET
POS_T_26:
	movi r16, 169
	slli r16, r16, 1
	movi r17, 183
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_26
	br ARMY_COUNT_GET
POS_T_27:
	movi r16, 188
	slli r16, r16, 1
	movi r17, 179
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_27
	br ARMY_COUNT_GET
POS_T_28:
	movi r16, 206
	slli r16, r16, 1
	movi r17, 66
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_28
	br ARMY_COUNT_GET
POS_T_29:
	movi r16, 229
	slli r16, r16, 1
	movi r17, 55
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_29
	br ARMY_COUNT_GET
POS_T_30:
	movi r16, 253
	slli r16, r16, 1
	movi r17, 55
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_30
	br ARMY_COUNT_GET
POS_T_31:
	movi r16, 284
	slli r16, r16, 1
	movi r17, 55
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_31
	br ARMY_COUNT_GET
POS_T_32:
	movi r16, 243
	slli r16, r16, 1
	movi r17, 76
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_32
	br ARMY_COUNT_GET
POS_T_33:
	movi r16, 205
	slli r16, r16, 1
	movi r17, 92
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_33
	br ARMY_COUNT_GET
POS_T_34:
	movi r16, 233
	slli r16, r16, 1
	movi r17, 108
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_34
	br ARMY_COUNT_GET
POS_T_35:
	movi r16, 246
	slli r16, r16, 1
	movi r17, 92
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_35
	br ARMY_COUNT_GET
POS_T_36:
	movi r16, 270
	slli r16, r16, 1
	movi r17, 103
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_36
	br ARMY_COUNT_GET
POS_T_37:
	movi r16, 190
	slli r16, r16, 1
	movi r17, 111
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_37
	br ARMY_COUNT_GET
POS_T_38:
	movi r16, 214
	slli r16, r16, 1
	movi r17, 122
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_38
	br ARMY_COUNT_GET
POS_T_39:
	movi r16, 234
	slli r16, r16, 1
	movi r17, 132
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_39
	br ARMY_COUNT_GET
POS_T_40:
	movi r16, 244
	slli r16, r16, 1
	movi r17, 154
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_40
	br ARMY_COUNT_GET
POS_T_41:
	movi r16, 268
	slli r16, r16, 1
	movi r17, 162
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_41
	br ARMY_COUNT_GET
POS_T_42:
	movi r16, 254
	slli r16, r16, 1
	movi r17, 188
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_42
	br ARMY_COUNT_GET
POS_T_43:
	movi r16, 272
	slli r16, r16, 1
	movi r17, 190
	slli r17, r17, 10
	add r2, r16, r17
	movia r18, T_43
	br ARMY_COUNT_GET

DRAW_PURPLE0:
	movia r3, PURPLE0
	br END

DRAW_PURPLE1:
	movia r3, PURPLE1
	br END

DRAW_PURPLE2:
	movia r3, PURPLE2
	br END

DRAW_PURPLE3:
	movia r3, PURPLE3
	br END

DRAW_PURPLE4:
	movia r3, PURPLE4
	br END

DRAW_PURPLE5:
	movia r3, PURPLE5
	br END

DRAW_PURPLE6:
	movia r3, PURPLE6
	br END

DRAW_PURPLE7:
	movia r3, PURPLE7
	br END

DRAW_PURPLE8:
	movia r3, PURPLE8
	br END

DRAW_PURPLE9:
	movia r3, PURPLE9
	br END
