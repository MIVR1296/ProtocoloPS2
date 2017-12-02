`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2017 11:37:23 PM
// Design Name: 
// Module Name: TopPS2
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

module TopPS2(
    input clk,reset,
    input ps2d,ps2c, rx_en,
    output rx_done_tick,
    output [7:0] data,
    output wire [7:0] dout
);

Teclado TopT(
     .clk(clk),
     .reset(reset),
     .ps2d(ps2d),
     .ps2c(ps2c), 
     .rx_en(rx_en),
     .rx_done_tick(rx_done_tick),
     .dout(data)
);

Nbit_register TopR(
     .clk(clk), 
     .enable(rx_done_tick), 
     .d(data), 
     .reset(reset),
     .q(dout)
);

endmodule
