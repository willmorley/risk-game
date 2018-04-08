.section .data
.align 2

.section .text
.global SELECT_T_NUMBER

SELECT_T_NUMBER:
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
	# continue

POS_T_1:
	movi r2, 100 #ex. offset: x*2 + y*1024 so (8 + 1024 = 1032)
	br END
POS_T_2:
	movi r2, 300 #ex. offset: x*2 + y*1024 so (8 + 1024 = 1032)
	br END
POS_T_3:
	movi r2, 500 #ex. offset: x*2 + y*1024 so (8 + 1024 = 1032)
	br END
POS_T_4:
	movi r2, 700 #ex. offset: x*2 + y*1024 so (8 + 1024 = 1032)
	br END
# continue
END:
    ret