        .model tiny
        .code
        org 100h
        include macros.inc
start:
        mov ch,00h      ;Number road
        mov cl,10h      ;Number sector
        mov dh,00h      ;Number head
        mov dl,80h      ;Number Nmhd equality
        mov bx, OFFSET buf
        ;Set code function
        mov ah,02h        ;Code function read sector
        mov al,01h        ; Read 1 Sector
        int 13h
        mov ax,4C00h
        
        int10ah0Ebx0000cx_si_ len_buf,buf
        int10ah0Ebx0000cx_si_ len_strNew,strNew
        
        ret
      buf db 512 dup (34)
      len_buf=$-buf
      strEnterSec     db "Enter sec in Hex for Read:",0Dh,0Ah
      len_strEnterSec=$-strEnterSec
      strEnterHead     db "Enter head in Hex for Read:",0Dh,0Ah
      len_strEnterHead=$-strEnterHead
      strEnterCylinder     db "Enter cylinder in Hex for Read:",0Dh,0Ah
      len_strEnterCylinder=$-strEnterCylinder
      strWrSecSuccessful     db "Write sector successful:",0Dh,0Ah
      len_strWrSecSuccessful=$-strWrSecSuccessful

      strNew          db 0Dh,0Ah
      len_strNew=$-strNew
      end   start