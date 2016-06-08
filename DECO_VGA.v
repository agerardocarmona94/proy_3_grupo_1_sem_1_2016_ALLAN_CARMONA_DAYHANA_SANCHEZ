`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// En este modulo se decodifica que se esta escribiendo de manera que se habiliten los registros del VGA necesarios para que se observe en pantalla el cambio respectivo
//////////////////////////////////////////////////////////////////////////////////
module DECO_VGA(
input [7:0] Fs,
input clk,reset,
output reg[2:0]activacion
    );

   always @(posedge clk)
      if (reset)
         activacion <= 3'b000;
      else
         case (Fs)
            8'h6C   : activacion <= 3'b001; // r
            8'h75   : activacion <= 3'b100;
				8'h7D   : activacion <= 3'b010;  //fecha
				
            default : activacion <= 3'b000;
         endcase
		

endmodule
