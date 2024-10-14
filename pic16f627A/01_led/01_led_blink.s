subtitle "Microchip MPLAB XC8 C Compiler v2.46 (Free license) build 20240104201356 Og1 "

pagewidth 120

	opt flic

	processor	16F627A
include "/opt/microchip/xc8/v2.46/pic/include/proc/16f627a.cgen.inc"
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
# 54 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
INDF equ 00h ;# 
# 61 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
TMR0 equ 01h ;# 
# 68 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
PCL equ 02h ;# 
# 75 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
STATUS equ 03h ;# 
# 161 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
FSR equ 04h ;# 
# 168 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
PORTA equ 05h ;# 
# 230 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
PORTB equ 06h ;# 
# 292 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
PCLATH equ 0Ah ;# 
# 312 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
INTCON equ 0Bh ;# 
# 390 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
PIR1 equ 0Ch ;# 
# 447 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
TMR1 equ 0Eh ;# 
# 454 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
TMR1L equ 0Eh ;# 
# 461 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
TMR1H equ 0Fh ;# 
# 468 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
T1CON equ 010h ;# 
# 527 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
TMR2 equ 011h ;# 
# 534 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
T2CON equ 012h ;# 
# 605 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
CCPR1 equ 015h ;# 
# 612 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
CCPR1L equ 015h ;# 
# 619 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
CCPR1H equ 016h ;# 
# 626 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
CCP1CON equ 017h ;# 
# 684 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
RCSTA equ 018h ;# 
# 755 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
TXREG equ 019h ;# 
# 762 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
RCREG equ 01Ah ;# 
# 769 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
CMCON equ 01Fh ;# 
# 839 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
OPTION_REG equ 081h ;# 
# 909 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
TRISA equ 085h ;# 
# 971 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
TRISB equ 086h ;# 
# 1033 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
PIE1 equ 08Ch ;# 
# 1090 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
PCON equ 08Eh ;# 
# 1139 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
PR2 equ 092h ;# 
# 1146 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
TXSTA equ 098h ;# 
# 1203 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
SPBRG equ 099h ;# 
# 1210 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
EEDATA equ 09Ah ;# 
# 1217 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
EEADR equ 09Bh ;# 
# 1224 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
EECON1 equ 09Ch ;# 
# 1262 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
EECON2 equ 09Dh ;# 
# 1269 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
VRCON equ 09Fh ;# 
# 54 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
INDF equ 00h ;# 
# 61 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
TMR0 equ 01h ;# 
# 68 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
PCL equ 02h ;# 
# 75 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
STATUS equ 03h ;# 
# 161 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
FSR equ 04h ;# 
# 168 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
PORTA equ 05h ;# 
# 230 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
PORTB equ 06h ;# 
# 292 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
PCLATH equ 0Ah ;# 
# 312 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
INTCON equ 0Bh ;# 
# 390 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
PIR1 equ 0Ch ;# 
# 447 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
TMR1 equ 0Eh ;# 
# 454 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
TMR1L equ 0Eh ;# 
# 461 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
TMR1H equ 0Fh ;# 
# 468 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
T1CON equ 010h ;# 
# 527 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
TMR2 equ 011h ;# 
# 534 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
T2CON equ 012h ;# 
# 605 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
CCPR1 equ 015h ;# 
# 612 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
CCPR1L equ 015h ;# 
# 619 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
CCPR1H equ 016h ;# 
# 626 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
CCP1CON equ 017h ;# 
# 684 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
RCSTA equ 018h ;# 
# 755 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
TXREG equ 019h ;# 
# 762 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
RCREG equ 01Ah ;# 
# 769 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
CMCON equ 01Fh ;# 
# 839 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
OPTION_REG equ 081h ;# 
# 909 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
TRISA equ 085h ;# 
# 971 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
TRISB equ 086h ;# 
# 1033 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
PIE1 equ 08Ch ;# 
# 1090 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
PCON equ 08Eh ;# 
# 1139 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
PR2 equ 092h ;# 
# 1146 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
TXSTA equ 098h ;# 
# 1203 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
SPBRG equ 099h ;# 
# 1210 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
EEDATA equ 09Ah ;# 
# 1217 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
EEADR equ 09Bh ;# 
# 1224 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
EECON1 equ 09Ch ;# 
# 1262 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
EECON2 equ 09Dh ;# 
# 1269 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f627a.h"
VRCON equ 09Fh ;# 
	debug_source C
	FNCALL	_main,_loop
	FNCALL	_main,_setup
	FNROOT	_main
	global	_PORTAbits
