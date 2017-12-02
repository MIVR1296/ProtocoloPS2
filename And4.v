`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2017 03:35:06 PM
// Design Name: 
// Module Name: And4
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


module And4(
input dina,dinb,dinc,dind,
output dout
);

assign dout = dina & dinb & dinc & dinb;
endmodule

