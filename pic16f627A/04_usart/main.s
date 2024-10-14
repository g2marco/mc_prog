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
	FNCALL	_main,_basic_setup
	FNCALL	_main,_loop
	FNCALL	_main,_setup
	FNCALL	_setup,_config_display
	FNCALL	_setup,_config_usart
	FNCALL	_setup,_init_display
	FNCALL	_setup,_write_display
	FNCALL	_write_display,_write_char
	FNCALL	_write_char,_send_command_lcd
	FNCALL	_init_display,_send_command_lcd
	FNCALL	_config_display,_config_interface_lcd
	FNCALL	_config_display,_init_lcd
	FNROOT	_main
	FNCALL	intlevel1,_general_isr
	global	intlevel1
	FNROOT	intlevel1
psect	idataCOMMON,class=CODE,space=0,delta=2,noexec
global __pidataCOMMON
__pidataCOMMON:
	file	"proceso.c"
	line	16

;initializer for _PTR_HELLO
	retlw	low((((STR_1)-__stringbase)|8000h))
	global	_data
	global	_RCSTAbits
_RCSTAbits	set	0x18
	global	_PORTAbits
_PORTAbits	set	0x5
	global	_PORTBbits
_PORTBbits	set	0x6
	global	_RCREG
_RCREG	set	0x1A
	global	_TXREG
_TXREG	set	0x19
	global	_PIR1bits
_PIR1bits	set	0xC
	global	_INTCONbits
_INTCONbits	set	0xB
	global	_CMCON
_CMCON	set	0x1F
	global	_PORTB
_PORTB	set	0x6
	global	_PORTA
_PORTA	set	0x5
	global	_PIE1bits
_PIE1bits	set	0x8C
	global	_SPBRG
_SPBRG	set	0x99
	global	_TXSTAbits
_TXSTAbits	set	0x98
	global	_TRISB
_TRISB	set	0x86
	global	_TRISA
_TRISA	set	0x85
	global	_TRISB2
_TRISB2	set	0x432
	global	_TRISB1
_TRISB1	set	0x431
	global	_TRISA7
_TRISA7	set	0x42F
	global	_TRISA6
_TRISA6	set	0x42E
	global	_TRISB0
_TRISB0	set	0x430
psect	strings,class=STRING,delta=2,noexec
global __pstrings
__pstrings:
stringtab:
	global    __stringtab
__stringtab:
;	String table - string pointers are 1 byte each
stringcode:stringdir:
movlw high(stringdir)
movwf pclath
movf fsr,w
incf fsr
	addwf pc
	global __stringbase
__stringbase:
	retlw	0
psect	strings
	global    __end_of__stringtab
__end_of__stringtab:
	
STR_1:	
	retlw	109	;'m'
	retlw	121	;'y'
	retlw	32	;' '
	retlw	102	;'f'
	retlw	105	;'i'
	retlw	114	;'r'
	retlw	115	;'s'
	retlw	116	;'t'
	retlw	32	;' '
	retlw	103	;'g'
	retlw	111	;'o'
	retlw	97	;'a'
	retlw	108	;'l'
	retlw	32	;' '
	retlw	105	;'i'
	retlw	115	;'s'
	retlw	32	;' '
	retlw	109	;'m'
	retlw	101	;'e'
	retlw	116	;'t'
	retlw	0
psect	strings
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
_data:
       ds      1

psect	dataCOMMON,class=COMMON,space=1,noexec
global __pdataCOMMON
__pdataCOMMON:
	file	"proceso.c"
	line	16
_PTR_HELLO:
       ds      1

	file	"main.s"
	line	#
; Initialize objects allocated to COMMON
	global __pidataCOMMON
psect cinit,class=CODE,delta=2,merge=1
	fcall	__pidataCOMMON+0		;fetch initializer
	movwf	__pdataCOMMON+0&07fh		
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
?_config_display:	; 1 bytes @ 0x0
?_init_display:	; 1 bytes @ 0x0
?_config_usart:	; 1 bytes @ 0x0
?_write_display:	; 1 bytes @ 0x0
?_basic_setup:	; 1 bytes @ 0x0
?_main:	; 1 bytes @ 0x0
?_general_isr:	; 1 bytes @ 0x0
??_general_isr:	; 1 bytes @ 0x0
?_send_command_lcd:	; 1 bytes @ 0x0
?_init_lcd:	; 1 bytes @ 0x0
?_config_interface_lcd:	; 1 bytes @ 0x0
?_write_char:	; 1 bytes @ 0x0
	ds	2
