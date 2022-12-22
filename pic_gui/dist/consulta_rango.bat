@echo on

for /L %%I in ( 20, 1, 130) DO ping -w 30 -n 1 192.168.1.%%I | find "Respuesta"
pause