	.model small
	.stack 100h

	.data
mess1   db "Input number #1: ",'$'
mess2   db "Input number #2: ",'$'
mess3   db "Result: ",'$'
mess4   db "Error enter $"
crlf    db 0Dh,0Ah,'$'		
n       db 5
nlength db 0
ncontents db 5 dup (?)

buff	db 100 dup(0),'$'
table1  db '0123456789ABCDEF'
base    dw 10

	.code

output PROC
	mov	ah,9
	int	21h
	ret
output ENDP

input PROC
	mov	ah,0Ah
	int	21h
	ret
input ENDP

str2int PROC
	xor	di,di
	xor	ax,ax
	mov	cl,nlength
	xor	ch,ch
	xor	bx,bx
	mov	si,cx
	mov	cl,10
next1:
	mov 	bl,byte ptr ncontents[di]
	sub 	bl,'0'
	jb	error1
	cmp	bl,9
	ja	error1
	mul	cx
	add	ax,bx
	inc	di
	cmp	di,si
	jb	next1
	ret
error1:
	mov	dx,offset mess4
	mov	ah,9
	int	21h
	jmp	exit
str2int ENDP

int2str PROC
	xor	di,di
	mov 	cx,99
zeroizing:
	mov	byte ptr buff[di],0
	inc	di
loop zeroizing

	xor	di,di
	mov	di,offset buff+99

next2:	xor	dx,dx
	div	base
	mov	si,offset table1
	add 	si,dx
	mov	dl,[si]
	mov	[di],dl
	dec	di
	cmp	ax,0
	jnz	next2
	mov	dx,di
	ret
int2str	ENDP

start:	mov	ax,@data
	mov	ds,ax

	mov 	dx,offset mess1
	call output

	mov	dx,offset n
	call	input

	mov	dx,offset crlf
	call output

	call str2int

	push ax

	mov 	dx,offset mess2
	call output

	mov	dx,offset n
	call input

	call	str2int

	pop	bx
	add	ax,bx	
	push	ax

	mov	dx,offset crlf
	call	output

	mov	dx,offset mess3
	call output

	pop	ax
	call	int2str
	call 	output
exit:
	mov	ax,4C00h
	int	21h

	end	start
 