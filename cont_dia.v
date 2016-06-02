`timescale 1ns / 1ps

module cont_dia(
	input clk, rst,
	input [P-1:0]posicion,
	input en_codigo, f2,
	input[N-1:0] key_code,
	output reg [N-1:0] dato_dia
    );

reg [4:0] dia;
parameter N=8;
parameter P=2;
parameter maximo =5'd31;

 always @ (posedge clk)
	begin
      if (rst)
         dia <= 0;
		else if (posicion==2'd0 && f2)
		begin
			if(en_codigo)
			begin
				if (key_code==8'h75) //tecla 8 (subir)
				begin
					if (dia == maximo)
						dia <= 0;
					else 
						dia <= dia + 1'd1;
				end
				else if (key_code==8'h72) //tecla 2 (bajar)
				begin
					if (dia == 0)
						dia <= maximo;
					else 
						dia <= dia - 1'd1;
				end
				else 
					dia <= dia;
			end
			else 
				dia <= dia;
		end 
		else 
			dia <= dia;
	end
	
	always @(dia)
	 case (dia)
          0 : dato_dia <=8'h00;
 			1 : dato_dia <=8'h01;
			2 : dato_dia <=8'h02;
			3 : dato_dia <=8'h03;
			4 : dato_dia <=8'h04;
			5 : dato_dia <=8'h05;
			6 : dato_dia <=8'h06;
			7 : dato_dia <=8'h07;
			8 : dato_dia <=8'h08;
			9 : dato_dia <=8'h09;
			10 : dato_dia <=8'h10;
			11 : dato_dia <=8'h11;
			12 : dato_dia <=8'h12;
			13 : dato_dia <=8'h13;
 			14 : dato_dia <=8'h14;
			15 : dato_dia <=8'h15;
			16 : dato_dia <=8'h16;
			17 : dato_dia <=8'h17;
			18 : dato_dia <=8'h18;
			19 : dato_dia <=8'h19;
			20 : dato_dia <=8'h20;
			21 : dato_dia <=8'h21;
			22 : dato_dia <=8'h22;
			23 : dato_dia <=8'h23;
 			24 : dato_dia <=8'h24;
			25 : dato_dia <=8'h25;
			26 : dato_dia <=8'h26;
			27 : dato_dia <=8'h27;
			28 : dato_dia <=8'h28;
			29 : dato_dia <=8'h29;
			30 : dato_dia <=8'h30;
			31 : dato_dia <=8'h31;
			default: dato_dia<=8'h00;
		endcase
endmodule 