	
	.model small
	.stack 100h
	.code
start:
	mov	 ax, @data
	mov	 ds, ax
	mov	 es, ax

	mov	dx,60h
	lea 	di,mem
movsb
	mov	ax,[di]
	mov	[di],ax
	
	mov al,[di]
	mov bx,0007
	mov ah,0Eh
	int 10h
	
	
Lab1:	jmp Lab1

		.data
	mem db 100 dup(" ")
	end	start