.section .text
.global start

start:
	add r1, pc, #0
	sub r1, r1, #8
	blx r1
