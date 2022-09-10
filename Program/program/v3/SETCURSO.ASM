        .model tiny
        .code
        org 7C00h

start:

jmp Teletype

Lab1: mov ah,00h      ;Input from keybord
      int 16h

      cmp ah,01h      ;Commpare from Exit
      je Exit

      cmp ah,48h      ;UpArrow
      jne UpArrow
      mov ah,03h
      int 10h
      add dh,-1
      mov ah,02h
      int 10h
      jmp Lab1
UpArrow:
      cmp ah,4Bh      ;LeftArrow
      jne LeftArrow
      mov ah,03h
      int 10h
      add dl,-1
      mov ah,02h
      int 10h
      jmp Lab1

LeftArrow:
      cmp ah,4Dh      ;RightArrow
      jne RightArrow
      mov ah,03h
      int 10h
      add dl,1
      mov ah,02h
      int 10h
      jmp Lab1

RightArrow:
      cmp ah,50h      ;DownArrow
      jne DownArrow
      mov ah,03h
      int 10h
      add dh,1
      mov ah,02h
      int 10h
      jmp Lab1

DownArrow:



Teletype:    mov ah,0Eh      ;Teletype output
      mov bh,00h
      mov bl,96h
      int 10h

      jmp Lab1

Exit: mov ax,4C00h
      int 21h
        end start