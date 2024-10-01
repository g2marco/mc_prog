#include <xc.h>
#include <stdbool.h>

#include "libs\device_pinout.h"

/**
 *  Every Timer2 interruption sets tick = true
 */  

bool tick;

void __interrupt() general_isr( void) {
	if (TMR2IE && TMR2IF) {
        TMR2IF = 0;
		tick = true;
    }
}

/**
 *  Inputs debouncing routines
 */ 

bool isDebouncing_0 = false;
bool hasChanged_switchA = false;
unsigned char ticks_0 = 0;
__bit switchA;

void debounce_input_0() {
    hasChanged_switchA = false;

    if( isDebouncing_0) {              //  input GP0 is debouncing
        if( --ticks_0 == 0) {          //  the number of ticks has passed
            hasChanged_switchA = (switchA != raw_switchA);
            // sets change flag before assign new value
            switchA = raw_switchA;            //  ends debouncing
            isDebouncing_0 = false;
        }
    
    } else {
        if ( raw_switchA != switchA) {
            ticks_0 = 100;
            isDebouncing_0 = true;
        }
    }
}

/**
 *  Output control variables for outputA
 */
int outputA_state   = -1;
int outputA_counter = 0;
int outputA_cycle   = 0;

/**
 *  Main loop method
 */

void loop( void) {
    if ( tick) {
        debounce_input_0();
        
        switch( outputA_state) {
    		case 0:                // state of element index
			
    			break;	
		
            default: 							// no state
                if (hasChanged_switchA && switchA == 1) {             
                    outputA = (!outputA);
                }
        }

        tick = false;
    }
}

