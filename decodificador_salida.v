`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:39:54 05/25/2016 
// Design Name: 
// Module Name:    decodificador_salida 
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
module decodificador_salida( 
input [7:0] port_id,
input clk,
input rst,
output [7:0] enable
    );

   reg [7:0] enable;
   
   wire [7:0] port_id;

   always @(posedge clk)
      if (rst)
         enable <= 8'h00;
      else
         case (port_id)
            8'd0  : enable <= 8'b00000001;
            8'd1  : enable <= 8'b00000010;
            8'd2  : enable <= 8'b00000100;
            8'd3  : enable <= 8'b00001000;
            8'd4  : enable <= 8'b00010000;
            8'd5  : enable <= 8'b00100000;
            8'd6  : enable <= 8'b01000000;
            8'd7  : enable <= 8'b10000000;
            default : enable <=8'b00000000;
         endcase

endmodule
