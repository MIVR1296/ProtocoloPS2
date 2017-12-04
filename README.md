# Protocolo PS2
Corresponde una interfaz la cual es compatible para que un teclado y un mouse se comuniquen con el host. El puerto PS2 está compuesto por  dos cables. Hay un cable  para datos, cuya transferencia es en serie. El otro cable se emplea para la información del reloj. Este último permite especificar si los datos son válidos y si se pueden recuperar. La información es transmitida como un "paquete" de 11 bits, el cual posee 1 bit de inicio, 8 bits de datos, un bit de paridad impar y finalmente un bit de parada.
## Diagrama de tiempos del puerto PS2
![DDT](https://github.com/MIVR1296/ProtocoloPS2/blob/master/Diagramas/DTPS2.png)
## Diagramas de bloques:
### Diagrama de primer nivel: 
El módulo PS2 tiene como entradas  la señal de datos ps2d y la señal de reloj ps2c. El borde descendente de la señal ps2c se utiliza como punto de referencia para recuperar datos. La señal rx_en se utiliza para habilitar o deshabilitar la operación de recepción. 
A la salida se encuentran los 32 bits que se conectan al módulo I/O. La bandera de listo indica al módulo I/O, que el buffer está lleno. Finalmente tick es la bandera para indicar que el dato del teclado es válido.
![DPN](https://github.com/MIVR1296/ProtocoloPS2/blob/master/Diagramas/DPN.png)
### Diagrama de segundo nivel:
![DSN](https://github.com/MIVR1296/ProtocoloPS2/blob/master/Diagramas/DSNPS2.png)

## Máquina de estados del receptor PS2 
### Estado idle:
 El receptor inicialmente se encuentra en estado inactivo. La señal de control  rx-en  se usa para habilitar o deshabilitar la operación de recepción. Después de confirmar el primer tick de borde decreciente y la señal rx-en en alto,  se desplaza  el bit de inicio y luego se salta al estado dps.
 ### Estado dps:
Dado que los datos recibidos están en formato fijo, cambiamos los 10 bits restantes en un solo estado en lugar de utilizar datos separados, paridad y estados de detención. Posteriormente se pasa al estado de carga.
### Estado Load:
Proporciona un ciclo extra de reloj para completar el desplazamiento del bit de parada, y la señal rx-done-tick se confirma para un ciclo de reloj.
![FSM](https://github.com/MIVR1296/ProtocoloPS2/blob/master/Diagramas/FSM_PS2.png)
## Diagramas RTL:
### Módulo PS2 y Buffer
![Módulo PS2 con Buffer](https://github.com/MIVR1296/ProtocoloPS2/blob/master/Diagramas/TOPPS2.png)
### Buffer
![Buffer](https://github.com/MIVR1296/ProtocoloPS2/blob/master/Diagramas/buffer.png)

## Referencias bibliográficas:
[1]  Chu, Pong P. (2008). FPGA prototyping by Verilog examples. Xilinx SpartanTM-3 Version, John Wiley & Sons, Inc.
