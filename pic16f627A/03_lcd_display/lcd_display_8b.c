#include <xc.h>

#define _XTAL_FREQ  4000000

#define OUTPUT 0

#define DIR_DATA_LCD_LOW    TRISA				// RA0-RA3 > D0-D3
#define DATA_LCD_LOW        PORTA

#define DIR_DATA_LCD_HIGH   TRISB				// RB4-RB7 > D4-D7
#define DATA_LCD_HIGH		PORTB

#define RS_LCD     		PORTAbits.RA7
#define DIR_RS_LCD      TRISA7

#define RW_LCD          PORTAbits.RA6
#define DIR_RW_LCD      TRISA6

#define ENABLE_LCD		PORTBbits.RB0
#define DIR_ENABLE_LCD	TRISB0

void send_command_lcd( unsigned char command) {

	DATA_LCD_LOW &= 0xF0;
	DATA_LCD_LOW |= (command & 0x0F);

	DATA_LCD_HIGH &= 0x0F;
	DATA_LCD_HIGH |= (command & 0xF0);

	ENABLE_LCD   = 1;
	ENABLE_LCD   = 0;

	__delay_us( 100);
}

/*
void init_lcd( void) {
	__delay_ms(15);

	send_command_lcd( 0b00110000);
	__delay_ms( 5);

	send_command_lcd( 0b00110000);
	__delay_us( 100);

	send_command_lcd( 0b00110000);
	__delay_us( 100);

	send_command_lcd( 0b00111100);			// two data lines, 5x7 matrix

	send_command_lcd( 0b00001000);			// display off

	send_command_lcd( 0b00000001);			// clear display, display is off

	send_command_lcd( 0b00000111);			// display off
}
*/

void init_lcd( void) {
	__delay_ms(200);
}


void config_interface_lcd( void) {
	DIR_DATA_LCD_LOW  &= 0xF0;			// pins to lcd data port are outputs
	DIR_DATA_LCD_HIGH &= 0x0F;

	DIR_ENABLE_LCD = 0;					// lcd display control lines are all outputs
	DIR_RW_LCD = 0;
	DIR_RS_LCD = 0;
}

void config_display( void) {
	config_interface_lcd();
	init_lcd();
}

void init_display( void) {
	send_command_lcd( 0x38);
	__delay_ms( 2);
	send_command_lcd( 0x0E);
	__delay_ms( 2);
	send_command_lcd( 0x06);
	__delay_ms( 2);
}

void write_char( unsigned char caracter) {
	RS_LCD = 1;
	send_command_lcd( caracter);
	RS_LCD = 0;
}


void write_display ( char *ptr) {
	unsigned char i = 0;

	while( ptr[i] != 0) {
		write_char( ptr[i]);
		i++;
	}
}
