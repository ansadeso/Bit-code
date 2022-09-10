@ECHO OFF 
XCOPY e:\program g:\ /m /e /y
start diskpart /s detach-script.txt
start f:\vdos1.lnk