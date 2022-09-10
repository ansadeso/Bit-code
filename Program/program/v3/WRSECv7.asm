        .model tiny
        .code
        org 7C00h
        include macros.inc
start:
      ;int10ah0Ebx0000cx_si_ len_strEnterBuf,strEnterBuf
        mov     si, offset strEnterBuf
        cld
        mov     ah, 0Eh
        mov     bh, 00h
us1Lab1:   lodsb
        test    al,al
        jz      us1Lab2
        int 10h
        jmp us1Lab1
us1Lab2:   
   
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

Enter2:       ;int10ah0Ebx0000cx_si_ len_strNew,strNew
              ;int10ah0Ebx0000cx_si_ len_strEnterSec,strEnterSec
               mov     si, offset strEnterSec
        cld
        mov     ah, 0Eh
        mov     bh, 00h
us2Lab1:   lodsb
        test    al,al
        jz      us2Lab2
        int 10h
        jmp us2Lab1
us2Lab2:   
      lea si,bufSec         ;Adres buf
Input_from_keybord_2: mov ah,00h      ;Input from keybord
      int 16h
      cmp ah,1Ch      ;Commpare from Enter   //Enter
      je Enter3 ; Convert_sector         
      mov [si],al       ;Enter buf
      add si,1      
      mov ah,0Eh      ;Teletype output
      mov bh,00h
      mov bl,96h
      int 10h
      jmp Input_from_keybord_2
        
 Enter3:      ;int10ah0Ebx0000cx_si_ len_strNew,strNew
              ;int10ah0Ebx0000cx_si_ len_strEnterHead,strEnterHead
        mov     si, offset strEnterHead
        cld
        mov     ah, 0Eh
        mov     bh, 00h
us3Lab1:   lodsb
        test    al,al
        jz      us3Lab2
        int 10h
        jmp us3Lab1
us3Lab2:   
              
      lea si,bufHead         ;Adres buf
Input_from_keybord_3: mov ah,00h      ;Input from keybord
      int 16h
      cmp ah,1Ch      ;Commpare from Enter   //Enter
      je Enter4         
      mov [si],al       ;Enter buf
      add si,1      
      mov ah,0Eh      ;Teletype output
      mov bh,00h
      mov bl,96h
      int 10h
      jmp Input_from_keybord_3 
      
Enter4:      ;int10ah0Ebx0000cx_si_ len_strNew,strNew
         ;int10ah0Ebx0000cx_si_ len_strEnterCylinder,strEnterCylinder 
        mov     si, offset strEnterCylinder
        cld
        mov     ah, 0Eh
        mov     bh, 00h
us4Lab1:   lodsb
        test    al,al
        jz      us4Lab2
        int 10h
        jmp us4Lab1
us4Lab2:       
       lea si,bufCylinder         ;Adres buf 
       Input_from_keybord_4: mov ah,00h      ;Input from keybord
      int 16h
      cmp ah,1Ch      ;Commpare from Enter   //Enter
      je Convert_sector         
      mov [si],al       ;Enter buf
      add si,1      
      mov ah,0Eh      ;Teletype output
      mov bh,00h
      mov bl,96h
      int 10h
      jmp Input_from_keybord_4

        
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
     ;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
          mov ax, 2C00h
     lea si,bufHead         ;Adres buf 
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
      
     lea si,bufHead         ;Adres buf 
     mov al,[si]
     add si,1  
     mov bl,[si]
     add al,bl
     add si,1
     mov bl,[si]
     add al,bl
        
     lea si,bufHeadHex         ;Adres buf 
     mov [si],al
     mov ax, 4C00h
    ;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
          mov ax, 2C00h
     lea si,bufCylinder         ;Adres buf 
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
      
     lea si,bufCylinder         ;Adres buf 
     mov al,[si]
     add si,1  
     mov bl,[si]
     add al,bl
     add si,1
     mov bl,[si]
     add al,bl
        
     lea si,bufCylinderHex         ;Adres buf 
     mov [si],al
     mov ax, 4C00h
    
    ; lea si, bufSecHex
     ;mov cl,[si]                                   ;Wreite Sector
  ;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        lea si,bufCylinderHex
        mov ch,[si]      ;Number road
        lea si,bufSecHex 
        mov cl,[si]      ;Number sector
        lea si,bufHeadHex 
        mov dh,[si]      ;Number head
        mov dl,80h      ;Number Nmhd equality
        mov bx, OFFSET bufData
        ;Set code function
        mov ah,03h        ;Code function read sector
        mov al,01h        ; Wreite 1 Sector
        int 13h
      
      
      
      
      
      
      ;int10ah0Ebx0000cx_si_ len_strNew,strNew   
      ;int10ah0Ebx0000cx_si_ len_strWrSecSuccessful,strWrSecSuccessful 
        mov     si, offset strWrSecSuccessful
        cld
        mov     ah, 0Eh
        mov     bh, 00h
us5Lab1:   lodsb
        test    al,al
        jz      us5Lab2
        int 10h
        jmp us5Lab1
us5Lab2:   

       
        ;Convert_ bufDec, bufHex     
      mov bx,3C00h  

Exit: jmp Exit
ret
      .data
      strEnterBuf     db "Enter buf:",0Dh,0Ah,00h
      len_strEnterBuf=$-strEnterBuf
      strEnterSec     db 0Dh,0Ah,"Enter sec in Hex:",0Dh,0Ah,00h
      len_strEnterSec=$-strEnterSec
      strEnterHead     db 0Dh,0Ah,"Enter head in Hex:",0Dh,0Ah,00h
      len_strEnterHead=$-strEnterHead
      strEnterCylinder     db 0Dh,0Ah,"Enter cylinder in Hex:",0Dh,0Ah,00h
      len_strEnterCylinder=$-strEnterCylinder
      strWrSecSuccessful     db 0Dh,0Ah,"Write sector successful:",0Dh,0Ah,00h
      len_strWrSecSuccessful=$-strWrSecSuccessful
      strNew          db 01h,02h,03h,04h,05h,06h,07h,08h,09h,0Ah,0Bh,0Ch,0Dh,0Eh,0Fh,10h,11h,12h,13h,14h,15h,16h,17h,18h,19h,1Ah,1Bh,1Ch,1Dh,1Eh,1Fh,20h,21h,22h,23h,24h,25h,26h,27h,28h,29h,2Ah,2Bh,2Ch,2Dh,2Eh,2Fh,30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,3Ah,3Bh,3Ch,3Dh,3Eh,3Fh,40h,41h,42h,43h,44h,45h,46h,47h,48h,49h,4Ah,4Bh,4Ch,4Dh,4Eh,4Fh,00h
      len_strNew=$-strNew
      bufData db 512 dup (8)
      ;len_bufData=$-bufData
      bufSec db 3 dup (?)
      bufHead db 3 dup (?)
      bufCylinder db 3 dup (?)
      ;len_bufSec=$-bufSec
      
      ;bufDec db 1,5,7
      ;len_bufDec=$-bufDec
      bufSecHex db 1 dup (?)
      bufHeadHex db 1 dup (?)
      bufCylinderHex db 1 dup (?)

        end start