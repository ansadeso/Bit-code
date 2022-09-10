; ----------------------------------------------------------------------------
; FILE: Format.Asm
; DATE: December 18, 2001
; DESCRIPTION: Formatting routines: string <-> value
; ----------------------------------------------------------------------------

.386

; --- Includes:

; --- Externals:

; --- Publics:
Public _bin2reg32
Public _bin2reg16
Public _bin2reg8
Public _reg32tobin
Public _reg16tobin
Public _reg8tobin
Public _atoi
Public _atou
Public _hex2u32
Public _hex2u16
Public _hex2u8
Public _u32_2hex
Public _u16_2hex
Public _u8_2hex
Public _utoa
Public _itoa

; ----------------------------------------------------------------------------
Data Segment Use16 Dword Public 'DATA'
	Assume Ds:Data

	strDecimalBuf	Db	16 Dup (0)
	strNonPadded	Db	16 Dup (0)
Data EndS

; ----------------------------------------------------------------------------
Code Segment Use16 Dword Public 'CODE'
	Assume Cs:Code

_itoa Proc Near
; ----------------------------------------------------------------------------
; INPUT:
;	EAX <- 32-bit signed value to format
;	ES:DI <- buffer where to drop the result
;	DL <- padding symbol (used in case DH is not zero)
;	DH <- field width (zero if not padded)
; OUTPUT:
;	DX -> number of symbols dumped into buffer
; ----------------------------------------------------------------------------
	test	eax, eax
	js	@_SignedInteger

	call	_utoa
	ret

@_SignedInteger:
	test	dh, dh
	jnz	@_PaddedSigned

	push	eax
	push	bx

	neg	eax
	mov	bl, '-'
	mov	es:[di], bl
	inc	di
	call	_utoa
	inc	dx
	dec	di

	pop	bx
	pop	eax
	ret

@_PaddedSigned:
	push	eax
	push	gs
	push	fs
	push	si
	push	di

	push	es
	push	di
	push	dx

	mov	di, offset [strNonPadded]
	push	ds
	pop	es
	xor	dx, dx
	neg	eax
	call	_utoa
	mov	cx, dx
	mov	fs, dx
	inc	cx

	xor	dx, dx
	mov	gs, dx

	pop	dx
	pop	di
	pop	es

	cmp	dh, cl
	jbe	@_NoPadding

	sub	dh, cl
	mov	cl, dh
	cld
	mov	al, dl
	mov	gs, cx
	rep	stosb

@_NoPadding:
	mov	al, '-'
	cld
	stosb

	mov	si, offset [strNonPadded]
	mov	cx, fs
	push	cx
	rep	movsb
	pop	dx
	inc	dx

	mov	di, gs
	add	dx, di

	pop	di
	pop	si
	pop	fs
	pop	gs
	pop	eax
	ret
_itoa EndP

_utoa Proc Near
; ----------------------------------------------------------------------------
; INPUT:
;	EAX <- 32-bit unsigned value to format
;	ES:DI <- buffer where to drop the result
;	DL <- padding symbol (used in case DH is not zero)
;	DH <- field width (zero if not padded)
; OUTPUT:
;	DX -> number of digits dumped into buffer
; ----------------------------------------------------------------------------
	Local	retCode:Word, wPadded:Word=VarSize
	Enter	VarSize, 0

	push	eax
	push	ecx
	push	bx
	push	si
	push	di

	mov	wPadded, dx
	mov	ecx, 10
	mov	bx, offset [strDecimalBuf+16]
	xor	si, si
	mov	retCode, si

@_Divide:
	xor	edx, edx
	div	ecx
	add	dl, '0'
	dec	bx
	mov	[bx], dl
	inc	si
	test	eax, eax
	jnz	@_Divide

	mov	cx, si
	mov	si, bx
	mov	dx, wPadded
	test	dh, dh
	jz	@_CopyUnsigned

	cmp	dh, cl
	jbe	@_CopyUnsigned

	push	cx
	mov	al, dl
	sub	dh, cl
	mov	cl, dh
	cld
	add	retCode, cx
	rep	stosb
	pop	cx

