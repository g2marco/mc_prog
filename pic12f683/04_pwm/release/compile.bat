@echo off

set SRC_DIR=..\src
set LIBS_DIR=%SRC_DIR%\libs

del /s *.cmf     >nul 2>&1
del /s *.elf     >nul 2>&1
del /s *.d       >nul 2>&1
del /s *.p1      >nul 2>&1
del /s *.hxl     >nul 2>&1
del /s startup.* >nul 2>&1
del /s *.o       >nul 2>&1
del /s *.sdb     >nul 2>&1
del /s *.sym     >nul 2>&1
del /s *.hex     >nul 2>&1
del /s *.s       >nul 2>&1

xc8-cc -mcpu=12F683 %SRC_DIR%\main.c %SRC_DIR%\app_main.c %LIBS_DIR%\device_setup.c %LIBS_DIR%\timer2.c %LIBS_DIR%\pwm.c

del /s *.cmf     >nul 2>&1
del /s *.elf     >nul 2>&1
del /s *.d       >nul 2>&1
del /s *.p1      >nul 2>&1
del /s *.hxl     >nul 2>&1
del /s startup.* >nul 2>&1
del /s *.o       >nul 2>&1
del /s *.sdb     >nul 2>&1
del /s *.sym     >nul 2>&1

