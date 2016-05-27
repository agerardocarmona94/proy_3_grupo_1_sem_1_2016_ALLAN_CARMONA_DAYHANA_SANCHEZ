`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:25:26 05/26/2016 
// Design Name: 
// Module Name:    DECO_REGISTROS_SALIDA 
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
module DECO_REGISTROS_SALIDA(
input wire [7:0] port_id,
input wire clk,rst,W_Strobe,
input wire listo,
input wire [7:0] port_out,
output [7:0]direccion,dato,
output arranque_inicio,arranque_leer,arranque_escribir
    );
wire [7:0]enable;
wire EN1,EN2,EN3,EN4,EN5;

assign EN1 = enable[1];
assign EN2 = enable[2];
assign EN3 = enable[3];
assign EN4 = enable[4];
assign EN5 = enable[5];

assign enable[0] =0;
assign enable[6] =0;
assign enable[7] =0;



decodificador_salida decodificador_salida (
    .port_id(port_id), 
    .clk(clk), 
    .rst(rst), 
    .enable(enable)
    );
Registro_dato Registro_dato (
    .clk(clk), 
    .rst(rst), 
    .EN(EN2), 
    .W_Strobe(W_Strobe), 
    .port_out(port_out), 
    .dato_salida(dato)
    );
Registro_direccion Registro_direccion (
    .clk(clk), 
    .rst(rst), 
    .EN(EN1), 
    .W_Strobe(W_Strobe), 
    .port_out(port_out), 
    .dato_salida(direccion)
    );
Registro_arranque_inicio Registro_arranque_inicio (
    .clk(clk), 
    .rst(rst), 
    .listo(listo), 
    .EN(EN3), 
    .W_Strobe(W_Strobe), 
    .port_out(port_out), 
    .dato_salida(arranque_inicio)
    );
Registro_arranque_leer Registro_arranque_leer (
    .clk(clk), 
    .rst(rst), 
    .listo(listo), 
    .EN(EN4), 
    .W_Strobe(W_Strobe), 
    .port_out(port_out), 
    .dato_salida(arranque_leer)
    );
Registro_arranque_escribe Registro_arranque_escribe (
    .clk(clk), 
    .rst(rst), 
    .listo(listo), 
    .EN(EN5), 
    .W_Strobe(W_Strobe), 
    .port_out(port_out), 
    .dato_salida(arranque_escribir)
    );

endmodule
