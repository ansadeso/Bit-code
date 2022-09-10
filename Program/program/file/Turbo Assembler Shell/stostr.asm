	.model small
	.stack 100h
	.code
start:
	mov	 ax, @data
	mov	 ds, ax
	mov	 es, ax

	cld
	lea	 si, text1	; в SI адрес начала строки text1
	lea	 di, text2	; в DI адрес начала строки text2
	mov 	 cx, len_text1	; в CX длину строки text1
	
Mark:	lodsb			
	stosb
	loop Mark

	mov	dx,offset text2	; выводим строку приемник
	mov	ah,9
	int	21h

	mov	ax,4C00h
	int	21h

	.data
text1	db	"Send String$" 	
len_text1=$-text1		
text2	db	"Recivere String$"

	end	start