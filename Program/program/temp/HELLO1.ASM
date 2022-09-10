        .model tiny
        .code
        org 100h
        ;org 7C00h
start:  

        mov     al, 01h
        mov     ah, 02h

        mov     bl, 03h
        mov     bh, 04h

        mov     cl, 05h
        mov     ch, 06h

        mov     dl, 07h
        mov     dh, 08h

	add al,bl
	add al,bh

        end     start