`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2017 03:01:09 PM
// Design Name: 
// Module Name: Nbit_register
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

module Nbit_register(
// inputs
clk, enable, d, reset,
// outputs
q
);

parameter N = 8;

input clk;
input enable;
input reset;
input [N-1:0] d;
output reg [N-1:0] q;

always @ (posedge clk or posedge reset)
begin
    if (reset == 1) begin
        q <= 0;
    end else if (enable == 1) begin
        q <= d;
    end
end                
endmodule
