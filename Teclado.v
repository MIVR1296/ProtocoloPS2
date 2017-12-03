`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2017 12:01:30 AM
// Design Name: 
// Module Name: Teclado
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Los datos se transmiten en una secuencia en serie. Comienza con un bit de inicio, 
// seguido de 8 bits de datos y un bit de paridad impar, y finaliza con un bit de parada.la información del 
// reloj se transmite en una señal de reloj separada, ps2c. El borde descendente de la señal ps2c indica que 
// el bit correspondiente en la línea ps2d es válido y puede recuperarse. El período de reloj de la señal ps2c 
// está entre  10 kHz a 16,7 kHz, y la señal ps2d es estable al menos 5 ps antes y después del borde descendente 
// de la señal ps2c
// 
//////////////////////////////////////////////////////////////////////////////////

// Puerto receptor PS2
module Teclado(
 input clk,reset,
 //*************************************************************************************************
 input ps2d,ps2c, rx_en, // ps2d: señal de datos/ ps2c: señal de reloj
 //  el borde descendente de la señal ps2c se utiliza como punto de referencia para recuperar datos.
 // Señal rx_en: El receptor incluye una señal de control adicional, rx-en, que se usa para habilitar
 // o deshabilitar la operación de recepción. El propósito de la señal es coordinar la operación
 // bidireccional. Se puede establecer en 1 para la interfaz del teclado.
 //*************************************************************************************************
 output reg rx_done_tick, // Si detecta un flanco descendente se genera un tick de habilitación
 output wire [7:0] dout
);

//***********************************************************************
//           Declaración simbólica de los estados de la FSM del receptor
//***********************************************************************
      localparam [1:0] 
      idle=2'b00, // Estado inactivo
      dps=2'b01 , //
      load=2'b10 ;
//***********************************************************************

// Declaración de señales
      reg [1:0] state_reg, state_next; // registros para control de los estados
      reg [7:0] filter_reg; // registro actual para el filtrado de los datos
      wire [7:0] filter_next; // // registro siguiente para el filtrado de los datos
      reg f_ps2c_reg ;
      wire f_ps2c_next ;
      reg [3:0] n_reg , n_next ;
      reg [10:0] b_reg , b_next ;
      wire fall_edge ; // flanco descendente como punto de referencia para la recuperación de los datos


//*************************************************************
// circuito de detección de flanco con circuito de filtrado
//*************************************************************
always @(posedge clk, posedge reset) // Siempre que se de un flanco de reloj positovo 
    if (reset) // si el reset está en alto
        begin
            filter_reg  <= 0; // inicializo el registro de filtrado 
            f_ps2c_reg <= 0;  // inicializo el registro de la señal de reloj ps2c
        end
    else begin                
            filter_reg<= filter_next;
            f_ps2c_reg<= f_ps2c_next;
        end
//****************************************************************************************
// El circuito está compuesto por un registro de desplazamiento de 8 bits y devuelve 1 o 0 
//cuando se reciben 1’s o 0’s consecutivos. Se ignorarán todas las fallas técnicas de menos
// de ocho ciclos de reloj (es decir, filtradas). La señal de salida filtrada se alimenta 
//luego al circuito de detección de flanco descendente normal.
//*****************************************************************************************
assign filter_next = {ps2c, filter_reg[7:1]};
assign f_ps2c_next = (filter_reg==8'b11111111) ? 1'b1:
                     (filter_reg == 8'b00000000) ? 1'b0 :
                     f_ps2c_reg;

assign fall_edge = f_ps2c_reg & ~f_ps2c_next; 


//*******************************************************************
//                      Máquina de estados del receptor
//*******************************************************************
// FSMD state & data registers 

always @(posedge clk, posedge reset)
      if (reset) // si hay un reset se pasa al estado de inactivo
          begin
              state_reg <= idle;
              n_reg <= 0 ; // Por defecto se inicializan los registros con "0"
              b_reg <= 0 ;
          end
      else begin //de lo contrario se pasa al estado siguiente
              state_reg <= state_next ;
              n_reg <= n_next;
              b_reg <= b_next;
      end

// Lógica del estado siguiente de la FSMD

always @* begin
          state_next = state_reg;
          rx_done_tick = 1'b0; // se inicializa la bandera de detección de flanco descendente (recuperación válida de los datos)
          n_next = n_reg;
          b_next = b_reg;
      case (state_reg) 
      
      //********************************************
      //                Estado de inactivo
      //********************************************
      idle:
            if (fall_edge & rx_en) // Si se detecta un flanco descendete y la recepción está habilitada
            begin
                // desplazamiento en el bit de inicio y luego pasa el estado dsp 
                b_next = { ps2d, b_reg [10:1]} ;
                n_next = 4'b1001;
                state_next = dps;
            end
            
      //****************************************************************************************************
      //*                                           DPS state                                              *
      //****************************************************************************************************
      //*Después de afirmar el primer tic de borde decreciente y la señal rx-en,                           *
      //*el FSMD se desplaza en el bit de inicio y pasa al estado dps.                                     *
      //*Dado que los datos recibidos están en formato fijo, cambiamos los 10 bits                         *
      //*restantes en un solo estado en lugar de utilizar datos separados, paridad y estados de detención. *
      //****************************************************************************************************

      dps: // 8datu + Iparity + Istop
            if (fall_edge) begin 
                b_next = { ps2d , b_reg [10:1] };
                if (n_reg==0)
                    state_next = load;
                else
                    n_next = n_reg - 1 ;
            end
            
       //****************************************************************************************************
       //*                                           load state                                             *
       //****************************************************************************************************
       //*A continuación, la FSMD pasa al estado de carga, en la que se proporciona un ciclo extra de reloj *
       //*para completar el desplazamiento del bit de parada, y la señal psrx-done-tick se confirma para un *
       //*ciclo de reloj.                                                                                    *
       //****************************************************************************************************                                                                              *

      load: // Iextra clock to complete the last
            begin
                  state_next = idle;
                  rx_done_tick = 1'b1 ;
            end
      endcase
end


// output

assign dout = b_reg[8:1]; // data bits


endmodule
