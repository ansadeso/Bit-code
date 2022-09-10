DE v3.0     James R. Webster
            113 Riverview Drive
            Lafollette, TN  37766
            EMAIL: jwebste3@bellsouth.net
            Home phone: (423) 566-6771
            Work phone: (423) 426-2141 [Ext 320]  7am-5:30pm EST
            

     NOTE: If DE is having trouble reading a particular drive in your
system, I would be most greatful if you would do a few things for me!
1.) Make a print-out of this file.
2.) Use a REAL program to help fill in as many blanks of this form as
    possible.
3.) If possible, send me a copy of the disks boot sector (sector 0).
    This can be a printed copy or a binary copy on a floppy disk.
4.) And mail them to me.
Just before I started recoding DE to handle large drives and files, I had
a 5.3 Gigabyte hard drive installed in my system. Is partitioned into
(2) 2 Gigabyte drives and (1) 1 Gigabyte drive. Drive manufacturers use
some crazy schemes in order to get DOS to recognize these large drives.
Had to create a SAFE_DIVIDE routine to handle some of the calcs that you
see with <Shift-F6> DskStat. Was getting "Divide Overflow" messages from
DOS and program crashes. It could be that I've overlooked another place
in the code that needs SAFE_DIVIDE or the like. Thanks!


Bytes per sector...................
                                   ----------------------------------------
Total number of sectors............
                                   ----------------------------------------
Sectors per cluster................
                                   ----------------------------------------
Cluster numbering..................
                                   ----------------------------------------
Sectors per track..................
                                   ----------------------------------------
Total number of tracks.............
                                   ----------------------------------------
Reserved sectors starting at 0.....
                                   ----------------------------------------
Total hidden sectors...............
                                   ----------------------------------------
Total number of FAT's..............
                                   ----------------------------------------
Sectors per FAT....................
                                   ----------------------------------------
Type of FAT........................     -bit
                                   ----------------------------------------
No. of root dir entries allowed....
                                   ----------------------------------------
Sectors taken by root directory....
                                   ----------------------------------------
Root directory entries @ sector....
                                   ----------------------------------------

Number of read/write heads.........
                                   ----------------------------------------
Number of cylinders................
                                   ----------------------------------------
Boot disk area begins at sector....
                                   ----------------------------------------
FAT #1 begins at sector............
                                   ----------------------------------------
FAT #2 begins at sector............
                                   ----------------------------------------
Root directory begins at sector....
                                   ----------------------------------------
Data (Cluster #2) begins @ sector..
                                   ----------------------------------------
Total data storage capacity........
                                   ----------------------------------------
Media Descriptor Byte..............
                                   ----------------------------------------
OEM Signature......................
                                   ----------------------------------------
Volume Signature...................
                                   ----------------------------------------
Volume Serial Number...............
                                   ----------------------------------------


Comments: __________________________________________________________________

          __________________________________________________________________

          __________________________________________________________________

          __________________________________________________________________

          __________________________________________________________________

          __________________________________________________________________

          __________________________________________________________________

          __________________________________________________________________

          __________________________________________________________________

          __________________________________________________________________

          __________________________________________________________________

          __________________________________________________________________

          __________________________________________________________________

          __________________________________________________________________

          __________________________________________________________________
