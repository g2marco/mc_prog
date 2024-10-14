	list p=16f627a
	#include p16f627a.inc	

W_TEMP 		equ 0x70
STATUS_TEMP equ 0x71

	org 0x0000
	
	call f_init
	call f_retardo
	goto principal	
	
	org 0x0004

	movwf 	W_TEMP 			;copy W to temp register
	swapf 	STATUS, W 		;swap status to be saved into W
	bcf 	STATUS,RP0 		;change to bank 0
	movwf 	STATUS_TEMP		;save status to bank 0 register

	;isr

	swapf 	STATUS_TEMP,W	;swap STATUS_TEMP
	movwf	STATUS 			;move W into STATUS
	swapf	W_TEMP,F 		;swap W_TEMP
	
	retfie
	
principal:
	movlw 0x00
	movwf PORTA

	call f_transmite

	btfss PIR1, RCIF		; espera recepci�n
		goto $ - 1
	movf RCREG, W			; lee dato para limpiar bandera

	movlw 0x01
	movwf PORTA

	call f_transmite
	
	btfss PIR1, RCIF		; Espera recepci�n
		goto $ - 1
	movf RCREG, W			; lee dato para limpiar bandera

	goto principal

;
;	Inicializacion del dispositivo
;

f_init:
	clrf PORTA			; limpia registro
	
	movlw 0x07			; deshabilita comparadores
	movwf CMCON
		
	bcf STATUS, RP1
	bsf STATUS, RP0
	
	movlw 0xFE			; RBO como salida digital
	movwf TRISA

	bcf STATUS, RP0

	call f_init_usart_async		; inicializa USART

	return

f_retardo:
	movlw 0xFF
	movwf 0x20
	
	decfsz 0x20,F
		goto $ - 1

	return

f_init_usart_async:
	bcf STATUS, RP1		; banco 1
	bsf STATUS, RP0
	
	bsf TRISB, RB2		; set RB2, RB1 as inputs
	bsf TRISB, RB1

	movlw 0x02			; load x
	movwf SPBRG	
	
	bcf TXSTA, SYNC		; modo asincrono

	bcf STATUS, RP0
	bsf RCSTA, SPEN		; habilita USART
	
	call f_init_async_rx

	call f_init_async_tx
	
	return


f_init_async_tx:
	
	bsf STATUS, RP0		; banco 1

	bsf TXSTA, TXEN		; habilita transmision

	bcf STATUS, RP0		; banco 0

	return

f_init_async_rx:
	
	bsf RCSTA, CREN		; habilita transmision

	return

f_transmite:
	movlw 0x66
	movwf TXREG			; inicia transmision

	nop
	nop
	
	return

	end