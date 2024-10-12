#!/bin/bash
#
# This script compiles and execute test programs
#

MODULES_PATH=../../modules
INCLUDE_LIBS=-I../../libs


echo "Compiling PIC16FXXX Programmer Test"

rm -f 01_program_pic16f.x


gcc 01_program_pic16f.c $MODULES_PATH/erase_device.c $MODULES_PATH/program_pic16f.c $MODULES_PATH/program_info.c $MODULES_PATH/driver_pic16f.c $MODULES_PATH/port_adapter.c $MODULES_PATH/parallel_port.c -o 01_program_pic16f.x $INCLUDE_LIBS 

sudo chown root.root 01_program_pic16f.x
sudo chmod +s        01_program_pic16f.x

echo " [done] Tests compiled!"
