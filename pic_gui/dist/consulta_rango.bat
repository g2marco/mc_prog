@echo on

for /L %%I in ( 60, 1, 90) DO ping -w 30 -n 1 192.168.1.%%I | find "Respuesta"
pause