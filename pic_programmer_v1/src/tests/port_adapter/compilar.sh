#!/bin/bash
#  Script de compilacion y ejecucion de proceso de prueba

MODULES_PATH=../../modules
INCLUDE_LIBS=-I../../libs


echo "Compiling Port Adapter Tests"

# delete object files

rm -f 01_port_adapter.x

# compile tests

gcc 01_port_adapter.c  $MODULES_PATH/01_port_adapter.c $MODULES_PATH/parallel_port.c -o 01_port_adapter.x $INCLUDE_LIBS 


# prepare for execution

sudo chown root.root 01_port_adapter.x
sudo chmod +s        01_port_adapter.x

echo " [done] Tests compiled!"
