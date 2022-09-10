; ----------------------------------------------------------------------------
; FILE: Main.Asm
; DATE: September 9, 2016
; DESCRIPTION: 
; ----------------------------------------------------------------------------

.386

; --- Includes:

; --- Externals:

; --- Publics:

; ----------------------------------------------------------------------------
Vars Segment Use16 Stack 'STACK'
	Db 512 Dup (0)
Vars EndS

; ----------------------------------------------------------------------------
Data Segment Use16 Dword Public 'DATA'
	Assume Ds:Data

	strHello	Db 'Hello, World!$'
Data EndS

; ----------------------------------------------------------------------------
Code Segment Use16 Dword Public 'CODE'
	Assume Cs:Code

Main:
	mov	ax, Data
	mov	ds, ax
	mov	gs, ax

	mov	dx, offset [strHello]
	mov	ah, 9
	int	21h

	mov	ax, 4C00h
	int	21h
Code EndS
End Main
