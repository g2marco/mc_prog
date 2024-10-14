#include <xc.h>
#include <stdbool.h>

#include "lcd_display_8b.h"
#include "usart.h"

unsigned char data;

/**
 * 	General interruption routine
 */
void __interrupt() general_isr( void) {
	return;
}

char *PTR_HELLO = "my first goal is met";

/*
 *	Initialization routine
 */
void setup( void ) {
    config_display();
	init_display();

	config_usart();

	write_display( PTR_HELLO);

	data = 0;
}

/*
 *	Loopable process. This code is repeated again and again
 */
void loop ( void) {
	if( PIR1bits.TXIF == 1) { 		// transmition is available && data received
		TXREG = data;
	}

	if ( PIR1bits.RCIF == 1) {		// received data is available
		data = RCREG + 1;
	}
}
