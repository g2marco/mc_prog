#ifndef _device_pinout_
#define _device_pinout_

/**
 *  Pin definition
 */

#define config_inputA  TRISIO0 = 1 // input signal
#define raw_inputA GP0

#define config_outputA  TRISIO5 = 0 // output signal
#define outputA GP5

#endif