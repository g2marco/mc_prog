# High-Level Output Specification



## Vision

- To ease the life of integration  developer 
- To ease the specification of an output signal  using a very simple syntax
- To translate the high level output specification to a low level programming language



## Language Elements



### General Layout

* Signal declaration
* Assignment declaration



### Signal declaration

- Identifies the signals that will participate into the assignment part of the specification
- Each signal is declared in a single line
- The input/output declaration syntax is:
  - <input signal name>     is input   <signal type> [ ; ]
  - <output signal name>  is output [ ; ]



````c
// examples
buttonControl is input  switch;
pushStart     is input  push-button;
motorLeft     is output;
````



**NOTES:**

- A switch normally produces an stable state (when commuted between an state or other)
- A push-button is normally open and changes its state by a short time only (only while being pressed)
- When the target device starts every output signal starts in OFF state



### Assignment declaration

- It's a list of assignment expressions
- Each expression assigns a value to an output signal depending on the value of one or more input/output signals
- Each assignment is evaluated only when:
  - The target system is restarted
  - Any of the input signals involved in a given expression change (change event)
- The assignment declaration syntax is:

````text
<output signal name> 
	is        <valueA expression>
    	[after XX mx|s] [for XX  ms|s ] [repeat N times] [each XX ms|s] [while <duration condition>]
        [when <assigment condition>]
	else      <valueB expression> 
		[after XX mx|s] [for XX  ms|s ] [repeat N times] [each XX ms|s] [while <duration condition>]
        [when <assigment condition>]
		. . . 
	otherwise <valueN expression>
[;]
````



## Expressions

- Set of operands an operators which result is an integer value or a boolean value
- Operands can be literals, signals and events

Examples

````c
buttonA is input
buttonB is input
output  is output
   
// output <- (buttonA && buttonB);
output is buttonA and buttonB;

output is
    ON  when buttonA is closed and buttonB is open
    OFF otherwise;

````



## Events

- When an input or output changes, a event is generated (time is also an event source)
- Such an event triggers evaluation of every expression where the signal is involved
- Expression evaluation may trigger one or more assignments to change
- An event is valid only during the evaluation cycle triggered when they where detected and fired



There is only one event available for digital signals:

- <signal>'change, its generated when a change of value is detected in a digital signal



The following are the composed events, defined in terms of the change event

- <signal>'rise = <signal>'change and <signal>
- <signal>'fall   = <signal>'change and not <signal>



The following are events available for input signals declared as 'switch':

- <switch>'close = <switch>'fall;
- <switch>'open = <switch>'rise;



The following are events available for input signals declared as 'push-button':

- <push-button>'pushed = <push-button>'fall;