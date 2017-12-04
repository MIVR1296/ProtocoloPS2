`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2017 12:26:05 AM
// Design Name: 
// Module Name: TopPPS2_tb
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


module TopPPS2dir_tb(
);

// Entradas
reg clk;
reg reset;
reg ps2d;
reg ps2c;
reg rx_en;
    
// Salidas
wire listo;
wire [31:0] joi;
wire tick;

wire [7:0] qfi;
wire [7:0] qs;
wire [7:0] qt;   
wire [7:0] qf;
wire [2:0] z;
wire [31:0] dire;


TopPPS2Dir uutTop(
.clk(clk),
.reset(reset),
.ps2d(ps2d),
.ps2c(ps2c),
.rx_en(rx_en),
.joi(joi),
.listo(listo),
.tick(tick),
.qfi(qfi),
.qs(qs),
.qt(qt),
.qf(qf),
.z(z),
.dire(dire)
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
