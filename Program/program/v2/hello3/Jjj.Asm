; ----------------------------------------------------------------------------
; FILE: Jjj.Asm
; DATE: September 9, 2016
; DESCRIPTION: 
; ----------------------------------------------------------------------------

.386

; --- Includes:

; --- Externals:

; --- Publics:

; ----------------------------------------------------------------------------
Data Segment Use16 Dword Public 'DATA'
	Assume Ds:Data

	MyVar Dd ?
Data EndS

; ----------------------------------------------------------------------------
Code Segment Use16 Dword Public 'CODE'
	Assume Cs:Code

Code EndS
End
