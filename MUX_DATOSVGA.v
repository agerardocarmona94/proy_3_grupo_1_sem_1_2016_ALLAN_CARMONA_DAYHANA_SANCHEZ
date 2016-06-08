`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:31:57 06/01/2016 
// Design Name: 
// Module Name:    MUX_DATOSVGA 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
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
