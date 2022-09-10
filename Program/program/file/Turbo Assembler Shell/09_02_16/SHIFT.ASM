        .model tiny
        .code
        org 100h

start:
Lab1:
        mov ah,12h
        int 16
         nop
         nop
         nop
         nop
jmp Lab1
      mov ax,4C00h
      int 21h
        end start