subtitle "Microchip MPLAB XC8 C Compiler v2.46 (Free license) build 20240104201356 Og1 "

pagewidth 120

	opt flic

	processor	16F874A
include "/opt/microchip/xc8/v2.46/pic/include/proc/16f874a.cgen.inc"
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
# 54 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
INDF equ 00h ;# 
# 61 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
TMR0 equ 01h ;# 
# 68 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
PCL equ 02h ;# 
# 75 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
STATUS equ 03h ;# 
# 161 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
FSR equ 04h ;# 
# 168 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
PORTA equ 05h ;# 
# 218 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
PORTB equ 06h ;# 
# 280 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
PORTC equ 07h ;# 
# 342 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
PORTD equ 08h ;# 
# 404 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
PORTE equ 09h ;# 
# 436 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
PCLATH equ 0Ah ;# 
# 456 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
INTCON equ 0Bh ;# 
# 534 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
PIR1 equ 0Ch ;# 
# 596 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
PIR2 equ 0Dh ;# 
# 636 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
TMR1 equ 0Eh ;# 
# 643 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
TMR1L equ 0Eh ;# 
# 650 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
TMR1H equ 0Fh ;# 
# 657 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
T1CON equ 010h ;# 
# 732 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
TMR2 equ 011h ;# 
# 739 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
T2CON equ 012h ;# 
# 810 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
SSPBUF equ 013h ;# 
# 817 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
SSPCON equ 014h ;# 
# 887 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
CCPR1 equ 015h ;# 
# 894 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
CCPR1L equ 015h ;# 
# 901 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
CCPR1H equ 016h ;# 
# 908 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
CCP1CON equ 017h ;# 
# 966 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
RCSTA equ 018h ;# 
# 1061 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
TXREG equ 019h ;# 
# 1068 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
RCREG equ 01Ah ;# 
# 1075 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
CCPR2 equ 01Bh ;# 
# 1082 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
CCPR2L equ 01Bh ;# 
# 1089 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
CCPR2H equ 01Ch ;# 
# 1096 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
CCP2CON equ 01Dh ;# 
# 1154 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
ADRESH equ 01Eh ;# 
# 1161 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
ADCON0 equ 01Fh ;# 
# 1257 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
OPTION_REG equ 081h ;# 
# 1327 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
TRISA equ 085h ;# 
# 1377 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
TRISB equ 086h ;# 
# 1439 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
TRISC equ 087h ;# 
# 1501 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
TRISD equ 088h ;# 
# 1563 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
TRISE equ 089h ;# 
# 1620 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
PIE1 equ 08Ch ;# 
# 1682 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
PIE2 equ 08Dh ;# 
# 1722 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
PCON equ 08Eh ;# 
# 1756 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
SSPCON2 equ 091h ;# 
# 1818 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
PR2 equ 092h ;# 
# 1825 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
SSPADD equ 093h ;# 
# 1832 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
SSPSTAT equ 094h ;# 
# 2001 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
TXSTA equ 098h ;# 
# 2082 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
SPBRG equ 099h ;# 
# 2089 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
CMCON equ 09Ch ;# 
# 2159 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
CVRCON equ 09Dh ;# 
# 2224 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
ADRESL equ 09Eh ;# 
# 2231 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
ADCON1 equ 09Fh ;# 
# 2290 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
EEDATA equ 010Ch ;# 
# 2297 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
EEADR equ 010Dh ;# 
# 2304 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
EEDATH equ 010Eh ;# 
# 2311 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
EEADRH equ 010Fh ;# 
# 2318 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
EECON1 equ 018Ch ;# 
# 2363 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
EECON2 equ 018Dh ;# 
# 54 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
INDF equ 00h ;# 
# 61 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
TMR0 equ 01h ;# 
# 68 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
PCL equ 02h ;# 
# 75 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
STATUS equ 03h ;# 
# 161 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
FSR equ 04h ;# 
# 168 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
PORTA equ 05h ;# 
# 218 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
PORTB equ 06h ;# 
# 280 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
PORTC equ 07h ;# 
# 342 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
PORTD equ 08h ;# 
# 404 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
PORTE equ 09h ;# 
# 436 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
PCLATH equ 0Ah ;# 
# 456 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
INTCON equ 0Bh ;# 
# 534 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
PIR1 equ 0Ch ;# 
# 596 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
PIR2 equ 0Dh ;# 
# 636 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
TMR1 equ 0Eh ;# 
# 643 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
TMR1L equ 0Eh ;# 
# 650 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
TMR1H equ 0Fh ;# 
# 657 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
T1CON equ 010h ;# 
# 732 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
TMR2 equ 011h ;# 
# 739 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
T2CON equ 012h ;# 
# 810 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
SSPBUF equ 013h ;# 
# 817 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
SSPCON equ 014h ;# 
# 887 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
CCPR1 equ 015h ;# 
# 894 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
CCPR1L equ 015h ;# 
# 901 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
CCPR1H equ 016h ;# 
# 908 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
CCP1CON equ 017h ;# 
# 966 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
RCSTA equ 018h ;# 
# 1061 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
TXREG equ 019h ;# 
# 1068 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
RCREG equ 01Ah ;# 
# 1075 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
CCPR2 equ 01Bh ;# 
# 1082 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
CCPR2L equ 01Bh ;# 
# 1089 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
CCPR2H equ 01Ch ;# 
# 1096 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
CCP2CON equ 01Dh ;# 
# 1154 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
ADRESH equ 01Eh ;# 
# 1161 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
ADCON0 equ 01Fh ;# 
# 1257 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
OPTION_REG equ 081h ;# 
# 1327 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
TRISA equ 085h ;# 
# 1377 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
TRISB equ 086h ;# 
# 1439 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
TRISC equ 087h ;# 
# 1501 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
TRISD equ 088h ;# 
# 1563 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
TRISE equ 089h ;# 
# 1620 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
PIE1 equ 08Ch ;# 
# 1682 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
PIE2 equ 08Dh ;# 
# 1722 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
PCON equ 08Eh ;# 
# 1756 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
SSPCON2 equ 091h ;# 
# 1818 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
PR2 equ 092h ;# 
# 1825 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
SSPADD equ 093h ;# 
# 1832 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
SSPSTAT equ 094h ;# 
# 2001 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
TXSTA equ 098h ;# 
# 2082 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
SPBRG equ 099h ;# 
# 2089 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
CMCON equ 09Ch ;# 
# 2159 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
CVRCON equ 09Dh ;# 
# 2224 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
ADRESL equ 09Eh ;# 
# 2231 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
ADCON1 equ 09Fh ;# 
# 2290 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
EEDATA equ 010Ch ;# 
# 2297 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
EEADR equ 010Dh ;# 
# 2304 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
EEDATH equ 010Eh ;# 
# 2311 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
EEADRH equ 010Fh ;# 
# 2318 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
EECON1 equ 018Ch ;# 
# 2363 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f874a.h"
EECON2 equ 018Dh ;# 
	debug_source C
	FNCALL	_main,_loop
	FNCALL	_main,_setup
	FNROOT	_main
	global	_PORTAbits
