`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:45:15 06/01/2016 
// Design Name: 
// Module Name:    DECO_VGA 
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
