	.model tiny
	.code
	org 100h

start: 	
	mov cx,5	;устанавливаем число повторов (5раз)
Mark:

	mov ah,9		; тело цикла
	mov dx,offset message	; тело цикла
	int 21h			; тело цикла
	loop Mark

	ret
message db "Hello, World!", 0Dh, 0Ah, '$'
	end start	