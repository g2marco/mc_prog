#!/bin/bash
#  Script de compilacion de versión de distribución

echo "Compiling PIC Programmer"

MODULES_PATH=../src/modules
MAIN_PATH=../src/main
INCLUDE_LIBS=-I../src/libs
TARGET_PATH=/home/g2marco/dist/pic_programmer


rm -f $TARGET_PATH

gcc $MAIN_PATH/pic16fxxx_programmer.c  $MODULES_PATH/program_pic16f.c $MODULES_PATH/program_info.c $MODULES_PATH/driver_pic16f.c $MODULES_PATH/port_adapter.c $MODULES_PATH/parallel_port.c -o $TARGET_PATH $INCLUDE_LIBS 

sudo chown root.root $TARGET_PATH
sudo chmod +s        $TARGET_PATH

echo "Distribution version installed on " $TARGET_PATH
