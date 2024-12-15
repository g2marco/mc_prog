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
	FNCALL	_loop,_send_data
	FNROOT	_main
psect	idataCOMMON,class=CODE,space=0,delta=2,noexec
global __pidataCOMMON
__pidataCOMMON:
	file	"../src/main.c"
	line	13

;initializer for _DATA3
	retlw	01h
	line	12

;initializer for _DATA2
	retlw	01h
	line	11

;initializer for _DATA1
	retlw	01h
	line	10

;initializer for _DATA0
	retlw	01h
	global	_CMCON0
_CMCON0	set	0x19
	global	_GPIO
_GPIO	set	0x5
	global	_GP0
_GP0	set	0x28
	global	_GP2
_GP2	set	0x2A
	global	_GP1
_GP1	set	0x29
	global	_TRISIO
_TRISIO	set	0x85
	global	_ANSEL
_ANSEL	set	0x9F
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
psect	dataCOMMON,class=COMMON,space=1,noexec
global __pdataCOMMON
__pdataCOMMON:
	file	"../src/main.c"
	line	13
_DATA3:
       ds      1

psect	dataCOMMON
	file	"../src/main.c"
	line	12
_DATA2:
       ds      1

psect	dataCOMMON
	file	"../src/main.c"
	line	11
_DATA1:
       ds      1

psect	dataCOMMON
	file	"../src/main.c"
	line	10
_DATA0:
       ds      1

	file	"main.s"
	line	#
; Initialize objects allocated to COMMON
	global __pidataCOMMON
psect cinit,class=CODE,delta=2,merge=1
	fcall	__pidataCOMMON+0		;fetch initializer
	movwf	__pdataCOMMON+0&07fh		
	fcall	__pidataCOMMON+1		;fetch initializer
	movwf	__pdataCOMMON+1&07fh		
	fcall	__pidataCOMMON+2		;fetch initializer
	movwf	__pdataCOMMON+2&07fh		
	fcall	__pidataCOMMON+3		;fetch initializer
	movwf	__pdataCOMMON+3&07fh		
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
?_main:	; 1 bytes @ 0x0
?_send_data:	; 1 bytes @ 0x0
	global	send_data@nbits
send_data@nbits:	; 1 bytes @ 0x0
	ds	1
??_send_data:	; 1 bytes @ 0x1
	ds	2
	global	send_data@value
send_data@value:	; 1 bytes @ 0x3
	ds	1
	global	send_data@i
send_data@i:	; 2 bytes @ 0x4
	ds	2
	global	send_data@mask
send_data@mask:	; 1 bytes @ 0x6
	ds	1
??_loop:	; 1 bytes @ 0x7
??_main:	; 1 bytes @ 0x7
;!
;!Data Sizes:
;!    Strings     0
;!    Constant    0
;!    Data        4
;!    BSS         0
;!    Persistent  0
;!    Stack       0
;!
;!Auto Spaces:
;!    Space          Size  Autos    Used
;!    COMMON           14      7      11
;!    BANK0            80      0       0
;!    BANK1            32      0       0

;!
;!Pointer List with Targets:
;!
;!    None.


;!
;!Critical Paths under _main in COMMON
;!
;!    _loop->_send_data
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
;! (0) _main                                                 0     0      0     418
;!                      _interruptions
;!                               _loop
;!                              _setup
;! ---------------------------------------------------------------------------------
;! (1) _setup                                                0     0      0       0
;! ---------------------------------------------------------------------------------
;! (1) _loop                                                 0     0      0     418
;!                          _send_data
;! ---------------------------------------------------------------------------------
;! (2) _send_data                                            7     6      1     418
;!                                              0 COMMON     7     6      1
;! ---------------------------------------------------------------------------------
;! (1) _interruptions                                        0     0      0       0
;! ---------------------------------------------------------------------------------
;! Estimated maximum stack depth 2
;! ---------------------------------------------------------------------------------
;!
;! Call Graph Graphs:
;!
;! _main (ROOT)
;!   _interruptions
;!   _loop
;!     _send_data
;!   _setup
;!

