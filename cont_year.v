`timescale 1ns / 1ps

module cont_year(
	input clk, rst,
	input [P-1:0]posicion,
	input en_codigo, f2,
	input[N-1:0] key_code,
	output reg[N-1:0] dato_year
    );

reg [6:0] year;
parameter N=8;
parameter P=2;
parameter maximo =7'd99;

 always @(posedge clk)
	 begin
      if (rst)
         year <= 0;
		else if (posicion==2'd2 && f2==1'b1)
		begin
			if(en_codigo)
			begin
				if (key_code==8'h75) //tecla 8 (subir)
				begin
					if (year == maximo)
						year <= 0;
					else 
						year <= year + 1'd1;
				end
				else if (key_code==8'h72) //tecla 2 (bajar)
				begin
					if (year == 0)
						year <= maximo;
					else 
						year <= year - 1'd1;
				end
				else 
				year <= year;
			end
			else 
				year <= year;
		end 
		else 
			year <= year;
	end
	
	always @ (year)
	case (year)
          0 : dato_year <=8'h00;
 			1 : dato_year <=8'h01;
			2 : dato_year <=8'h02;
			3 : dato_year <=8'h03;
			4 : dato_year <=8'h04;
			5 : dato_year <=8'h05;
			6 : dato_year <=8'h06;
			7 : dato_year <=8'h07;
			8 : dato_year <=8'h08;
			9 : dato_year <=8'h09;
			10 : dato_year <=8'h10;
			11 : dato_year <=8'h11;
			12 : dato_year <=8'h12;
			13 : dato_year <=8'h13;
 			14 : dato_year <=8'h14;
			15 : dato_year <=8'h15;
			16 : dato_year <=8'h16;
			17 : dato_year <=8'h17;
			18 : dato_year <=8'h18;
			19 : dato_year <=8'h19;
			20 : dato_year <=8'h20;
			21 : dato_year <=8'h21;
			22 : dato_year <=8'h22;
			23 : dato_year <=8'h23;
 			24 : dato_year <=8'h24;
			25 : dato_year <=8'h25;
			26 : dato_year <=8'h26;
			27 : dato_year <=8'h27;
			28 : dato_year <=8'h28;
			29 : dato_year <=8'h29;
			30 : dato_year <=8'h30;
			31 : dato_year <=8'h31;
			32 : dato_year <=8'h32;
			33 : dato_year <=8'h33;
 			34 : dato_year <=8'h34;
			35 : dato_year <=8'h35;
			36 : dato_year <=8'h36;
			37 : dato_year <=8'h37;
			38 : dato_year <=8'h38;
			39 : dato_year <=8'h39;
			40 : dato_year <=8'h40;
			41 : dato_year <=8'h41;
			42 : dato_year <=8'h42;
			43 : dato_year <=8'h43;
 			44 : dato_year <=8'h44;
			45 : dato_year <=8'h45;
			46 : dato_year <=8'h46;
			47 : dato_year <=8'h47;
			48 : dato_year <=8'h48;
			49 : dato_year <=8'h49;
			50 : dato_year <=8'h50;
			51 : dato_year <=8'h51;
			52 : dato_year <=8'h52;
			53 : dato_year <=8'h53;
 			54 : dato_year <=8'h54;
			55 : dato_year <=8'h55;
			56 : dato_year <=8'h56;
			57 : dato_year <=8'h57;
			58 : dato_year <=8'h58;
			59 : dato_year <=8'h59;
			60 : dato_year <=8'h60;
 			61 : dato_year <=8'h61;
			62 : dato_year <=8'h62;
			63 : dato_year <=8'h63;
			64 : dato_year <=8'h64;
			65 : dato_year <=8'h65;
			66 : dato_year <=8'h66;
			67 : dato_year <=8'h67;
			68 : dato_year <=8'h68;
			69 : dato_year <=8'h69;
			70 : dato_year <=8'h70;
			71 : dato_year <=8'h71;
			72 : dato_year <=8'h72;
			73 : dato_year <=8'h73;
 			74 : dato_year <=8'h74;
			75 : dato_year <=8'h75;
			76 : dato_year <=8'h76;
			77 : dato_year <=8'h77;
			78 : dato_year <=8'h78;
			79 : dato_year <=8'h79;
			80 : dato_year <=8'h80;
			81 : dato_year <=8'h81;
			82 : dato_year <=8'h82;
			83 : dato_year <=8'h83;
 			84 : dato_year <=8'h84;
			85 : dato_year <=8'h85;
			86 : dato_year <=8'h86;
			87 : dato_year <=8'h87;
			88 : dato_year <=8'h88;
			89 : dato_year <=8'h89;
			90 : dato_year <=8'h90;
			91 : dato_year <=8'h91;
			92 : dato_year <=8'h92;
			93 : dato_year <=8'h93;
 			94 : dato_year <=8'h94;
			95 : dato_year <=8'h95;
			96 : dato_year <=8'h96;
			97 : dato_year <=8'h97;
			98 : dato_year <=8'h98;
			99 : dato_year <=8'h99;
			default: dato_year <=8'h00;
		endcase
endmodule
