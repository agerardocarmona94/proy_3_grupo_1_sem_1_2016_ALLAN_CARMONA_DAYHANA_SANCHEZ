`timescale 1ns / 1ps

module cont_seg(
	input clk, rst,
	input [P-1:0]posicion,
	input en_codigo, f1,f3,
	input[N-1:0] key_code,
	output reg [N-1:0] dato_seg
    );

reg [5:0] seg;
parameter N=8;
parameter P=2;
parameter maximo =6'd59;

    always @ (posedge clk)
	 begin
      if (rst)
         seg <= 0;
		else if (posicion==2'd2 && (f1==1'b1 || f3==1'b1))
		begin
			if (en_codigo)
			begin
				if (key_code==8'h75) //tecla 8 (subir)
				begin
					if (seg == maximo)
						seg <= 0;
					else 
						seg <= seg + 1'd1;
				end
				else if (key_code==8'h72) //tecla 2 (bajar)
				begin
					if (seg == 0)
						seg <= maximo;
					else 
						seg <= seg - 1'd1;
				end
				else 
					seg <= seg;
			end 
			else 
				seg <= seg;
		end
		else 
				seg <= seg;
	end
	
	
	always @ (seg)
		case (seg)
		   0 : dato_seg <=8'h00;
 			1 : dato_seg <=8'h01;
			2 : dato_seg <=8'h02;
			3 : dato_seg <=8'h03;
			4 : dato_seg <=8'h04;
			5 : dato_seg <=8'h05;
			6 : dato_seg <=8'h06;
			7 : dato_seg <=8'h07;
			8 : dato_seg <=8'h08;
			9 : dato_seg <=8'h09;
			10 : dato_seg <=8'h10;
			11 : dato_seg <=8'h11;
			12 : dato_seg <=8'h12;
			13 : dato_seg <=8'h13;
 			14 : dato_seg <=8'h14;
			15 : dato_seg <=8'h15;
			16 : dato_seg <=8'h16;
			17 : dato_seg <=8'h17;
			18 : dato_seg <=8'h18;
			19 : dato_seg <=8'h19;
			20 : dato_seg <=8'h20;
			21 : dato_seg <=8'h21;
			22 : dato_seg <=8'h22;
			23 : dato_seg <=8'h23;
 			24 : dato_seg <=8'h24;
			25 : dato_seg <=8'h25;
			26 : dato_seg <=8'h26;
			27 : dato_seg <=8'h27;
			28 : dato_seg <=8'h28;
			29 : dato_seg <=8'h29;
			30 : dato_seg <=8'h30;
			31 : dato_seg <=8'h31;
			32 : dato_seg <=8'h32;
			33 : dato_seg <=8'h33;
 			34 : dato_seg <=8'h34;
			35 : dato_seg <=8'h35;
			36 : dato_seg <=8'h36;
			37 : dato_seg <=8'h37;
			38 : dato_seg <=8'h38;
			39 : dato_seg <=8'h39;
			40 : dato_seg <=8'h40;
			41 : dato_seg <=8'h41;
			42 : dato_seg <=8'h42;
			43 : dato_seg <=8'h43;
 			44 : dato_seg <=8'h44;
			45 : dato_seg <=8'h45;
			46 : dato_seg <=8'h46;
			47 : dato_seg <=8'h47;
			48 : dato_seg <=8'h48;
			49 : dato_seg <=8'h49;
			50 : dato_seg <=8'h50;
			51 : dato_seg <=8'h51;
			52 : dato_seg <=8'h52;
			53 : dato_seg <=8'h53;
 			54 : dato_seg <=8'h54;
			55 : dato_seg <=8'h55;
			56 : dato_seg <=8'h56;
			57 : dato_seg <=8'h57;
			58 : dato_seg <=8'h58;
			59 : dato_seg <=8'h59;
			default: dato_seg <=8'h00;
		endcase
endmodule
