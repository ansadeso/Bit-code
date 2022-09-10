	.model small
	.stack 100h
	.code
start:	mov	ax, @data
	mov	ds, ax
	mov	ah,9
	mov	dx, offset message
	int 	21h
	mov	ax, 4C00h
	int	21h

	.data
message		db "Hello, World!", 0Dh, 0Ah, '$'

	end	start