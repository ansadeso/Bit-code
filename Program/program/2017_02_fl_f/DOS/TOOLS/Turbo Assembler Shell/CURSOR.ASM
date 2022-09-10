        .model tiny
        .code
        org 100h

start:
      mov ah,02h
      mov bh,00h
      mov dh,03h
      mov dl,03h
      int 10h

      mov ah,09h
      mov bh,00h
      mov al,'h'
      mov bl,01010001b
      mov cx,000Fh
      int 10h

      mov ax,4C00h
      int 21h
        end start