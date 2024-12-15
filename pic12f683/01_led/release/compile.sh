#!/bin/bash
#  compilación de proyecto 

clear

SRC_DIR=../src
LIBS_DIR=$SRC_DIR/libs

# delete possible files left by previous run

rm *.cmf        2> /dev/null
rm *.elf        2> /dev/null
rm *.d          2> /dev/null
rm *.p1         2> /dev/null
rm *.hx         2> /dev/null
rm startup.*    2> /dev/null
rm *.o          2> /dev/null
rm *.sdb        2> /dev/null
rm *.sym        2> /dev/null
rm *.hex        2> /dev/null
rm *.s          2> /dev/null

xc8-cc -mcpu=12F683  $SRC_DIR/main.c $SRC_DIR/app_main.c $LIBS_DIR/device_setup.c

rm *.cmf        2> /dev/null
rm *.elf        2> /dev/null
rm *.d          2> /dev/null
rm *.p1         2> /dev/null
rm *.hxl        2> /dev/null
rm startup.*    2> /dev/null
rm *.o          2> /dev/null
rm *.sdb        2> /dev/null
rm *.sym        2> /dev/null
