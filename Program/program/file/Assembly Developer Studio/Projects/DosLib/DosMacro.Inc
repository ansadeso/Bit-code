; ----------------------------------------------------------------------------
; FILE: DosMacro.Inc
; DATE: December 19, 2001
; DESCRIPTION: A lot of DOS macros...
; NOTE: CF=TRUE indicates a success (Windows style)
; ----------------------------------------------------------------------------
macro_PutChar Macro chAscii
	mov	ah, 2
	mov	dl, chAscii
	int	21h
EndM

; ----------------------------------------------------------------------------
macro_GetCharWithEcho Macro chAscii
	mov	ah, 1
	int	21h
	mov	chAscii, al
EndM

; ----------------------------------------------------------------------------
macro_GetChar Macro chAscii
	mov	ah, 8
	int	21h
	mov	chAscii, al
EndM

; ----------------------------------------------------------------------------
macro_GetFullKbdInfo Macro chScan, chAscii, chFlags
	xor	ah, ah
	int	16h
	mov	chScan, ah
	mov	chAscii, al
	mov	ah, 2
	int	16h
	mov	chFlags, al
EndM

; ----------------------------------------------------------------------------
macro_KeyPressed Macro JumpHere
	mov	ah, 1
	int	16h
	jnz	JumpHere
EndM

; ----------------------------------------------------------------------------
; Use this macro when string is in .DATA segment
; ----------------------------------------------------------------------------
macro_PutText Macro strText
	mov	dx, offset [strText]
	mov	ah, 9
	int	21h
EndM

; ----------------------------------------------------------------------------
; Use this macro when string is a local variable
; ----------------------------------------------------------------------------
macro_PutLocalText Macro strText
	push	ds
	lea	dx, [strText]
	mov	ax, ss
	mov	ds, ax
	mov	ah, 9
	int	21h
	pop	ds
EndM

; ----------------------------------------------------------------------------
macro_PutTextEx Macro pstrTextVar32
	push	ds
	lds	dx, pstrTextVar32
	mov	ah, 9
	int	21h
	pop	ds
EndM

; ----------------------------------------------------------------------------
; Use this object with 'macro_GetText':
;
; .DATA
;	ConsoleInput	CIN	<?>
; .CODE
;	macro_GetText	ConsoleInput, 12
;	jcxz	@_EmptyInput
; ----------------------------------------------------------------------------
CIN Struc
	maxCharCount	Db	0
	inputChars	Db	0
	strInpBuffer	Db	128 Dup (0)
CIN EndS

; ----------------------------------------------------------------------------
macro_GetText Macro cinObject, maxChars
	mov	bx, offset [cinObject]
	mov	al, maxChars
	inc	al
	mov	[bx].maxCharCount, al
	mov	ah, 0Ah
	int	21h
	mov	cl, [bx].inputChars
	xor	ch, ch
EndM

; ----------------------------------------------------------------------------
; 'dwVector' should be far label or DWORD variable.
; ----------------------------------------------------------------------------
macro_SetVector Macro idVector, dwVector
	push	ds
	mov	al, idVector
	mov	ah, 25h
	lds	dx, dwVector
	int	21h
	pop	ds
EndM

; ----------------------------------------------------------------------------
macro_Store32 Macro var32, regSeg, regOfs
	mov	word ptr [var32], regOfs
	mov	word ptr [var32+2], regSeg
EndM

; ----------------------------------------------------------------------------
macro_GetVector Macro dwVector, idVector
	mov	al, idVector
	mov	ah, 35h
	int	21h

	macro_Store32	dwVector, es, bx
EndM

; ----------------------------------------------------------------------------
macro_TSR Macro LeaveKbytes
	mov	dx, LeaveKbytes
	shl	dx, 6
	mov	ax, 3100h
	int	21h
EndM

; ----------------------------------------------------------------------------
macro_GetTicks Macro var32
	xor	bx, bx
	mov	es, bx
	mov	bx, 046Ch
	mov	var32, es:[bx]
EndM

; ----------------------------------------------------------------------------
; Use it with 'macro_GetTime'
; ----------------------------------------------------------------------------
DOSTIME Struc
	tmHour	Db  ?
	tmMin	Db  ?
	tmSec	Db  ?
	tmHund	Db  ?
DOSTIME EndS

; ----------------------------------------------------------------------------
macro_GetTime Macro dostimeObj
	mov	ah, 2Ch
	int	21h
	mov	dostimeObj.tmHour, ch
	mov	dostimeObj.tmMin, cl
	mov	dostimeObj.tmSec, dh
	mov	dostimeObj.tmHund, dl
