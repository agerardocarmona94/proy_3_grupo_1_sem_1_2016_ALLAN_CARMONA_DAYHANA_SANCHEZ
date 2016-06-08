`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// En este modulo se controla cuando se tiene que llegar el bus de datos a los registros del VGA y cuando debe de llegar
// directamente los registros de escritura con el fin de ver los camios en el VGA
//////////////////////////////////////////////////////////////////////////////////
module MUX_DATOSVGA(
input seleccion,
input [7:0]BUS,
input [7:0]RG1,
input [7:0]RG2,
input [7:0]RG3,
output reg[7:0] OUT1,
output reg[7:0] OUT2,
output reg[7:0] OUT3
    );

   always @(seleccion, RG1, RG2, RG3, BUS)
      case (seleccion)
         1'b0: begin
			OUT1 <= BUS;
			OUT2 <= BUS;
			OUT3 <= BUS;
					end
         1'b1: begin
			OUT1 <= RG1;
			OUT2 <= RG2;
			OUT3 <= RG3;
					end
      endcase
		

endmodule
