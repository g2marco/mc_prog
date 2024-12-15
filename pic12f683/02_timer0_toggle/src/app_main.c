
#include <xc.h>
#include <stdbool.h>

#include "libs/device_pinout.h"
#include "libs/timer0.h"


bool tick;

void __interrupt() general_isr( void) {
	if (T0IE && T0IF) {
        // init timer 0                             // invocation of function into interruption routine is not recommended
        TMR0 = TMRO_INIT_VALUE;
        T0IF = 0;

		tick = true;
    }
}

void loop( void) {
    if ( tick) {
        toggle_output;
        tick = false;
    }
}

