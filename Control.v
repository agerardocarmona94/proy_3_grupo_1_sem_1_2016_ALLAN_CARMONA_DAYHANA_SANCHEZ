`timescale 1ns / 1ps
//En este módulo se encapsulan todos los módulos relacionados con el teclado y los contadores de los parámtros
// se tiene la entrada de reset_guardar la cual desactiva la señal de guardar, la cual se pone en alto al momento de
//terminar de configurar

//Las salidas dato_1 dato_2 y dato_3, corresponden a los tres datos del parámetro que se este cambiando
// La señal Configurando se activa cuando se desea cambiar ya sea fecha, reloj o cronometro
// La señal Fs recibe un valor dependiendo del parámetro a cambiar, para indicar al picoblaze, si se cambiar fecha, reloj o cronometro
// la señal de guardar se activa cuando se han terminado de configurar todos los datos

module Control(
	input clk, rst,
	input reset_guardar, ps2d, ps2c,
	output  [N:0] dato_1, dato_2, dato_3, //Datos hacia el Mux (PicoBlaze)
	output  configurando, // señal utilizada para indicar al picoblaze
	output [N:0]Fs, guardar
    );

parameter N = 7;

wire configurando; 
wire [7:0] dato_hora, dato_min, dato_seg, dato_dia, dato_mes, dato_year;
wire [7:0] dato_display, guardar;
wire [1:0] posicion;
wire [7:0]key_code;
wire f1, f2, f3;
wire got_code_tick;
//-------------------------------------------------------------------------------------



// Código para la interpretación del Teclado

Keyboard Keyboard (
    .clk(clk), 
    .reset(rst), 
    .ps2d(ps2d), 
    .ps2c(ps2c), 
    .reset_guardar(reset_guardar), 
    .key_code(key_code), 
    .got_code_tick(got_code_tick), 
    .f1(f1), 
    .f2(f2), 
    .f3(f3), 
    .guardar(guardar), 
    .configurando(configurando), 
    .Fs(Fs)
    );
//-------------------------------------------------------------------------------------	

Contador_Posicion Contador_Posicion (
    .clk(clk),
	 .rst(rst), 
    .key_code(key_code), 
	 .got_code_tick(got_code_tick),  
    .posicion(posicion)
    );
	 
//---- Contadores para cada uno de los datos de los diferentes parámetros
cont_hora cont_hora ( 
	 .clk(clk),
    .rst(rst), 
    .posicion(posicion), 
    .en_codigo(got_code_tick), 
    .f1(f1), 
    .f3(f3), 
    .key_code(key_code), 
    .dato_hora(dato_hora)
    );

cont_min cont_min ( 
	.clk(clk),
    .rst(rst), 
    .posicion(posicion), 
    .en_codigo(got_code_tick), 
    .f1(f1), 
    .f3(f3), 
    .key_code(key_code), 
    .dato_min(dato_min)
    );

cont_seg cont_seg ( 
	.clk(clk),
    .rst(rst), 
    .posicion(posicion), 
    .en_codigo(got_code_tick), 
    .f1(f1), 
    .f3(f3), 
    .key_code(key_code), 
    .dato_seg(dato_seg)
    );

cont_dia cont_dia ( 
	.clk(clk),
    .rst(rst), 
    .posicion(posicion), 
    .en_codigo(got_code_tick), 
    .f2(f2), 
    .key_code(key_code), 
    .dato_dia(dato_dia)
    );

cont_mes cont_mes ( 
	.clk(clk),
    .rst(rst), 
    .posicion(posicion), 
    .en_codigo(got_code_tick), 
    .f2(f2), 
    .key_code(key_code), 
    .dato_mes(dato_mes)
    );	 

cont_year cont_year ( 
	.clk(clk),
    .rst(rst), 
    .posicion(posicion), 
    .en_codigo(got_code_tick), 
    .f2(f2), 
    .key_code(key_code), 
    .dato_year(dato_year)
    );

Deco_salida Deco_salida (
    .f1(f1), 
    .f2(f2), 
    .f3(f3), 
    .dato_hora(dato_hora), 
    .dato_min(dato_min), 
    .dato_seg(dato_seg), 
    .dato_dia(dato_dia), 
    .dato_mes(dato_mes), 
    .dato_year(dato_year), 
    .dato_1(dato_1), 
    .dato_2(dato_2), 
    .dato_3(dato_3)
    );
	 

	  
endmodule 