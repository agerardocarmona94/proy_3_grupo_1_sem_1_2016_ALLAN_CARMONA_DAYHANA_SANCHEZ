`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:07:04 06/02/2016 
// Design Name: 
// Module Name:    registro_min_CRONOMETRO 
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
module registro_min_CRONOMETRO(
input wire clk,reset,seleccion,
input wire [7:0] dseg,
input wire EN,EN_deco,ACT,
output reg [7:0]dato_min
    );


always@(posedge clk ) 
begin   
   if (reset)
      dato_min<=0;

	else begin 
	if((EN_deco==1)&&(((EN==1)&&(seleccion==0))||((ACT==1)&&(seleccion==1))))
     dato_min<=dseg;
	 else 
	  dato_min<=dato_min;
	  end
	 
end

endmodule
