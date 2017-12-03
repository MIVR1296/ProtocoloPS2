`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2017 12:01:52 AM
// Design Name: 
// Module Name: TopPPS2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// Modulo perifirico PS2, es la union del protocolo PS2 con el buffer de datos
//////////////////////////////////////////////////////////////////////////////////


module TopPPS2(
    input clk,reset, // clk y reset del sistema
    input ps2d,ps2c, rx_en, // bits de entrada del teclado
    output [31:0] joi, // salida de 32 bits del buffer
    output listo, // bandera hacia modulo I/O
    output tick, // bandera de dato valido en el teclado, y entrada de clk al contador
    output [7:0] qfi, // salida primer registro
    output [7:0] qs, // salida segundo reistro
    output [7:0] qt, // salida tercer registro
    output [7:0] qf, // salida cuarto registro
    output [2:0] z // valor del contador
    );

wire [7:0] dout;

// Instancia del modulo teclado

Teclado TopT(
     .clk(clk),
     .reset(reset),
     .ps2d(ps2d),
     .ps2c(ps2c), 
     .rx_en(rx_en),
     .rx_done_tick(tick),
     .dout(dout)
);

wire ready;

// Instancia modulo Buffer

Buffer TopBu(
     .clk(clk), 
     .reset(reset),
     .tick(tick),
     .d(dout),
     .ready(ready),
     .qfi(qfi),
     .qs(qs),
     .qt(qt),
     .qf(qf),
     .z(z),
     .joi(joi),
     .listo(listo) 
);    
    
endmodule


