/**
 *  device_pinout.h     declaration of I/O pins 
 * 
 */
#ifndef _device_pinout_
#define _device_pinout_

/**
 *  Pin definition
 */

#define config_pins TRISIO = 1       // GPIO0 is input, the remainder are outputs

#define PUSH_BTN  GP0

#define DATA_OUT  GP1
#define CLK_OUT   GP2

#endif