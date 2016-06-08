`timescale 1ns / 1ps
//--------------------------------------------------------------------------------------
/*

En este modulo se realiza la organizacion de los puertos de entrada del picoblaze mediante el uso 
de una mezcla entre un multiplexor y un decodificador dependiendo de la entrada port_id.
 
Adeamas se utiliza un registro antes del picoblaze para estabilizar el dato de entrada, esto segun la hoja de datos
*/
//--------------------------------------------------------------------------------------
module Puertos_de_entrada( 
input  rst,
input  clk,
input  listo,
input  listo_lee,
input  listo_escribe,
input  [7:0]seleccion,
input  [7:0]tipo_escritura,
input  [7:0]Guardar,
input  [7:0]RG1,
input  [7:0]RG2,
input  [7:0]RG3,
input [3:0] crono_reset,
output [7:0]salida_picoblaze

    );
	 
wire [7:0]salida_mux_deco;

// se instancia el deco mux


Multiplexor_Decodificador Multiplexor_Decodificador (
    .seleccion(seleccion), 
    .listo(listo), 
    .listo_lee(listo_lee), 
    .listo_escribe(listo_escribe), 
	 .crono_reset(crono_reset),
    .salida_mux_deco(salida_mux_deco),
	 .tipo_escritura(tipo_escritura),
	 .Guardar(Guardar),
	 .RG1(RG1),
	 .RG2(RG2),
	 .RG3(RG3)
    );
	 
// se instancia el registro
	 
FFD FFD (
    .rst(rst), 
    .clk(clk), 
    .dato_mux(salida_mux_deco), 
    .salida_picoblaze(salida_picoblaze)
    );

endmodule
