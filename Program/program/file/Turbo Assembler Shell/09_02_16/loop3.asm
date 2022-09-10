	.model tiny

	INCLUDE const.inc	;включаем содержимое файла const.inc
	
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

;используются константы cr и lf из файла const.inc
message		db	"Hello, World!", cr,lf, '$'

	end start	