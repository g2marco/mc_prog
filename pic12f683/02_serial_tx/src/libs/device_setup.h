
/**
 *  PIC12F683 config flags and general device setup
 */

// internal clock 4 MHz

#ifndef _device_setup_
#define _device_setup_

/**
 *  Special characteristics of the device
 */
#pragma config FOSC  = INTOSCIO
#pragma config WDTE  = OFF
#pragma config PWRTE = OFF
#pragma config MCLRE = OFF
#pragma config CP 	 = OFF
#pragma config CPD 	 = OFF
#pragma config BOREN = OFF
#pragma config IESO  = OFF
#pragma config FCMEN = OFF    

void setup( void );

void interruptions( void);

#endif
