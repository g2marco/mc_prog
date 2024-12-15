# PIC12F683 GPIO PORT


<p align="center"><img src="https://raw.githubusercontent.com/g2marco/microcontrollers/master/pic12f683/datasheets/images/pinout.png"/></p>



## Device Summary

| Program Memory | Data memory                         | I/O Lines | A/D Channels | Comparators | Timers                        |
| -------------- | ----------------------------------- | --------- | ------------ | ----------- | ----------------------------- |
| 2KW            | 128 bytes RAM<br />256 bytes EEPROM | 6         | 4 (10 bits ) | 1           | 2 (  8 bits)<br />1 (16 bits) |



## GPIO Port Functions

| Function        | GP5        | GP4         | GP3        | GP2     | GP1      | GP0     |
| --------------- | ---------- | ----------- | ---------- | ------- | -------- | ------- |
| **Digital I/O** | I/O        | I/O         | I          | I/O     | I/O      | I/O     |
| **Pull Ups**    | Yes        | Yes         | Yes (MCLR) | Yes     | Yes      | Yes     |
| **Interrupts**  | IOC        | IOC         | IOC        | INT/IOC | IOC      | IOC     |
| **Basic**       | OSC1/CLKIN | OSC2/CLKOUT | nMCLR      |         |          | ULPWU   |
| **ICSP**        |            |             | VPP        |         | ICSPCLK  | ICSPDAT |
| **Analog**      |            | AN3         |            | AN2     | AN1/VREF | AN0     |
| **Comparators** |            |             |            | COUT    | CIN-     | CIN+    |
| **Timers**      | T1CKI      | nT1G        |            | T0CKI   |          |         |
| **CCP**         |            |             |            | CCP1    |          |         |

**NOTE:** When a peripheric is enabled, some or all related pins cannot been used as digital I/O



## Port Initialization

- **ANSEL** and **CMCON0** must be initialized in order to configure analog pins as digital I/O
- **TRISIO** sets direction of **GPIO** pins even when they are used with other peripherals



````asm
// basic initialization routine
GPIO   = 0;
CMCON0 = 07H;			// GPIO<2:0> as digital I/O
ANSEL  = 0;				// analog inputs as digital pins
TRISIO = XX;
````



##### ANSEL

| U-0  | R/W-0 | R/W-0 | R/W-0 | R/W-0 | R/W-0 | R/W-0 | R/W-0 |
| ---- | ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| ---- | ADCS2 | ADCS1 | ADCS0 | ANS3  | ANS2  | ANS1  | ANS0  |

**ADCS[2:0]** A/D Conversion clock select

**ANS[3:0]**  Analog select between analog or digital functions pins (AN3, AN2, AN1, AN0)

​	**1**= analog pin
​	**0** = digital pin

**NOTE:**

- Setting a pin to an analog input automatically disables the digital input circuitry, weak pull-ups and interrupt-on-change
- The corresponding **TRISIO** bit must be set to input mode in order to allow external control of the voltage on the pin.  



##### CMCON0

| U-0  | R-0  | U-0  | R/W-0 | R/W-0 | R/W-0 | R/W-0 | R/W-0 |
| ---- | ---- | ---- | ----- | ----- | ----- | ----- | ----- |
| ---- | COUT | ---- | CINV  | CIS   | CM2   | CM1   | CM0   |

**CM[2:0]** Comparator Mode 

​	**000 - 110** = different configurations for the comparator peripheral

​	**111** = **CIN** pins are configured as I/O, **COUT** pin is configured as I/O, comparator output is disabled, and comparator turned off



##### TRISIO

- Controls the direction of the **GPIO** pins, even when they are being used as analog inputs

| U-0  | U-0  | R/W-1   | R/W-1   | R-1     | R/W-1   | R/W-1   | R/W-1   |
| ---- | ---- | ------- | ------- | ------- | ------- | ------- | ------- |
| ---  | ---  | TRISIO5 | TRISIO4 | TRISIO3 | TRISIO2 | TRISIO1 | TRISIO0 |

**TRISIO[5:0]** GPIO Tri-state control

​	**1** = GPIO pin configured as an input (tri-stated)

​	**0** = GPIO pin configured as an output

**NOTE**:

- TRISIO<3> always read 1 (GP3 is input only)
- TRISIO< 5:4 > always read 1 in XT, HS and LP OSC modes
- TRISIO< 5 > always read 1 in RC, RCIO and EC modes



##### GPIO

- Reading the **GPIO** register reads the status of the pins, whereas writing to it will write to the port latch (each write operation involves read/modification/write).
- Pins configured as analog inputs will read 0.

| U-0  | U-0  | R/W-x | R/W-0 | R-x  | R/W-0 | R/W-0 | R/W-0 |
| ---- | ---- | ----- | ----- | ---- | ----- | ----- | ----- |
| ---- | ---- | GP5   | GP4   | GP3  | GP2   | GP1   | GP0   |



## Additional pin functions



### Weak pull-up

---

- Each pull-up is automatically turned off when for a pin configured as an output (**TRISIOx** = 0)
- Global **GPPU** must be enabled for individuals pull-ups to be enabled
- Individual Enable **WPUx**
  - Weak pull-up is automatically enabled for **GP3** when configured as MCLR (it can not be turned off)
    - When **CONFIG < MCLRE >** = 1, pint GP3/MCLR is configured as master clear reset input
  - Weak pull-up is automatically disabled when **GP3** is digital I/O

