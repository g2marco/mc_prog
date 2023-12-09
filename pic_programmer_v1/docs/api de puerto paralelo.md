## API de puerto paralelo



### parallel_port

| Variables         | Methods                                 |
| ----------------- | --------------------------------------- |
| log_file : FILE * | init_puerto_paralelo( baseAddr)   : int |
|                   | write_data_port()                       |
|                   | read_data_port()                        |
|                   | read_status_port()                      |
|                   | write_control_port()                    |
|                   | print_registros()                       |

### port_adapter

| Variables      | Methods                                                      |
| -------------- | ------------------------------------------------------------ |
| modo_operacion | init_adaptador_pp( baseAddr, modoOperacion)   : int          |
|                | release_adaptador_pp()                                           : int |
|                | start_write_mode()                                           |
|                | end_write_mode()                                             |
|                | start_read_mode()                                            |
|                | end_read_mode()                                              |

### driver_pic16f

| Variables | Methods                                            |
| --------- | -------------------------------------------------- |
|           | init_driver( baseAddr)    : int                    |
|           | release_driver()              : int                |
|           | reset_device()                                     |
|           | init_HVP_mode()                                    |
|           | execute_command( cmd, tipo, data)    : unsgd short |

### program_info

| Variables | Methods                                        |
| --------- | ---------------------------------------------- |
|           | read_program_info( ProgramInfo *, filePath *)  |
|           | write_program_info( ProgramInfo *, filePath *) |

### program_pic16f

| Variables | Methods                                            |
| --------- | -------------------------------------------------- |
|           | execute_programming_task( ProgramInfo *)     : int |
