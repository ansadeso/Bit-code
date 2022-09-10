	.model tiny
	.code
	org 100h

start: 	
	mov dx,offset message1
	call Output

	mov dx,offset message2
	call Output

	mov dx,offset message3
	call Output
	
	ret

Output PROC
	mov ah,9
	int 21h
	ret
Output ENDP	


message1 db "Hello, Ivan!", 0Dh, 0Ah, '$'
message2 db "Hello, Peter!", 0Dh, 0Ah, '$'
message3 db "Hello, Fedor!", 0Dh, 0Ah, '$'

	end start	