;! Address spaces:

;!Name               Size   Autos  Total    Cost      Usage
;!BANK1               20      0       0       5        0.0%
;!BITBANK1            20      0       0       7        0.0%
;!SFR1                 0      0       0       2        0.0%
;!BITSFR1              0      0       0       2        0.0%
;!BANK0               50      0       0       4        0.0%
;!BITBANK0            50      0       0       3        0.0%
;!SFR0                 0      0       0       1        0.0%
;!BITSFR0              0      0       0       1        0.0%
;!COMMON               E      7       B       1       78.6%
;!BITCOMMON            E      0       0       0        0.0%
;!CODE                 0      0       0       0        0.0%
;!DATA                 0      0       B       8        0.0%
;!ABS                  0      0       B       6        0.0%
;!NULL                 0      0       0       0        0.0%
;!STACK                0      0       0       2        0.0%
;!EEDATA             100      0       0       0        0.0%

	global	_main

;; *************** function _main *****************
;; Defined at:
;;		line 16 in file "../src/main.c"
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
;; Hardware stack levels required when called: 2
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
	line	16
global __pmaintext
__pmaintext:	;psect for function _main
psect	maintext
	file	"../src/main.c"
	line	16
	
_main:	
;incstack = 0
	callstack 6
; Regs used in _main: [wreg+status,2+status,0+pclath+cstack]
	line	17
	
l669:	
	fcall	_setup
	line	19
	
l671:	
	fcall	_interruptions
	line	22
	
l673:	
	fcall	_loop
	goto	l673
	global	start
	ljmp	start
	callstack 0
	line	24
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
	
l627:	
	bcf	status, 5	;RP0=0, select bank0
	clrf	(5)	;volatile
	line	15
	
l629:	
	movlw	low(07h)
	movwf	(25)	;volatile
	line	16
	
l631:	
	bsf	status, 5	;RP0=1, select bank1
	clrf	(159)^080h	;volatile
	line	18
	movlw	low(01h)
	movwf	(133)^080h	;volatile
	line	19
	
l62:	
	return
	callstack 0
GLOBAL	__end_of_setup
	__end_of_setup:
	signat	_setup,89
	global	_loop

;; *************** function _loop *****************
;; Defined at:
;;		line 31 in file "../src/app_main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
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
;; Hardware stack levels required when called: 1
;; This function calls:
;;		_send_data
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text2,local,class=CODE,delta=2,merge=1,group=0
	file	"../src/app_main.c"
	line	31
global __ptext2
__ptext2:	;psect for function _loop
psect	text2
	file	"../src/app_main.c"
	line	31
	
_loop:	
;incstack = 0
	callstack 6
; Regs used in _loop: [wreg+status,2+status,0+pclath+cstack]
	line	32
	
l663:	
	bcf	status, 5	;RP0=0, select bank0
	btfsc	(40/8),(40)&7	;volatile
	goto	u91
	goto	u90
u91:
	goto	l667
u90:
	goto	l48
	line	36
	
l667:	
	movlw	low(04h)
	movwf	(send_data@nbits)
	movlw	low(01h)
	fcall	_send_data
	line	37
	movlw	low(04h)
	movwf	(send_data@nbits)
	movlw	low(01h)
	fcall	_send_data
	line	38
	movlw	low(04h)
	movwf	(send_data@nbits)
	movlw	low(01h)
	fcall	_send_data
	line	39
	movlw	low(04h)
	movwf	(send_data@nbits)
	movlw	low(01h)
	fcall	_send_data
	line	43
	
l49:	
	line	41
	bcf	status, 5	;RP0=0, select bank0
	btfsc	(40/8),(40)&7	;volatile
	goto	u101
	goto	u100
u101:
	goto	l49
u100:
	line	44
	
l48:	
	return
	callstack 0
