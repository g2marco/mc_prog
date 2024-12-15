
#include <xc.h>
#include <stdbool.h>

#include "libs\device_pinout.h"


bool tick;

void __interrupt() general_isr( void) {
	if (TMR2IE && TMR2IF) {
        TMR2IF = 0;
		tick = true;
    }
}

void loop( void) {
    if ( tick) {
        toggle_output;
        tick = false;
    }
}

