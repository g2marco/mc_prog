#!/bin/bash
#  
#	This script compile test programs and execute them
#
echo "Compiling Programming Info Test"

rm -f test
gcc programming_info_test.c programming_info.c -o test

echo "Executing Programming Info Test"
./test
