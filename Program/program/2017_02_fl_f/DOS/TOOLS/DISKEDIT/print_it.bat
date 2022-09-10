ECHO OFF
ECHO                 DE (Disk Editor) v3.0  by  Jim Webster
ECHO .
ECHO     This batch file handles sending the large DOC file to the printer.
ECHO It requires 46 sheets of paper, assuming a continious print-out and
ECHO printing on only one side of each sheet. The file DE_MINI.DOC is a quick
ECHO start DOC file, if you don't want the full DOC file yet!
ECHO .
ECHO To abort this batch file, press Ctrl-C and then Y.
ECHO .
ECHO Press any other key to continue...................
PAUSE > NUL
ECHO .
ECHO ......... Printing DOC file for DE v3.0 ..........
ECHO .
ECHO ON
copy DE1.DOC prn
copy DE2.DOC prn
copy DE3.DOC prn
copy DE4.DOC prn
