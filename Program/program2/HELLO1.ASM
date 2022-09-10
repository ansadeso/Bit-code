        .model tiny
        .code
        org 0100h
        ;org 7C00h
start:  
        mov     si, offset message
        cld
        mov     ah, 0Eh
        mov     bh, 00h
Lab1:   ;lodsb
        mov     al,[si]
        inc     si
        test    al,al
        jz      Lab2
        int 10h
        jmp Lab1
Lab2:   jmp Lab2

        ret  
message         db "Hello World!", 0Dh, 0Ah, '$',00h

        end     start