##### WPU

| U-0  | U-0  | R/W-1 | R/W-1 | U-0  | R/W-1 | R/W-1 | R/W-1 |
| ---- | ---- | ----- | ----- | ---- | ----- | ----- | ----- |
| -    | -    | WPU5  | WPU4  | -    | WPU2  | WPU1  | WPU0  |

**WPUx** Weak pull-up control

​	**1** = Pull-up enabled

​	**0** = Pull-up disabled

**NOTE**:

- WPU< 5:4 > always read 1 in XT, HS and LP OSC modes



### Interrupt on change (IOC)

---

- **IOCx**  enable interrupt function for each pin
  - **INTCON** < **GPIE** >  must be enabled
- Interrupt is generated when comparison of the last latched value (last read) detects a change
  - Any read or write of GPIO will end the mismatch condition
  - **INTCON** < **GPIF** > must be cleared
- This interrupt can wake-up the device from sleep

**NOTE**

- If a change on the I/O pin should occur when any GPIO operation is being executed, then the **GPIF** interrupt flag may not get set.



##### IOC: Interrupt on-change GPIO register

| U-0  | U-0  | R/W-0 | R/W-0 | R/W-0 | R/W-0 | R/W-0 | R/W-0 |
| ---- | ---- | ----- | ----- | ----- | ----- | ----- | ----- |
| -    | -    | IOC5  | IOC4  | IOC3  | IOC2  | IOC1  | IOC0  |

**IOCx** Interrupt on-change GPIO control

​	**1** = Interrupt on-change enabled

​	**0** = Interrupt on-change disabled

**NOTE**:

- IOC< 5:4 > always read 0 in XT, HS and LP OSC modes



### GP2/INT External Interruption

---

- This interruption is enabled with the **INTCON< INTE>** bit
- **OPTION_REG< INTEDG>** controls whether the interruption occurs on the falling/rising edge on **GP2/INT** pin
- When a valid appears on the **GP2/INT** pin, the **INTCON< INTF >** bit is set (this flag must be cleared in software)
- This interrupt can wake-up the device from sleep



##### INTCON

| R/W-0 | R/W-0 | R/W-0 | R/W-0 | R/W-0 | R/W-0 | R/W-0 | R/W-0 |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| GIE   | PEIE  | T0IE  | INTE  | GPIE  | T0IF  | INTF  | GPIF  |

**GIE** Global Interrupt Enable 

​	**1** = Enables all unmasked interrupts

​	**0** = Disables all interrupts

**PEIE** Peripheral Interrupt Enable 

​	**1** = Enables all unmasked peripheral interrupts

​	**0** = Disables all peripheral interrupts

**T0IE** Timer 0 Overflow Interrupt Enable 

​	**1** = Enables the Timer 0 interrupt

​	**0** = Disables the Timer 0 interrupt

**INTE** GP2/INT External Interrupt Enable 

​	**1** = Enables the GP2/INT external interrupt

​	**0** = Disables the GP2/INT external interrupt

**GPIE** GPIO Change Interrupt Enable 

​	**1** = Enables the GPIO change interrupt (IOC register must also be enabled)

​	**0** = Disables the GPIO change interrupt

**T0IF** Timer0 Overflow Interrupt Flag

​	**1** = Timer0 register has overflowed (TMRO should be initialized before clearing TOIF)

​	**0** = Timer0 register has no overflowed

**INTF**  GP2/INT External Interrupt Flag

​	**1** = GP2/INT external interrupt occurred (must be cleared in software)

​	**0** = GP2/INT external interrupt has not occurred

**GPIF** GPIO Change Interrupt Flag 

​	**1** = At least one of the GPIO< 5:0 > pins change state (must be cleared in software)

​	**0** = None of the GPIO< 5:0 > have change state



##### OPTION_REG

| R/W-1 | R/W-1  | R/W-1 | R/W-1 | R/W-1 | R/W-1 | R/W-1 | R/W-1 |
| ----- | ------ | ----- | ----- | ----- | ----- | ----- | ----- |
| nGPPU | INTEDG | T0CS  | T0SE  | PSA   | PS2   | PS1   | PS0   |

**nGPPU** GPIO Pull-up Enable

​	**1** = GPIO pull-ups are disabled

​	**0** = GPIO pull-ups are enabled

**INTEDG** Interrupt Edge Select 

​	**1** = Interrupt on rising edge of INT pin

​	**0** = Interrupt on falling edge of INT pin



### Ultra low-power wake-up (only GP0)

---

- Provides a low-power technique for periodically waking up the device from sleep.
  - An RC circuit on **GP0** determines timeout
  - A slow falling voltage on pin **GP0** generates an interrupt-on-change
    1. **GP0** must be configured as output and its value must be '1'
    2. Time must be spend in order to charge the external capacitor
    3. Interrupt-on-change for **GP0** must be enabled
    4. **GP0** is configured as an input (external capacitor starts discharging )
- **PCON**< **ULPWUE** > enables a small current sink which can be used to discharge a capacitor on GP0
  - When the voltage on **GP0** drops below VIL, an interrupt will be generated 