??_loop:	; 1 bytes @ 0x2
??_config_usart:	; 1 bytes @ 0x2
??_basic_setup:	; 1 bytes @ 0x2
??_send_command_lcd:	; 1 bytes @ 0x2
??_init_lcd:	; 1 bytes @ 0x2
??_config_interface_lcd:	; 1 bytes @ 0x2
	ds	1
	global	send_command_lcd@command
send_command_lcd@command:	; 1 bytes @ 0x3
	ds	1
??_init_display:	; 1 bytes @ 0x4
??_write_char:	; 1 bytes @ 0x4
	global	write_char@caracter
write_char@caracter:	; 1 bytes @ 0x4
	ds	1
??_config_display:	; 1 bytes @ 0x5
??_write_display:	; 1 bytes @ 0x5
	global	write_display@ptr
write_display@ptr:	; 1 bytes @ 0x5
	ds	1
	global	write_display@i
write_display@i:	; 1 bytes @ 0x6
	ds	1
??_setup:	; 1 bytes @ 0x7
??_main:	; 1 bytes @ 0x7
;!
;!Data Sizes:
;!    Strings     21
;!    Constant    0
;!    Data        1
;!    BSS         1
;!    Persistent  0
;!    Stack       0
;!
;!Auto Spaces:
;!    Space          Size  Autos    Used
;!    COMMON           14      7       9
;!    BANK0            80      0       0
;!    BANK1            80      0       0
;!    BANK2            48      0       0

;!
;!Pointer List with Targets:
;!
;!    write_display@ptr	PTR unsigned char  size(1) Largest target is 21
;!		 -> STR_1(CODE[21]), 
;!
;!    PTR_HELLO	PTR unsigned char  size(1) Largest target is 21
;!		 -> STR_1(CODE[21]), 
;!


