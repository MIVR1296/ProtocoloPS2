`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2017 08:28:41 PM
// Design Name: 
// Module Name: Counter_Tb
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


module Counter_Tb(
);


// Entradas
reg clk;
reg clear;
    
// Salidas
wire [1:0] z;

Counter uutC(
.clk(clk),
.clear(clear),
.z(z)
);

initial
         begin
             clk=0;//inicial el clock en cero
             clear=1;//clear en alto al inicio
             #10 clear=0; //despues de diez 10ns, el clear se pone en cero, dando inicio al funcionamiento
         end
         
            always
             begin
                 #10 clk=~clk;
             end

         always
             begin      
                #60 clear=~clear;                      
             end    
                                                         
endmodule
