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
// 
//////////////////////////////////////////////////////////////////////////////////


module TopPPS2(
    input clk,reset,
    input ps2d,ps2c, rx_en,
    output [31:0] joi,
    output listo,
    output tick
    );

Teclado TopT(
     .clk(clk),
     .reset(reset),
     .ps2d(ps2d),
     .ps2c(ps2c), 
     .rx_en(rx_en),
     .rx_done_tick(tick),
     .dout(dout)
);

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


