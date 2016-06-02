`timescale 1ns / 1ps

module Divisor_Displays(    //este modulo se encarga de dividir la frecuencia para trabajar el 7 segmentos
    input clk,					 //declaracion de entradas y salidas
    input rst,
    output reg q				 //salida dl nuevo reloj
    );
reg [16:0] counter=0; //declaracion del contador de 17 bits
	
	always @(posedge clk or posedge rst)  //cuenta o borra la cuenta en el flanco positivo del reset o el clock
	begin
		if (rst)
			begin
				counter<=17'd0;   //si reset en alto pone cuenta en 0
				q<= 1'b0;
			end
		else
			if (counter==17'd99999)  //si se llega a este valor el contador vuelve a contador desde cero
			begin
				counter<=17'd0;
				q <= ~q;
			end
	  else
	   begin
			counter <=counter+1'b1; //se aumenta una cuenta en el contador
		end
	end

endmodule

