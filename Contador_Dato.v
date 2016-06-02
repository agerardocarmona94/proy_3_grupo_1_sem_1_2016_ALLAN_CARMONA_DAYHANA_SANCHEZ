`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:14:56 05/12/2016 
// Design Name: 
// Module Name:    Contador_Dato 
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
module Contador_Dato(
    input rst,
    input Subir,
    input Bajar,
    input clk,
    input W_R,
    output reg [(N-1):0] cuenta
    );
	
	 
	 parameter N = 6;
	 parameter X = 59;

    always @(posedge clk)
      if (rst)
         cuenta <= 0;
      else if (W_R)
		     begin
			     if (Subir)
				  begin
				     if (cuenta == X)
						   cuenta <= 0;
					  else 
						   cuenta <= cuenta + 1'd1;
				  end
				  else 
              begin
				     if (!Bajar)
					     cuenta <= cuenta;
					  else
					  begin
				        if (cuenta == 0)
						     cuenta <= X;
					     else 
						     cuenta <= cuenta - 1'd1;
				     end
				  end 
			  end
			  else 
			     cuenta <= cuenta;
				 

endmodule
