        .model tiny
        .code
        org 100h

start:
      mov ah,00h
      int 16h

      mov ax,4C00h
      int 21h
        end start