	.model	tiny
	.code	
	org	100h
start:
	mov	ax,0003h
	int	10h

	mov	ax,0B800h
	mov	es,ax

	mov	di,80*2*12+40*2

	mov	ah,30
	mov	al,'+'

	mov	es:[di],ax

	int	20h

	end	start