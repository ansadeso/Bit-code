	.model small
	.stack 100h
	.code
start:
	mov	 ax, @data
	mov	 ds, ax
	mov	 es, ax

	cld
	lea	 si, text1	; � SI ����� ������ ������ text1
	lea	 di, text2	; � DI ����� ������ ������ text2
	mov 	 cx, len_text1	; � CX ����� ������ text1
	
Mark:	lodsb			
	stosb
	loop Mark

	mov	dx,offset text2	; ������� ������ ��������
	mov	ah,9
	int	21h

	mov	ax,4C00h
	int	21h

	.data
text1	db	"Send String$" 	
len_text1=$-text1		
text2	db	"Recivere String$"

	end	start