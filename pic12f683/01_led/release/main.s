subtitle "Microchip MPLAB XC8 C Compiler v2.46 (Free license) build 20240104201356 Og1 "

pagewidth 120

	opt flic

	processor	12F683
include "/opt/microchip/xc8/v2.46/pic/include/proc/12f683.cgen.inc"
getbyte	macro	val,pos
	(((val) >> (8 * pos)) and 0xff)
endm
byte0	macro	val
	(getbyte(val,0))
endm
byte1	macro	val
	(getbyte(val,1))
endm
byte2	macro	val
	(getbyte(val,2))
endm
byte3	macro	val
	(getbyte(val,3))
endm
byte4	macro	val
	(getbyte(val,4))
endm
byte5	macro	val
	(getbyte(val,5))
endm
byte6	macro	val
	(getbyte(val,6))
endm
byte7	macro	val
	(getbyte(val,7))
endm
getword	macro	val,pos
	(((val) >> (8 * pos)) and 0xffff)
endm
word0	macro	val
	(getword(val,0))
endm
word1	macro	val
	(getword(val,2))
endm
word2	macro	val
	(getword(val,4))
endm
word3	macro	val
	(getword(val,6))
endm
gettword	macro	val,pos
	(((val) >> (8 * pos)) and 0xffffff)
endm
tword0	macro	val
	(gettword(val,0))
endm
tword1	macro	val
	(gettword(val,3))
endm
tword2	macro	val
	(gettword(val,6))
endm
getdword	macro	val,pos
	(((val) >> (8 * pos)) and 0xffffffff)
endm
dword0	macro	val
	(getdword(val,0))
endm
dword1	macro	val
	(getdword(val,4))
endm
clrc	macro
	bcf	3,0
	endm
clrz	macro
	bcf	3,2
	endm
setc	macro
	bsf	3,0
	endm
setz	macro
	bsf	3,2
	endm
skipc	macro
	btfss	3,0
	endm
skipz	macro
	btfss	3,2
	endm
skipnc	macro
	btfsc	3,0
	endm
skipnz	macro
	btfsc	3,2
	endm