_PORTAbits	set	0x5
	global	_PORTA
_PORTA	set	0x5
	global	_TRISA
_TRISA	set	0x85
	global	_CMCON
_CMCON	set	0x9C
; #config settings
	config pad_punits      = on
	config apply_mask      = off
	config ignore_cmsgs    = off
	config default_configs = off
	config default_idlocs  = off
	config FOSC = "HS"
	config WDTE = "OFF"
	config PWRTE = "ON"
	config BOREN = "ON"
	config LVP = "OFF"
	config CPD = "OFF"
	config WRT = "OFF"
	config DEBUG = "OFF"
	config CP = "OFF"
	file	"01_led_blink.s"
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
??_setup:	; 1 bytes @ 0x0
??_loop:	; 1 bytes @ 0x0
??_main:	; 1 bytes @ 0x0
psect	cstackBANK0,class=BANK0,space=1,noexec
global __pcstackBANK0
__pcstackBANK0:
?_setup:	; 1 bytes @ 0x0
?_loop:	; 1 bytes @ 0x0
?_main:	; 1 bytes @ 0x0
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
;!    COMMON            0      0       0
;!    BANK0            94      0       0
;!    BANK1            94      0       0

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
;!                               _loop
;!                              _setup
;! ---------------------------------------------------------------------------------
;! (1) _setup                                                0     0      0       0
;! ---------------------------------------------------------------------------------
;! (1) _loop                                                 0     0      0       0
;! ---------------------------------------------------------------------------------
;! Estimated maximum stack depth 1
;! ---------------------------------------------------------------------------------
;!
;! Call Graph Graphs:
;!
;! _main (ROOT)
;!   _loop
;!   _setup
;!

