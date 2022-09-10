        .model small

        .stack 100h
        .code
start:
      mov ax,@data
      mov ds,ax
      mov es,ax
      
Lab1: mov ah,00h
      int 16h

     cmp ah,01h
     je Exit
     cmp ah,55h
     jne MF11
      call F11

MF11:  mov ah,09h
      mov bh,00h
      mov bl,offset collor
      mov cx,0001h
      int 10h

      jmp Lab1

Exit: mov ax,4C00h
      int 21h

F11 PROC
    mov ah,offset collor
    and ah,70h
    shr ah,4
    add ah,01h
    shl ah,4
    and ah,70h
    mov bh, offset collor
    and bh,8Fh
    or ah,bh
    mov collor,ah
      ret
F11 ENDP


      .data
collor     db 96h

        end start