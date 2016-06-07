`timescale 1ns / 1ps
// Este m�dulo se encarga de selecionar la posici�n a cambiar, por ejemplo si se va a cambiar la fecha se debe 
//elegir entre dia, mes o a�o, por lo que este contador realiza esta distinci�n de posici�n.

module Contador_Posicion(
	input clk, rst,
    input [N-1:0]key_code, // recibe el c�digo de la tecla presionada
	 input got_code_tick, // se�al que indica el momento de captura del codigo de la tecla
	 output reg [P-1:0] posicion // --:--:--
    );
	 
	parameter N=8;
	parameter P=2;
   always @ (posedge clk)
	begin
		if (rst)
			posicion <=0;
		else if (got_code_tick==1'b1)
		begin
			if (key_code==8'h74) //tecla 6 (derecha)
			begin
				if (posicion==2'd2) 
					posicion <=0;
				else
					posicion <= posicion + 1'd1;
			end
			else if (key_code==8'h6B) //tecla 4 (izquierda)
			begin
				if(posicion==0)
					posicion <=2'd2;
				else
					posicion <= posicion - 1'd1;
			end 
			else 
				posicion <= posicion;
		end
		else 
				posicion <= posicion;
	end
	
endmodule
