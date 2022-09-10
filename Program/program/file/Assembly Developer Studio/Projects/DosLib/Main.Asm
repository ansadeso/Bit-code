; ----------------------------------------------------------------------------
; FILE: Main.Asm
; DATE: December 17, 2001
; DESCRIPTION:
; ----------------------------------------------------------------------------

.386

; --- Includes:
Include DosMacro.Inc

; --- Externals:
Extrn _utoa : Proc

; --- Publics:

; ----------------------------------------------------------------------------
Vars Segment Use16 Stack 'STACK'
	Db 512 Dup (0)
Vars EndS

; ----------------------------------------------------------------------------
Data Segment Use16 Dword Public 'DATA'
	Assume Ds:Data

	strFormatted	Db	36 Dup ('$')
	strDecData	Db	'01010110010101101111111100100001;'
Data EndS

; ----------------------------------------------------------------------------
Code Segment Use16 Dword Public 'CODE'
	Assume Cs:Code

Main:
	mov	ax, Data
	mov	ds, ax
	mov	es, ax

	macro_HeapInit	24
	macro_HeapMaxBlockRoom
	movzx	eax, bx
	xor	dx, dx
	mov	di, offset [strFormatted]
	push	ds
	pop	es
	shl	eax, 4
	call	_utoa
	macro_PutText	strFormatted
	macro_GetChar	dl

	mov	ax, 4C00h
	int	21h
Code EndS
End Main
