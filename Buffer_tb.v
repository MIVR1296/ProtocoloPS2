`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2017 10:28:41 PM
// Design Name: 
// Module Name: Buffer_tb
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


module Buffer_tb(
);

// Entradas
reg clk;
reg reset;
reg tick;
reg [7:0] d;

// Salidas
wire ready;
wire [7:0] qfi;
wire [7:0] qs;
wire [7:0] qt;
wire [7:0] qf;
wire [2:0] z;
wire [31:0] joi;
wire listo;

Buffer testB(
.clk(clk), 
.reset(reset),
.tick(tick),
.d(d),
.ready(ready),
.qfi(qfi),
.qs(qs),
.qt(qt),
.qf(qf),
.z(z),
.joi(joi),
.listo(listo) 
);

initial
         begin
             clk=0;//inicial el clock en cero
             tick=0;
             reset=1;
             #10 reset=0; //despues de diez 10ns, el clear se pone en cero, dando inicio al funcionamiento
         end
         
            always
             begin
                 #10 clk=~clk;
             end

         always
             begin      
                #20 tick=~tick;                      
             end    
             
initial
                  begin
             
             d=8'h10;
             
             #15
             d=8'h01;
             
             #15 
             d=8'h11;
             
             #15
             d=8'h10;
     end    



endmodule
