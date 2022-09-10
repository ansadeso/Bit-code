        .model small
        .stack 100h
        INCLUDE macros.inc
        .code
start:
        mov ax,@data
        mov ds,ax
        int21ah9dx_ helloWorld1
        int21ah9dx_ helloWorld1
        int21ah9dx_ helloWorld1
        int10ah0Ebx0000cx_si_ len_helloWorld2,helloWorld2
        int10ah0Ebx0000cx_si_ len_helloWorld2,helloWorld2
        int10ah09bx005Ccx0001al_ 'H'
        moveCursor
        int10ah09bx005Ccx0001al_ 'T'
        moveCursor
        int10ah09bx005Ccx0001al_ 'M'
        moveCursor
        int10ah09bx005Ccx0001al_ 'L'
        moveCursor0D0A
        int10ah09bx005Ccx_si_ len_helloWorld3,helloWorld3
      ;  moveCursor0D0A
       ; int10ah09bx005Ccx_si_ len_helloWorld3,helloWorld3
       ; int21ah9dx_ UpKey
       ; int10ah0Ebx0000cx_si_ len_helloWorld2,helloWorld2
       ; call OutputDOS
       ; call OutputHW
       ; call OutputTeletype
       ; call OutputTeletypeString
       ; call OutputCharacterAndAttribute
       ; call OutputCharacterAndAttributeString
       ; call VideoSetCursorPosition
       ; call GetKeyTeletypeOutput
       ; call GetJumpForKeyUpDownRightLeftTeletype
        mov ax,4C00h
        int 21h

        .data
helloWorld1     db "Hello, World 1 !",0Dh,0Ah,'$'
helloWorld2     db "Hello, World 2 !",0Dh,0Ah
len_helloWorld2=$-helloWorld2
helloWorld3     db "Hello, World 3 !"

len_helloWorld3=$-helloWorld3
UpKey          db 0Dh,0Ah
len_UpKey=$-UpKey

        end start