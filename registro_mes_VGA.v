`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:06:49 05/31/2016 
// Design Name: 
// Module Name:    registro_mes_VGA 
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
module registro_mes_VGA(
input wire clk,reset,seleccion,
input wire [7:0] dseg,
input wire EN,EN_deco,ACT,
output reg [7:0]dato_seg
    );


always@(posedge clk ) 
begin   
   if (reset)
      dato_seg<=0;

	else begin 
	if((EN_deco==1)&&(((EN==1)&&(seleccion==0))||((ACT==1)&&(seleccion==1))))
     dato_seg<=dseg;
	 else 
	  dato_seg<=dato_seg;
	  end
	 
end

endmodule 