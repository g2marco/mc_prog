subtitle "Microchip MPLAB XC8 C Compiler v2.20 (Free license) build 20200408173844 Og1 "

pagewidth 120

	opt flic

	processor	16F627A
include "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\16f627a.cgen.inc"
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
# 54 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
INDF equ 00h ;# 
# 61 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TMR0 equ 01h ;# 
# 68 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PCL equ 02h ;# 
# 75 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
STATUS equ 03h ;# 
# 161 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
FSR equ 04h ;# 
# 168 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PORTA equ 05h ;# 
# 230 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PORTB equ 06h ;# 
# 292 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PCLATH equ 0Ah ;# 
# 312 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
INTCON equ 0Bh ;# 
# 390 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PIR1 equ 0Ch ;# 
# 447 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TMR1 equ 0Eh ;# 
# 454 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TMR1L equ 0Eh ;# 
# 461 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TMR1H equ 0Fh ;# 
# 468 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
T1CON equ 010h ;# 
# 527 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TMR2 equ 011h ;# 
# 534 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
T2CON equ 012h ;# 
# 605 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
CCPR1 equ 015h ;# 
# 612 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
CCPR1L equ 015h ;# 
# 619 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
CCPR1H equ 016h ;# 
# 626 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
CCP1CON equ 017h ;# 
# 684 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
RCSTA equ 018h ;# 
# 755 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TXREG equ 019h ;# 
# 762 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
RCREG equ 01Ah ;# 
# 769 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
CMCON equ 01Fh ;# 
# 839 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
OPTION_REG equ 081h ;# 
# 909 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TRISA equ 085h ;# 
# 971 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TRISB equ 086h ;# 
# 1033 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PIE1 equ 08Ch ;# 
# 1090 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PCON equ 08Eh ;# 
# 1139 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PR2 equ 092h ;# 
# 1146 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TXSTA equ 098h ;# 
# 1203 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
SPBRG equ 099h ;# 
# 1210 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
EEDATA equ 09Ah ;# 
# 1217 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
EEADR equ 09Bh ;# 
# 1224 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
EECON1 equ 09Ch ;# 
# 1262 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
EECON2 equ 09Dh ;# 
# 1269 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
VRCON equ 09Fh ;# 
# 54 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
INDF equ 00h ;# 
# 61 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TMR0 equ 01h ;# 
# 68 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PCL equ 02h ;# 
# 75 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
STATUS equ 03h ;# 
# 161 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
FSR equ 04h ;# 
# 168 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PORTA equ 05h ;# 
# 230 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PORTB equ 06h ;# 
# 292 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PCLATH equ 0Ah ;# 
# 312 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
INTCON equ 0Bh ;# 
# 390 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PIR1 equ 0Ch ;# 
# 447 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TMR1 equ 0Eh ;# 
# 454 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TMR1L equ 0Eh ;# 
# 461 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TMR1H equ 0Fh ;# 
# 468 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
T1CON equ 010h ;# 
# 527 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TMR2 equ 011h ;# 
# 534 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
T2CON equ 012h ;# 
# 605 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
CCPR1 equ 015h ;# 
# 612 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
CCPR1L equ 015h ;# 
# 619 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
CCPR1H equ 016h ;# 
# 626 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
CCP1CON equ 017h ;# 
# 684 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
RCSTA equ 018h ;# 
# 755 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TXREG equ 019h ;# 
# 762 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
RCREG equ 01Ah ;# 
# 769 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
CMCON equ 01Fh ;# 
# 839 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
OPTION_REG equ 081h ;# 
# 909 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TRISA equ 085h ;# 
# 971 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TRISB equ 086h ;# 
# 1033 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PIE1 equ 08Ch ;# 
# 1090 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PCON equ 08Eh ;# 
# 1139 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PR2 equ 092h ;# 
# 1146 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TXSTA equ 098h ;# 
# 1203 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
SPBRG equ 099h ;# 
# 1210 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
EEDATA equ 09Ah ;# 
# 1217 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
EEADR equ 09Bh ;# 
# 1224 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
EECON1 equ 09Ch ;# 
# 1262 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
EECON2 equ 09Dh ;# 
# 1269 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
VRCON equ 09Fh ;# 
# 54 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
INDF equ 00h ;# 
# 61 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TMR0 equ 01h ;# 
# 68 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PCL equ 02h ;# 
# 75 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
STATUS equ 03h ;# 
# 161 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
FSR equ 04h ;# 
# 168 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PORTA equ 05h ;# 
# 230 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PORTB equ 06h ;# 
# 292 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PCLATH equ 0Ah ;# 
# 312 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
INTCON equ 0Bh ;# 
# 390 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PIR1 equ 0Ch ;# 
# 447 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TMR1 equ 0Eh ;# 
# 454 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TMR1L equ 0Eh ;# 
# 461 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TMR1H equ 0Fh ;# 
# 468 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
T1CON equ 010h ;# 
# 527 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TMR2 equ 011h ;# 
# 534 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
T2CON equ 012h ;# 
# 605 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
CCPR1 equ 015h ;# 
# 612 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
CCPR1L equ 015h ;# 
# 619 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
CCPR1H equ 016h ;# 
# 626 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
CCP1CON equ 017h ;# 
# 684 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
RCSTA equ 018h ;# 
# 755 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TXREG equ 019h ;# 
# 762 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
RCREG equ 01Ah ;# 
# 769 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
CMCON equ 01Fh ;# 
# 839 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
OPTION_REG equ 081h ;# 
# 909 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TRISA equ 085h ;# 
# 971 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TRISB equ 086h ;# 
# 1033 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PIE1 equ 08Ch ;# 
# 1090 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PCON equ 08Eh ;# 
# 1139 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PR2 equ 092h ;# 
# 1146 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TXSTA equ 098h ;# 
# 1203 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
SPBRG equ 099h ;# 
# 1210 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
EEDATA equ 09Ah ;# 
# 1217 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
EEADR equ 09Bh ;# 
# 1224 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
EECON1 equ 09Ch ;# 
# 1262 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
EECON2 equ 09Dh ;# 
# 1269 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
VRCON equ 09Fh ;# 
# 54 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
INDF equ 00h ;# 
# 61 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TMR0 equ 01h ;# 
# 68 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PCL equ 02h ;# 
# 75 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
STATUS equ 03h ;# 
# 161 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
FSR equ 04h ;# 
# 168 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PORTA equ 05h ;# 
# 230 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PORTB equ 06h ;# 
# 292 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PCLATH equ 0Ah ;# 
# 312 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
INTCON equ 0Bh ;# 
# 390 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PIR1 equ 0Ch ;# 
# 447 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TMR1 equ 0Eh ;# 
# 454 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TMR1L equ 0Eh ;# 
# 461 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TMR1H equ 0Fh ;# 
# 468 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
T1CON equ 010h ;# 
# 527 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TMR2 equ 011h ;# 
# 534 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
T2CON equ 012h ;# 
# 605 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
CCPR1 equ 015h ;# 
# 612 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
CCPR1L equ 015h ;# 
# 619 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
CCPR1H equ 016h ;# 
# 626 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
CCP1CON equ 017h ;# 
# 684 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
RCSTA equ 018h ;# 
# 755 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TXREG equ 019h ;# 
# 762 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
RCREG equ 01Ah ;# 
# 769 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
CMCON equ 01Fh ;# 
# 839 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
OPTION_REG equ 081h ;# 
# 909 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TRISA equ 085h ;# 
# 971 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TRISB equ 086h ;# 
# 1033 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PIE1 equ 08Ch ;# 
# 1090 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PCON equ 08Eh ;# 
# 1139 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
PR2 equ 092h ;# 
# 1146 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
TXSTA equ 098h ;# 
# 1203 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
SPBRG equ 099h ;# 
# 1210 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
EEDATA equ 09Ah ;# 
# 1217 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
EEADR equ 09Bh ;# 
# 1224 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
EECON1 equ 09Ch ;# 
# 1262 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
EECON2 equ 09Dh ;# 
# 1269 "C:\Program Files\Microchip\xc8\v2.20\pic\include\proc\pic16f627a.h"
VRCON equ 09Fh ;# 
	FNCALL	_main,_loop
	FNCALL	_main,_setup
	FNCALL	_setup,_config_timer0
	FNCALL	_setup,_init_timer0
	FNROOT	_main
	FNCALL	intlevel1,_general_isr
	global	intlevel1
	FNROOT	intlevel1
	global	_timer0
	global	_TMR0
