`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2017 08:25:27 PM
// Design Name: 
// Module Name: Counter
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


module Counter(
 input clk,
 input clear,
 output [2:0] z
);

reg [2:0] q;

 always @(posedge clk, posedge clear)
    if (clear == 1)
     q <= 0;
    else
     q <= q + 1;
    assign z = q;
    
endmodule


