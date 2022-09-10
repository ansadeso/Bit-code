        .model tiny
        .code
        org 100h
        
start:
        mov dl,80h 
        mov ch,00h      ;Number cylinder
        mov dh,00h      ;Number head
        mov cl,10h      ;Number sector             
        mov bx, 7C00h      
        mov ax,0201h         
        int 13h
        mov ax,4c00h 
        end start
        
        ; this code in bin
        
        ; b2 80 b5 00 b6 00 b1 10 bb 00 7c b8 01 02 cd 13
        ; b8 00 4c 