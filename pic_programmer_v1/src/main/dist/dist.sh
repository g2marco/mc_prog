#!/bin/bash
#  Script de compilacion de versión de distribución

echo "Compiling PIC Programmer"

MODULES_PATH=../../modules
INCLUDE_LIBS=-I../../libs
TARGET_PATH=/usr/local/pic_programmer/pic16fxxx


rm -f $TARGET_PATH

gcc pic16fxxx_programmer.c  $MODULES_PATH/program_pic16f.c $MODULES_PATH/program_info.c $MODULES_PATH/driver_pic16f.c $MODULES_PATH/port_adapter.c $MODULES_PATH/parallel_port.c -o $TARGET_PATH $INCLUDE_LIBS 

sudo chown root.root $TARGET_PATH
sudo chmod +s        $TARGET_PATH

echo "Distribution version installed on /usr/local/pic_programmer/pic16fxxx"
