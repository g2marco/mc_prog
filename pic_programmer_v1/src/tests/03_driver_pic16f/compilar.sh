#!/bin/bash
#  
#	This script compiles parallel port test programs and changes its permissions
#
echo "Compiling PIC programmer driver tests"

rm -f 01_driver_pic16f.x

MODULES_PATH=../../modules
INCLUDE_LIBS=-I../../libs

gcc 01_driver_pic16f.c  $MODULES_PATH/driver_pic16f.c $MODULES_PATH/port_adapter.c $MODULES_PATH/parallel_port.c  -o 01_driver_pic16f.x $INCLUDE_LIBS 


sudo chown root.root 01_driver_pic16f.x
sudo chmod +s        01_driver_pic16f.x

echo " [done] Tests compiled!"
