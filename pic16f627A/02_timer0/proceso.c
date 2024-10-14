#include <xc.h>
#include <stdbool.h>

#include "timer0.h"

#define PORTA_RA0 PORTAbits.RA0

bool timer0;

void __interrupt() general_isr( void) {
    
	if (TMR0IE && TMR0IF) {
        TMR0IF=0;
		timer0 = true;
    }
    
	return;
}

/*
 *	Initialization routine	
 *
 */
void setup( void ) {
	PORTA = 0;		// clear port latches
	PORTB = 0;
	
	CMCON = 7;		// turn comparators off, enable related pins for I/O
	
	TRISA = 0xFF;	// data port changes to output only if needed
	TRISB = 0xFF;
	
	config_timer0();
	
	init_timer0( 200);
	
	TRISA0 = 0;
	
	timer0 = false;
}

/*
 *	Loopable process. This code is repeated again and again 
 */
void loop ( void) {

	if( timer0) {
		PORTA_RA0 = ~PORTA_RA0;
		timer0 = false;
	}

}

