#include <xc.h>

extern void setup( void);
extern void loop ( void);

void basic_setup( void) {
	PORTA = 0;		// clear port latches
	PORTB = 0;

	CMCON = 0x07;		// turn comparators off, enable related pins for I/O

	TRISA = 0xFF;	// data port changes to output only if needed
	TRISB = 0xFF;
}

void main( void) {
	basic_setup();
	setup();

	ei();						// enable interruptions

	while( 1) {
		loop();
	}
}
