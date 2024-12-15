
/**
 *  PIC12F84A config flags and general device setup
 */
#ifndef _device_setup_
#define _device_setup_

/**
 *  Special characteristics of the device
 */
#pragma config FOSC  = XT
#pragma config WDTE  = OFF
#pragma config PWRTE = OFF
#pragma config CP 	 = OFF

#define _XTAL_FREQ 		4000000        // crystal oscilator

void setup( void );

void interruptions( void);

#endif