
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;!!!!!!!!!!!!!!!!!!!!!!!!!!!! MACRO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

ah9 MACRO
    mov ah,9
    int 21h
    ENDM
; 0.1 Video  Get Cursor Position and Size  !!!!!!!!!!!!!!!!!!!!!!!!!!
int10ah03bh00 MACRO
               mov bh,00h
               mov ah,03h
               int 10h

               ENDM
; 0.2 Video  Set Cursor Position and Size  !!!!!!!!!!!!!!!!!!!!!!!!!!
int10ah02bh00dx MACRO
               add dl,01h
               mov bh,00h
               mov ah,02h
               int 10h

               ENDM
; 0.3 Video  Set Cursor Position and Size  !!!!!!!!!!!!!!!!!!!!!!!!!!
moveCursor MACRO
               push cx
               mov bh,00h
               mov ah,03h
               int 10h
               pop cx
               add dl,01h
               mov bh,00h
               mov ah,02h
               int 10h

               ENDM
; 0.4 Video  Set Cursor Position and Size  !!!!!!!!!!!!!!!!!!!!!!!!!!
moveCursor0D0A MACRO
               push cx
               mov bh,00h
               mov ah,03h
               int 10h
               pop cx
               mov dl,00h
               add dh,00h
               mov bh,00h
               mov ah,02h
               int 10h

               ENDM
;1.0 for Dos !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

int21ah9 MACRO
         mov ah,9
         int 21h

         ENDM

; 1.1 for Dos !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
int21ah9dx_ MACRO str
         mov dx,offset str
         mov ah,9
         int 21h

         ENDM
; 2.0 for BIOS Teletype output !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
int10ah0Ebx0000al_ MACRO char
               mov al,char
               mov bx,0000h
               mov ah,0Eh
               int 10h

               ENDM
; 2.1 for BIOS Teletype string output !!!!!!!!!!!!!!!!!!!!!!!!!!

int10ah0Ebx0000cx_si_ MACRO len_str, str
               LOCAL Mark3
               lea si,str
               mov cx,len_str
Mark3:         lodsb
               mov bx,0000h
               mov ah,0Eh
               int 10h
               loop  Mark3

               ENDM
; 3.0 for BIOS Write Character and attribute output !!!!!!!!!!!!!!!!!!!!!!!!!!
int10ah09bx005Ccx0001al_ MACRO char
               mov al,char
               mov cx,0001h
               mov bx,005Ch
               mov ah,09h
               int 10h

               ENDM
; 3.1 for BIOS Write Character and attribute string output !!!!!!!!!!!!!!!!!!!!!!!!!!
int10ah09bx005Ccx_si_ MACRO len_str, str
               LOCAL Mark5
               lea si, str
              ; add si,len_str
              ; dec si
               mov cx,len_str
               cld
Mark5:         moveCursor
               lodsb
               mov bx,005Ch
               mov ah,09h
               int 10h
               ;moveCursor
               loop Mark5

               ENDM


; 8 Get Key Teletype Output !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
GetKeyTeletypeOutput MACRO
Mark8:         mov ah,00h
               int 16h       ;Enter Key
               cmp ah,01h
               je Exit8      ;IF Enter Exit

               mov al,ah
               mov bx,0000h
               mov ah,0Eh
               int 10h       ;Teletype Output Key Scan code in Ascii code

               jmp Mark8
Exit8:
               ENDM
; 9  Get Key UP Down Left Right Teletype  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
GetJumpForKeyUpDownRightLeftTeletype MACRO
Mark9:         mov ah,00h
               int 16h             ;Enter Key
               cmp ah,01h          ;IF Enter Exit
               je Exit9
               cmp ah,48h          ;IF Enter Up
               jne MarkAnySymbol9
               ;
              ; OutputTeletypeStringMacros helloWorld, len_helloWorld
              ; call OutputTeletypeString
               ;
               cmp ah,4Bh          ;IF Enter Left
               jne MarkAnySymbol9
               ;
               cmp ah,4Dh          ;IF Enter Right
               jne MarkAnySymbol9
               ;
               cmp ah,50h          ;IF Enter Down
               jne MarkAnySymbol9
               ;
MarkAnySymbol9: mov al,ah
               mov bx,0000h
               mov ah,0Eh
               int 10h       ;Teletype Output Key Scan code in Ascii code

               jmp Mark9
Exit9:
               ENDM
