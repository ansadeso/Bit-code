	.model small
	.stack 100h
	.code
start:
	mov	 ax, @data
	mov	 ds, ax
	mov	 es, ax

	cld
	lea	 di, text1	; � DI ����� ������ ������ text1
	mov 	 cx, len_text1	;� CX ����� ������ text1
	
	mov	ah,0
	mov	al,'t' 		;���� ������ 't' � ������
	repne	scasb
	je	found
	
	mov	dx,offset mes_no
	mov	ah,9
	int	21h

	jmp	exit
found:
	mov	dx, offset mes_yes
	mov	ah,9
	int	21h
exit:
	mov	ax,4C00h
	int	21h

	.data
text1	db	"Not many people can do it" 	
len_text1=$-text1		
mes_yes	db	"mes_yes  symbol find", '$'
mes_no	db	"mes_no symbol not find", '$'

	end	start