	.model tiny

	INCLUDE const.inc	;�������� ���������� ����� const.inc
	
	.code
	org 100h
start:
	mov cx,COUNT
Mark:
	mov ah,9
	mov dx, offset message
	int 21h
	loop Mark

	ret

;������������ ��������� cr � lf �� ����� const.inc
message		db	"Hello, World!", cr,lf, '$'

	end start	