_PORTAbits	set	0x5
	global	_CMCON
_CMCON	set	0x1F
	global	_PORTA
_PORTA	set	0x5
	global	_TRISA
_TRISA	set	0x85
; #config settings
	config pad_punits      = on
	config apply_mask      = off
	config ignore_cmsgs    = off
	config default_configs = off
	config default_idlocs  = off
	config FOSC = "INTOSCIO"
	config WDTE = "OFF"
	config PWRTE = "ON"
	config MCLRE = "OFF"
	config BOREN = "ON"
	config LVP = "OFF"
	config CPD = "OFF"
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
?_setup:	; 1 bytes @ 0x0
??_setup:	; 1 bytes @ 0x0
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
;!    BANK1            80      0       0
;!    BANK2            48      0       0

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
;!
;!Critical Paths under _main in BANK2
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
;!BITCOMMON            E      0       0       0        0.0%
;!EEDATA              80      0       0       0        0.0%
;!NULL                 0      0       0       0        0.0%
;!CODE                 0      0       0       0        0.0%
;!COMMON               E      0       0       1        0.0%
;!BITSFR0              0      0       0       1        0.0%
;!SFR0                 0      0       0       1        0.0%
;!BITSFR1              0      0       0       2        0.0%
;!SFR1                 0      0       0       2        0.0%
;!STACK                0      0       0       2        0.0%
;!BANK0               50      0       0       3        0.0%
;!BITSFR3              0      0       0       4        0.0%
;!SFR3                 0      0       0       4        0.0%
;!ABS                  0      0       0       4        0.0%
;!BITBANK0            50      0       0       5        0.0%
;!BITSFR2              0      0       0       5        0.0%
;!SFR2                 0      0       0       5        0.0%
;!BITBANK1            50      0       0       6        0.0%
;!BANK1               50      0       0       7        0.0%
;!BITBANK2            30      0       0       8        0.0%
;!BANK2               30      0       0       9        0.0%
;!DATA                 0      0       0      10        0.0%

	global	_main

;; *************** function _main *****************
;; Defined at:
;;		line 28 in file "01_led_blink.c"
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
	line	28
global __pmaintext
__pmaintext:	;psect for function _main
psect	maintext
	file	"01_led_blink.c"
	line	28
	
_main:	
;incstack = 0
	callstack 7
; Regs used in _main: [wreg+status,2+status,0+pclath+cstack]
	line	29
	
l574:	
	fcall	_setup
	line	32
	
l576:	
	fcall	_loop
	goto	l576
	global	start
	ljmp	start
	callstack 0
	line	34
GLOBAL	__end_of_main
	__end_of_main:
	signat	_main,89
	global	_setup

;; *************** function _setup *****************
;; Defined at:
;;		line 16 in file "01_led_blink.c"
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
;; Hardware stack levels used: 1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text1,local,class=CODE,delta=2,merge=1,group=0
	line	16
global __ptext1
__ptext1:	;psect for function _setup
psect	text1
	file	"01_led_blink.c"
	line	16
	
_setup:	
;incstack = 0
	callstack 7
; Regs used in _setup: [wreg+status,2]
	line	17
	
l566:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(5)	;volatile
	line	18
	
l568:	
	movlw	low(07h)
	movwf	(31)	;volatile
	line	19
	
l570:	
	movlw	low(0FEh)
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(133)^080h	;volatile
	line	20
	
l11:	
	return
	callstack 0
GLOBAL	__end_of_setup
	__end_of_setup:
	signat	_setup,89
	global	_loop

;; *************** function _loop *****************
;; Defined at:
;;		line 22 in file "01_led_blink.c"
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
;; Hardware stack levels used: 1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text2,local,class=CODE,delta=2,merge=1,group=0
	line	22
global __ptext2
__ptext2:	;psect for function _loop
psect	text2
	file	"01_led_blink.c"
	line	22
	
_loop:	
;incstack = 0
	callstack 7
; Regs used in _loop: []
	line	23
	
l572:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(5),0	;volatile
	line	24
# 24 "01_led_blink.c"
nop ;# 
psect	text2
	line	25
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(5),0	;volatile
	line	26
	
l14:	
	return
	callstack 0
GLOBAL	__end_of_loop
	__end_of_loop:
	signat	_loop,89
global	___latbits
___latbits	equ	0
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp+0
	end
