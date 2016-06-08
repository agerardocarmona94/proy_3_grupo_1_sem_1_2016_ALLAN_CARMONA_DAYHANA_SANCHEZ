`timescale 1ns / 1ps
//-------------------------------------------------------------------------------------
/*
 En este modulo se encunetran almacenadas todas las direcciones que se van a ocupar para el RTC,
 ademas se tienen ciertas entradas como los registros para escribir y señales de control.

*/
//-------------------------------------------------------------------------------------
module Multiplexor_Decodificador(
input wire [7:0]seleccion,
input wire [7:0]tipo_escritura,
input wire [7:0]Guardar,
input wire [7:0]RG1,
input wire [7:0]RG2,
input wire [7:0]RG3,
input wire [3:0] crono_reset,
input wire listo,
input wire listo_lee,
input wire listo_escribe,
output reg [7:0]salida_mux_deco
    );

   always @(seleccion, listo, listo_lee,listo_escribe,RG1,RG2,RG3,tipo_escritura,Guardar,crono_reset)
      case (seleccion)
         8'b00000000: salida_mux_deco = 8'h00;     //dato 0
         8'b00000001: salida_mux_deco = {7'b0000000,listo}; //listo de la maquina de estados
         8'b00000010: salida_mux_deco = {7'b0000000,listo_escribe};//listo de la maquina de estados
         8'b00000011: salida_mux_deco = {7'b0000000,listo_lee};//listo de la maquina de estados
         8'b00000100: salida_mux_deco = 8'h02;  
         8'b00000101: salida_mux_deco = 8'h10;
         8'b00000110: salida_mux_deco = 8'h00;
         8'b00000111: salida_mux_deco = 8'hd2;
			8'b00001000: salida_mux_deco = 8'h01;       //direcciones que se ocupan en el RTC
         8'b00001001: salida_mux_deco = 8'hf1;
         8'b00001010: salida_mux_deco = 8'h21;
			8'b00001011: salida_mux_deco = 8'h22;
         8'b00001100: salida_mux_deco = 8'h23;
         8'b00001101: salida_mux_deco = 8'h24;
         8'b00001110: salida_mux_deco = 8'h25;
			8'b00001111: salida_mux_deco = 8'h26;
         8'b00010000: salida_mux_deco = 8'h41;
         8'b00010001: salida_mux_deco = 8'h42;
			8'b00010010: salida_mux_deco = 8'h43;
		   8'b00010011: salida_mux_deco = 8'h03;
			8'b00010100: salida_mux_deco = 8'h04;
         8'b00010101: salida_mux_deco = 8'h05;
         8'b00010110: salida_mux_deco = 8'h06;
         8'b00010111: salida_mux_deco = 8'h07;
			8'b00011000: salida_mux_deco = 8'h08;
         8'b00011001: salida_mux_deco = tipo_escritura; //tipo de escritura como lo es reloj,fecha o cornometro
         8'b00011010: salida_mux_deco = RG1; //Registro de escritura 1
			8'b00011011: salida_mux_deco = RG2; //Registro de escritura 1
			8'b00011100: salida_mux_deco = RG3; //Registro de escritura 1
			8'b00011101: salida_mux_deco = Guardar; //señal de guardar del teclado
         8'b00011110: salida_mux_deco =  {4'b0000,crono_reset}; //señal para resetear el cronometro
         8'b00011111: salida_mux_deco = 8'hf0;//direcion rtc
         8'b00100000: salida_mux_deco = 8'hf2;//direccion rtc
			
			
			default: salida_mux_deco = 8'h00;
      endcase
		
	
endmodule
