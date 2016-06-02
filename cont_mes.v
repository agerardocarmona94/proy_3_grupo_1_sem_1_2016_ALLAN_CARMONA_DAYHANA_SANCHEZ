`timescale 1ns / 1ps

module cont_mes(
	input clk, rst,
	input [P-1:0]posicion,
	input en_codigo, f2,
	input[N-1:0] key_code,
	output reg[N-1:0] dato_mes
    );

reg [3:0] mes;
parameter N=8;
parameter P=2;
parameter maximo =4'd12;

 always @ (posedge clk)
	 begin
      if (rst)
         mes <= 0;
		else if (posicion==2'd1 && f2==1'b1)
		begin
		 if(en_codigo)
		 begin
			if (key_code==8'h75) //tecla 8 (subir)
			begin
				if (mes == maximo)
					mes <= 0;
				else 
					mes <= mes + 1'd1;
		   end
			else if (key_code==8'h72) //tecla 2 (bajar)
			begin
				if (mes == 0)
					mes <= maximo;
				else 
					mes <= mes - 1'd1;
			end
			else 
				mes <= mes;
		end 
		else 
			mes <= mes;
		end
		else 
			mes <= mes;
	end
	
	always @(mes)	 
	   case (mes)
          0 : dato_mes <=8'h00;
 			1 : dato_mes <=8'h01;
			2 : dato_mes <=8'h02;
			3 : dato_mes <=8'h03;
			4 : dato_mes <=8'h04;
			5 : dato_mes <=8'h05;
			6 : dato_mes <=8'h06;
			7 : dato_mes <=8'h07;
			8 : dato_mes <=8'h08;
			9 : dato_mes <=8'h09;
			10 : dato_mes <=8'h10;
			11 : dato_mes <=8'h11;
			12 : dato_mes <=8'h12;
			default: dato_mes <=8'h00;
		endcase
		
endmodule
