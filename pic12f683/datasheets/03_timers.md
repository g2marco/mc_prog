# PIC12F683 Timers



## Timers Summary

| Timer  | Bits | Modes          | Clock Source       | Prescaler      | Postscaler | Interrupt   |
| ------ | ---- | -------------- | ------------------ | -------------- | ---------- | ----------- |
| Timer0 | 8    | timer /counter | Fosc / 4  \| T0CKI | 1:1 - 1:256    |            | on overflow |
| Timer1 | 16   | timer/counter  | Fosc / 4 \| T1CKI  | 1:1, 2, 4, 8   |            | on overflow |
| Timer2 | 8    | timer          | Fosc / 4           | 1:1, 1:4, 1:16 | 1:1 - 1:16 | yes         |



## Timer0

* Timer mode
  * **OPTION [ T0CS ]** = 0                     ,enables the timer mode
  * when **TMR0** is written, the increment is inhibited for two instruction cycles
* Counter mode
  * **OPTION [ T0CS ]** = 1                      enables the counter mode 
  * **OPTION [ T0SE ]** = 0 | 1                 timer0 is incremented on every rising | falling edge of T0CKI pin (GP2) 

* Pre-scaler 

  * **OPTION [ PSA ]** = 0                        pre-scaler is assigned to Timer0 , otherwise is assigned to Watchdog timer (WDT)

    When pre-scaler is assigned to WDT, Timer0 pre-scaler is 1:1

  * **OPTION [ PS2 : PS0]** = XXX        8 pre-scalers: 1:2 | 1:4 | 1:8 | 1:16 | 1:32 | 1:54 | 1:128 | 1:256 |

    Pre-scaler assigned to Timer0 :     Any instruction writing to Timer0 will clear the pre-scaler

    Pre-scaler assigned to WDT    :      A CLRWDT instruction will clear the pre-scaler 



### Switching Pre-scaler between Timer0 and WDT

* In order to avoid an unintended reset, specific code lines must be executed when assigning the pre-scaler

```assembly
; assigning pre-scaler to WDT
BANKSEL TMR0                		;
CLRWDT                             	; clear WDT
CLRF TMR0                          	; clear TMR0 and prescaler
BANKSEL OPTION_REG                 	;
BSF OPTION_REG, PSA                	; select WDT
CLRWDT                             	;
                                   	;
MOVLW b’11111000’                  	; mask prescaler bits
ANDWF OPTION_REG,W                 	;
IORLW b’00000101’ 					; set WDT prescaler to 1:32
MOVWF OPTION_REG 					;
```

```assembly
; asssigning pre-scaler to Timer0
CLRWDT 								; clear WDT and prescaler
BANKSEL OPTION_REG 					;
MOVLW b’11110000’ 					; mask TMR0 select and prescaler bits 
ANDWF OPTION_REG,W 					;
IORLW b’00000011’ 					; set prescale to 1:16 
MOVWF OPTION_REG 					;

```



### Timer0 Interruption

* When **TMR0** overflows from 0xFFH to 0x00H 
  * An interruption will be generated if Timer0 interrupt is enabled     **INTCON [ T0IE ]**
  * Timer0 interruption flag is set                                                             **INTCON [ T0IF]** = 1

### OPTION_REG

| R/W-1 | R/W-1  | R/W-1 | R/W-1 | R/W-1 | R/W-1 | R/W-1 | R/W-1 |
| ----- | ------ | ----- | ----- | ----- | ----- | ----- | ----- |
| GPPU  | INTEDG | T0CS  | T0SE  | PSA   | PS2   | PS1   | PS0   |

**GPPU** GPIO pull-up enable bit

​	**1** = GPIO pull-ups are disable
​	**0** = GPIO pull-ups are enabled by individual port latch (see WPU register)

**INTEDG** Interrupt edge select bit

​	**1** = interrupt on rising edge of INT pin (GP2)
​	**0** = interrupt on falling edge of INT pin

**T0CS** Timer0 clock source select

​	**1** = T0CKI pin
​	**0** = Internal instruction cycle clock ( Fosc / 4 )

**T0SE** Timer0 source edge select

​	**1** = increment on falling edge of T0CKI
​	**0** = increment on rising edge of T0CKI

**PSA** Pre-scaler assignment

​	**1** = pre-scaler assigned to the WDT (besides, a 16 bit post-scaler is available for the WDT)
​	**0** = pre-scaler assigned to Timer0

**PS [ 2 : 0]** Pre-scaler rate select

| PS [2: 0] | Timer 0 pre-scale | WDT pre-scale |
| --------- | ----------------- | ------------- |
| 000       | 1:2               | 1:1           |
| 001       | 1:4               | 1:2           |
| 010       | 1:8               | 1:4           |
| 011       | 1:16              | 1:8           |
| 100       | 1:32              | 1:16          |
| 101       | 1:64              | 1:32          |
| 110       | 1:128             | 1:64          |
| 111       | 1:256             | 1:128         |



## Timer1

- 16 bit incrementing timer / counter  (TMR1H : TMR1L)
  - timer                 > when used with an internal clock source (T1CON.TMR1CS = 0 => Fosc / 4)
  - timer / counter > when used with an external clock source (T1CON.TMR1CS = 1 => T1CKI pin - GP5 -)
    - timer
    - counter
      - incremented on the rising edge of T1CKI
      - clock can be synchronized to the system clock or run asynchronously
      - if an external clock is needed and if using the INTOSC without CLKOUT, Timer1 can use the LP oscillator as clock source
      - NOTE: A falling edge must be registered by the counter prior the first incrementing rising edge
