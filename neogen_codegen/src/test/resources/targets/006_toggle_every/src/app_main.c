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
        
        switch( outputA_state) {
    		case 0:                // state of element index
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
			
    			break;	
		
            default: 							// no state
                outputA_state = 0;
                outputA = (1);
        }
        
        tick = false;
    }
}

