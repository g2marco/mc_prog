# APPLICATION: Digital Motor Control

## Requeriments

- A motor may be turned on/off by different events:
  - an small pulse (pusbutton) in an input
  - level change (switch)
  - signal edge (digital control line)
- When turned on, a motor may stay in such state:
  - an indefinite amount of time 
  - up to another event is detected                                 (while)
  - a definite amount of time or up to another event is detected    (for)
- A motor can be controlled by one o more inputs, for example:
  - one push button can be used for turning on and turning off (pulses)
  - one switch can be used for turning on and turning off ( level)
  - one switch can be used for turning on the motor and another switch or push button can be used for turning off
  - two o more inputs can ben used for either turning on and turning off a motor


PIC 12F683 will be used


- Two digital outputs will be used for motor control

	- two motors can be turned on/off
	- one motor can be controlled (turn left / turn right / turn off)


- Three digital inputs can be used 

- programable control inputs 


One digital input is left as reset (emergency stop input)



Event definition / input assignment / motor assignment 

	- Using a high level configuration language
	- configuration and assignment can be updated via ICSP 