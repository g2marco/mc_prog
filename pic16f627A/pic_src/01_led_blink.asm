	list p=16f627a
	#include p16f627a.inc	

	org 0x0000
	
	call f_init
	goto principal	
	
	org 0x0020

principal:
	movlw 0x01
	movwf PORTA

	call f_retardo

	movlw 0x00
	movwf PORTA

	call f_retardo
	
	goto principal

f_init:
	clrf PORTA
	
	movlw 0x07
	movwf CMCON
		
	bcf STATUS, RP1
	bsf STATUS, RP0

	movlw 0xFE
	movwf TRISA

	bcf STATUS, RP0

	return

f_retardo:
	movlw 0xFF
	movwf 0x20
	
	decfsz 0x20,F
		goto $ - 1

	return

	end