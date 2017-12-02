`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2017 12:24:02 AM
// Design Name: 
// Module Name: Buffer
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


module Buffer(
input clk, reset,tick,
input [7:0] d,
output [31:0] data,
output ready
);

//data = {~pixel_y [3],pixel_y[2:0]}; se concatenan todos los datos de los registros

reg [1:0] z;

And2 Ready(
.dina(z[0]), 
.dinb(z[1]),
.dout(ready)
);

Counter B(
.clk(tick),
.clear(ready),
.z(z)
);

Nbit_register PD(
.clk(clk), 
.enable(enable), 
.d(d), 
.reset(reset),
.q(q)
);

Nbit_register SD(
.clk(clk), 
.enable(enable), 
.d(d), 
.reset(reset),
.q(q)
);

Nbit_register TD(
.clk(clk), 
.enable(enable), 
.d(d), 
.reset(reset),
.q(q)
);

Nbit_register UD(
.clk(clk), 
.enable(enable), 
.d(d), 
.reset(reset),
.q(q)
);

endmodule