- 2 bit prescaler ( 1:1, 2, 4, 8 )
  - T1CON.T1CKPS<1:0>
  - Prescaler counter is cleared upon a write to TMR1H:TMR1L

- Optional LP oscillator
  - Low-power 32.768kHz crystal oscillator between OSC1 (GP2 input pin) and OSC2 ( GP4 amplifier output pin)
  - T1CON.T1OSCEN = 1 enables this oscillator
  - This oscillator will continue to run during sleep
  - This oscillator is shared with the system LP oscillator, thus it can be used only when the primary system clock is derived from the internal oscillator or when in LP oscillator mode ( a software time delay **must** be provided to ensure proper oscillator startup)
  - TRISIO[ 5 : 4] = 11 when Timer1 oscillator is enabled (GP5 and GP4 are read as '0's)

- synchronous o asynchronous operation
- timer1 gate == count enable (comparator / T1G pin)
- Wake-up on overflow (only on asynchronous mode and using external clock)
- Special event trigger (with CCP)
- Comparator output synchronization to Timer1 clock

 T1CON

| R/w-0  | R/W-0  | R/W-0   | R/W-0   | R/W-0   | R/W-0  | R/W-0  | R/W-0  |
| ------ | ------ | ------- | ------- | ------- | ------ | ------ | ------ |
| T1GINV | TMR1GE | T1CKPS1 | T1CKPS0 | T1OSCEN | T1SYNC | TMR1CS | TMR1ON |

**T1GINV** Timer1 gate invert

​    **1** = Timer1 gate is active-high (timer counts when gate is high)
​    **0** = Timer1 gate is active=low

**TMR1GE** Timer1 gate enable ( this bit is ignored when **TMR1ON** = **0**)

​    **1** = Timer1 is on if Timer1 gate is not active
​    **0** = Timer1 is on

**T1CKPS[1:0]** Timer1 input clock prescale

​    **11** = 1:8 prescale
​    **10** = 1:4 prescale
​    **01** = 1:2 prescale
​    **00** = 1:1 prescale

**T1OSCEN** LP oscillator enable( this bit is ignored when **TMR1CS = **0** - timer1 uses internal clock)

​    **1** = LP oscillator is enabled for Timer1 clock
​    **0** = LP oscillator is off

**T1SYNC** Timer1 external clock input synchronization ( this bit is ignored when **TMR1ON** = **0**)

​    **1** = Timer1 is on if Timer1 gate is not active
​    **0** = Timer1 is on





## Timer2

### Operation

- Fosc/4 is feed into Timer2 prescaler
- Every time prescaler overflows, TMR2 is incremented
- When TMR2 matches PR2
  - TMR2 is reset to 00H on the next increment cycle
  - Timer2 postcaler is incremented
- Every time postscaler overflows, timer2 interruption flag is set

### Period Formula

​	$T =  (\frac{1} {Fosc/4} ) * prescaler * period * postcaler $

​	Example: Using Timer2, select prescaler, period and postcaler values for getting a 1ms period  with Fosc = 4 MHz.

​	Solution:    $period = \frac {T \times (Fosc /4) } {(prescaler \times postscaler)}$

​	After tabulating such an expression, the following values are obtained: **period = 25, pre-scaler = 4, post-scaler = 10**

NOTE:

​	By selecting a value of 25 for the period, it allows generating periods from 1m to 10ms by simply multiplying this value

### Initialization

- **T2CON< TMR2ON>* = 1 ** turns on the timer 
- **T2CON< T2CKPS> = XX** sets the prescaler value
- **T2CON< TOUTPS> = XXXX** sets the postscaler value
- **PR2 = period_value** sets Timer2 module period
- **PIE1< TMR2IE > = 1** Timer 2 interrupt enable

````asm
// basic initialization routine
T2CON  = postscaler(4 bits) | on/off (1 bit) | prescaler (2 bits);
TMR2   = 0;
PR2    = NN;
TMR2IF = 0;						// PIR1<TMR2IF> clears timer 2 interruption flag
TMR2IE = 1;						// PIE1<TMR2IE> enables timer 2 interruption
. . .
PEIE   = 1;						// INTCON<PEIE> enables peripheral interruptions
. . . 
ie();							// INTCON<GIE> global interruption enable
````



### T2CON

| U-0  | R/W-0   | R/W-0   | R/W-0   | R/W-0   | R/W-0  | R/W-0  | R/W-0  |
| ---- | ------- | ------- | ------- | ------- | ------ | ------ | ------ |
| ---- | TOUTPS3 | TOUTPS2 | TOUTPS1 | TOUTPS0 | TMR2ON | TCKPS1 | TCKPS0 |

**TOUTPS[3:0]** Timer2 output postscaler

​	**0000** = 1:1 postcaler
​    **.  .  .**
​	**1111** = 1:16 postcaler

**TMR2ON** Timer2 on

​	**1** = Timer2 is on
​	**0** = Timer2 is off

**T2CKPS[1:0]** Timer2 clock prescaler

​	**00** = pre-scaler is 1
​	**01** = pre-scaler is 4
​	**1X** = pre-scaler is 16