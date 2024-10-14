#include <xc.h>

#pragma config FOSC  = INTOSCIO
#pragma config WDTE  = OFF
#pragma config PWRTE = ON
#pragma config MCLRE = OFF
#pragma config BOREN = ON
#pragma config LVP   = OFF
#pragma config CPD 	 = OFF
#pragma config CP 	 = OFF

#define _XTAL_FREQ 		4000000   

#define PORTA_RA0 PORTAbits.RA0

void setup( void ){
	PORTA = 0;			// clear port latches
	CMCON = 7;			// turn comparators off, enable related pins for I/O
	TRISA = 0xFE;		// only RA0 is output
}

void loop () {
	PORTA_RA0 = 1;			// conmute pin on and off
	asm( "nop");
	PORTA_RA0 = 0;
}

void main( void) {
	setup();
	
	while( 1) {
		loop();
	}
}
