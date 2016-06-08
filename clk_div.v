`timescale 1ns / 1ps
// Divisor utilizado para poder trabajar a una señal de reloj de 25MHz, el divisor solo convierte de 100 a 50MHz, xq en el módulo del VGA 
//ya se encuentra otro divisor, que convierte de 50 a 25MHz
module clk_div(clk ,out_clk);
output reg out_clk;
input clk ;


always @(posedge clk)
	begin
      out_clk <= ~out_clk;	
	end
	
endmodule
 