_TMR0	set	0x1
	global	_PORTAbits
_PORTAbits	set	0x5
	global	_CMCON
_CMCON	set	0x1F
	global	_PORTB
_PORTB	set	0x6
	global	_PORTA
_PORTA	set	0x5
	global	_INTCONbits
_INTCONbits	set	0xB
	global	_TMR0IF
_TMR0IF	set	0x5A
	global	_TMR0IE
_TMR0IE	set	0x5D
	global	_OPTION_REGbits
_OPTION_REGbits	set	0x81
	global	_TRISB
_TRISB	set	0x86
	global	_TRISA
_TRISA	set	0x85
	global	_TRISA0
_TRISA0	set	0x428
; #config settings
	config pad_punits      = on
	config apply_mask      = off
	config ignore_cmsgs    = off
	config default_configs = off
	config default_idlocs  = off
	file	"main.s"
	line	#
psect cinit,class=CODE,delta=2
global start_initialization
start_initialization:

global __initialization
__initialization:
psect	bssCOMMON,class=COMMON,space=1,noexec
global __pbssCOMMON
__pbssCOMMON:
_timer0:
       ds      1

	file	"main.s"
	line	#
; Clear objects allocated to COMMON
psect cinit,class=CODE,delta=2,merge=1
	clrf	((__pbssCOMMON)+0)&07Fh
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
?_loop:	; 1 bytes @ 0x0
?_config_timer0:	; 1 bytes @ 0x0
?_main:	; 1 bytes @ 0x0
?_general_isr:	; 1 bytes @ 0x0
??_general_isr:	; 1 bytes @ 0x0
	ds	2
