        .model tiny   ;f1f2v4F
        .code
        org 7C00h
        include macros.inc
start:

Input_from_keybord_for_f1f2: mov ah,00h      
      int 16h
      
      cmp ah,3Bh      ;Commpare from F1
      je F11 ; 
       
       
      cmp ah,3Ch      ;Commpare from F2
      je F22    

      jmp Input_from_keybord_for_f1f2
      
F11:  jmp F1
F22:  jmp F2
        
F1:   int10ah0Ebx0000cx_si_ len_ViewSector,ViewSector
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
            
   
Enter2v:    int10ah0Ebx0000cx_si_ len_strEnterSecv,strEnterSecv
      lea si,bufSec         ;Adres buf
Input_from_keybord_2v: mov ah,00h      ;Input from keybord
      int 16h
      cmp ah,1Ch      ;Commpare from Enter   //Enter
      je Enter3v ; Convert_sector         
      mov [si],al       ;Enter buf
      add si,1      
      mov ah,0Eh      ;Teletype output
      mov bh,00h
      mov bl,96h
      int 10h
      jmp Input_from_keybord_2v
        
 Enter3v:      int10ah0Ebx0000cx_si_ len_strNew,strNew
              int10ah0Ebx0000cx_si_ len_strEnterHeadv,strEnterHeadv
      lea si,bufHead         ;Adres buf
Input_from_keybord_3v: mov ah,00h      ;Input from keybord
      int 16h
      cmp ah,1Ch      ;Commpare from Enter   //Enter
      je Enter4v         
      mov [si],al       ;Enter buf
      add si,1      
      mov ah,0Eh      ;Teletype output
      mov bh,00h
      mov bl,96h
      int 10h
      jmp Input_from_keybord_3v 
      
Enter4v:      int10ah0Ebx0000cx_si_ len_strNew,strNew
    int10ah0Ebx0000cx_si_ len_strEnterCylinderv,strEnterCylinderv       
       lea si,bufCylinder         ;Adres buf 
       Input_from_keybord_4v: mov ah,00h      ;Input from keybord
      int 16h
      cmp ah,1Ch      ;Commpare from Enter   //Enter
      je Convert_sectorv         
      mov [si],al       ;Enter buf
      add si,1      
      mov ah,0Eh      ;Teletype output
      mov bh,00h
      mov bl,96h
      int 10h
      jmp Input_from_keybord_4v

        
Convert_sectorv:      

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
        mov ah,02h        ;Code function read sector
        mov al,01h        ; Wreite 1 Sector
        int 13h
      
      
      
      
      
      
      int10ah0Ebx0000cx_si_ len_strNew,strNew   
      int10ah0Ebx0000cx_si_ len_bufData,bufData   
      int10ah0Ebx0000cx_si_ len_strNew,strNew   
       
        ;Convert_ bufDec, bufHex     
      mov bx,3C00h  

Exitv label far
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;       
      jmp Input_from_keybord_for_f1f2
      
F2 LABEL PROC
          int10ah0Ebx0000cx_si_ len_WriteSector,WriteSector   
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            int10ah0Ebx0000cx_si_ len_strEnterBufw,strEnterBufw
   
      lea si,bufData         ;Adres buf
Input_from_keybord_1w: mov ah,00h      ;Input from keybord
      int 16h
      cmp ah,1Ch      ;Commpare from Enter   //Enter
      je Enter2w         
      mov [si],al       ;Enter buf
      add si,1      
      mov ah,0Eh      ;Teletype output
      mov bh,00h
      mov bl,96h
      int 10h
      jmp Input_from_keybord_1w

Enter2w:       int10ah0Ebx0000cx_si_ len_strNew,strNew
              int10ah0Ebx0000cx_si_ len_strEnterSecw,strEnterSecw
      lea si,bufSec         ;Adres buf