;! Address spaces:

;!Name               Size   Autos  Total    Cost      Usage
;!BITCOMMON            0      0       0       0        0.0%
;!EEDATA              80      0       0       0        0.0%
;!NULL                 0      0       0       0        0.0%
;!CODE                 0      0       0       0        0.0%
;!BITSFR0              0      0       0       1        0.0%
;!SFR0                 0      0       0       1        0.0%
;!COMMON               0      0       0       1        0.0%
;!BITSFR1              0      0       0       2        0.0%
;!SFR1                 0      0       0       2        0.0%
;!STACK                0      0       0       2        0.0%
;!BITBANK0            5E      0       0       3        0.0%
;!BANK0               5E      0       0       4        0.0%
;!BITSFR3              0      0       0       4        0.0%
;!SFR3                 0      0       0       4        0.0%
;!BITBANK1            5E      0       0       5        0.0%
;!BITSFR2              0      0       0       5        0.0%
;!SFR2                 0      0       0       5        0.0%
;!BANK1               5E      0       0       6        0.0%
;!ABS                  0      0       0       7        0.0%
;!DATA                 0      0       0       8        0.0%

	global	_main

;; *************** function _main *****************
;; Defined at:
;;		line 30 in file "01_led_blink.c"
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
;;		_loop
;;		_setup
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext,global,class=CODE,delta=2,split=1,group=0
	file	"01_led_blink.c"
	line	30
global __pmaintext
__pmaintext:	;psect for function _main
psect	maintext
	file	"01_led_blink.c"
	line	30
	
_main:	
;incstack = 0
	callstack 7
; Regs used in _main: [wreg+status,2+status,0+pclath+cstack]
	line	31
	
l586:	
	fcall	_setup
	line	34
	
l588:	
	fcall	_loop
	goto	l588
	global	start
	ljmp	start
	callstack 0
	line	36
GLOBAL	__end_of_main
	__end_of_main:
	signat	_main,89
	global	_setup

;; *************** function _setup *****************
;; Defined at:
;;		line 18 in file "01_led_blink.c"
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
	line	18
global __ptext1
__ptext1:	;psect for function _setup
psect	text1
	file	"01_led_blink.c"
	line	18
	
_setup:	
;incstack = 0
	callstack 7
; Regs used in _setup: [wreg+status,2]
	line	19
	
l578:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(5)	;volatile
	line	20
	
l580:	
	movlw	low(07h)
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(156)^080h	;volatile
	line	21
	
l582:	
	movlw	low(0FEh)
	movwf	(133)^080h	;volatile
	line	22
	
l11:	
	return
	callstack 0
GLOBAL	__end_of_setup
	__end_of_setup:
	signat	_setup,89
	global	_loop

;; *************** function _loop *****************
;; Defined at:
;;		line 24 in file "01_led_blink.c"
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
psect	text2,local,class=CODE,delta=2,merge=1,group=0
	line	24
global __ptext2
__ptext2:	;psect for function _loop
psect	text2
	file	"01_led_blink.c"
	line	24
	
_loop:	
;incstack = 0
	callstack 7
; Regs used in _loop: []
	line	25
	
l584:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(5),0	;volatile
	line	26
# 26 "01_led_blink.c"
nop ;# 
psect	text2
	line	27
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(5),0	;volatile
	line	28
	
l14:	
	return
	callstack 0
GLOBAL	__end_of_loop
	__end_of_loop:
	signat	_loop,89
global	___latbits
___latbits	equ	1
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp+0
	end
