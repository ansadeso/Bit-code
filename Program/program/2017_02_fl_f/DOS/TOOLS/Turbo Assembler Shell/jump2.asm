	.model tiny
	.code
	org 100h

start: 	
	mov ax,3
	mov bx,3

	cmp ax,bx
	jle Lab

	mov ah,9		
	mov dx,offset message1	 
	int 21h			 
	ret

Lab:

	mov ah,9		
	mov dx,offset message2	 
	int 21h			 

	ret

message1 db "����� �� ������ ���, ��� � ��., AX greter BX", 0Dh, 0Ah, '$'
message2 db "����� �� ������ ��� ����� �������� � ��, AX lees or equal BX ", 0Dh, 0Ah, '$'

	end start	