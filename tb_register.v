`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2017 03:01:57 PM
// Design Name: 
// Module Name: tb_register
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

module tb_register;

reg clk;
reg reset;
reg enable;
reg[7:0] d;

wire[7:0] q;

Nbit_register register (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .d(d),
    .q(q)
    );

initial
begin
    clk = 0;
    reset = 0;
    enable = 0;
    d = 8'h11;
end

always
    #5 clk =  !clk; 

initial
begin
    d = 8'hAB;
#5  enable = 1;
    d = 8'hFF;
#10 enable = 0;
    d = 8'hAA;        
end
endmodule
