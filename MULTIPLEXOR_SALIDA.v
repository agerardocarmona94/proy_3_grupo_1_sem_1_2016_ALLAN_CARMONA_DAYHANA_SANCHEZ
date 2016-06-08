`timescale 1ns / 1ps
// en este modulo se define si sale un dato o una direccion al bus de datos esterno
module multiplexor_de_salida (

input [7:0] direccion,
input [7:0] dato,
input seleccion,
output [7:0] salida_bus

    );

   assign salida_bus = seleccion ? dato : direccion; //condicion de salida para el mux

endmodule
