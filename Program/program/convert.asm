        .model small
        .stack 100h
        .code        
        include macros.inc
start:
        mov ax,@data
        mov ds,ax
        
        lea si,bufData         ;Adres buf
        
Lab1:   mov ah,00h      ;Input from keybord number to convert in bufData
        int 16h  
         
        cmp ah,1Ch      ;Commpare from Enter   //Enter
        je Enter2 
      
        mov [si],al       ;Enter buf
        add si,1
     
     jmp Lab1
 
 Enter2:     
           int10ah0Ebx0000cx_si_ len_bufData,bufData
     
     mov ax, 2C00h
     lea si,bufData         ;Adres buf 
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
      
     lea si,bufData         ;Adres buf 
     mov al,[si]
     add si,1  
     mov bl,[si]
     add al,bl
     add si,1
     mov bl,[si]
     add al,bl
        
     lea si,bufDataMod         ;Adres buf 
     mov [si],al
     
     ;int10ah0Ebx0000cx_si_ len_bufDataMod,bufDataMod
    
     
      mov ax,4C00h
      int 21h
        
      .data
;      bufData2 dd 100 dup (11)
;      bufDec dw 157
;      bufHex dw 16
      bufData db 3 dup (?)
      len_bufData=$-bufData
      bufDataMod db 1 dup (?)
     ; len_bufDataMod=$-bufDataMod

        end start
        
        
        
        
        
                
;     mov dx, 0     
;     mov ax, bufDec
;     mov bx, bufHex
;     div bx       ; Divides 1234 by 10. DX = 4 and AX = 123
     ;mov ax, 8
     