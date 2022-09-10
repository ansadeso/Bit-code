	.model tiny
	.code
	org 100h

start: 	
	jmp Go_mess2	

Go_mess1:

	mov ah,9		; Эта функция не будет выполнена
	mov dx,offset message1	; 
	int 21h			; 
	ret

Go_mess2:


	mov ah,9		
	mov dx,offset message2	 
	int 21h			 

jmp Go_mess1

	

message1 db "Hello, World!", 0Dh, 0Ah, '$'
message2 db "Goodbye, World!", 0Dh, 0Ah, '$'

	end start	