# 54 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
INDF equ 00h ;# 
# 61 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
TMR0 equ 01h ;# 
# 68 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
PCL equ 02h ;# 
# 75 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
STATUS equ 03h ;# 
# 161 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
FSR equ 04h ;# 
# 168 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
GPIO equ 05h ;# 
# 218 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
PCLATH equ 0Ah ;# 
# 238 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
INTCON equ 0Bh ;# 
# 316 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
PIR1 equ 0Ch ;# 
# 387 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
TMR1 equ 0Eh ;# 
# 394 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
TMR1L equ 0Eh ;# 
# 401 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
TMR1H equ 0Fh ;# 
# 408 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
T1CON equ 010h ;# 
# 485 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
TMR2 equ 011h ;# 
# 492 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
T2CON equ 012h ;# 
# 563 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
CCPR1 equ 013h ;# 
# 570 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
CCPR1L equ 013h ;# 
# 577 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
CCPR1H equ 014h ;# 
# 584 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
CCP1CON equ 015h ;# 
# 648 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
WDTCON equ 018h ;# 
# 701 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
CMCON0 equ 019h ;# 
# 760 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
CMCON1 equ 01Ah ;# 
# 786 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
ADRESH equ 01Eh ;# 
# 793 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
ADCON0 equ 01Fh ;# 
# 883 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
OPTION_REG equ 081h ;# 
# 953 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
TRISIO equ 085h ;# 
# 1003 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
PIE1 equ 08Ch ;# 
# 1074 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
PCON equ 08Eh ;# 
# 1113 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
OSCCON equ 08Fh ;# 
# 1178 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
OSCTUNE equ 090h ;# 
# 1230 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
PR2 equ 092h ;# 
# 1237 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
WPU equ 095h ;# 
# 1242 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
WPUA equ 095h ;# 
# 1391 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
IOC equ 096h ;# 
# 1396 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
IOCA equ 096h ;# 
# 1565 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
VRCON equ 099h ;# 
# 1625 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
EEDAT equ 09Ah ;# 
# 1630 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
EEDATA equ 09Ah ;# 
# 1663 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
EEADR equ 09Bh ;# 
# 1670 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
EECON1 equ 09Ch ;# 
# 1708 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
EECON2 equ 09Dh ;# 
# 1715 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
ADRESL equ 09Eh ;# 
# 1722 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
ANSEL equ 09Fh ;# 
# 54 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
INDF equ 00h ;# 
# 61 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
TMR0 equ 01h ;# 
# 68 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
PCL equ 02h ;# 
# 75 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
STATUS equ 03h ;# 
# 161 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
FSR equ 04h ;# 
# 168 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
GPIO equ 05h ;# 
# 218 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
PCLATH equ 0Ah ;# 
# 238 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
INTCON equ 0Bh ;# 
# 316 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
PIR1 equ 0Ch ;# 
# 387 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
TMR1 equ 0Eh ;# 
# 394 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
TMR1L equ 0Eh ;# 
# 401 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
TMR1H equ 0Fh ;# 
# 408 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
T1CON equ 010h ;# 
# 485 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
TMR2 equ 011h ;# 
# 492 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
T2CON equ 012h ;# 
# 563 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
CCPR1 equ 013h ;# 
# 570 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
CCPR1L equ 013h ;# 
# 577 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
CCPR1H equ 014h ;# 
# 584 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
CCP1CON equ 015h ;# 
# 648 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
WDTCON equ 018h ;# 
# 701 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
CMCON0 equ 019h ;# 
# 760 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
CMCON1 equ 01Ah ;# 
# 786 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
ADRESH equ 01Eh ;# 
# 793 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
ADCON0 equ 01Fh ;# 
# 883 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
OPTION_REG equ 081h ;# 
# 953 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
TRISIO equ 085h ;# 
# 1003 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
PIE1 equ 08Ch ;# 
# 1074 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
PCON equ 08Eh ;# 
# 1113 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
OSCCON equ 08Fh ;# 
# 1178 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
OSCTUNE equ 090h ;# 
# 1230 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
PR2 equ 092h ;# 
# 1237 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
WPU equ 095h ;# 
# 1242 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
WPUA equ 095h ;# 
# 1391 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
IOC equ 096h ;# 
# 1396 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
IOCA equ 096h ;# 
# 1565 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
VRCON equ 099h ;# 
# 1625 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
EEDAT equ 09Ah ;# 
# 1630 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
EEDATA equ 09Ah ;# 
# 1663 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
EEADR equ 09Bh ;# 
# 1670 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
EECON1 equ 09Ch ;# 
# 1708 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
EECON2 equ 09Dh ;# 
# 1715 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
ADRESL equ 09Eh ;# 
# 1722 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
ANSEL equ 09Fh ;# 
# 54 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
INDF equ 00h ;# 
# 61 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
TMR0 equ 01h ;# 
# 68 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
PCL equ 02h ;# 
# 75 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
STATUS equ 03h ;# 
# 161 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
FSR equ 04h ;# 
# 168 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
GPIO equ 05h ;# 
# 218 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
PCLATH equ 0Ah ;# 
# 238 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
INTCON equ 0Bh ;# 
# 316 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
PIR1 equ 0Ch ;# 
# 387 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
TMR1 equ 0Eh ;# 
# 394 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
TMR1L equ 0Eh ;# 
# 401 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
TMR1H equ 0Fh ;# 
# 408 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
T1CON equ 010h ;# 
# 485 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
TMR2 equ 011h ;# 
# 492 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
T2CON equ 012h ;# 
# 563 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
CCPR1 equ 013h ;# 
# 570 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
CCPR1L equ 013h ;# 
# 577 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
CCPR1H equ 014h ;# 
# 584 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
CCP1CON equ 015h ;# 
# 648 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
WDTCON equ 018h ;# 
# 701 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
CMCON0 equ 019h ;# 
# 760 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
CMCON1 equ 01Ah ;# 
# 786 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
ADRESH equ 01Eh ;# 
# 793 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
ADCON0 equ 01Fh ;# 
# 883 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
OPTION_REG equ 081h ;# 
# 953 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
TRISIO equ 085h ;# 
# 1003 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
PIE1 equ 08Ch ;# 
# 1074 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
PCON equ 08Eh ;# 
# 1113 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
OSCCON equ 08Fh ;# 
# 1178 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
OSCTUNE equ 090h ;# 
# 1230 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
PR2 equ 092h ;# 
# 1237 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
WPU equ 095h ;# 
# 1242 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
WPUA equ 095h ;# 
# 1391 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
IOC equ 096h ;# 
# 1396 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
IOCA equ 096h ;# 
# 1565 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
VRCON equ 099h ;# 
# 1625 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
EEDAT equ 09Ah ;# 
# 1630 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
EEDATA equ 09Ah ;# 
# 1663 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
EEADR equ 09Bh ;# 
# 1670 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
EECON1 equ 09Ch ;# 
# 1708 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
EECON2 equ 09Dh ;# 
# 1715 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
ADRESL equ 09Eh ;# 
# 1722 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
ANSEL equ 09Fh ;# 
# 54 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
INDF equ 00h ;# 
# 61 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
TMR0 equ 01h ;# 
# 68 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
PCL equ 02h ;# 
# 75 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
STATUS equ 03h ;# 
# 161 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
FSR equ 04h ;# 
# 168 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
GPIO equ 05h ;# 
# 218 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
PCLATH equ 0Ah ;# 
# 238 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
INTCON equ 0Bh ;# 
# 316 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
PIR1 equ 0Ch ;# 
# 387 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
TMR1 equ 0Eh ;# 
# 394 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
TMR1L equ 0Eh ;# 
# 401 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
TMR1H equ 0Fh ;# 
# 408 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
T1CON equ 010h ;# 
# 485 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
TMR2 equ 011h ;# 
# 492 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
T2CON equ 012h ;# 
# 563 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
CCPR1 equ 013h ;# 
# 570 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
CCPR1L equ 013h ;# 
# 577 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
CCPR1H equ 014h ;# 
# 584 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
CCP1CON equ 015h ;# 
# 648 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
WDTCON equ 018h ;# 
# 701 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
CMCON0 equ 019h ;# 
# 760 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
CMCON1 equ 01Ah ;# 
# 786 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
ADRESH equ 01Eh ;# 
# 793 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
ADCON0 equ 01Fh ;# 
# 883 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
OPTION_REG equ 081h ;# 
# 953 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
TRISIO equ 085h ;# 
# 1003 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
PIE1 equ 08Ch ;# 
# 1074 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
PCON equ 08Eh ;# 
# 1113 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
OSCCON equ 08Fh ;# 
# 1178 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
OSCTUNE equ 090h ;# 
# 1230 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
PR2 equ 092h ;# 
# 1237 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
WPU equ 095h ;# 
# 1242 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
WPUA equ 095h ;# 
# 1391 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
IOC equ 096h ;# 
# 1396 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
IOCA equ 096h ;# 
# 1565 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
VRCON equ 099h ;# 
# 1625 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
EEDAT equ 09Ah ;# 
# 1630 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
EEDATA equ 09Ah ;# 
# 1663 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
EEADR equ 09Bh ;# 
# 1670 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
EECON1 equ 09Ch ;# 
# 1708 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
EECON2 equ 09Dh ;# 
# 1715 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
ADRESL equ 09Eh ;# 
# 1722 "/opt/microchip/xc8/v2.46/pic/include/proc/pic12f683.h"
ANSEL equ 09Fh ;# 
	debug_source C
	FNCALL	_main,_interruptions
	FNCALL	_main,_loop
	FNCALL	_main,_setup
	FNROOT	_main
	global	_CMCON0