;!
;!Critical Paths under _main in COMMON
;!
;!    _setup->_write_display
;!    _write_display->_write_char
;!    _write_char->_send_command_lcd
;!    _init_display->_send_command_lcd
;!    _config_display->_init_lcd
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
;! (0) _main                                                 0     0      0     198
;!                        _basic_setup
;!                               _loop
;!                              _setup
;! ---------------------------------------------------------------------------------
;! (1) _setup                                                0     0      0     198
;!                     _config_display
;!                       _config_usart
;!                       _init_display
;!                      _write_display
;! ---------------------------------------------------------------------------------
;! (2) _write_display                                        2     2      0     168
;!                                              5 COMMON     2     2      0
;!                         _write_char
;! ---------------------------------------------------------------------------------
;! (3) _write_char                                           1     1      0      45
;!                                              4 COMMON     1     1      0
;!                   _send_command_lcd
;! ---------------------------------------------------------------------------------
;! (2) _init_display                                         2     2      0      30
;!                                              4 COMMON     2     2      0
;!                   _send_command_lcd
;! ---------------------------------------------------------------------------------
;! (4) _send_command_lcd                                     2     2      0      30
;!                                              2 COMMON     2     2      0
;! ---------------------------------------------------------------------------------
;! (2) _config_usart                                         0     0      0       0
;! ---------------------------------------------------------------------------------
;! (2) _config_display                                       0     0      0       0
;!               _config_interface_lcd
;!                           _init_lcd
;! ---------------------------------------------------------------------------------
;! (3) _init_lcd                                             3     3      0       0
;!                                              2 COMMON     3     3      0
;! ---------------------------------------------------------------------------------
;! (3) _config_interface_lcd                                 0     0      0       0
;! ---------------------------------------------------------------------------------
;! (1) _loop                                                 0     0      0       0
;! ---------------------------------------------------------------------------------
;! (1) _basic_setup                                          0     0      0       0
;! ---------------------------------------------------------------------------------
;! Estimated maximum stack depth 4
;! ---------------------------------------------------------------------------------
;! (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;! ---------------------------------------------------------------------------------
;! (5) _general_isr                                          2     2      0       0
;!                                              0 COMMON     2     2      0
;! ---------------------------------------------------------------------------------
;! Estimated maximum stack depth 5
;! ---------------------------------------------------------------------------------
;!
;! Call Graph Graphs:
;!
;! _main (ROOT)
;!   _basic_setup
;!   _loop
;!   _setup
;!     _config_display
;!       _config_interface_lcd
;!       _init_lcd
;!     _config_usart
;!     _init_display
;!       _send_command_lcd
;!     _write_display
;!       _write_char
;!         _send_command_lcd
;!
;! _general_isr (ROOT)
;!

;! Address spaces:

;!Name               Size   Autos  Total    Cost      Usage
;!SFR3                 0      0       0       4        0.0%
;!BITSFR3              0      0       0       4        0.0%
;!BANK2               30      0       0       9        0.0%
;!BITBANK2            30      0       0       8        0.0%
;!SFR2                 0      0       0       5        0.0%
;!BITSFR2              0      0       0       5        0.0%
;!BANK1               50      0       0       7        0.0%
;!BITBANK1            50      0       0       6        0.0%
;!SFR1                 0      0       0       2        0.0%
;!BITSFR1              0      0       0       2        0.0%
;!BANK0               50      0       0       3        0.0%
;!BITBANK0            50      0       0       5        0.0%
;!SFR0                 0      0       0       1        0.0%
;!BITSFR0              0      0       0       1        0.0%
;!COMMON               E      7       9       1       64.3%
;!BITCOMMON            E      0       0       0        0.0%
;!CODE                 0      0       0       0        0.0%
;!DATA                 0      0       9      10        0.0%
;!ABS                  0      0       9       4        0.0%
;!NULL                 0      0       0       0        0.0%
;!STACK                0      0       0       2        0.0%
;!EEDATA              80      0       0       0        0.0%

	global	_main

;; *************** function _main *****************
;; Defined at:
;;		line 16 in file "main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+1, pclath, cstack
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
;; Hardware stack levels required when called:    5
;; This function calls:
;;		_basic_setup
;;		_loop
;;		_setup
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext,global,class=CODE,delta=2,split=1,group=0
	file	"main.c"
	line	16
global __pmaintext
__pmaintext:	;psect for function _main
psect	maintext
	file	"main.c"
	line	16
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
;incstack = 0
	callstack 3
; Regs used in _main: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
	line	17
	
l825:	
	fcall	_basic_setup
	line	18
	
l827:	
	fcall	_setup
	line	20
	
l829:	
	bsf	(11),7	;volatile
	line	23
	
l831:	
	fcall	_loop
	goto	l831
	global	start
	ljmp	start
	callstack 0
	line	25
GLOBAL	__end_of_main
	__end_of_main:
	signat	_main,89
	global	_setup

;; *************** function _setup *****************
;; Defined at:
;;		line 21 in file "proceso.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+1, pclath, cstack
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
;; Hardware stack levels required when called:    4
;; This function calls:
;;		_config_display
;;		_config_usart
;;		_init_display
;;		_write_display
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text1,local,class=CODE,delta=2,merge=1,group=0
	file	"proceso.c"
	line	21
global __ptext1
__ptext1:	;psect for function _setup
psect	text1
	file	"proceso.c"
	line	21
	global	__size_of_setup
	__size_of_setup	equ	__end_of_setup-_setup
	
_setup:	
;incstack = 0
	callstack 3
; Regs used in _setup: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
	line	22
	
l817:	
	fcall	_config_display
	line	23
	fcall	_init_display
	line	25
	
l819:	
	fcall	_config_usart
	line	27
	
l821:	
	movlw	(low((((STR_1)-__stringbase)|8000h)))&0ffh
	fcall	_write_display
	line	29
	
l823:	
	clrf	(_data)
	line	30
	
l53:	
	return
	callstack 0
GLOBAL	__end_of_setup
	__end_of_setup:
	signat	_setup,89
	global	_write_display

;; *************** function _write_display *****************
;; Defined at:
;;		line 94 in file "lcd_display_8b.c"
;; Parameters:    Size  Location     Type
;;  ptr             1    wreg     PTR unsigned char 
;;		 -> STR_1(21), 
;; Auto vars:     Size  Location     Type
;;  ptr             1    5[COMMON] PTR unsigned char 
;;		 -> STR_1(21), 
;;  i               1    6[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         2       0       0       0
;;      Temps:          0       0       0       0
;;      Totals:         2       0       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		_write_char
;; This function is called by:
;;		_setup
;; This function uses a non-reentrant model
;;
psect	text2,local,class=CODE,delta=2,merge=1,group=0
	file	"lcd_display_8b.c"
	line	94
global __ptext2
__ptext2:	;psect for function _write_display
psect	text2
	file	"lcd_display_8b.c"
	line	94
	global	__size_of_write_display
	__size_of_write_display	equ	__end_of_write_display-_write_display
	
_write_display:	
;incstack = 0
	callstack 3
; Regs used in _write_display: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
	movwf	(write_display@ptr)
	line	95
	
l809:	
	clrf	(write_display@i)
	line	97
	goto	l815
	line	98
	
l811:	
	movf	(write_display@i),w
	addwf	(write_display@ptr),w
	movwf	fsr0
	fcall	stringdir
	fcall	_write_char
	line	99
	
l813:	
	movlw	low(01h)
	movwf	btemp+1
	movf	btemp+1,w
	addwf	(write_display@i),f
	line	97
	
l815:	
	movf	(write_display@i),w
	addwf	(write_display@ptr),w
	movwf	fsr0
	fcall	stringdir
	xorlw	0
	skipz
	goto	u41
	goto	u40
u41:
	goto	l811
u40:
	line	101
	
l102:	
	return
	callstack 0
GLOBAL	__end_of_write_display
	__end_of_write_display:
	signat	_write_display,4217
	global	_write_char

;; *************** function _write_char *****************
;; Defined at:
;;		line 87 in file "lcd_display_8b.c"
;; Parameters:    Size  Location     Type
;;  caracter        1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  caracter        1    4[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         1       0       0       0
;;      Temps:          0       0       0       0
;;      Totals:         1       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_send_command_lcd
;; This function is called by:
;;		_write_display
;; This function uses a non-reentrant model
;;
psect	text3,local,class=CODE,delta=2,merge=1,group=0
	line	87
global __ptext3
__ptext3:	;psect for function _write_char
psect	text3
	file	"lcd_display_8b.c"
	line	87
	global	__size_of_write_char
	__size_of_write_char	equ	__end_of_write_char-_write_char
	
_write_char:	
;incstack = 0
	callstack 3
; Regs used in _write_char: [wreg+status,2+status,0+btemp+1+pclath+cstack]
	movwf	(write_char@caracter)
	line	88
	
l727:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(5),7	;volatile
	line	89
	
l729:	
	movf	(write_char@caracter),w
	fcall	_send_command_lcd
	line	90
	
l731:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(5),7	;volatile
	line	91
	
l96:	
	return
	callstack 0
GLOBAL	__end_of_write_char
	__end_of_write_char:
	signat	_write_char,4217
	global	_init_display

;; *************** function _init_display *****************
;; Defined at:
;;		line 78 in file "lcd_display_8b.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, status,0, btemp+1, pclath, cstack
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
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_send_command_lcd
;; This function is called by:
;;		_setup
;; This function uses a non-reentrant model
;;
psect	text4,local,class=CODE,delta=2,merge=1,group=0
	line	78
global __ptext4
__ptext4:	;psect for function _init_display
psect	text4
	file	"lcd_display_8b.c"
	line	78
	global	__size_of_init_display
	__size_of_init_display	equ	__end_of_init_display-_init_display
	
_init_display:	
;incstack = 0
	callstack 4
; Regs used in _init_display: [wreg+status,2+status,0+btemp+1+pclath+cstack]
	line	79
	
l737:	
	movlw	low(038h)
	fcall	_send_command_lcd
	line	80
	
l739:	
	asmopt push
asmopt off
movlw	3
movwf	((??_init_display+0)+0+1),f
	movlw	151
movwf	((??_init_display+0)+0),f
	u57:
decfsz	((??_init_display+0)+0),f
	goto	u57
	decfsz	((??_init_display+0)+0+1),f
	goto	u57
	nop2
asmopt pop

	line	81
	
l741:	
	movlw	low(0Eh)
	fcall	_send_command_lcd
	line	82
	asmopt push
asmopt off
movlw	3
movwf	((??_init_display+0)+0+1),f
	movlw	151
movwf	((??_init_display+0)+0),f
	u67:
decfsz	((??_init_display+0)+0),f
	goto	u67
	decfsz	((??_init_display+0)+0+1),f
	goto	u67
	nop2
asmopt pop

	line	83
	
l743:	
	movlw	low(06h)
	fcall	_send_command_lcd
	line	84
	
l745:	
	asmopt push
asmopt off
movlw	3
movwf	((??_init_display+0)+0+1),f
	movlw	151
movwf	((??_init_display+0)+0),f
	u77:
decfsz	((??_init_display+0)+0),f
	goto	u77
	decfsz	((??_init_display+0)+0+1),f
	goto	u77
	nop2
asmopt pop

	line	85
	
l93:	
	return
	callstack 0
GLOBAL	__end_of_init_display
	__end_of_init_display:
	signat	_init_display,89
	global	_send_command_lcd

;; *************** function _send_command_lcd *****************
;; Defined at:
;;		line 22 in file "lcd_display_8b.c"
;; Parameters:    Size  Location     Type
;;  command         1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  command         1    3[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, status,0, btemp+1
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         1       0       0       0
;;      Temps:          1       0       0       0
;;      Totals:         2       0       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_init_display
;;		_write_char
;; This function uses a non-reentrant model
;;
psect	text5,local,class=CODE,delta=2,merge=1,group=0
	line	22
global __ptext5
__ptext5:	;psect for function _send_command_lcd
psect	text5
	file	"lcd_display_8b.c"
	line	22
	global	__size_of_send_command_lcd
	__size_of_send_command_lcd	equ	__end_of_send_command_lcd-_send_command_lcd
	
_send_command_lcd:	
;incstack = 0
	callstack 3
; Regs used in _send_command_lcd: [wreg+status,2+status,0+btemp+1]
	movwf	(send_command_lcd@command)
	line	24
	
l709:	
	movlw	low(0F0h)
	movwf	btemp+1
	movf	btemp+1,w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	andwf	(5),f	;volatile
	line	25
	movf	(send_command_lcd@command),w
	andlw	0Fh
	movwf	btemp+1
	movf	btemp+1,w
	iorwf	(5),f	;volatile
	line	27
	movlw	low(0Fh)
	movwf	btemp+1
	movf	btemp+1,w
	andwf	(6),f	;volatile
	line	28
	movf	(send_command_lcd@command),w
	andlw	0F0h
	movwf	btemp+1
	movf	btemp+1,w
	iorwf	(6),f	;volatile
	line	30
	
l711:	
	bsf	(6),0	;volatile
	line	31
	
l713:	
	bcf	(6),0	;volatile
	line	33
	
l715:	
	asmopt push
asmopt off
	movlw	33
movwf	((??_send_command_lcd+0)+0),f
	u87:
decfsz	(??_send_command_lcd+0)+0,f
	goto	u87
asmopt pop

	line	34
	
l81:	
	return
	callstack 0
GLOBAL	__end_of_send_command_lcd
	__end_of_send_command_lcd:
	signat	_send_command_lcd,4217
	global	_config_usart

;; *************** function _config_usart *****************
;; Defined at:
;;		line 3 in file "usart.c"
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
psect	text6,local,class=CODE,delta=2,merge=1,group=0
	file	"usart.c"
	line	3
global __ptext6
__ptext6:	;psect for function _config_usart
psect	text6
	file	"usart.c"
	line	3
	global	__size_of_config_usart
	__size_of_config_usart	equ	__end_of_config_usart-_config_usart
	
_config_usart:	
;incstack = 0
	callstack 5
; Regs used in _config_usart: [wreg]
	line	4
	
l747:	
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1073/8)^080h,(1073)&7	;volatile
	line	5
	bsf	(1074/8)^080h,(1074)&7	;volatile
	line	7
	bsf	(152)^080h,2	;volatile
	line	8
	
l749:	
	movlw	low(015h)
	movwf	(153)^080h	;volatile
	line	10
	
l751:	
	bcf	(152)^080h,4	;volatile
	line	12
	
l753:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(24),7	;volatile
	line	14
	
l755:	
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bcf	(152)^080h,6	;volatile
	line	15
	
l757:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(24),6	;volatile
	line	17
	
l759:	
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bcf	(140)^080h,4	;volatile
	line	18
	
l761:	
	bcf	(140)^080h,5	;volatile
	line	20
	
l763:	
	bsf	(152)^080h,5	;volatile
	line	21
	
l765:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(24),4	;volatile
	line	22
	
l117:	
	return
	callstack 0
GLOBAL	__end_of_config_usart
	__end_of_config_usart:
	signat	_config_usart,89
	global	_config_display

;; *************** function _config_display *****************
;; Defined at:
;;		line 73 in file "lcd_display_8b.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, status,0, btemp+1, pclath, cstack
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
;;		_config_interface_lcd
;;		_init_lcd
;; This function is called by:
;;		_setup
;; This function uses a non-reentrant model
;;
psect	text7,local,class=CODE,delta=2,merge=1,group=0
	file	"lcd_display_8b.c"
	line	73
global __ptext7
__ptext7:	;psect for function _config_display
psect	text7
	file	"lcd_display_8b.c"
	line	73
	global	__size_of_config_display
	__size_of_config_display	equ	__end_of_config_display-_config_display
	
_config_display:	
;incstack = 0
	callstack 4
; Regs used in _config_display: [wreg+status,2+status,0+btemp+1+pclath+cstack]
	line	74
	
l733:	
	fcall	_config_interface_lcd
	line	75
	
l735:	
	fcall	_init_lcd
	line	76
	
l90:	
	return
	callstack 0
GLOBAL	__end_of_config_display
	__end_of_config_display:
	signat	_config_display,89
	global	_init_lcd

;; *************** function _init_lcd *****************
;; Defined at:
;;		line 59 in file "lcd_display_8b.c"
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
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         0       0       0       0
;;      Temps:          3       0       0       0
;;      Totals:         3       0       0       0
;;Total ram usage:        3 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_config_display
;; This function uses a non-reentrant model
;;
psect	text8,local,class=CODE,delta=2,merge=1,group=0
	line	59
global __ptext8
__ptext8:	;psect for function _init_lcd
psect	text8
	file	"lcd_display_8b.c"
	line	59
	global	__size_of_init_lcd
	__size_of_init_lcd	equ	__end_of_init_lcd-_init_lcd
	
_init_lcd:	
;incstack = 0
	callstack 4
; Regs used in _init_lcd: [wreg]
	line	60
	
l717:	
	asmopt push
asmopt off
movlw  2
movwf	((??_init_lcd+0)+0+2),f
movlw	4
movwf	((??_init_lcd+0)+0+1),f
	movlw	186
movwf	((??_init_lcd+0)+0),f
	u97:
decfsz	((??_init_lcd+0)+0),f
	goto	u97
	decfsz	((??_init_lcd+0)+0+1),f
	goto	u97
	decfsz	((??_init_lcd+0)+0+2),f
	goto	u97
	nop
asmopt pop

	line	61
	
l84:	
	return
	callstack 0
GLOBAL	__end_of_init_lcd
	__end_of_init_lcd:
	signat	_init_lcd,89
	global	_config_interface_lcd

;; *************** function _config_interface_lcd *****************
;; Defined at:
;;		line 64 in file "lcd_display_8b.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, status,0, btemp+1
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
;;		_config_display
;; This function uses a non-reentrant model
;;
psect	text9,local,class=CODE,delta=2,merge=1,group=0
	line	64
global __ptext9
__ptext9:	;psect for function _config_interface_lcd
psect	text9
	file	"lcd_display_8b.c"
	line	64
	global	__size_of_config_interface_lcd
	__size_of_config_interface_lcd	equ	__end_of_config_interface_lcd-_config_interface_lcd
	
_config_interface_lcd:	
;incstack = 0
	callstack 4
; Regs used in _config_interface_lcd: [wreg+status,2+status,0+btemp+1]
	line	65
	
l719:	
	movlw	low(0F0h)
	movwf	btemp+1
	movf	btemp+1,w
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	andwf	(133)^080h,f	;volatile
	line	66
	movlw	low(0Fh)
	movwf	btemp+1
	movf	btemp+1,w
	andwf	(134)^080h,f	;volatile
	line	68
	
l721:	
	bcf	(1072/8)^080h,(1072)&7	;volatile
	line	69
	
l723:	
	bcf	(1070/8)^080h,(1070)&7	;volatile
	line	70
	
l725:	
	bcf	(1071/8)^080h,(1071)&7	;volatile
	line	71
	
l87:	
	return
	callstack 0
GLOBAL	__end_of_config_interface_lcd
	__end_of_config_interface_lcd:
	signat	_config_interface_lcd,89
	global	_loop

;; *************** function _loop *****************
;; Defined at:
;;		line 35 in file "proceso.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, status,0, btemp+1
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
psect	text10,local,class=CODE,delta=2,merge=1,group=0
	file	"proceso.c"
	line	35
global __ptext10
__ptext10:	;psect for function _loop
psect	text10
	file	"proceso.c"
	line	35
	global	__size_of_loop
	__size_of_loop	equ	__end_of_loop-_loop
	
_loop:	
;incstack = 0
	callstack 6
; Regs used in _loop: [wreg+status,2+status,0+btemp+1]
	line	36
	
l791:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	btfss	(12),4	;volatile
	goto	u21
	goto	u20
u21:
	goto	l795
u20:
	line	37
	
l793:	
	movf	(_data),w
	movwf	(25)	;volatile
	line	40
	
l795:	
	btfss	(12),5	;volatile
	goto	u31
	goto	u30
u31:
	goto	l58
u30:
	line	41
	
l797:	
	movf	(26),w	;volatile
	addlw	01h
	movwf	btemp+1
	movf	btemp+1,w
	movwf	(_data)
	line	43
	
l58:	
	return
	callstack 0
GLOBAL	__end_of_loop
	__end_of_loop:
	signat	_loop,89
	global	_basic_setup

;; *************** function _basic_setup *****************
;; Defined at:
;;		line 6 in file "main.c"
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
psect	text11,local,class=CODE,delta=2,merge=1,group=0
	file	"main.c"
	line	6
global __ptext11
__ptext11:	;psect for function _basic_setup
psect	text11
	file	"main.c"
	line	6
	global	__size_of_basic_setup
	__size_of_basic_setup	equ	__end_of_basic_setup-_basic_setup
	
_basic_setup:	
;incstack = 0
	callstack 6
; Regs used in _basic_setup: [wreg+status,2]
	line	7
	
l775:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(5)	;volatile
	line	8
	clrf	(6)	;volatile
	line	10
	
l777:	
	movlw	low(07h)
	movwf	(31)	;volatile
	line	12
	
l779:	
	movlw	low(0FFh)
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(133)^080h	;volatile
	line	13
	
l781:	
	movlw	low(0FFh)
	movwf	(134)^080h	;volatile
	line	14
	
l19:	
	return
	callstack 0
GLOBAL	__end_of_basic_setup
	__end_of_basic_setup:
	signat	_basic_setup,89
	global	_general_isr

;; *************** function _general_isr *****************
;; Defined at:
;;		line 12 in file "proceso.c"
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
psect	text12,local,class=CODE,delta=2,merge=1,group=0
	file	"proceso.c"
	line	12
global __ptext12
__ptext12:	;psect for function _general_isr
psect	text12
	file	"proceso.c"
	line	12
	global	__size_of_general_isr
	__size_of_general_isr	equ	__end_of_general_isr-_general_isr
	
_general_isr:	
;incstack = 0
	callstack 3
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
psect	text12
	line	13
	
i1l807:	
	line	14
	
i1l48:	
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
