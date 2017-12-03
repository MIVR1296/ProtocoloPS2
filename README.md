# Protocolo PS2
Corresponde una interfaz la cual es compatible para que un teclado y un mouse se comuniquen con el host. El puerto PS2 está compuesto por  dos cables. Hay un cable  para datos, cuya transferencia es en serie. El otro cable se emplea para la información del reloj. Este último permite especificar si los datos son válidos y si se pueden recuperar. La información es transmitida como un "paquete" de 11 bits, el cual posee 1 bit de inicio, 8 bits de datos, un bit de paridad impar y finalmente un bit de parada.
## Diagrama de tiempos del puerto PS2
![DDT](https://github.com/MIVR1296/ProtocoloPS2/blob/master/Diagramas/DTPS2.png)
## Máquina de estados del receptor PS2 
### Estado idle:
 El receptor inicialmente se encuentra en estado inactivo. La señal de control  rx-en  se usa para habilitar o deshabilitar la operación de recepción. Después de confirmar el primer tick de borde decreciente y la señal rx-en en alto,  se desplaza  el bit de inicio y luego se salta al estado dps.
![FSM](https://github.com/MIVR1296/ProtocoloPS2/blob/master/Diagramas/FSM_PS2.png)
![Módulo PS2 con Buffer](https://github.com/MIVR1296/ProtocoloPS2/blob/master/Diagramas/TOP.png)
## Referencias bibliográficas:
[1]  Chu, Pong P. (2008). FPGA prototyping by Verilog examples. Xilinx SpartanTM-3 Version, John Wiley & Sons, Inc.
