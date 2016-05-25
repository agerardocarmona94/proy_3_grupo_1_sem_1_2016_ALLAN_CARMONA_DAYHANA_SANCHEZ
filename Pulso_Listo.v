`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:31:38 05/16/2016 
// Design Name: 
// Module Name:    Pulso_Listo 
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
module Pulso_Listo(
    input listo,
	 input clk,
	 output reg Pulso_Listo
    );
	 
	 reg FF_1 = 0;
	 reg FF_2 = 0;
	 
	 always @(posedge clk)
	 begin
	    FF_1 <= listo;
	    FF_2<=FF_1;
		 if (listo && !FF_1 && !FF_2)
		   Pulso_Listo = 1;
		else
		   Pulso_Listo = 0;
	 end 
	 


endmodule
