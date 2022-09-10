        .model tiny
        .code
        org 100h
start:
        mov ch,00h      ;Number road
        mov cl,10h      ;Number sector
        mov dh,00h      ;Number head
        mov dl,80h      ;Number Nmhd equality
        mov bx, OFFSET buf
        ;Set code function
        mov ah,03h        ;Code function read sector
        mov al,01h        ; Wreite 1 Sector
        int 13h
        ret
      buf db 512 dup (34)
      end   start
