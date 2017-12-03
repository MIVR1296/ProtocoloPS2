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
//  Modulo de buffer, carga los datos del teclado hasta llegar a la capacidad
// maxima de 32 bits y enciende la bandera de listo y pasa los datoos al modulo DMA
///////////////////////////////////////////////////////////////////////////////////


module Buffer(
input clk, reset,tick, // clk de los registros, reset del sistema, tick es el clk del contador
input [7:0] d, // datos que salen del teclado
output ready,
output [7:0] qfi, // datos salidas de los registros
output [7:0] qs,
output [7:0] qt,
output [7:0] qf,
output [2:0] z, // valor del contador
output [31:0] joi, // 32 bits de salida hacia modulo DMA
output listo // bandera de datos cargados
);

assign joi = {qfi,qs,qt,qf}; //concatenation operator

//wire [2:0] z;

/*reg [7:0] qfi;  // salida primer registro 
reg [7:0] qs;  // salida segundo registro
reg [7:0] qt;  // salida tercer registrp
reg [7:0] qf; // salida cuarto registro*/



And4 DReady(
.dina(z[0]), 
.dinb(~z[1]),
.dinc(z[2]),
.dout(ready)
);

And4 Dlisto(
.dina(~z[0]), 
.dinb(~z[1]),
.dinc(z[2]),
.dout(listo)
);

wire clear;

Or2 Ini(
.dina(reset), 
.dinb(ready),
.dout(clear)
);

Counter B(
.clk(tick),
.clear(clear),
.z(z)
);

wire enablePD;

// Instancia de compuerta and para habilitar carga en el primer registro 
// segun valor del contador

And4 PDFI(
.dina(~z[0]), 
.dinb(~z[1]),
.dinc(~z[2]),
.dout(enablePD)
);

Nbit_register PD(
.clk(clk), 
.enable(enablePD), 
.d(d), 
.reset(reset),
.q(qfi)
);

wire enableSD;

// Instancia de compuerta and para habilitar carga en el segundo registro 
// segun valor del contador

/*And2 SDS(
.dina(~z[1]),
.dinb(~z[2]),
.dout(enableSD)
); */

And4 SDS(
.dina(z[0]), 
.dinb(~z[1]),
.dinc(~z[2]),
.dout(enableSD)
);

Nbit_register SD(
.clk(clk), 
.enable(enableSD), 
.d(d), 
.reset(reset),
.q(qs)
);

wire enableTD;

// Instancia de compuerta and para habilitar carga en el tercer registro 
// segun valor del contador

And4 TDT(
.dina(~z[0]), 
.dinb(z[1]),
.dinc(~z[2]),
.dout(enableTD)
);

Nbit_register TD(
.clk(clk), 
.enable(enableTD), 
.d(d), 
.reset(reset),
.q(qt)
);

wire enableUD;

// Instancia de compuerta and para habilitar carga en el ultimo registro 
// segun valor del contador

And4 UDF(
.dina(z[0]), 
.dinb(z[1]),
.dinc(~z[2]),
.dout(enableUD)
);

/*And2 UDF(
.dina(z[0]),
.dinb(z[1]),
.dout(enableUD)
); */

Nbit_register UD(
.clk(clk), 
.enable(enableUD), 
.d(d), 
.reset(reset),
.q(qf)
);

endmodule