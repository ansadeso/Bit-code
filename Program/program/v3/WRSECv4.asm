        .model tiny
        .code
        org 7C00h
        include macros.inc
start:
      int10ah0Ebx0000cx_si_ len_strEnterBuf,strEnterBuf
   
      lea si,bufData         ;Adres buf
Input_from_keybord_1: mov ah,00h      ;Input from keybord
      int 16h
      cmp ah,1Ch      ;Commpare from Enter   //Enter
      je Enter2         
      mov [si],al       ;Enter buf
      add si,1      
      mov ah,0Eh      ;Teletype output
      mov bh,00h
      mov bl,96h
      int 10h
      jmp Input_from_keybord_1

Enter2:       int10ah0Ebx0000cx_si_ len_strNew,strNew
              int10ah0Ebx0000cx_si_ len_strEnterSec,strEnterSec
      lea si,bufSec         ;Adres buf
Input_from_keybord_2: mov ah,00h      ;Input from keybord
      int 16h
      cmp ah,1Ch      ;Commpare from Enter   //Enter
      je Convert_sector         
      mov [si],al       ;Enter buf
      add si,1      
      mov ah,0Eh      ;Teletype output
      mov bh,00h
      mov bl,96h
      int 10h
      jmp Input_from_keybord_2
        
Convert_sector:      

           mov ax, 2C00h
     lea si,bufSec         ;Adres buf 
     mov al,[si]
     sub al,30h  
     mov bl,0Ah
     mul bl
     mul bl   
     mov [si],al
     add si,1     
          mov al,[si]
     sub al,30h     
     mov bl,0Ah
     mul bl
     mov [si],al
     add si,1   
               mov al,[si]
     sub al,30h     
     
     mov [si],al
     mov ax, 3C00h
      
     lea si,bufSec         ;Adres buf 
     mov al,[si]
     add si,1  
     mov bl,[si]
     add al,bl
     add si,1
     mov bl,[si]
     add al,bl
        
     lea si,bufSecHex         ;Adres buf 
     mov [si],al
     mov ax, 4C00h
    ; lea si, bufSecHex
     ;mov cl,[si]                                   ;Wreite Sector
  ;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        mov ch,00h      ;Number road
        mov cl,[si]      ;Number sector
        mov dh,00h      ;Number head
        mov dl,80h      ;Number Nmhd equality
        mov bx, OFFSET bufData
        ;Set code function
        mov ah,03h        ;Code function read sector
        mov al,01h        ; Wreite 1 Sector
        int 13h
      
      
      
      
      
      
      int10ah0Ebx0000cx_si_ len_strNew,strNew   
      int10ah0Ebx0000cx_si_ len_strWrSecSuccessful,strWrSecSuccessful   

       
        ;Convert_ bufDec, bufHex     
      mov bx,3C00h  

Exit label far
ret

      strEnterBuf     db "Enter buf:",0Dh,0Ah
      len_strEnterBuf=$-strEnterBuf
      strEnterSec     db "Enter sec in Hex:",0Dh,0Ah
      len_strEnterSec=$-strEnterSec
      strWrSecSuccessful     db "Write sector successful:",0Dh,0Ah
      len_strWrSecSuccessful=$-strWrSecSuccessful
      strNew          db 0Dh,0Ah
      len_strNew=$-strNew
      bufData db 512 dup (8)
      len_bufData=$-bufData
      bufSec db 3 dup (?)
      len_bufSec=$-bufSec
      
      bufDec db 1,5,7
      len_bufDec=$-bufDec
      bufSecHex db 1 dup (?)

        end start