#include <xc.h>

#include "lcd_display_8b.h"

/**
 * 	General interruption routine
 */
void __interrupt() general_isr( void) {
	return;
}

char *PTR_HELLO = "my first goal is met";

/*
 *	Initialization routine
 *
 */
void setup( void ) {
    config_display();
	init_display();

	write_display( PTR_HELLO);
}

/*
 *	Loopable process. This code is repeated again and again
 */
void loop ( void) {

}
