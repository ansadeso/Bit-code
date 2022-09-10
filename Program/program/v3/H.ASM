        .model tiny
        .code
        ;org 100h
        org 7C00h
start:  
        mov     ah, 0Eh
        mov     bh, 00h
        mov     al,48h
 
        int 10h
Lab2:   jmp Lab2


        end     start