`timescale 1ns / 1ps
// en este modulo se activa el triestado a la salida de la FPGA para no enviar datos al RTC y se puedan leer datos del mismo

module triestado_salida(
    input [7:0] Deco_out,     // entrada del tri estado
    input en,
    output [7:0] RTC_in   //Salida del triestado
    );
	 
	 assign RTC_in = en ? Deco_out : 8'bz; //Operacion del Triestado, si tiene el enable activo pone el dato, sino alta impedancia
		 
endmodule
