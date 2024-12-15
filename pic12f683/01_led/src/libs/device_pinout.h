/**
 *  device_pinout.h     declaration of I/O pins 
 * 
 */
#ifndef _device_pinout_
#define _device_pinout_

/**
 *  Pin definition
 */

#define config_pin_led TRISIO0 = 0        // GPIO0 is output
#define toggle_pin_led     GP0 = ~GP0

#endif