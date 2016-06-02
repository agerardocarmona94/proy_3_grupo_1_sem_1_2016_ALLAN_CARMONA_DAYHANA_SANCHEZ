`timescale 1ns / 1ps
//listo
module Control(
	input clk, rst,
	input   I_ack, ps2d, ps2c,
	//output wire [7:0] dato_hora, dato_min, dato_seg, dato_dia, dato_mes, dato_year, //Dato para mostrar en VGA
	//output  [7:0] dato_1, dato_2, dato_3, //Datos hacia el Mux (PicoBlaze)
	//output  en_hora, en_min, en_seg,
	//output  en_dia, en_mes, en_year, //Señales de enable para los registros del VGA
	//output  en_cr_hora, en_cr_min, en_cr_seg,
	//output  listo_conf, // señal utilizada para indicar la interrupción
	output wire [6:0] catodo, //Salida display
    output  [7:0] anodo
    );
	 
//parameter N = 7;
/*output */wire [7:0] dato_1, dato_2, dato_3;  
/*output */wire [7:0] dato_hora, dato_min, dato_seg, dato_dia, dato_mes, dato_year, dato_display;
wire [1:0] posicion;
wire [7:0]key_code;
/*output */wire f1, f2, f3;
wire got_code_tick;

//-------------------------------------------------------------------------------------
// Código para la interpretación del Teclado
Keyboard Keyboard (
    .clk(clk), 
    .reset(rst), 
    .ps2d(ps2d), 
    .ps2c(ps2c), 
    .I_ack(I_ack), 
    .key_code(key_code), 
	 .got_code_tick(got_code_tick),
    .f1(f1), 
    .f2(f2), 
    .f3(f3), 
    .listo_conf(listo_conf)
    );
//-------------------------------------------------------------------------------------	

Contador_Posicion Contador_Posicion (
    .clk(clk),
	 .rst(rst), 
    .key_code(key_code), 
	 .got_code_tick(got_code_tick),  
    .posicion(posicion)
    );
	 
//---- Contadores
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
	 
Deco_dato_display Deco_dato_display (
    .f1(f1), 
    .f2(f2), 
    .f3(f3), 
    .dato_hora(dato_hora), 
    .dato_min(dato_min), 
    .dato_seg(dato_seg), 
    .dato_dia(dato_dia), 
    .dato_mes(dato_mes), 
    .dato_year(dato_year), 
    .posicion(posicion), 
    .dato_display(dato_display)
    );	 

Control_Displays Control_Displays (
    .clk(clk), 
    .rst(rst), 
    .Deco_cont(dato_display), 
    .catodo(catodo), 
    .anodo(anodo)
    );
	  
endmodule 