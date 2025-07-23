subtitle "Microchip MPLAB XC8 C Compiler v2.46 (Free license) build 20240104201356 Og1 "

pagewidth 120

	opt flic

	processor	16F84A
include "/opt/microchip/xc8/v2.46/pic/include/proc/16f84a.cgen.inc"
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
# 54 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
INDF equ 00h ;# 
# 61 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
TMR0 equ 01h ;# 
# 68 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
PCL equ 02h ;# 
# 75 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
STATUS equ 03h ;# 
# 161 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
FSR equ 04h ;# 
# 168 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
PORTA equ 05h ;# 
# 212 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
PORTB equ 06h ;# 
# 274 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
EEDATA equ 08h ;# 
# 281 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
EEADR equ 09h ;# 
# 288 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
PCLATH equ 0Ah ;# 
# 308 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
INTCON equ 0Bh ;# 
# 386 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
OPTION_REG equ 081h ;# 
# 456 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
TRISA equ 085h ;# 
# 500 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
TRISB equ 086h ;# 
# 562 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
EECON1 equ 088h ;# 
# 606 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
EECON2 equ 089h ;# 
# 54 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
INDF equ 00h ;# 
# 61 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
TMR0 equ 01h ;# 
# 68 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
PCL equ 02h ;# 
# 75 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
STATUS equ 03h ;# 
# 161 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
FSR equ 04h ;# 
# 168 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
PORTA equ 05h ;# 
# 212 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
PORTB equ 06h ;# 
# 274 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
EEDATA equ 08h ;# 
# 281 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
EEADR equ 09h ;# 
# 288 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
PCLATH equ 0Ah ;# 
# 308 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
INTCON equ 0Bh ;# 
# 386 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
OPTION_REG equ 081h ;# 
# 456 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
TRISA equ 085h ;# 
# 500 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
TRISB equ 086h ;# 
# 562 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
EECON1 equ 088h ;# 
# 606 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
EECON2 equ 089h ;# 
# 54 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
INDF equ 00h ;# 
# 61 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
TMR0 equ 01h ;# 
# 68 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
PCL equ 02h ;# 
# 75 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
STATUS equ 03h ;# 
# 161 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
FSR equ 04h ;# 
# 168 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
PORTA equ 05h ;# 
# 212 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
PORTB equ 06h ;# 
# 274 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
EEDATA equ 08h ;# 
# 281 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
EEADR equ 09h ;# 
# 288 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
PCLATH equ 0Ah ;# 
# 308 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
INTCON equ 0Bh ;# 
# 386 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
OPTION_REG equ 081h ;# 
# 456 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
TRISA equ 085h ;# 
# 500 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
TRISB equ 086h ;# 
# 562 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
EECON1 equ 088h ;# 
# 606 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
EECON2 equ 089h ;# 
# 54 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
INDF equ 00h ;# 
# 61 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
TMR0 equ 01h ;# 
# 68 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
PCL equ 02h ;# 
# 75 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
STATUS equ 03h ;# 
# 161 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
FSR equ 04h ;# 
# 168 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
PORTA equ 05h ;# 
# 212 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
PORTB equ 06h ;# 
# 274 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
EEDATA equ 08h ;# 
# 281 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
EEADR equ 09h ;# 
# 288 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
PCLATH equ 0Ah ;# 
# 308 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
INTCON equ 0Bh ;# 
# 386 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
OPTION_REG equ 081h ;# 
# 456 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
TRISA equ 085h ;# 
# 500 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
TRISB equ 086h ;# 
# 562 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
EECON1 equ 088h ;# 
# 606 "/opt/microchip/xc8/v2.46/pic/include/proc/pic16f84a.h"
EECON2 equ 089h ;# 
	debug_source C
	FNCALL	_main,_interruptions
	FNCALL	_main,_loop
	FNCALL	_main,_setup
	FNROOT	_main
	global	_PORTB
_PORTB	set	0x6
	global	_PORTA
_PORTA	set	0x5
	global	_RA0
_RA0	set	0x28
	global	_TRISA
