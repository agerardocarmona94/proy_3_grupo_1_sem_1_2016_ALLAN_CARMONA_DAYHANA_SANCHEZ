`timescale 1ns / 1ps
//NOTA: El razonamiento utilizado para la explicación de este módulo es el mismo que para el de minutos y segundos
// por lo que solo se explica una vez.
// Este módulo realiza la cuenta correspondiente para el parámetro hora, por lo que su valor maximo es hasta 24
// para poder cambiar este parámetro la señal de F1 o F3 deben de estar activas, las cuales indican que se esta 
// cambiando el reloj o el cronometro.


module cont_hora(
	input clk, rst,
	input [P-1:0]posicion,
	input en_codigo, f1,f3,
	input[N-1:0] key_code, 
	//input[N-1:0] Fs,
	output reg[N-1:0] dato_hora
    );

reg [4:0] hora;
parameter maximo =5'd24;
parameter N=8;
parameter P=2;



   always @ (posedge clk)
   begin
      if (rst)
         hora <= 0;
		else if (posicion==2'd0 &&  (f1==1'b1 || f3==1'b1))
		begin
			if(en_codigo)
			begin
				if (key_code==8'h75) //tecla 8 (subir)
				begin
					if (hora == maximo)
						hora <= 0;
					else 
						hora <= hora + 1'd1;
				end
				else if (key_code==8'h72) //tecla 2 (bajar)
				  begin
					  if (hora == 0)
						hora <= maximo;
					  else 
						hora <= hora - 1'd1;
				  end
				else 
				  hora <= hora;
			end
			else 
				  hora <= hora;
		end
		else 
			hora <= hora;
		
	end
	// En esta sección se reliza internamente en el módulo la conversion a hexadeciamal para cada uno de los
	//valores.
	always @ (hora)
		case (hora)
		   0 : dato_hora <=8'h00;
 			1 : dato_hora <=8'h01;
			2 : dato_hora <=8'h02;
			3 : dato_hora <=8'h03;
			4 : dato_hora <=8'h04;
			5 : dato_hora <=8'h05;
			6 : dato_hora <=8'h06;
			7 : dato_hora <=8'h07;
			8 : dato_hora <=8'h08;
			9 : dato_hora <=8'h09;
			10 : dato_hora <=8'h10;
			11 : dato_hora <=8'h11;
			12 : dato_hora <=8'h12;
			13 : dato_hora <=8'h13;
 			14 : dato_hora <=8'h14;
			15 : dato_hora <=8'h15;
			16 : dato_hora <=8'h16;
			17 : dato_hora <=8'h17;
			18 : dato_hora <=8'h18;
			19 : dato_hora <=8'h19;
			20 : dato_hora <=8'h20;
			21 : dato_hora <=8'h21;
			22 : dato_hora <=8'h22;
			23 : dato_hora <=8'h23;
 			24 : dato_hora <=8'h24;
			default: dato_hora <=8'h00;
		endcase
endmodule


