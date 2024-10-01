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
bool hasChanged_inputA = false;
unsigned char ticks_0 = 0;
__bit inputA; 

void debounce_input_0() {
    hasChanged_inputA = false;

    if( isDebouncing_0) {              //  input GP0 is debouncing
        if( --ticks_0 == 0) {          //  the number of ticks has passed
            hasChanged_inputA = (inputA != raw_inputA);
            // sets change flag before assign new value
            inputA = raw_inputA;            //  ends debouncing
            isDebouncing_0 = false;
        }
    
    } else {
        if ( raw_inputA != inputA) {
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
                if (inputA != 0) {
    				outputA_state = -1;
    				outputA = !(1);

    			} else {
                    if( outputA_cycle == 0) {
                        outputA_counter = (1000);
                        outputA_cycle = (2000);
                        outputA = (1);
                    }
                    
                    if( outputA == (1) && outputA_counter == 0) {
        				outputA = !outputA;
            		}
                    
                    --outputA_counter;
                    --outputA_cycle;
                }

    			break;	
		
            default: 							// no state
                if (inputA == 0) {
                    outputA_state = 0;
                    outputA = (1);
                }
        }

        tick = false;
    }
}