Input_from_keybord_2w: mov ah,00h      ;Input from keybord
      int 16h
      cmp ah,1Ch      ;Commpare from Enter   //Enter
      je Enter3w ; Convert_sector         
      mov [si],al       ;Enter buf
      add si,1      
      mov ah,0Eh      ;Teletype output
      mov bh,00h
      mov bl,96h
      int 10h
      jmp Input_from_keybord_2w
        
 Enter3w:      int10ah0Ebx0000cx_si_ len_strNew,strNew
              int10ah0Ebx0000cx_si_ len_strEnterHeadw,strEnterHeadw
      lea si,bufHead         ;Adres buf
Input_from_keybord_3w: mov ah,00h      ;Input from keybord
      int 16h
      cmp ah,1Ch      ;Commpare from Enter   //Enter
      je Enter4w         
      mov [si],al       ;Enter buf
      add si,1      
      mov ah,0Eh      ;Teletype output
      mov bh,00h
      mov bl,96h
      int 10h
      jmp Input_from_keybord_3w 
      
Enter4w:      int10ah0Ebx0000cx_si_ len_strNew,strNew
    int10ah0Ebx0000cx_si_ len_strEnterCylinderw,strEnterCylinderw       
       lea si,bufCylinder         ;Adres buf 
       Input_from_keybord_4w: mov ah,00h      ;Input from keybord
      int 16h
      cmp ah,1Ch      ;Commpare from Enter   //Enter
      je Convert_sectorw         
      mov [si],al       ;Enter buf
      add si,1      
      mov ah,0Eh      ;Teletype output
      mov bh,00h
      mov bl,96h
      int 10h
      jmp Input_from_keybord_4w

        
Convert_sectorw:      

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
      
      
      
      
      
      
      int10ah0Ebx0000cx_si_ len_strNew,strNew   
      int10ah0Ebx0000cx_si_ len_strWrSecSuccessfulw,strWrSecSuccessfulw   

       
        ;Convert_ bufDec, bufHex     
      mov bx,3C00h  

Exit label far
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;           
      jmp Input_from_keybord_for_f1f2     

ret
      .data
      ViewSector     db "View Sector:",0Dh,0Ah
      len_ViewSector=$-ViewSector
      WriteSector     db "Write Sector:",0Dh,0Ah
      len_WriteSector=$-WriteSector
     
     ; strEnterBuf     db "View Sector:",0Dh,0Ah
     ; len_strEnterBuf=$-strEnterBuf
      strEnterSecv     db "Enter sec in Hex for View:",0Dh,0Ah
      len_strEnterSecv=$-strEnterSecv
      strEnterHeadv     db "Enter head in Hex for View:",0Dh,0Ah
      len_strEnterHeadv=$-strEnterHeadv
      strEnterCylinderv     db "Enter cylinder in Hex for View:",0Dh,0Ah
      len_strEnterCylinderv=$-strEnterCylinderv
      strWrSecSuccessfulv     db "View sector successful:",0Dh,0Ah
      len_strWrSecSuccessfulv=$-strWrSecSuccessfulv
             strEnterBufw     db "Enter buf for Wreite:",0Dh,0Ah
      len_strEnterBufw=$-strEnterBufw
      strEnterSecw     db "Enter sec in Hex for Wreite:",0Dh,0Ah
      len_strEnterSecw=$-strEnterSecw
      strEnterHeadw     db "Enter head in Hex for Wreite:",0Dh,0Ah
      len_strEnterHeadw=$-strEnterHeadw
      strEnterCylinderw     db "Enter cylinder in Hex for Wreite:",0Dh,0Ah
      len_strEnterCylinderw=$-strEnterCylinderw
      strWrSecSuccessfulw     db "Write sector successful:",0Dh,0Ah
      len_strWrSecSuccessfulw=$-strWrSecSuccessfulw
      strNew          db 0Dh,0Ah
      len_strNew=$-strNew
      bufData db 512 dup (8)
      len_bufData=$-bufData
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