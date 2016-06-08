`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:25:23 06/03/2016 
// Design Name: 
// Module Name:    registro_almacenamiento 
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
module registro_almacenamiento( 
input [7:0] dato1,dato2,dato3,tecla,guardar,
input clk,reset,
output reg [7:0] salida1,salida2,salida3,
output reg AAA
    );
   always @(posedge clk)
      if (reset) begin
         salida1 <=0;
			salida2<=0;
			salida3 <=0;
			AAA<=0;
      end else if ((tecla==8'h75)&&(guardar===8'h01)) begin
         salida1 <=dato1;
			salida2<=dato2;
			salida3 <=dato3;
			AAA<=1;
      end else begin
		    salida1 <=salida1;
			salida2<=salida2;
			salida3 <=salida3;
			AAA<=AAA;
		end

endmodule
