	.model small
	.stack 100h
	.code
start:
	mov	 ax, @data
	mov	 ds, ax
	mov	 es, ax

	lea	 si, text1	; � SI ����� ������ ������ text1
	lea	 di, text2	; � DI ����� ������ ������ text2
	cld

	;� CX ����� ������ text1 (����� �������� ��� ���������)
	mov 	cx, len_text1

	repe cmpsb	;����������, ���� �������� �����
	je Equality

	mov dx, offset mes_no
	mov ah, 9
	int 21h

	jmp exit

Equality:
	mov	dx, offset mes_yes
	mov 	ah, 9
	int	21h
exit:			;����� �� ��������
	mov	ax, 4C00h
	int	21h

	.data
text1	db	"Ivan Sklyroff" 	;������ ������
len_text1=$-text1			;����� ������ ������
text2	db	"Ivan Sklyroff", '$'	;������ ������
mes_yes	db	"mes_yes, Strings Equals", '$'
mes_no	db	"mes_no, Strings Difrents", '$'

	end	start