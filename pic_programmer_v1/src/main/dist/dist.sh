#!/bin/bash
#  Script de compilacion de versión de distribución

echo "Compiling PIC16FXXX Programmer"

rm -f /usr/local/pic_programmer/pic16fxxx

gcc pic16fxxx.c pic16fxxx_programmer.c pic16fxxx_driver.c ../programming_info/programming_info.c ../adaptador_pp/adaptador_pp.c ../puerto_paralelo/puerto_paralelo.c -o /usr/local/pic_programmer/pic16fxxx

sudo chown root.root /usr/local/pic_programmer/pic16fxxx
sudo chmod +s        /usr/local/pic_programmer/pic16fxxx

echo "Distribution version installed on /usr/local/pic_programmer/pic16fxxx"