EndM

; ----------------------------------------------------------------------------
; Use it with 'macro_GetDate'
; ----------------------------------------------------------------------------
DOSDATE Struc
	dtDay	Db  ?	; [1..31]
	dtWkDay	Db  ?	; 0-Sunday
	dtMonth	Db  ?	; [1..12]
	dtYear	Dw  ?	; [1980..2099]
DOSDATE EndS

; ----------------------------------------------------------------------------
macro_GetDate Macro dosdateObj
	mov	ah, 2Ah
	int	21h
	mov	dosdateObj.dtDay, dl
	mov	dosdateObj.dtMonth, dh
	mov	dosdateObj.dtWkDay, al
	mov	dosdateObj.dtYear, cx
EndM

; ----------------------------------------------------------------------------
macro_MakeDir Macro strFolder
	mov	ah, 39h
	mov	dx, offset [strFolder]
	int	21h
	cmc
EndM

; ----------------------------------------------------------------------------
macro_MakeDirEx Macro pstrFolderVar32
	push	ds
	mov	ah, 39h
	lds	dx, [pstrFolderVar32]
	int	21h
	pop	ds
	cmc
EndM

; ----------------------------------------------------------------------------
macro_RemoveDir Macro strFolder
	mov	ah, 3Ah
	mov	dx, offset [strFolder]
	int	21h
	cmc
EndM

; ----------------------------------------------------------------------------
macro_RemoveDirEx Macro pstrFolderVar32
	push	ds
	mov	ah, 3Ah
	lds	dx, [pstrFolderVar32]
	int	21h
	pop	ds
	cmc
EndM

; ----------------------------------------------------------------------------
macro_ChangeDir Macro strFolder
	mov	ah, 3Bh
	mov	dx, offset [strFolder]
	int	21h
	cmc
EndM

; ----------------------------------------------------------------------------
macro_ChangeDirEx Macro pstrFolderVar32
	push	ds
	mov	ah, 3Bh
	lds	dx, [pstrFolderVar32]
	int	21h
	pop	ds
	cmc
EndM

; ----------------------------------------------------------------------------
macro_CreateFile Macro strPath, wFileHandle
	mov	dx, offset [strPath]
	mov	ah, 3Ch
	mov	cx, 0020h
	int	21h
	mov	wFileHandle, ax
	cmc
EndM

; ----------------------------------------------------------------------------
macro_CreateFileEx Macro pstrDwPath, wFileHandle
	push	ds
	lds	dx, [pstrDwPath]
	mov	ah, 3Ch
	mov	cx, 0020h
	int	21h
	pop	ds
	mov	wFileHandle, ax
	cmc
EndM

; ----------------------------------------------------------------------------
; Use it with 'macro_OpenFile'/'macro_OpenFileEx'
; ----------------------------------------------------------------------------
FILE_OPEN_RDONLY	Equ	0
FILE_OPEN_WRONLY	Equ	1
FILE_OPEN_READWR	Equ	2

; ----------------------------------------------------------------------------
macro_OpenFile Macro strPath, fMode, wFileHandle
	mov	dx, offset [strPath]
	mov	ah, 3Dh
	mov	al, fMode
	int	21h
	mov	wFileHandle, ax
	cmc
EndM

; ----------------------------------------------------------------------------
macro_OpenFileEx Macro pstrDwPath, fMode, wFileHandle
	push	ds
	lds	dx, [pstrDwPath]
	mov	ah, 3Dh
	mov	al, fMode
	int	21h
	pop	ds
	mov	wFileHandle, ax
	cmc
EndM

; ----------------------------------------------------------------------------
macro_CloseFile Macro wFileHandle
	mov	bx, wFileHandle
	mov	ah, 3Eh
	int	21h
	cmc
EndM

; ----------------------------------------------------------------------------
macro_GetLocalVarPtr Macro var32, varLocal
	lea	bx, varLocal

	macro_Store32	var32, ss, bx
EndM

; ----------------------------------------------------------------------------
macro_ReadFile Macro wFileHandle, strBuffer, wCount, wStored
	mov	bx, wFileHandle
	mov	cx, wCount
	mov	ah, 3Fh
	mov	dx, offset [strBuffer]
	int	21h
	mov	wStored, ax
	sub	ax, cx
	cmc
EndM

; ----------------------------------------------------------------------------
macro_ReadFileEx Macro wFileHandle, pstrDwBuffer, wCount, wStored
	mov	bx, wFileHandle
	mov	cx, wCount
	mov	ah, 3Fh
	push	ds
	lds	dx, [pstrDwBuffer]
	int	21h
	pop	ds
	mov	wStored, ax
	sub	ax, cx
	cmc