??_loop:	; 1 bytes @ 0x2
??_config_timer0:	; 1 bytes @ 0x2
?_init_timer0:	; 1 bytes @ 0x2
	global	init_timer0@value
init_timer0@value:	; 2 bytes @ 0x2
	ds	2
??_setup:	; 1 bytes @ 0x4
??_init_timer0:	; 1 bytes @ 0x4
??_main:	; 1 bytes @ 0x4
;!
;!Data Sizes:
;!    Strings     0
;!    Constant    0
;!    Data        0
;!    BSS         1
;!    Persistent  0
;!    Stack       0
;!
;!Auto Spaces:
;!    Space          Size  Autos    Used
;!    COMMON           14      4       5
;!    BANK0            80      0       0
;!    BANK1            80      0       0
;!    BANK2            48      0       0

;!
;!Pointer List with Targets:
;!
;!    None.


;!
;!Critical Paths under _main in COMMON
;!
;!    _setup->_init_timer0
;!
;!Critical Paths under _general_isr in COMMON
;!
;!    None.
;!
;!Critical Paths under _main in BANK0
;!
;!    None.
;!
;!Critical Paths under _general_isr in BANK0
;!
;!    None.
;!
;!Critical Paths under _main in BANK1
;!
;!    None.
;!
;!Critical Paths under _general_isr in BANK1
;!
;!    None.
;!
;!Critical Paths under _main in BANK2
;!
;!    None.
;!
;!Critical Paths under _general_isr in BANK2
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
;! (0) _main                                                 0     0      0      98
;!                               _loop
;!                              _setup
;! ---------------------------------------------------------------------------------
;! (1) _setup                                                0     0      0      98
;!                      _config_timer0
;!                        _init_timer0
;! ---------------------------------------------------------------------------------
;! (2) _init_timer0                                          2     0      2      98
;!                                              2 COMMON     2     0      2
;! ---------------------------------------------------------------------------------
;! (2) _config_timer0                                        0     0      0       0
;! ---------------------------------------------------------------------------------
;! (1) _loop                                                 0     0      0       0
;! ---------------------------------------------------------------------------------
;! Estimated maximum stack depth 2
;! ---------------------------------------------------------------------------------
;! (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;! ---------------------------------------------------------------------------------
;! (3) _general_isr                                          2     2      0       0
;!                                              0 COMMON     2     2      0
;! ---------------------------------------------------------------------------------
;! Estimated maximum stack depth 3
;! ---------------------------------------------------------------------------------
;!
;! Call Graph Graphs:
;!
;! _main (ROOT)
;!   _loop
;!   _setup
;!     _config_timer0
;!     _init_timer0
;!
;! _general_isr (ROOT)
;!

;! Address spaces:

;!Name               Size   Autos  Total    Cost      Usage
;!BITCOMMON            E      0       0       0        0.0%
;!EEDATA              80      0       0       0        0.0%
;!NULL                 0      0       0       0        0.0%
;!CODE                 0      0       0       0        0.0%
;!COMMON               E      4       5       1       35.7%
;!BITSFR0              0      0       0       1        0.0%
;!SFR0                 0      0       0       1        0.0%
;!BITSFR1              0      0       0       2        0.0%
;!SFR1                 0      0       0       2        0.0%
;!STACK                0      0       0       2        0.0%
;!BANK0               50      0       0       3        0.0%
;!BITSFR3              0      0       0       4        0.0%
;!SFR3                 0      0       0       4        0.0%
;!ABS                  0      0       5       4        0.0%
;!BITBANK0            50      0       0       5        0.0%
;!BITSFR2              0      0       0       5        0.0%
;!SFR2                 0      0       0       5        0.0%
;!BITBANK1            50      0       0       6        0.0%
;!BANK1               50      0       0       7        0.0%
;!BITBANK2            30      0       0       8        0.0%
;!BANK2               30      0       0       9        0.0%
;!DATA                 0      0       5      10        0.0%

	global	_main

;; *************** function _main *****************
;; Defined at:
;;		line 6 in file "main.c"
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
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         0       0       0       0
;;      Temps:          0       0       0       0
;;      Totals:         0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels required when called:    3
;; This function calls:
;;		_loop
;;		_setup
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext,global,class=CODE,delta=2,split=1,group=0
	file	"main.c"
	line	6
global __pmaintext
__pmaintext:	;psect for function _main
psect	maintext
	file	"main.c"
	line	6
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
;incstack = 0
	callstack 5
; Regs used in _main: [wreg+status,2+status,0+pclath+cstack]
	line	7
	
l707:	
	fcall	_setup
	line	9
	
l709:	
	bsf	(11),7	;volatile
	line	11
	
l11:	
	line	12
	fcall	_loop
	goto	l11
	global	start
	ljmp	start
	callstack 0
	line	14
GLOBAL	__end_of_main
	__end_of_main:
	signat	_main,89
	global	_setup

;; *************** function _setup *****************
;; Defined at:
;;		line 24 in file "proceso.c"
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
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         0       0       0       0
;;      Temps:          0       0       0       0
;;      Totals:         0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_config_timer0
;;		_init_timer0
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text1,local,class=CODE,delta=2,merge=1,group=0
	file	"proceso.c"
	line	24
global __ptext1
__ptext1:	;psect for function _setup
psect	text1
	file	"proceso.c"
	line	24
	global	__size_of_setup
	__size_of_setup	equ	__end_of_setup-_setup
	
_setup:	
;incstack = 0
	callstack 5
; Regs used in _setup: [wreg+status,2+status,0+pclath+cstack]
	line	25
	
l693:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(5)	;volatile
	line	26
	clrf	(6)	;volatile
	line	28
	
l695:	
	movlw	low(07h)
	movwf	(31)	;volatile
	line	30
	
l697:	
	movlw	low(0FFh)
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(133)^080h	;volatile
	line	31
	
l699:	
	movlw	low(0FFh)
	movwf	(134)^080h	;volatile
	line	33
	
l701:	
	fcall	_config_timer0
	line	35
	
l703:	
	movlw	0C8h
	movwf	(init_timer0@value)
	movlw	0
	movwf	((init_timer0@value))+1
	fcall	_init_timer0
	line	37
	
l705:	
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bcf	(1064/8)^080h,(1064)&7	;volatile
	line	39
	clrf	(_timer0)
	line	40
	
l47:	
	return
	callstack 0
GLOBAL	__end_of_setup
	__end_of_setup:
	signat	_setup,89
	global	_init_timer0

;; *************** function _init_timer0 *****************
;; Defined at:
;;		line 18 in file "timer0.c"
;; Parameters:    Size  Location     Type
;;  value           2    2[COMMON] unsigned short 
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
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         2       0       0       0
;;      Locals:         0       0       0       0
;;      Temps:          0       0       0       0
;;      Totals:         2       0       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_setup
;; This function uses a non-reentrant model
;;
psect	text2,local,class=CODE,delta=2,merge=1,group=0
	file	"timer0.c"
	line	18
global __ptext2
__ptext2:	;psect for function _init_timer0
psect	text2
	file	"timer0.c"
	line	18
	global	__size_of_init_timer0
	__size_of_init_timer0	equ	__end_of_init_timer0-_init_timer0
	
_init_timer0:	
;incstack = 0
	callstack 5
; Regs used in _init_timer0: [wreg]
	line	19
	
l691:	
	movf	(init_timer0@value),w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(1)	;volatile
	line	20
	
l65:	
	return
	callstack 0
GLOBAL	__end_of_init_timer0
	__end_of_init_timer0:
	signat	_init_timer0,4217
	global	_config_timer0

;; *************** function _config_timer0 *****************
;; Defined at:
;;		line 4 in file "timer0.c"
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
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         0       0       0       0
;;      Temps:          0       0       0       0
;;      Totals:         0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_setup
;; This function uses a non-reentrant model
;;
psect	text3,local,class=CODE,delta=2,merge=1,group=0
	line	4
global __ptext3
__ptext3:	;psect for function _config_timer0
psect	text3
	file	"timer0.c"
	line	4
	global	__size_of_config_timer0
	__size_of_config_timer0	equ	__end_of_config_timer0-_config_timer0
	
_config_timer0:	
;incstack = 0
	callstack 5
; Regs used in _config_timer0: []
	line	5
	
l657:	
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bcf	(129)^080h,5	;volatile
	line	7
# 7 "timer0.c"
clrwdt ;# 
psect	text3
	line	8
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bcf	(129)^080h,3	;volatile
	line	10
	bcf	(129)^080h,2	;volatile
	line	11
	bcf	(129)^080h,1	;volatile
	line	12
	bsf	(129)^080h,0	;volatile
	line	14
	bcf	(90/8),(90)&7	;volatile
	line	15
	bsf	(93/8),(93)&7	;volatile
	line	16
	
l62:	
	return
	callstack 0
GLOBAL	__end_of_config_timer0
	__end_of_config_timer0:
	signat	_config_timer0,89
	global	_loop

;; *************** function _loop *****************
;; Defined at:
;;		line 45 in file "proceso.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         0       0       0       0
;;      Temps:          0       0       0       0
;;      Totals:         0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text4,local,class=CODE,delta=2,merge=1,group=0
	file	"proceso.c"
	line	45
global __ptext4
__ptext4:	;psect for function _loop
psect	text4
	file	"proceso.c"
	line	45
	global	__size_of_loop
	__size_of_loop	equ	__end_of_loop-_loop
	
_loop:	
;incstack = 0
	callstack 6
; Regs used in _loop: [wreg+status,2+status,0]
	line	47
	
l675:	
	movf	((_timer0)),w
	btfsc	status,2
	goto	u11
	goto	u10
u11:
	goto	l51
u10:
	line	48
	
l677:	
	clrc
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	btfss	(5),0	;volatile
	setc
	btfsc	status,0
	goto	u21
	goto	u20
	
u21:
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(5),0	;volatile
	goto	u34
u20:
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(5),0	;volatile
u34:
	line	49
	
l679:	
	clrf	(_timer0)
	line	52
	
l51:	
	return
	callstack 0
GLOBAL	__end_of_loop
	__end_of_loop:
	signat	_loop,89
	global	_general_isr

;; *************** function _general_isr *****************
;; Defined at:
;;		line 10 in file "proceso.c"
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
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         0       0       0       0
;;      Temps:          2       0       0       0
;;      Totals:         2       0       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		Interrupt level 1
;; This function uses a non-reentrant model
;;
psect	text5,local,class=CODE,delta=2,merge=1,group=0
	line	10
global __ptext5
__ptext5:	;psect for function _general_isr
psect	text5
	file	"proceso.c"
	line	10
	global	__size_of_general_isr
	__size_of_general_isr	equ	__end_of_general_isr-_general_isr
	
_general_isr:	
;incstack = 0
	callstack 5
; Regs used in _general_isr: []
psect	intentry,class=CODE,delta=2
global __pintentry
__pintentry:
global interrupt_function
interrupt_function:
	global saved_w
	saved_w	set	btemp+0
	movwf	saved_w
	swapf	status,w
	movwf	(??_general_isr+0)
	movf	pclath,w
	movwf	(??_general_isr+1)
	ljmp	_general_isr
psect	text5
	line	12
	
i1l685:	
	btfss	(93/8),(93)&7	;volatile
	goto	u4_21
	goto	u4_20
u4_21:
	goto	i1l44
u4_20:
	
i1l687:	
	btfss	(90/8),(90)&7	;volatile
	goto	u5_21
	goto	u5_20
u5_21:
	goto	i1l44
u5_20:
	line	13
	
i1l689:	
	bcf	(90/8),(90)&7	;volatile
	line	14
	clrf	(_timer0)
	incf	(_timer0),f
	line	18
	
i1l44:	
	movf	(??_general_isr+1),w
	movwf	pclath
	swapf	(??_general_isr+0)^0FFFFFF80h,w
	movwf	status
	swapf	saved_w,f
	swapf	saved_w,w
	retfie
	callstack 0
GLOBAL	__end_of_general_isr
	__end_of_general_isr:
	signat	_general_isr,89
global	___latbits
___latbits	equ	0
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp+0
	end
