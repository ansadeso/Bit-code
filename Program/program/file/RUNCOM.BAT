cls
del %1.obj
del %1.com
tasm %1
tlink /t %1.obj
%1.com