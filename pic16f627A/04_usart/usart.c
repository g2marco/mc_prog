#include <xc.h>

void config_usart( void) {
    TRISB1 = 1;                // peripheric controls pin direction
    TRISB2 = 1;

    TXSTAbits.BRGH = 1;		   // BRG, high speed, BR = 11,200 b
    SPBRG = 21;

    TXSTAbits.SYNC = 0;         // modo asincrono

    RCSTAbits.SPEN = 1;         // habilita USART

    TXSTAbits.TX9 = 0;          // 8 bits format
    RCSTAbits.RX9 = 0;          //

    PIE1bits.TXIE = 0;          // disable empty TXREG interruption
    PIE1bits.RCIE = 0;          // disable available RCREG  interruption

    TXSTAbits.TXEN = 1;         // enable TX
    RCSTAbits.CREN = 1;         // enable RX
}