GLOBAL	__end_of_loop
	__end_of_loop:
	signat	_loop,89
	global	_send_data

;; *************** function _send_data *****************
;; Defined at:
;;		line 17 in file "../src/app_main.c"
;; Parameters:    Size  Location     Type
;;  value           1    wreg     unsigned char 
;;  nbits           1    0[COMMON] unsigned char 
;; Auto vars:     Size  Location     Type
;;  value           1    3[COMMON] unsigned char 
;;  i               2    4[COMMON] int 
;;  mask            1    6[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         1       0       0
;;      Locals:         4       0       0
;;      Temps:          2       0       0
;;      Totals:         7       0       0
;;Total ram usage:        7 bytes
;; Hardware stack levels used: 1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_loop
;; This function uses a non-reentrant model
;;
psect	text3,local,class=CODE,delta=2,merge=1,group=0
	line	17
global __ptext3
__ptext3:	;psect for function _send_data
psect	text3
	file	"../src/app_main.c"
	line	17
	
_send_data:	
;incstack = 0
	callstack 6
; Regs used in _send_data: [wreg+status,2+status,0]
	movwf	(send_data@value)
	line	18
	
l645:	
	clrf	(send_data@mask)
	incf	(send_data@mask),f
	line	20
	
l647:	
	clrf	(send_data@i)
	clrf	(send_data@i+1)
	goto	l661
	line	21
	
l649:	
	movf	(send_data@value),w
	andwf	(send_data@mask),w
	btfss	status,2
	goto	u61
	goto	u60
	
u61:
	bcf	status, 5	;RP0=0, select bank0
	bsf	(41/8),(41)&7	;volatile
	goto	u74
u60:
	bcf	status, 5	;RP0=0, select bank0
	bcf	(41/8),(41)&7	;volatile
u74:
	line	22
	movf	(send_data@mask),w
	movwf	(??_send_data+0)+0
	addwf	(??_send_data+0)+0,w
	movwf	(send_data@mask)
	line	24
	
l651:	
	bsf	(42/8),(42)&7	;volatile
	line	25
	
l653:	
	asmopt push
asmopt off
movlw	13
movwf	((??_send_data+0)+0+1)
	movlw	251
movwf	((??_send_data+0)+0)
	u117:
decfsz	((??_send_data+0)+0),f
	goto	u117
	decfsz	((??_send_data+0)+0+1),f
	goto	u117
	nop2
asmopt pop

	line	26
	
l655:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	(42/8),(42)&7	;volatile
	line	27
	
l657:	
	asmopt push
asmopt off
movlw	13
movwf	((??_send_data+0)+0+1)
	movlw	251
movwf	((??_send_data+0)+0)
	u127:
decfsz	((??_send_data+0)+0),f
	goto	u127
	decfsz	((??_send_data+0)+0+1),f
	goto	u127
	nop2
asmopt pop

	line	28
	
l659:	
	movlw	01h
	addwf	(send_data@i),f
	skipnc
	incf	(send_data@i+1),f
	movlw	0
	addwf	(send_data@i+1),f
	
l661:	
	movf	(send_data@i+1),w
	xorlw	80h
	movwf	(??_send_data+0)+0
	movlw	80h
	subwf	(??_send_data+0)+0,w
	skipz
	goto	u85
	movf	(send_data@nbits),w
	subwf	(send_data@i),w
u85:

	skipc
	goto	u81
	goto	u80
u81:
	goto	l649
u80:
	line	29
	
l44:	
	return
	callstack 0
GLOBAL	__end_of_send_data
	__end_of_send_data:
	signat	_send_data,8313
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
psect	text4,local,class=CODE,delta=2,merge=1,group=0
	file	"../src/libs/device_setup.c"
	line	25
global __ptext4
__ptext4:	;psect for function _interruptions
psect	text4
	file	"../src/libs/device_setup.c"
	line	25
	
_interruptions:	
;incstack = 0
	callstack 7
; Regs used in _interruptions: []
	line	27
	
l65:	
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
