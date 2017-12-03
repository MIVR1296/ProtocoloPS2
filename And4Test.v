`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2017 03:36:31 PM
// Design Name: 
// Module Name: And4Test
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


module And4Test(
);

reg a,b,c,d;

wire dout;

And4 T(
.dina(a),
.dinb(b),
.dinc(c),
.dind(d),
.dout(dout)
);


initial
         begin
         
         a = 1'b0;
         b = 1'b0;
         c = 1'b0;
         d = 1'b0;
         
         #5
         a = 1'b0;
         b = 1'b1;
         c = 1'b1;
         d = 1'b1;
         
         #5 
         a = 1'b1;
         b = 1'b0;
         c = 1'b0;
         d = 1'b1;
         
         #5
         a = 1'b1;
         b = 1'b1;
         c = 1'b1;
         d = 1'b1;
 end
                 
endmodule
