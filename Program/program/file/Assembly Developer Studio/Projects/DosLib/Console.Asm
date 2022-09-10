; ----------------------------------------------------------------------------
; FILE: Console.Asm
; DATE: December 17, 2001
; DESCRIPTION: Routines for console I/O
; ----------------------------------------------------------------------------

.386

; --- Includes:

; --- Externals:

; --- Publics:
Public _kbflush
Public _kbflags
Public _kbhit
Public _getch
Public _cgets
Public _newline
Public _cputs
Public _putch

; ----------------------------------------------------------------------------
Data Segment Use16 Dword Public 'DATA'
	Assume Ds:Data

	strNewLine	Db	0Dh,0Ah,'$'

	; --- Output buffer for '_cputs()'

	strOutBuffer	Db	128 Dup (0)	;BM
	roomOutBuffer	Dw	0

	; --- Input buffer for '_cgets()'

	maxInputChars	Db	0
	numInputChars	Db	0
	strInputBuffer	Db	128 Dup (0)
Data EndS

; ----------------------------------------------------------------------------
Code Segment Use16 Dword Public 'CODE'
	Assume Cs:Code

; ----------------------------------------------------------------------------
_newline Proc Near
	push	ax
	push	dx

	mov	dx, offset [strNewLine]
	mov	ah, 9
	int	21h

	pop	dx
	pop	ax
	ret
_newline EndP

static_DumpChar Proc Near
; ----------------------------------------------------------------------------
; INPUT: AL <- ASCII code to dump
; ----------------------------------------------------------------------------
	push	bx
	push	si

	mov	bx, offset [strOutBuffer]
	mov	si, roomOutBuffer
	mov	[bx+si], al
	inc	si
	mov	roomOutBuffer, si
	cmp	si, 127
	je	@_DumpIt

	pop	si
	pop	bx
	ret

@_DumpIt:
	call	static_DumpOutBuffer
	pop	si
	pop	bx
	ret
static_DumpChar EndP

; ----------------------------------------------------------------------------
static_DumpOutBuffer Proc Near
	push	cx
	mov	cx, roomOutBuffer
	jcxz	@_Dumped

	push	ax
	push	bx
	push	dx
	push	si

	mov	si, cx
	mov	bx, offset [strOutBuffer]
	mov	al, '$'
	mov	[bx+si], al

	mov	dx, bx
	mov	ah, 9
	int	21h

	xor	ax, ax
	mov	roomOutBuffer, ax

	pop	si
	pop	dx
	pop	bx
	pop	ax

@_Dumped:
	pop	cx
	ret
static_DumpOutBuffer EndP

_putch Proc Near
; ----------------------------------------------------------------------------
; INPUT: DL <- ASCII symbol to print to console
; ----------------------------------------------------------------------------
	push	ax
	mov	ah, 2
	int	21h
	pop	ax
	ret
_putch EndP

_cputs Proc Near
; ----------------------------------------------------------------------------
; INPUT: ES:DI <- ASCIIZ string to print to console
; ----------------------------------------------------------------------------
	push	ax
	push	di

@_PrintNextChar:
	mov	al, es:[di]
	inc	di

	test	al, al
	jz	@_PrintDone
	cmp	al, '$'
	je	@_PrintDollar

	call	static_DumpChar
	jmp	@_PrintNextChar

@_PrintDollar:
	call	static_DumpOutBuffer
	push	dx
	mov	dl, '$'
	call	_putch
	pop	dx
	jmp	@_PrintNextChar

@_PrintDone:
	call	static_DumpOutBuffer
	pop	di
	pop	ax
	ret
_cputs EndP

_cgets Proc Near
; ----------------------------------------------------------------------------
; INPUT:
;	ES:DI <- buffer for entered ASCIIZ string
;	CX <- max chars to enter
; OUTPUT:
;	CX -> number of chars entered
; ----------------------------------------------------------------------------
	push	ax
	push	dx

	inc	cx
	mov	maxInputChars, cl
	mov	dx, offset [maxInputChars]
	mov	ah, 0Ah
	int	21h

	mov	cl, numInputChars
	cld
	jcxz	@_StoreTerminator

	push	si
	mov	si, offset [strInputBuffer]
	push	cx
	push	di
	rep	movsb
	pop	di
	pop	cx
	pop	si

@_StoreTerminator:
	xor	al, al
	stosb
	dec	di

	pop	dx
	pop	ax
	ret
_cgets EndP

_getch Proc Near
; ----------------------------------------------------------------------------
; OUTPUT:
;	AH -> scan code
;	AL -> ASCII code
; ----------------------------------------------------------------------------
	xor	ah, ah
	int	16h
	ret
_getch EndP

_kbhit Proc Near
; ----------------------------------------------------------------------------
; OUTPUT: CF=TRUE if key is present in keyboard buffer
; ----------------------------------------------------------------------------
	push	ax
	mov	ah, 1
	int	16h
	pop	ax
	jz	@_EmptyKbdBuffer

	stc
	ret

@_EmptyKbdBuffer:
	clc
	ret
_kbhit EndP

_kbflags Proc Near
; ----------------------------------------------------------------------------
; OUTPUT: DL -> CTRL,ALT,SHIFT,...etc. bit state
; ----------------------------------------------------------------------------
	push	ax
	mov	ah, 2
	int	16h
	mov	dl, al
	pop	ax
	ret
_kbflags EndP

_kbflush Proc Near
; ----------------------------------------------------------------------------
; I recommend to call this one before '_cgets()'
; ----------------------------------------------------------------------------
	push	ax

@_FlushingKbd:
	call	_kbhit
	jnc	@_KbdFlushed

	call	_getch
	jmp	@_FlushingKbd

@_KbdFlushed:
	pop	ax
	ret
_kbflush EndP

Code EndS
End