_TRISA	set	0x85
; #config settings
	config pad_punits      = on
	config apply_mask      = off
	config ignore_cmsgs    = off
	config default_configs = off
	config default_idlocs  = off
	config FOSC = "XT"
	config WDTE = "OFF"
	config PWRTE = "OFF"
	config CP = "OFF"
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
??_setup:	; 1 bytes @ 0x0
??_interruptions:	; 1 bytes @ 0x0
??_loop:	; 1 bytes @ 0x0
??_main:	; 1 bytes @ 0x0
psect	cstackBANK0,class=BANK0,space=1,noexec
global __pcstackBANK0
__pcstackBANK0:
?_setup:	; 1 bytes @ 0x0
?_interruptions:	; 1 bytes @ 0x0
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
;!    BANK0            66      0       0

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
;!BITCOMMON            0      0       0       0        0.0%
;!EEDATA              40      0       0       0        0.0%
;!NULL                 0      0       0       0        0.0%
;!CODE                 0      0       0       0        0.0%
;!BITSFR0              0      0       0       1        0.0%
;!SFR0                 0      0       0       1        0.0%
;!COMMON               0      0       0       1        0.0%
;!BITSFR1              0      0       0       2        0.0%
;!SFR1                 0      0       0       2        0.0%
;!STACK                0      0       0       2        0.0%
;!BANK0               42      0       0       3        0.0%
;!ABS                  0      0       0       4        0.0%
;!BITBANK0            42      0       0       5        0.0%
;!DATA                 0      0       0       6        0.0%

	global	_main

;; *************** function _main *****************
;; Defined at:
;;		line 11 in file "../src/main.c"
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
;; Data sizes:     COMMON   BANK0
;;      Params:         0       0
;;      Locals:         0       0
;;      Temps:          0       0
;;      Totals:         0       0
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
	line	11
global __pmaintext
__pmaintext:	;psect for function _main
psect	maintext
	file	"../src/main.c"
	line	11
	
_main:	
;incstack = 0
	callstack 7
; Regs used in _main: [wreg+status,2+status,0+pclath+cstack]
	line	12
	
l593:	
	fcall	_setup
	line	14
	
l595:	
	fcall	_interruptions
	line	17
	
l597:	
	fcall	_loop
	goto	l597
	global	start
	ljmp	start
	callstack 0
	line	19
GLOBAL	__end_of_main
	__end_of_main:
	signat	_main,89
	global	_setup

;; *************** function _setup *****************
;; Defined at:
;;		line 14 in file "../src/libs/device_setup.c"
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
;; Data sizes:     COMMON   BANK0
;;      Params:         0       0
;;      Locals:         0       0
;;      Temps:          0       0
;;      Totals:         0       0
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
	line	14
global __ptext1
__ptext1:	;psect for function _setup
psect	text1
	file	"../src/libs/device_setup.c"
	line	14
	
_setup:	
;incstack = 0
	callstack 7
; Regs used in _setup: [wreg+status,2]
	line	15
	
l587:	
	bcf	status, 5	;RP0=0, select bank0
	clrf	(5)	;volatile
	line	16
	clrf	(6)	;volatile
	line	18
	
l589:	
	movlw	low(01h)
	bsf	status, 5	;RP0=1, select bank1
	movwf	(133)^080h	;volatile
	line	19
	
l28:	
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
;; Data sizes:     COMMON   BANK0
;;      Params:         0       0
;;      Locals:         0       0
;;      Temps:          0       0
;;      Totals:         0       0
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
	
l591:	
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
;; Data sizes:     COMMON   BANK0
;;      Params:         0       0
;;      Locals:         0       0
;;      Temps:          0       0
;;      Totals:         0       0
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
	
l31:	
	return
	callstack 0
GLOBAL	__end_of_interruptions
	__end_of_interruptions:
	signat	_interruptions,89
global	___latbits
___latbits	equ	0
	global	btemp
	btemp set 04Eh

	DABS	1,78,2	;btemp
	global	wtemp0
	wtemp0 set btemp+0
	end
