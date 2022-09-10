        .model tiny
        .code
        org 100h
        include macros.inc
start:

Input_from_keybord: mov ah,00h      ;Input from keybord
      int 16h
      
      cmp ah,3Bh      ;Commpare from F1
      je Enter3 ; Convert_sector    
       
      cmp ah,3Ch      ;Commpare from F2
      je Enter4 ; Convert_sector       

      jmp Input_from_keybord
        
Enter3:       ;int10ah0Ebx0000cx_si_ len_strNew,strNew
              int10ah0Ebx0000cx_si_ len_strEnterBuf,strEnterBuf
              
      jmp Input_from_keybord
      
Enter4:      ;int10ah0Ebx0000cx_si_ len_strNew,strNew
             int10ah0Ebx0000cx_si_ len_strEnterSec,strEnterSec   
                 
       jmp Input_from_keybord     

ret
      .data
      strEnterBuf     db "View Sector:",0Dh,0Ah
      len_strEnterBuf=$-strEnterBuf
      strEnterSec     db "Write Sector:",0Dh,0Ah
      len_strEnterSec=$-strEnterSec
     

        end start