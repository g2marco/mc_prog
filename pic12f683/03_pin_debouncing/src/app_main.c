
#include <xc.h>
#include <stdbool.h>

#include "libs\device_pinout.h"

/**
 *  The most simple assignment output = input[debounced]
 */

bool tick;

void __interrupt() general_isr( void) {
	if (TMR2IE && TMR2IF) {
        TMR2IF=0;
		tick = true;
    }
}

bool isDebouncing_XXX = false;
unsigned char ticks_XXX       = 0;
__bit debounced_XXX = 0;
#define raw_XXX  GP1

void debounce_input_XXX() {
    if( isDebouncing_XXX) {                     //  input XXX is debouncing
        if( --ticks_XXX == 0) {                 //  the number of ticks has passed
            // sets change flag before assign new value
            debounced_XXX = raw_XXX;            //  ends debouncing
            isDebouncing_XXX = false;
        }
    } else {
        if ( raw_XXX != debounced_XXX) {
            ticks_XXX = 100;                    // aprox 100 ms @ 4MHz
            isDebouncing_XXX = true;
        }
    }
}


void loop( void) {
    if ( tick) {
        debounce_input_XXX();

        outputA = debounced_XXX;

        tick = false;
    }
}

