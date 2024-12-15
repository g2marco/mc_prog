
#include <xc.h>
#include <stdbool.h>

#include "libs\device_pinout.h"


bool tick;                                      // true, every time timer 2 is done

void __interrupt() general_isr( void) {
	if (TMR2IE && TMR2IF) {
        TMR2IF = 0;
		tick = true;
    }
}

bool isDebouncing_XXX = false;
unsigned char ticks_XXX       = 0;
__bit debounced_XXX = 0;


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

unsigned short pwm_value;                      // current pwm high value
bool increment;                                 // true, when pwm high value must be incremented


void loop( void) {
    if ( tick) {
        debounce_input_XXX();

        outputA = debounced_XXX;

        tick = false;
    }

    if (GPIO5 == 0) {					// debounces
		__delay_ms( 100);
	}

	if( GPIO5 == 0) {
		if( pwm_value >= MAX_PWM_VALUE) {
			__delay_ms( 300);
			increment = false;
		}

		if ( pwm_value <= 0) {
			__delay_ms( 300);
			increment = true;
		}

		if ( increment) {
			pwm_value += DELTA_PWM;
		} else {
			pwm_value -= DELTA_PWM;
		}

		set_duty_cycle( pwm_value);

		__delay_ms( 300);
	}


}

