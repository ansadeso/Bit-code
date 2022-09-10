        .model tiny
        .code
        org 100h

start:
Lab1: mov ah,00h
      int 16h

     cmp ah,01h
     je Exit

      mov ah,0Eh
      mov bh,00h
      mov bl,96h
      int 10h

      jmp Lab1

Exit: mov ax,4C00h
      int 21h
        end start