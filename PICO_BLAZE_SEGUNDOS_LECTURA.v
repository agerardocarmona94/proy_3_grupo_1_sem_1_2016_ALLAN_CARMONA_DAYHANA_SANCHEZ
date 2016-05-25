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
	 
	 
	wire [7:0] salida_picoblaze; 

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



PICOBLAZE PICOBLAZE (
    .interrupt(interrupt), 
    .sleep(sleep), 
    .clk(clk), 
    .in_port(in_port), 
    .rst(rst), 
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
    .seleccion(seleccion), 
    .salida_picoblaze(salida_picoblaze)
    );
	 


registros_salida registros_salida (
    .Write_Strobe(Write_Strobe), 
    .Out_Port(Out_Port), 
    .Port_ID(Port_ID), 
    .rst(rst), 
    .clk(clk), 
    .Dir(Dir), 
    .Dato(Dato), 
    .contro_listo(contro_listo), 
    .contro_lee(contro_lee), 
    .contro_escribe(contro_escribe)
    );


MUX_SALIDA MUX_SALIDA (
    .direccion(direccion), 
    .dato(dato), 
    .seleccion(seleccion), 
    .salida_bus(salida_bus)
    );


endmodule
