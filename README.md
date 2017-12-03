# ProtocoloPS2
Corresponde una interfaz la cual es compatible para que un teclado y un mouse se comuniquen con el host. El puerto PS2 está compuesto por c dos cables, empleados para comunicación. Hay un cable  para datos, cuya transferencia es en serie. El otro cable se emplea para la información del reloj. Este último permite especificar si los datos son válidos y si se pueden recuperar. La información en transmitida como un "paquete" de 11 bits, el cual posee 1 bit de inicio, 8 bits de datos, un bit de paridad impar y finalmente un bit de parada.
![FSM](https://github.com/MIVR1296/ProtocoloPS2/blob/master/Diagramas/FSM_PS2.png)
![Módulo PS2 con Buffer](https://github.com/MIVR1296/ProtocoloPS2/blob/master/Diagramas/TOP.png)
