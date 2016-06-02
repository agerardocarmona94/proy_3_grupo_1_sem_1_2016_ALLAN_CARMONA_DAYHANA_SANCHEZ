`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:33:12 05/15/2016 
// Design Name: 
// Module Name:    Senales_de_Control 
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
module Control_RTC(
    input clk,
	 input PB_in,
	 input enable_inicio,
	 input enable_escribir,
	 input enable_leer
	 
    );
	 
	 wire estado
	 
	 Contador_Control_de_Tiempos Contador_Control_de_Tiempos (
    .clk(clk), 
    .PB_in(PB_in), 
    .enable_inicio(enable_inicio), 
    .enable_escribir(enable_escribir), 
    .enable_leer(enable_leer), 
    .c_5(c_5)
    );
	 
	 Control_de_Tiempos Control_de_Tiempos (
    .enable_inicio(enable_inicio), 
    .enable_escribir(enable_escribir), 
    .clk(clk), 
    .enable_leer(enable_leer), 
    .estado(estado), 
    .A_D(A_D), 
    .CS(CS), 
    .RD(RD), 
    .WR(WR), 
    .HI(HI), 
    .Dato_Dir(Dato_Dir), 
    .listo(listo), 
    .en_out(en_out)
    );

	 
	 
	 


endmodule
