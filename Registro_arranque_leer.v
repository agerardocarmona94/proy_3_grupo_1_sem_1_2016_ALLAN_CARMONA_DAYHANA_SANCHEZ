`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:28:51 05/26/2016 
// Design Name: 
// Module Name:    Registro_arranque_leer 
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
module Registro_arranque_leer(
input wire clk,rst,listo,
input wire EN,W_Strobe,
input wire [7:0]port_out,
output reg dato_salida 
    );
 always @(posedge clk)
      if (rst||listo) begin
         dato_salida <= 1'b0;
      end else if (EN && W_Strobe) begin	
			if(port_out==1)
				begin
					dato_salida <= 1'b1;
				end 
			else 
				begin
					dato_salida <= 1'b0;
				end
      end

endmodule  