_CMCON0	set	0x19
	global	_GPIO
_GPIO	set	0x5
	global	_GP0
_GP0	set	0x28
	global	_ANSEL
_ANSEL	set	0x9F
	global	_TRISIO0
_TRISIO0	set	0x428
; #config settings
	config pad_punits      = on
	config apply_mask      = off
	config ignore_cmsgs    = off
	config default_configs = off
	config default_idlocs  = off
	config FOSC = "INTOSCIO"
	config WDTE = "OFF"
	config PWRTE = "OFF"
	config MCLRE = "OFF"
	config CP = "OFF"
	config CPD = "OFF"
	config BOREN = "OFF"
	config IESO = "OFF"
	config FCMEN = "OFF"
	file	"main.s"
	line	#
psect cinit,class=CODE,delta=2
global start_initialization
start_initialization:

global __initialization
__initialization:
psect cinit,class=CODE,delta=2,merge=1
global end_of_initialization,__end_of__initialization

;End of C runtime variable initialization code

end_of_initialization:
__end_of__initialization:
clrf status
ljmp _main	;jump to C main() function
psect	cstackCOMMON,class=COMMON,space=1,noexec
global __pcstackCOMMON
__pcstackCOMMON:
?_setup:	; 1 bytes @ 0x0
??_setup:	; 1 bytes @ 0x0
?_interruptions:	; 1 bytes @ 0x0
??_interruptions:	; 1 bytes @ 0x0
?_loop:	; 1 bytes @ 0x0
??_loop:	; 1 bytes @ 0x0
?_main:	; 1 bytes @ 0x0
??_main:	; 1 bytes @ 0x0
;!
;!Data Sizes:
;!    Strings     0
;!    Constant    0
;!    Data        0
;!    BSS         0
;!    Persistent  0
;!    Stack       0
;!
;!Auto Spaces:
;!    Space          Size  Autos    Used
;!    COMMON           14      0       0
;!    BANK0            80      0       0
;!    BANK1            32      0       0

