	.model tiny
	.code
	org 100h

start: 	
	mov cx,5	;������������� ����� �������� (5���)
Mark:

	mov ah,9		; ���� �����
	mov dx,offset message	; ���� �����
	int 21h			; ���� �����
	loop Mark

	ret
message db "Hello, World!", 0Dh, 0Ah, '$'
	end start	