@_CopyUnsigned:
	cld
	add	retCode, cx
	rep	movsb

	mov	dx, retCode

	pop	di
	pop	si
	pop	bx
	pop	ecx
	pop	eax
	leave
	ret
_utoa EndP

_u8_2hex Proc Near
; ----------------------------------------------------------------------------
; INPUT:
;	AL <- dump this byte as hexadecimal
;	ES:DI <- buffer where 2 HEX digits will be stored
; OUTPUT:
;	ES:DI -> points to the next byte after two digits
; ----------------------------------------------------------------------------
	push	ax
	push	bx
	push	dx

	cld
	mov	dx, 690Ah

	mov	bl, al
	shr	al, 4
	cmp	al, dl
	sbb	al, dh
	das
	stosb

	mov	al, bl
	and	al, 0Fh
	cmp	al, dl
	sbb	al, dh
	das
	stosb

	pop	dx
	pop	bx
	pop	ax
	ret
_u8_2hex EndP

_u16_2hex Proc Near
; ----------------------------------------------------------------------------
; INPUT:
;	AX <- dump this word as hexadecimal
;	ES:DI <- buffer where 4 HEX digits will be stored
; OUTPUT:
;	ES:DI -> points to the next byte after four digits
; ----------------------------------------------------------------------------
	xchg	ah, al
	call	_u8_2hex
	xchg	ah, al
	call	_u8_2hex
	ret
_u16_2hex EndP

_u32_2hex Proc Near
; ----------------------------------------------------------------------------
; INPUT:
;	EAX <- dump this double word as hexadecimal
;	ES:DI <- buffer where 8 HEX digits will be stored
; OUTPUT:
;	ES:DI -> points to the next byte after eight digits
; ----------------------------------------------------------------------------
	push	eax
	shr	eax, 16
	call	_u16_2hex
	pop	eax
	call	_u16_2hex
	ret
_u32_2hex EndP

_hex2u8 Proc Near
; ----------------------------------------------------------------------------
; INPUT: ES:BX <- points to 2 HEX digits in string: "CD"
; OUTPUT: AL -> binary result
; NOTE: No validation is performed, just a conversion.
; ----------------------------------------------------------------------------
	push	dx

	mov	dx, es:[bx]
	cmp	dl, '9'
	ja	@_DL_is_A__F

	sub	dl, '0'
	jmp	@_SecondDigit

@_DL_is_A__F:
	sub	dl, 37h

@_SecondDigit:
	cmp	dh, '9'
	ja	@_DH_is_A__F

	sub	dh, '0'
	jmp	@_BindInto_AL

@_DH_is_A__F:
	sub	dh, 37h

@_BindInto_AL:
	shl	dl, 4
	or	dl, dh
	mov	al, dl

	pop	dx
	ret
_hex2u8 EndP

_hex2u16 Proc Near
; ----------------------------------------------------------------------------
; INPUT: ES:BX <- points to 4 HEX digits in string: "7D02"
; OUTPUT: AX -> binary result
; NOTE: No validation is performed, just a conversion.
; ----------------------------------------------------------------------------
	push	dx
	call	_hex2u8
	mov	dh, al
	add	bx, 2
	call	_hex2u8
	sub	bx, 2
	mov	ah, dh
	pop	dx
	ret
_hex2u16 EndP

_hex2u32 Proc Near
; ----------------------------------------------------------------------------
; INPUT: ES:BX <- points to 8 HEX digits in string: "7CF2007B"
; OUTPUT: EAX -> binary result
; NOTE: No validation is performed, just a conversion.
; ----------------------------------------------------------------------------
	call	_hex2u16
	shl	eax, 16
	add	bx, 4
	call	_hex2u16
	sub	bx, 4
	ret
_hex2u32 EndP

_atou Proc Near
; ----------------------------------------------------------------------------
; INPUT: ES:BX <- string buffer
; OUTPUT: EAX -> unsigned 32-bit value to receive
; NOTE: Function reads chars until non-digit is found.
; ----------------------------------------------------------------------------
	push	edx
	push	ecx
	push	bx

	xor	eax, eax
	xor	ecx, ecx

