        .model tiny
        .code
        org 7C00h
        include macros.inc
start:
      int10ah0Ebx0000cx_si_ len_strEnterNumber,strEnterNumber


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

      cmp ah,11h      ;WreiteSector
      jne WreiteSector

        mov ch,00h      ;Number road
        mov cl,10h      ;Number sector
        mov dh,00h      ;Number head
        mov dl,80h      ;Number Nmhd equality
        mov bx, OFFSET buf
        ;Set code function
        mov ah,03h        ;Code function read sector
        mov al,01h        ; Wreite 1 Sector
        int 13h


     ; jmp Lab1

WreiteSector:



      mov ah,0Eh      ;Teletype output
      mov bh,00h
      mov bl,96h
      int 10h

      jmp Lab1

Exit:   ret

      strEnterNumber     db "Enter Number Sector:",0Dh,0Ah
      len_strEnterNumber=$-strEnterNumber
      buf db 512 dup (8)

        end start