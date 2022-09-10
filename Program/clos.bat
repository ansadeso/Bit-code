@ECHO OFF 
taskkill /F /IM virtualbox.exe /T
start diskpart /s attach-script.txt