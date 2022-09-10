@echo off
tasm   *.asm        /t
tlink  com.obj      /t/x
tlink  exe.obj        /x
tlink  ff.obj       /t/x
tlink  with_4b.obj  /t/x
tlink  with_com.obj /t/x
tlink  ffffffff.obj /t/x
del *.obj
