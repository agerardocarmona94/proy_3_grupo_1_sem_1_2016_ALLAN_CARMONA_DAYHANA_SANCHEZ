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
	 input W_R,
	 input Aumentar,
	 input Disminuir,
	 input reset,
	 input conf,
	 input [7:0] RTC_out,
	 output A_D,
	 output CS,
	 output RD,
	 output WR,
	 output [2:0] rgb,
	 output hsync,
	 output vsync,
	 output [7:0] RTC_in
    );
	 
	 wire [3:0] Estado;
	 wire [5:0] Cuenta;
	 wire [1:0] posicion;
	 wire [7:0] Salida;
	 wire [7:0] Salida_D;
	 wire [7:0] Salida_M;
	 wire Dato_Dir;
	 wire listo;
	 wire en_out;
	 wire aumentar;
	 wire disminuir;
	 wire Push_out;
	 wire HI;
	 wire am_pm;
	 wire [2:0] Estado_m;
	 wire [3:0] d_seg,u_seg, cuenta;
    wire [3:0]d0,d1,d2,d3,d4,d5,d6,d7,d8,d9,d12,d13,d14,d15,d16,d17;
	 wire [7:0] dato_seg;
	 wire Pulso_Listo;
	 
	 assign d_seg[3:0] = Salida_M [7:4];
    assign u_seg[3:0] = Salida_M [3:0];
    assign d0=0;
    assign d1=0;
    assign d2=0;
    assign d3=0;
    assign d4=0;
    assign d5=0;
    assign d6=0;
    assign d7=0;
    assign d8=0;
    assign d9=0;
    assign d12=0;
    assign d13=0;
    assign d14=0;
    assign d15=0;
    assign d16=0;
    assign d17=0;
    assign am_pm=0;

	 
	 
	 Contador_Control_de_Tiempos F1(
	
    .clk(clk), 
    .PB_in(Push_out), 
    .enable_inicio(enable_inicio), 
    .enable_escribir(enable_escribir), 
    .enable_leer(enable_leer), 
	 .estado_m(Estado_m),
    .c_5(Estado),
	 .reset (reset)
    );
	 
	 Control_de_Tiempos F2 (
    .enable_inicio(enable_inicio), 
    .enable_escribir(enable_escribir), 
    .clk(clk), 
    .enable_leer(enable_leer), 
    .estado(Estado), 
    .A_D(A_D), 
	 .Estado_m (Estado_m),
    .CS(CS), 
    .RD(RD), 
    .WR(WR), 
    .HI(HI), 
    .Dato_Dir(Dato_Dir), 
    .listo(listo), 
    .en_out(en_out)
    );
	 
	 Aumento_metastabilidad F3 (
    .botton_aumentar(Aumentar), 
    .clk(clk), 
    .aumentar(aumentar)
    );
	 
	 Disminuye_metastabilidad F4 (
    .botton_disminuir(Disminuir), 
    .clk(clk), 
    .disminuir(disminuir)
    );
	 
	 Deco_Escritura F5 (
    .dato(Cuenta), 
    .clk(clk), 
    .enable_escritura(enable_escribir), 
    .enable_leer(enable_leer), 
    .enable_inicio(enable_inicio), 
    .A_D(Dato_Dir), 
    .posicion(posicion), 
    .Salida(Salida),
	 .Estado(Estado_m)
    );
	 
	 Contador_Dato F6 (
    .rst(reset), 
    .Subir(aumentar), 
    .Bajar(disminuir), 
    .clk(clk), 
    .W_R(W_R), 
    .cuenta(Cuenta)
    );
	 
	 FSM_p F7 (
    .clk(clk), 
    .reset(reset), 
    .listo(Pulso_Listo), 
    .sw(W_R), 
    .posicion(posicion), 
    .enable_inicio(enable_inicio), 
    .enable_escribir(enable_escribir), 
    .enable_leer(enable_leer),
	 .Estado(Estado_m)
    );

	 botonconfig F8 (
    .listo_rst(Pulso_Listo), 
    .button(conf), 
    .clk(clk), 
    .Push_out(Push_out)
    );
	 
	 Buffer_Triestado_Salida F9 (
    .Deco_out(Salida), 
    .en(~HI), 
    .RTC_in(RTC_in)
    );
	 
	 pong_top F10 (
    .clkd(clk), 
    .reset(reset), 
    .d0(d0), 
    .d1(d1), 
    .d2(d2), 
    .d3(d3), 
    .d4(d4), 
    .d5(d5), 
    .d6(d6), 
    .d7(d7), 
    .d8(d8), 
    .d9(d9), 
    .d10(d_seg), 
    .d11(u_seg), 
    .d12(d12), 
    .d13(d13), 
    .d14(d14), 
    .d15(d15), 
    .d16(d16), 
    .d17(d17), 
    .hsync(hsync), 
    .vsync(vsync), 
    .rgb(rgb), 
    .am_pm(am_pm)
    );
	 
	 seg_reg F11 (
    .clk(clk), 
    .reset(reset), 
    .dseg(RTC_out), 
    .EN(en_out), 
    .dato_seg(dato_seg)
    );
	 
	Pulso_Listo F12 (
    .listo(listo), 
    .clk(clk), 
    .Pulso_Listo(Pulso_Listo)
    );
	 
	 Deco_Contador F13 (
    .cuenta(Cuenta), 
    .clk(clk), 
    .Salida(Salida_D)
    );
	 
	 MUX_WR_RD F14 (
    .Deco_Escritura(Salida_D), 
    .RTC_out(dato_seg), 
    .W_R(W_R), 
    .clk(clk), 
    .Salida(Salida_M)
    );




	 
	 
	 


endmodule
