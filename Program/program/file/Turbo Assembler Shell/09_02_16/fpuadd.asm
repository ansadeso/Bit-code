	.model	tiny
	.code
	org	100h
start:
	finit
	fld	num1
	fld	num2
	fadd
	fstp	result

	ret

num1	dd	45.56
num2	dd	30.13
result	dt	?

	end start