@_LoadDigit:
	mov	cl, es:[bx]
	inc	bx

	cmp	cl, '0'
	jb	@_NonDigit
	cmp	cl, '9'
	ja	@_NonDigit

	sub	cl, '0'

	mov	edx, eax	; MUL EAX by 10 using EDX
	shl	edx, 1
	shl	eax, 3
	add	eax, edx

	add	eax, ecx
	jmp	@_LoadDigit

@_NonDigit:
	pop	bx
	pop	ecx
	pop	edx
	ret
_atou EndP

_atoi Proc Near
; ----------------------------------------------------------------------------
; INPUT: ES:BX <- string buffer
; OUTPUT: EAX -> signed 32-bit value to receive
; NOTE: Function reads chars until non-digit is found.
; ----------------------------------------------------------------------------
	mov	al, es:[bx]
	cmp	al, '-'
	je	@_Negative

	call	_atou
	ret

@_Negative:
	inc	bx
	call	_atou
	neg	eax
	dec	bx
	ret
_atoi EndP

_reg8tobin Proc Near
; ----------------------------------------------------------------------------
; INPUT:
;	DL <- value to format
;	ES:DI <- string buffer where "01101011" will be stored
; ----------------------------------------------------------------------------
	push	ax
	push	cx
	push	di

	mov	cx, 8
	mov	ah, 80h
	cld

@_NextBit:
	test	dl, ah
	jz	@_DumpZero

	mov	al, '1'
	jmp	@_DumpBinDigit

@_DumpZero:
	mov	al, '0'

@_DumpBinDigit:
	stosb
	shr	ah, 1
	loop	@_NextBit

	pop	di
	pop	cx
	pop	ax
	ret
_reg8tobin EndP

_reg16tobin Proc Near
; ----------------------------------------------------------------------------
; INPUT:
;	DX <- value to format
;	CX <- 1 if separator needed between bytes
;	ES:DI <- string buffer where 16-digit value will be stored
; ----------------------------------------------------------------------------
	push	di

	xchg	dh, dl
	call	_reg8tobin
	add	di, 8
	jcxz	@_DumpLowByte

	push	ax
	mov	al, ' '
	cld
	stosb
	pop	ax

@_DumpLowByte:
	xchg	dh, dl
	call	_reg8tobin

	pop	di
	ret
_reg16tobin EndP

_reg32tobin Proc Near
; ----------------------------------------------------------------------------
; INPUT:
;	EDX <- value to format
;	CX <- 1 if separator needed between bytes
;	ES:DI <- string buffer where 32-digit value will be stored
; ----------------------------------------------------------------------------
	push	di

	push	edx
	shr	edx, 16
	call	_reg16tobin
	pop	edx
	add	di, 16
	jcxz	@_DumpLowWord

	push	ax
	mov	al, ' '
	cld
	inc	di
	stosb
	pop	ax

@_DumpLowWord:
	call	_reg16tobin

	pop	di
	ret
_reg32tobin EndP

_bin2reg8 Proc Near
; ----------------------------------------------------------------------------
; INPUT: ES:BX <- points to 8 binary digits: "01101011"
; OUTPUT: AL -> converted value
; ----------------------------------------------------------------------------
	push	cx
	push	dx

	mov	cx, 8
	xor	al, al
	mov	dh, '0'

@_ReadBit:
	mov	dl, es:[bx]
	inc	bx
	sub	dl, dh
	shl	al, 1
	add	al, dl
	loop	@_ReadBit
	sub	bx, 8

	pop	dx
	pop	cx
	ret
_bin2reg8 EndP

_bin2reg16 Proc Near
; ----------------------------------------------------------------------------
; INPUT: ES:BX <- points to 16 binary digits: "01101..."
; OUTPUT: AX -> converted value
; ----------------------------------------------------------------------------
	call	_bin2reg8
	mov	ah, al
	add	bx, 8
	call	_bin2reg8
	sub	bx, 8
	ret
_bin2reg16 EndP

_bin2reg32 Proc Near
; ----------------------------------------------------------------------------
; INPUT: ES:BX <- points to 32 binary digits: "01101..."
; OUTPUT: EAX -> converted value
; ----------------------------------------------------------------------------
	call	_bin2reg16
	shl	eax, 16
	add	bx, 16
	call	_bin2reg16
	sub	bx, 16
	ret
_bin2reg32 EndP

Code EndS
End
