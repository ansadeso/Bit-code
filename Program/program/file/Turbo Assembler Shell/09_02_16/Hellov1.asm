	.model tiny
	.code
	org 100h
start: 	
	cli
	xor ax,ax
	mov ss,ax
	mov sp,7C00h
	mov si,sp
	push ax
	pop es
	push ax
	pop ds
	sti
	cld

	mov al,01h
	mov ah,02h
	mov ax,0003h
	
	mov bl,11h
	mov bh,12h
	mov bx,1113h
	
	mov cl,21h
	mov ch,22h
	mov cx,2223h
	
	mov dl,31h
	mov dh,32h
	mov dx,3333h
	



	int 10h
Lab1:	jmp Lab1

	ret
					  

	end start