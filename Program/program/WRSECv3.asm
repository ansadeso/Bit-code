        .model tiny
        .code
        org 100h
        include macros.inc
start:
      int10ah0Ebx0000cx_si_ len_strEnterBuf,strEnterBuf
   
   lea si,bufData         ;Adres buf
    

Lab1: mov ah,00h      ;Input from keybord
      int 16h

      cmp ah,01h      ;Commpare from Exit  //Esc
      je Exit ;label near ptr   
      
      cmp ah,1Ch      ;Commpare from Enter   //Enter
      je Enter2 
        
    mov [si],al       ;Enter buf
    add si,1
    
      cmp ah,3Ch      ;WreiteSector //F2
      jne WreiteSector

        mov ch,00h      ;Number road
        mov cl,10h      ;Number sector
        mov dh,00h      ;Number head
        mov dl,80h      ;Number Nmhd equality
        mov bx, OFFSET bufData
        ;Set code function
        mov ah,03h        ;Code function read sector
        mov al,01h        ; Wreite 1 Sector
        int 13h
WreiteSector:

      mov ah,0Eh      ;Teletype output
      mov bh,00h
      mov bl,96h
      int 10h

      jmp Lab1

Enter2:       int10ah0Ebx0000cx_si_ len_strNew,strNew
              int10ah0Ebx0000cx_si_ len_strEnterSec,strEnterSec
      mov bx,2C00h  
      mov bx,2C00h  
      mov bx,2C00h   
      mov bx,2C00h  
      mov bx,2C00h  
      mov bx,2C00h  
      mov bx,2C00h  
      mov bx,2C00h  
      mov bx,2C00h  
      mov bx,2C00h  
      mov bx,2C00h  
      mov bx,2C00h  
      mov bx,2C00h  
      mov bx,2C00h  
      mov bx,2C00h  
      
      mov bx,2C00h  
             

       
   ;     Convert_ bufDec, bufHex     
      mov bx,3C00h  

;near ptr Exit:
Exit:
ret

      strEnterBuf     db "Enter buf:",0Dh,0Ah
      len_strEnterBuf=$-strEnterBuf
      strEnterSec     db "Enter sec in Hex:",0Dh,0Ah
      len_strEnterSec=$-strEnterSec
      strNew          db 0Dh,0Ah
      len_strNew=$-strNew
      bufData db 512 dup (8)
      len_bufData=$-bufData
      bufSec db 3 dup (49)
      len_bufSec=$-bufSec
      
      bufDec db 1,5,7
      len_bufDec=$-bufDec
      bufHex db 1 dup (?)

        end start