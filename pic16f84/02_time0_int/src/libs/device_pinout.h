
/**
 *  device_pinout.h     declaration of I/O pins 
 * 
 */
#ifndef _device_pinout_
#define _device_pinout_

/**
 *  Pin definition
 */

#define config_pin_led TRISA = 1                // port A is output
#define toggle_pin_led   RA0 = ~RA0

#endif