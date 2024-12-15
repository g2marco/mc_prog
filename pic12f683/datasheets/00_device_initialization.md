
## Device Initialization

1. Define the function(s) of each pin in the app (inputs, outputs, peripheral assigned)
2. Implement general device configuration (#pragma)
3. Implement peripheral configuration
4. Implement pin configuration

   - Pin I/O direction
   - Pull-ups (global an individual)
5. Global pin initialization
6. Configure and enable interruptions
   - Interruption source, edge, flags, etc.
   - Interruption service routine implementation
7. Global Interrupt enabling



## Normal Operation



- Always (on app tick)
  - Attend Task 1 
  - Attend Task 2
  - . . . 
  - Sleep / wait for next app tick



## Task Operation

function task()
	if ( init) { 
		variable initialization
	} else if ( state 1) { 
		state1's code
	} else if( state 2) {
		state2's code
	} else {
		. . . 
	}

