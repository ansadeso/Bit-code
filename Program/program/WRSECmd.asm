        .model tiny
        .code
        org 100h
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

Enter2:       
      
 Enter5:      int10ah0Ebx0000cx_si_ len_strNew,strNew
    int10ah0Ebx0000cx_si_ len_strEnterSectors,strEnterSectors       
       lea si,bufSectors         ;Adres buf 
       Input_from_keybord_5: mov ah,00h      ;Input from keybord
      int 16h
      cmp ah,1Ch      ;Commpare from Enter   //Enter
      je Convert_sector         
      mov [si],al       ;Enter buf
      add si,2      
      mov ah,0Eh      ;Teletype output
      mov bh,00h
      mov bl,96h
      int 10h
      jmp Input_from_keybord_5

        
Convert_sector:      

   
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;Sectors;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         mov ax, 2C00h
     lea si,bufSectors         ;Adres buf 
   ;  mov dx, 0
   ;  mov ax, [si] ;1234
    ; mov bx, 10
    ; div bx
     mov ax, 3C00h
      
     mov ax,[si]
     sub al,30h  
     mov bx,000Ah
     mul bx
     mul bx  
     mul bx 
     mov [si],ax
     add si,2     
          mov ax,[si]
     sub al,30h     
     mov bx,000Ah
     mul bx
     mul bx
     mov [si],ax
     add si,2  
               mov ax,[si]
     sub al,30h     
     mov bx,000Ah
     mul bx     
     mov [si],ax
     add si,2  
               mov ax,[si]
     sub ax,30h     
     
     mov [si],ax
     mov ax, 3C00h
     
          lea si,bufSectors         ;Adres buf 
     mov ax,[si]
     add si,2  
     mov bx,[si]
     add ax,bx
     add si,2
     mov bx,[si]
     add ax,bx
          add si,2
     mov bx,[si]
     add ax,bx
      lea si,bufSectorsHex         ;Adres buf 
     mov [si],ax
     mov ax, 3C00h
     mov ax, 3C00h
     mov ax, 3C00h
     mov ax, 3C00h
     
     mov ax,[si]
     mov bx, 3F0h
     div bx
     ;cmp ax,0000h
     ;je SLab1
     lea si,bufSCylinderHex
     mov [si], byte ptr ax 
     mov ax,dx
     mov dx,0000h
;SLab1:

      mov bx, 3Fh
     div bx
     ;cmp ax,0000h
     ;je SLab2
     lea si,bufSHeadHex
     mov  [si], byte ptr ax 
          lea si,bufSSecHex
     mov  [si],byte ptr dx 
;SLab2:
    
         mov ax, 4C00h
     mov ax, 4C00h
     mov ax, 4C00h
     mov ax, 4C00h
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; lea si, bufSecHex
     ;mov cl,[si]                                   ;Wreite Sector
  ;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        lea si,bufSCylinderHex
        mov ch,[si]      ;Number road
        lea si,bufSSecHex 
        mov cl,[si]      ;Number sector
        lea si,bufSHeadHex 
        mov dh,[si]      ;Number head
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
      ;strEnterSec     db "Enter sec in Hex:",0Dh,0Ah
      ;len_strEnterSec=$-strEnterSec
      ;strEnterHead     db "Enter head in Hex:",0Dh,0Ah
      ;len_strEnterHead=$-strEnterHead
      ;strEnterCylinder     db "Enter cylinder in Hex:",0Dh,0Ah
      ;len_strEnterCylinder=$-strEnterCylinder
      strWrSecSuccessful     db "Write sector successful:",0Dh,0Ah
      len_strWrSecSuccessful=$-strWrSecSuccessful
      strEnterSectors     db "Enter sectors min 0 max 9999:",0Dh,0Ah
      len_strEnterSectors=$-strEnterSectors
      strNew          db 0Dh,0Ah
      len_strNew=$-strNew
      bufData db 512 dup (8)
      ;len_bufData=$-bufData
      bufSec db 3 dup (?)
      bufHead db 3 dup (?)
      bufCylinder db 3 dup (?)
      bufSectors dw 4 dup (9)

      ;len_bufSec=$-bufSec
      ;
      ;bufDec db 1,5,7
      ;len_bufDec=$-bufDec
      bufSecHex db 1 dup (?)
      bufHeadHex db 1 dup (?)
      bufCylinderHex db 1 dup (?)      
      bufSectorsHex dw 1 dup (?)      
      bufSCylinderHex db 1 dup (8)
      bufSHeadHex db 1 dup (8)
      bufSSecHex db 1 dup (8)
        end start