@ echo off

xc8-cc -mcpu=16F627A main.c proceso.c timer0.c

del *.cmf
del *.elf
del *.d
del *.p1
del *.hxl
del startup.*
del *.o
del *.sdb
del *.sym