EndM

; ----------------------------------------------------------------------------
macro_WriteFile Macro wFileHandle, strBuffer, wCount, wStored
	mov	bx, wFileHandle
	mov	cx, wCount
	mov	ah, 40h
	mov	dx, offset [strBuffer]
	int	21h
	mov	wStored, ax
	sub	ax, cx
	cmc
EndM

; ----------------------------------------------------------------------------
macro_WriteFileEx Macro wFileHandle, pstrDwBuffer, wCount, wStored
	mov	bx, wFileHandle
	mov	cx, wCount
	mov	ah, 40h
	push	ds
	lds	dx, [pstrDwBuffer]
	int	21h
	pop	ds
	mov	wStored, ax
	sub	ax, cx
	cmc
EndM

; ----------------------------------------------------------------------------
; Use it with 'macro_SeekFile'
; ----------------------------------------------------------------------------
FILE_SEEK_SET	Equ	0
FILE_SEEK_CUR	Equ	1
FILE_SEEK_END	Equ	2

; ----------------------------------------------------------------------------
macro_SeekFile Macro wFileHandle, var32Ofs, fMode, var32AbsPos
	push	var32Ofs
	pop	dx
	pop	cx
	mov	bx, wFileHandle
	mov	al, fMode
	mov	ah, 42h
	int	21h
	push	ax
	push	dx
	pop	var32AbsPos
	cmc
EndM

; ----------------------------------------------------------------------------
macro_GotoFilePos Macro wFileHandle, var32Offset
	macro_SeekFile	wFileHandle, var32Offset, FILE_SEEK_SET, eax
EndM

; ----------------------------------------------------------------------------
macro_RewindFile Macro wFileHandle
	macro_SeekFile	wFileHandle, 0, FILE_SEEK_SET, eax
EndM

; ----------------------------------------------------------------------------
macro_SeekFileEnd Macro wFileHandle
	macro_SeekFile	wFileHandle, 0, FILE_SEEK_END, eax
EndM

; ----------------------------------------------------------------------------
macro_GetFileSize Macro wFileHandle, var32Size
	macro_SeekFileEnd	wFileHandle
	mov	var32Size, eax
	macro_RewindFile	wFileHandle
EndM

; ----------------------------------------------------------------------------
macro_GetFilePos Macro wFileHandle, var32Pos
	macro_SeekFile	wFileHandle, 0, FILE_SEEK_CUR, eax
	mov	var32Pos, eax
EndM

; ----------------------------------------------------------------------------
macro_GetCurDir Macro strDir
	mov	si, offset [strDir]
	mov	ah, 47h
	xor	dl, dl
	int	21h
	cmc
EndM

; ----------------------------------------------------------------------------
macro_GetCurDirEx Macro pstrDir
	push	ds
	lds	si, [pstrDir]
	mov	ah, 47h
	xor	dl, dl
	int	21h
	pop	ds
	cmc
EndM

; ----------------------------------------------------------------------------
macro_AllocMem Macro wBytes, wBlockSeg
	mov	bx, wBytes
	dec	bx
	shr	bx, 4
	inc	bx
	mov	ah, 48h
	int	21h
	mov	wBlockSeg, ax
	cmc
EndM

; ----------------------------------------------------------------------------
macro_FreeMem Macro wBlockSeg
	mov	ax, wBlockSeg
	mov	es, ax
	mov	ah, 49h
	int	21h
	cmc
EndM

macro_HeapMaxBlockRoom Macro
; ----------------------------------------------------------------------------
; EAX will contain max # of bytes in the system.
; ----------------------------------------------------------------------------
	mov	ah, 48h
	mov	bx, -1
	int	21h
	movzx	eax, bx
	shl	eax, 4
EndM

; ----------------------------------------------------------------------------
macro_HeapInit Macro wCutKbytes
	mov	ah, 62h
	int	21h
	mov	es, bx
	mov	bx, wCutKbytes
	shl	bx, 6
	mov	ah, 4Ah
	int	21h
	cmc
EndM

; ----------------------------------------------------------------------------
macro_MovDsInto Macro regSeg
	push	ds
	pop	regSeg
EndM

; ----------------------------------------------------------------------------
macro_MemCopy Macro ptrDest, ptrSrc, wCount
	mov	cx, wCount
	les	di, ptrDest
	push	ds
	lds	si, ptrSrc
	cld
	shr	cx, 1
	rep	movsw
	adc	cx, cx
	rep	movsb
	pop	ds
EndM
