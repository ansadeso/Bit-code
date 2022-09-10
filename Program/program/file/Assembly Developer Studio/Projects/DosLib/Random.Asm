; ----------------------------------------------------------------------------
; FILE: Random.Asm
; DATE: December 19, 2001
; DESCRIPTION: Random number generation.
; ----------------------------------------------------------------------------

.386

; --- Includes:

; --- Externals:

; --- Publics:
Public RandomRange
Public Random
Public RandomSeed
Public Random1024

; ----------------------------------------------------------------------------
Data Segment Use16 Dword Public 'DATA'
	Assume Ds:Data

	wNextRandom	Dw	817
	wRandSeed	Dw	0
Data EndS

; ----------------------------------------------------------------------------
Code Segment Use16 Dword Public 'CODE'
	Assume Cs:Code

Random1024 Proc Near
; ----------------------------------------------------------------------------
; OUTPUT: AX -> random number in range [0..1023]
; ----------------------------------------------------------------------------
	push	ecx
	push	edx

	movzx	eax, wNextRandom
	mov	ecx, 217
	mul	ecx
	add	eax, 333
	mov	ecx, 1024
	div	ecx
	mov	wNextRandom, dx
	mov	ax, dx

	pop	edx
	pop	ecx
	ret
Random1024 EndP

; ----------------------------------------------------------------------------
RandomSeed Proc Near
	push	ax
	push	cx
	push	dx

	mov	ah, 2Ch
	int	21h
	xor	dh, dl
	movzx	cx, dh
	inc	cx

@_SeedInProgress:
	call	Random1024
	loop	@_SeedInProgress

	pop	dx
	pop	cx
	pop	ax
	ret
RandomSeed EndP

Random Proc Near
; ----------------------------------------------------------------------------
; INPUT: DX <- enumerator value
; OUTPUT: AX -> random value in range [0..DX-1]
; ----------------------------------------------------------------------------
	push	cx
	push	dx

	call	Random1024
	mov	cx, dx
	xor	dx, dx
	div	cx
	mov	ax, dx

	pop	dx
	pop	cx
	ret
Random EndP

RandomRange Proc Near
; ----------------------------------------------------------------------------
; INPUT:
;	CX <- range begin
;	DX <- range end
; OUTPUT:
;	AX -> random value in range [CX..DX] inclusive
; ----------------------------------------------------------------------------
	push	dx
	sub	dx, cx
	inc	dx
	call	Random
	add	ax, cx
	pop	dx
	ret
RandomRange EndP

Code EndS
End
