# Protocolo PS2
Corresponde una interfaz la cual es compatible para que un teclado y un mouse se comuniquen con el host. El puerto PS2 está compuesto por  dos cables. Hay un cable  para datos, cuya transferencia es en serie. El otro cable se emplea para la información del reloj. Este último permite especificar si los datos son válidos y si se pueden recuperar. La información es transmitida como un "paquete" de 11 bits, el cual posee 1 bit de inicio, 8 bits de datos, un bit de paridad impar y finalmente un bit de parada.
## Diagrama de tiempos del puerto PS2
![DDT](https://github.com/MIVR1296/ProtocoloPS2/blob/master/Diagramas/DTPS2.png)
## Diagramas de bloques:
### Diagrama de primer nivel: 
![DPN](https://github.com/MIVR1296/ProtocoloPS2/blob/master/Diagramas/DPN.png)
El módulo PS2 tiene como entradas  la señal de datos ps2d y la señal de reloj ps2c. El borde descendente de la señal ps2c se utiliza como punto de referencia para recuperar datos. La señal rx_en se utiliza para habilitar o deshabilitar la operación de recepción. 
A la salida se encuentran los 32 bits que se conectan al módulo I/O. La bandera de listo indica al módulo I/O, que el buffer está lleno. Finalmente tick es la bandera para indicar que el dato del teclado es válido.
### Diagrama de segundo nivel:
![DSN](https://github.com/MIVR1296/ProtocoloPS2/blob/master/Diagramas/DSNPS2.png)
#### Receptor PS2
El receptor del puerto PS2  sutiliza como punto de referencia el borde descendente de la señal ps2c, con la finalidad de poder recuperar datos. Dicho subsistema posee un circuito de detección de flanco descendente, el cual produce un tick de un ciclo de reloj en el borde descendente de la señal ps2c, y el receptor, que se desplaza y ensambla los bits en serie. Se añade un circuito de filtrado simple para eliminar problemas técnicos. 
##### Máquina de estados del receptor PS2 
![FSM](https://github.com/MIVR1296/ProtocoloPS2/blob/master/Diagramas/FSM_PS2.png)
###### Estado idle:
 El receptor inicialmente se encuentra en estado inactivo. La señal de control  rx-en  se usa para habilitar o deshabilitar la operación de recepción. Después de confirmar el primer tick de borde decreciente y la señal rx-en en alto,  se desplaza  el bit de inicio y luego se salta al estado dps.
 ###### Estado dps:
Dado que los datos recibidos están en formato fijo, cambiamos los 10 bits restantes en un solo estado en lugar de utilizar datos separados, paridad y estados de detención. Posteriormente se pasa al estado de carga.
###### Estado Load:
Proporciona un ciclo extra de reloj para completar el desplazamiento del bit de parada, y la señal rx-done-tick se confirma para un ciclo de reloj.
#### Buffer
El Buffer, carga los datos del teclado hasta llegar a la capacidad maxima de 32 bits y enciende la bandera de listo y pasa los datos al modulo I/O. 
## Diagramas RTL:
### Módulo PS2 y Buffer
![Módulo PS2 con Buffer](https://github.com/MIVR1296/ProtocoloPS2/blob/master/Diagramas/TOPPS2.png)
### Buffer
![Buffer](https://github.com/MIVR1296/ProtocoloPS2/blob/master/Diagramas/buffer.png)
## Simulaciones
### Receptor PS2
En la simulación Post-synthesis del receptor PS2 se observa el paquete de 11 bits compuestos por el bit de inicio, los 8 bits de dados, el de paridad impar y finalmente el de parada. Los bits se pueden ver en la señal de datos ps2c ,en la cual se asignó en el Testbench que el bit de incio fuese "0" los de datos "01011010", el de paridad "1" y finalmente el de parada "1". Ahora en este caso se decidió que la señal rx_en se mantuviese en alto, por lo que la recepción está habilitada.
![TSBT2](https://github.com/MIVR1296/ProtocoloPS2/blob/master/Diagramas/TT2.png)
Como se observa en la siguiente imagen, cuando se completa el ciclo de reloj (ver máquina de estados), se levanta la bandera px_done_tick.
![TSBT](https://github.com/MIVR1296/ProtocoloPS2/blob/master/Diagramas/TSBT.png)


### Buffer
El tick es el que indica que ya están los 8 bits del teclado y por eso se utiliza como clk en el contador, porque cuando hay un tick se sabe que hay 8 bits válidos, entonces se cargan al primer registro, y así, cuando hay otro tick, se carga al segundo registro y así sucesivamente. Entonces las salidas del contador son 3 bits, por lo que cuando está en 000 va hacia la and, y coloca el primer dato, luego en 001 el segundo dato y así continua hasta completar los 32 bits. Cuando el bus está lleno entonces se levanta la bandera de listo.
![SPB](https://github.com/MIVR1296/ProtocoloPS2/blob/master/Diagramas/SPB.png)


## Referencias bibliográficas:
[1]  Chu, Pong P. (2008). FPGA prototyping by Verilog examples. Xilinx SpartanTM-3 Version, John Wiley & Sons, Inc.
