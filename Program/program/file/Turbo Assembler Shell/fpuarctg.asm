	.model	tiny
	.code
	org	100h
start:
	finit
	fld	x
	fld	x
	fmul
	fld	st(0)
	fld1
	fadd
	fsqrt
	fpatan
	fild	y
	fmul

	ret

x	dd	0.5
y	dd	2
	end start