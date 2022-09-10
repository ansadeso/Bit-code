        .model tiny
        .code
        org 100h
        include macros.inc
start:

Input_from_keybord: mov ah,00h      ;Input from keybord
      int 16h
      
      cmp ah,3Bh      ;Commpare from F1
      je F1 ; Convert_sector    
       
      cmp ah,3Ch      ;Commpare from F2
      je F2 ; Convert_sector       

      jmp Input_from_keybord
        
F1:       ;int10ah0Ebx0000cx_si_ len_strNew,strNew
              int10ah0Ebx0000cx_si_ len_ViewSector,ViewSector
              
      jmp Input_from_keybord
      
F2:      ;int10ah0Ebx0000cx_si_ len_strNew,strNew
             int10ah0Ebx0000cx_si_ len_WriteSector,WriteSector   
                 
       jmp Input_from_keybord     

ret
      .data
      ViewSector     db "View Sector:",0Dh,0Ah
      len_ViewSector=$-ViewSector
      WriteSector     db "Write Sector:",0Dh,0Ah
      len_WriteSector=$-WriteSector
     

        end start