`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:16:18 05/22/2016 
// Design Name: 
// Module Name:    MUX_DECO_FF 
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
module MUX_DECO_FF( 
input wire rst,
input wire clk,
input wire listo,
input wire listo_lee,
input wire listo_escribe,
input wire [7:0]seleccion,
output [7:0]salida_picoblaze

    );
	 
wire [7:0]salida_mux_deco;

MUX_DECO MUX_DECO (
    .seleccion(seleccion), 
    .listo(listo), 
    .listo_lee(listo_lee), 
    .listo_escribe(listo_escribe), 
    .salida_mux_deco(salida_mux_deco)
    );
	 
FFD FFD (
    .rst(rst), 
    .clk(clk), 
    .dato_mux(salida_mux_deco), 
    .salida_picoblaze(salida_picoblaze)
    );

endmodule
