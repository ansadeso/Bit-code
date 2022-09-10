	.model small
	.stack 100h
	.code
start:
	mov	 ax, @data
	mov	 ds, ax
	mov	 es, ax

	lea	 si, text1	; в SI адрес начала строки text1
	lea	 di, text2	; в DI адрес начала строки text2
	cld

	;в CX длина строки text1 (число символов для сравнения)
	mov 	cx, len_text1

	repe cmpsb	;сравнивать, пока элементы равны
	je Equality

	mov dx, offset mes_no
	mov ah, 9
	int 21h

	jmp exit

Equality:
	mov	dx, offset mes_yes
	mov 	ah, 9
	int	21h
exit:			;выход из програмы
	mov	ax, 4C00h
	int	21h

	.data
text1	db	"Ivan Sklyroff" 	;первая строка
len_text1=$-text1			;длина первой строки
text2	db	"Ivan Sklyroff", '$'	;вторая строка
mes_yes	db	"mes_yes, Strings Equals", '$'
mes_no	db	"mes_no, Strings Difrents", '$'

	end	start