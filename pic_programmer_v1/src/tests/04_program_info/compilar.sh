#!/bin/bash
#  
#	This script compile test programs and execute them
#

MODULES_PATH=../../modules
INCLUDE_LIBS=-I../../libs

echo "Compiling program info tests"

rm -f 01_program_info.x

gcc 01_program_info.c  $MODULES_PATH/program_info.c -o 01_program_info.x $INCLUDE_LIBS 

sudo chown root.root 01_program_info.x
sudo chmod +s        01_program_info.x

echo " [done] Tests compiled!"
