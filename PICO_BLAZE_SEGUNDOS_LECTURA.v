`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:24:29 05/24/2016 
// Design Name: 
// Module Name:    PICO_BLAZE_SEGUNDOS_LECTURA 
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
module PICO_BLAZE_SEGUNDOS_LECTURA(
    input clk,
	 input reset,
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
	 
	wire listo; 
	wire listo_lee;
	wire listo_escribe;
	wire [7:0]port_id;
	wire [7:0]in_port;
	wire write_strobe;
	wire [7:0]out_port;
	wire pulso_Listo;
	wire contro_listo;
	wire contro_lee;
	wire contro_escribe;
	wire [7:0]Dir;
	wire [7:0]Dato;
	wire Dato_Dir;
	wire [7:0]salida_bus;
	wire HI;
	wire interrupt;
	wire sleep;
	wire [3:0]c_5;
	wire [2:0] Estado_m;
	wire en_out;
	wire am_pm;
	wire PB_in;
	wire [3:0] d_seg,u_seg;
    wire [3:0]d0,d1,d2,d3,d4,d5,d6,d7,d8,d9,d12,d13,d14,d15,d16,d17;
	 wire [7:0] dato_seg;
	
	assign PB_in =0;
	assign listo_lee = 0;
	assign listo_escribe = 0;
	assign interrupt =0;
	assign sleep =0;
	assign Estado_m =0;
   assign d_seg[3:0] = dato_seg [7:4];
    assign u_seg[3:0] = dato_seg [3:0];
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



PICOBLAZE PICOBLAZE (
    .interrupt(interrupt), 
    .sleep(sleep), 
    .clk(clk), 
    .in_port(in_port), 
    .rst(reset), 
    .write_strobe(write_strobe), 
    .k_write_strobe(k_write_strobe), 
    .read_strobe(read_strobe), 
    .out_port(out_port), 
    .port_id(port_id), 
    .interrupt_ack(interrupt_ack)
    );
	 
MUX_DECO_FF MUX_DECO_FF (
    .rst(reset), 
    .clk(clk), 
    .listo(listo), 
    .listo_lee(listo_lee), 
    .listo_escribe(listo_escribe), 
    .seleccion(port_id), 
    .salida_picoblaze(in_port)
    );
	 
Buffer_Triestado_Salida Buffer_Triestado_Salida (
    .Deco_out(salida_bus), 
    .en(~HI), 
    .RTC_in(RTC_in)
    );

DECO_REGISTROS_SALIDA DECO_REGISTROS_SALIDA  (
    .port_id(port_id), 
    .clk(clk), 
    .rst(reset), 
    .W_Strobe(write_strobe), 
    .listo(pulso_Listo), 
    .port_out(out_port), 
    .direccion(Dir), 
    .dato(Dato), 
    .arranque_inicio(contro_listo), 
    .arranque_leer(contro_lee), 
    .arranque_escribir(contro_escribe)
    );
/*DECO_REGISTROS_SALIDA DECO_REGISTROS_SALIDA (
    .port_id(port_id), 
    .clk(clk), 
    .rst(rst), 
    .W_Strobe(write_strobe), 
    .listo(pulso_Listo), 
    .port_out(out_port), 
    .direccion(Dir), 
    .dato(Dato), 
    .arranque_inicio(contro_listo), 
    .arranque_leer(contro_lee), 
    .arranque_escribir(contro_escribe))
    );
	 */

MUX_SALIDA MUX_SALIDA (
    .direccion(Dir), 
    .dato(Dato), 
    .seleccion(Dato_Dir), 
    .salida_bus(salida_bus)
    );

pong_top pong_top (
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
	 

	 
Contador_Control_de_Tiempos Contador_Control_de_Tiempos (
    .reset(reset), 
    .clk(clk), 
    .PB_in(PB_in), 
    .enable_inicio(contro_listo), 
    .enable_escribir(contro_escribe), 
    .enable_leer(contro_lee), 
    .estado_m(Estado_m), 
    .c_5(c_5)
    );

Control_de_Tiempos Control_de_Tiempos (
    .enable_inicio(contro_listo), 
    .enable_escribir(contro_escribe), 
    .clk(clk), 
    .enable_leer(contro_lee), 
    .estado(c_5), 
    .Estado_m(Estado_m), 
    .A_D(A_D), 
    .CS(CS), 
    .RD(RD), 
    .WR(WR), 
    .HI(HI), 
    .Dato_Dir(Dato_Dir), 
    .listo(listo), 
    .en_out(en_out)
    );
	 
Pulso_Listo Pulso_Listo (
    .listo(listo), 
    .clk(clk), 
    .Pulso_Listo(pulso_Listo)
    );
	 
seg_reg seg_reg (
	 .clk(clk), 
    .reset(reset), 
    .dseg(RTC_out), 
    .EN(en_out), 
    .dato_seg(dato_seg)
    );




endmodule
