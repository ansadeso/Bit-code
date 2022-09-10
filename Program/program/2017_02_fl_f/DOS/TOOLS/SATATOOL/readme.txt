Sata Tool brief guide

By CC Tan, 04/21/2005

SATA tool is an utility for ExcelStor SATA drives

DO NOT RUN THIS UTILITY FROM WINDOWS 9x/NT/2000!

Usage:
SataTool [/D:xy] [/H] [/?]
    /D:xy which drive to be tested
       x = p or s, p - Primary controller, s - Secondary controller
       y = 0 or 1, 0 - Master drive, 1 - Slave drive
       if not specified, default to s0
    /H Print this help message
    /? Same as /H

Sata Tool is to set the Maximum Transfer Setting for ExcelStor SATA drives

Sata Tool Version 1.00, 4/21/2005
 - Initial Release
 - To set the maximum transfer setting from 1.5Gb/s to 3.0G/bs or vice versa.

Sata Tool Version 1.10, 5/13/2005
 - Hardcoded the Maximum Supported Sata to 2 (3.0Gb/s)

