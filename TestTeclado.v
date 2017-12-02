`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2017 12:03:03 AM
// Design Name: 
// Module Name: TestTeclado
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



module TestTeclado(
);

// Entradas
reg clk;
reg reset;
reg ps2d;
reg ps2c;
reg rx_en;
    
// Salidas
wire tick;
wire [7:0] dout;


	// Instantiate the Unit Under Test (UUT)    
Teclado uut(
.clk(clk),
.reset(reset),
.ps2d(ps2d),
.ps2c(ps2c),
.rx_en(rx_en),
.rx_done_tick(tick),
.dout(dout)
);

initial
         begin
             clk=0;//inicial el clock en cero
             reset=1;//reset en alto al inicio
             ps2d = 1;
             ps2c = 0;
             rx_en = 1;
             #10 reset=0; //despues de diez 10ns, el reset se pone en cero, dando inicio al funcionamiento
         end
         
            always
             begin
                 #10 clk=~clk;
             end
         always
             begin
                  #100000 ps2c=~ps2c;
             end
         always
             begin      
                 // #200000 ps2d = 1;
                  #200000  ps2d = 0; //inicio 
             //byte de datos
                  #200000  ps2d = 0;
                  #200000  ps2d = 1;
                  #200000  ps2d = 0;
                  #200000  ps2d = 1;
                  #200000  ps2d = 1;
                  #200000  ps2d = 0;
                  #200000  ps2d = 1;
                  #200000  ps2d = 0;
             //paridad
                  #200000  ps2d = 1;
             //final
                  #200000  ps2d = 1;                         
             end    
                                                         
endmodule
