`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:02:37 05/26/2016 
// Design Name: 
// Module Name:    Registro_dato 
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
module Registro_dato(
input wire clk,rst,
input wire EN,W_Strobe,
input wire [7:0]port_out,
output reg [7:0]dato_salida 
    );
 always @(posedge clk)
      if (rst) begin
         dato_salida <= 8'b00000000;
      end else if (EN && W_Strobe) begin
         dato_salida <= port_out;
      end

endmodule 