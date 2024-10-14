#include <xc.h>


void config_timer0( void) {
	OPTION_REGbits.T0CS = 0;				// timer function
	
	CLRWDT();								// prescaler assigned to timer0
	OPTION_REGbits.PSA = 0;					
	
	OPTION_REGbits.PS2 = 0;					// prescaler 1:4 (2^(PS + 1)
	OPTION_REGbits.PS1 = 0;
	OPTION_REGbits.PS0 = 1;
	
	TMR0IF = 0;			
	TMR0IE = 1;								// enable timer interrupt
}

void init_timer0( unsigned short int value) {
	TMR0 = value;
}