;!
;!Pointer List with Targets:
;!
;!    None.


;!
;!Critical Paths under _main in COMMON
;!
;!    None.
;!
;!Critical Paths under _main in BANK0
;!
;!    None.
;!
;!Critical Paths under _main in BANK1
;!
;!    None.

;;
;;Main: autosize = 0, tempsize = 0, incstack = 0, save=0
;;

;!
;!Call Graph Tables:
;!
;! ---------------------------------------------------------------------------------
;! (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;! ---------------------------------------------------------------------------------
;! (0) _main                                                 0     0      0       0
;!                      _interruptions
;!                               _loop
;!                              _setup
;! ---------------------------------------------------------------------------------
;! (1) _setup                                                0     0      0       0
;! ---------------------------------------------------------------------------------
;! (1) _loop                                                 0     0      0       0
;! ---------------------------------------------------------------------------------
;! (1) _interruptions                                        0     0      0       0
;! ---------------------------------------------------------------------------------
;! Estimated maximum stack depth 1
;! ---------------------------------------------------------------------------------
;!
;! Call Graph Graphs:
;!
;! _main (ROOT)
;!   _interruptions
;!   _loop
;!   _setup
;!

;! Address spaces:

;!Name               Size   Autos  Total    Cost      Usage
;!BITCOMMON            E      0       0       0        0.0%
;!EEDATA             100      0       0       0        0.0%
;!NULL                 0      0       0       0        0.0%
;!CODE                 0      0       0       0        0.0%
;!COMMON               E      0       0       1        0.0%
;!BITSFR0              0      0       0       1        0.0%
;!SFR0                 0      0       0       1        0.0%
;!BITSFR1              0      0       0       2        0.0%
;!SFR1                 0      0       0       2        0.0%
;!STACK                0      0       0       2        0.0%
;!BITBANK0            50      0       0       3        0.0%
;!BANK0               50      0       0       4        0.0%
;!BANK1               20      0       0       5        0.0%
;!ABS                  0      0       0       6        0.0%
;!BITBANK1            20      0       0       7        0.0%
;!DATA                 0      0       0       8        0.0%

	global	_main

;; *************** function _main *****************
;; Defined at:
;;		line 10 in file "../src/main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : B00/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          0       0       0
;;      Totals:         0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels required when called: 1
;; This function calls:
;;		_interruptions
;;		_loop
;;		_setup
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext,global,class=CODE,delta=2,split=1,group=0
	file	"../src/main.c"
	line	10
global __pmaintext
__pmaintext:	;psect for function _main
psect	maintext
	file	"../src/main.c"
	line	10
	
_main:	
;incstack = 0
	callstack 7
; Regs used in _main: [wreg+status,2+status,0+pclath+cstack]
	line	11
	
l587:	
	fcall	_setup
	line	13
	
l589:	
	fcall	_interruptions
	line	16
	
l591:	
	fcall	_loop
	goto	l591
	global	start
	ljmp	start
	callstack 0
	line	18
GLOBAL	__end_of_main
	__end_of_main:
	signat	_main,89
	global	_setup

;; *************** function _setup *****************
;; Defined at:
;;		line 13 in file "../src/libs/device_setup.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          0       0       0
;;      Totals:         0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used: 1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text1,local,class=CODE,delta=2,merge=1,group=0
	file	"../src/libs/device_setup.c"
	line	13
global __ptext1
__ptext1:	;psect for function _setup
psect	text1
	file	"../src/libs/device_setup.c"
	line	13
	
_setup:	
;incstack = 0
	callstack 7
; Regs used in _setup: [wreg+status,2]
	line	14
	
l577:	
	bcf	status, 5	;RP0=0, select bank0
	clrf	(5)	;volatile
	line	15
	
l579:	
	movlw	low(07h)
	movwf	(25)	;volatile
	line	16
	
l581:	
	bsf	status, 5	;RP0=1, select bank1
	clrf	(159)^080h	;volatile
	line	18
	
l583:	
	bcf	(1064/8)^080h,(1064)&7	;volatile
	line	19
	
l30:	
	return
	callstack 0
GLOBAL	__end_of_setup
	__end_of_setup:
	signat	_setup,89
	global	_loop

;; *************** function _loop *****************
;; Defined at:
;;		line 8 in file "../src/app_main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          0       0       0
;;      Totals:         0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used: 1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text2,local,class=CODE,delta=2,merge=1,group=0
	file	"../src/app_main.c"
	line	8
global __ptext2
__ptext2:	;psect for function _loop
psect	text2
	file	"../src/app_main.c"
	line	8
	
_loop:	
;incstack = 0
	callstack 7
; Regs used in _loop: [wreg]
	line	9
	
l585:	
	movlw	1<<((40)&7)
	bcf	status, 5	;RP0=0, select bank0
	xorwf	((40)/8),f
	line	10
	
l19:	
	return
	callstack 0
GLOBAL	__end_of_loop
	__end_of_loop:
	signat	_loop,89
	global	_interruptions

;; *************** function _interruptions *****************
;; Defined at:
;;		line 25 in file "../src/libs/device_setup.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		None
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          0       0       0
;;      Totals:         0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used: 1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text3,local,class=CODE,delta=2,merge=1,group=0
	file	"../src/libs/device_setup.c"
	line	25
global __ptext3
__ptext3:	;psect for function _interruptions
psect	text3
	file	"../src/libs/device_setup.c"
	line	25
	
_interruptions:	
;incstack = 0
	callstack 7
; Regs used in _interruptions: []
	line	27
	
l33:	
	return
	callstack 0
GLOBAL	__end_of_interruptions
	__end_of_interruptions:
	signat	_interruptions,89
global	___latbits
___latbits	equ	0
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp+0
	end
