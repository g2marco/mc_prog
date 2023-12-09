#!/bin/bash
#
# This script compiles and execute test programs
#
echo "Compiling PIC16FXXX Programmer"

rm -f ./pic_progammer
gcc pic16fxxx_programmer.c ../pic16fxxx/pic16fxxx_programmer.c ../pic16fxxx/pic16fxxx_driver.c ../programming_info/programming_info.c ../adaptador_pp/adaptador_pp.c ../puerto_paralelo/puerto_paralelo.c -o pic_programmer

sudo chown root.root ./pic_programmer
sudo chmod +s ./pic_programmer

