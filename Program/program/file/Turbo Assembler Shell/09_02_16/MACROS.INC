
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;!!!!!!!!!!!!!!!!!!!!!!!!!!!! MACRO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;LOCAL Mark3
ah9 MACRO
    mov ah,9
    int 21h
    ENDM


; 0 for Dos !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

int21ah9 MACRO
         mov ah,9
         int 21h

         ENDM

; 1 for Dos !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
int21ah9dx_ MACRO str
         mov dx,offset str
         mov ah,9
         int 21h

         ENDM
; 2 for BIOS Teletype output !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
int10ah0Ebx0000al_ MACRO char
               mov al,char
               mov bx,0000h
               mov ah,0Eh
               int 10h

               ENDM
; 3 for BIOS Teletype string output !!!!!!!!!!!!!!!!!!!!!!!!!!

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
; 4 for BIOS Write Character and attribute output !!!!!!!!!!!!!!!!!!!!!!!!!!
int10ah09bx005Ccx0001al_ MACRO char
               mov al,char
               mov cx,0001h
               mov bx,005Ch
               mov ah,09h
               int 10h

               ENDM
; 5 for BIOS Write Character and attribute string output !!!!!!!!!!!!!!!!!!!!!!!!!!
int10ah09bx005Ccx_si_ MACRO len_str, str
               LOCAL Mark5
               lea si, str
               add si,len_str
               dec si
               mov cx,len_str
               std
Mark5:         lodsb
               mov bx,005Ch
               mov ah,09h
               int 10h
               loop Mark5

               ENDM
; 6 Video  Get Cursor Position and Size  !!!!!!!!!!!!!!!!!!!!!!!!!!
int10ah03bh00 MACRO
               mov bh,00h
               mov ah,03h
               int 10h

               ENDM
; 7 Video  Set Cursor Position and Size  !!!!!!!!!!!!!!!!!!!!!!!!!!
int10ah02bh00dx MACRO
               add dl,01h
               mov bh,00h
               mov ah,02h
               int 10h

               ENDM
; 7.1 Video  Set Cursor Position and Size  !!!!!!!!!!!!!!!!!!!!!!!!!!
moveCursor MACRO


               add dl,01h
               mov bh,00h
               mov ah,02h
               int 10h

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
