`timescale 1ns / 1ps

module Control_Displays(
    input clk, rst,
	 input [N-1:0] Deco_cont, 
    output wire [C-1:0] catodo,
    output  [N-1:0] anodo
    );
parameter N=8;
parameter C=7;
	 
wire q;
wire [3:0] y;
wire [3:0] D1;
wire [3:0] D2;

wire [1:0] an;
assign anodo[0]=an[0];
assign anodo[1]=an[1];
assign anodo[2]=1; 
assign anodo[3]=1; 
assign anodo[4]=1; 
assign anodo[5]=1; 
assign anodo[6]=1; 
assign anodo[7]=1;
//

/*assign D4= dato[15:12];
assign D3= dato[11:8];*/
assign D1= Deco_cont[3:0];
assign D2= Deco_cont[7:4];
	 
//-----------------------------------------
Divisor_Displays Divisor_Displays (
    .clk(clk), 
    .rst(rst), 
    .q(q)
    );

//-----------------------------------------
Contador_Displays Contador_Displays (
    .ck(q), 
    .rst(rst), 
    .an(an)
    );
	 
//-----------------------------------------
Mux_Displays Mux_Displays (
    .select(an), 
    .dato_D1(D1), 
    .dato_D2(D2), 
    .y(y)
    );
	 
//-----------------------------------------
Decodificador_Displays Decodificador_Displays (
    .bcd(y),
    .segmento(catodo)
    );
	 
endmodule

