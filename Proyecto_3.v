`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:11:42 05/27/2016 
// Design Name: 
// Module Name:    TOP 
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
module Proyecto_3
    (
	 input clk,
	 input reset,ps2d,ps2c,rst_alarma,
	 input [7:0] RTC_out,
	 output [7:0] RTC_in,
	 output A_D,CS,RD,WR, hsync, vsync,sonido,
	 output [7:0] COLOUR_OUT
	 );
	 
	
	 wire write_strobe, interrupt, sleep, PB_in, Pulso_Listo,listo,contro_listo,contro_lee,contro_escribe;
	 wire Dato_Dir,HI;
	 wire [7:0] Dato;
	 wire [7:0] Dir;
	 wire [7:0] salida_bus;
	 wire [2:0]estado_m;
    wire [3:0]c_5;
	 wire [7:0] port_id;
	 wire [7:0]in_port;
	 wire [7:0]out_port,RG1, RG2, RG3;
	 wire [3:0] d_seg,u_seg;
	 wire [3:0] d_min,u_min;
	 wire [3:0] d_hor,u_hor;
	 wire [3:0] d_dia,u_dia;
	 wire [3:0] d_mes,u_mes;
	 wire [3:0] d_year,u_year;
	 wire [3:0] d_seg_crono,u_seg_crono;
	 wire [3:0] d_hor_crono,u_hor_crono;
    wire [3:0]d0,d1,d2,d3,d4,d5,d6,d7,d8,d9,d12,d13,d14,d15,d16,d17;
	 wire [7:0] dato_seg;
	 wire [7:0] dato_min;
	 wire [7:0] dato_hor;
	 wire [7:0] dato_dia;
	 wire [7:0] dato_mes;
	 wire [7:0] dato_year;
	 wire [7:0] dato_seg_crono;
	 wire [7:0] dato_min_cr;
	 wire [7:0] dato_hor_crono;
	 wire [3:0] d_min_cr,u_min_cr;
	 wire en_out;
	 wire [3:0] direccion;
	 wire am_pm;
	 wire [8:0]enable;
	 wire EN_deco_1,EN_deco_2,EN_deco_3,EN_deco_4,EN_deco_5,EN_deco_6,EN_deco_7,EN_deco_8,EN_deco_9;
	 wire [7:0]tipo_escritura;
	 wire [7:0]Guardar;
	 wire [7:0]crono_reset;
	 wire [3:0]alarma;
	 wire [7:0]DATO1,DATO2,DATO3;
	 wire sonido;

	
	 assign d_seg[3:0] = dato_seg [7:4];
    assign u_seg[3:0] = dato_seg [3:0];
	 assign d_min[3:0] = dato_min [7:4];
    assign u_min[3:0] = dato_min [3:0];
	 assign d_hor[3:0] = dato_hor [7:4];
    assign u_hor[3:0] = dato_hor [3:0];
	 assign d_dia[3:0] = dato_dia [7:4];
    assign u_dia[3:0] = dato_dia [3:0];
	 assign d_mes[3:0] = dato_mes [7:4];
    assign u_mes[3:0] = dato_mes [3:0];
	 assign d_year[3:0] = dato_year [7:4];
    assign u_year[3:0] = dato_year [3:0];
	 assign d_seg_crono[3:0] = dato_seg_crono [7:4];
    assign u_seg_crono[3:0] = dato_seg_crono [3:0];
	 assign d_min_cr[3:0] = dato_min_cr [7:4];
    assign u_min_cr[3:0] = dato_min_cr [3:0];
	 assign d_hor_crono[3:0] = dato_hor_crono [7:4];
    assign u_hor_crono[3:0] = dato_hor_crono [3:0];
    assign am_pm=0;
	 assign interrupt=0;
	 assign sleep=0;
	 assign EN_deco_1= enable [0];
	 assign EN_deco_2= enable [1];
	 assign EN_deco_3= enable [2];
	 assign EN_deco_4= enable [3];
	 assign EN_deco_5= enable [4];
	 assign EN_deco_6= enable [5];
	 assign EN_deco_7= enable [6];
	 assign EN_deco_8= enable [7];
	 assign EN_deco_9= enable [8];
	 assign crono_reset=0;
	 assign sonido=alarma;
	 
    
	 
	 
	 //__________________________________________________________________
	 PicoBlaze6 PicoBlaze6(
    .interrupt(interrupt),// 
    .sleep(sleep), //
    .clk(clk), 
    .in_port(in_port), 
    .rst(reset), 
    .write_strobe(write_strobe),  //
    .out_port(out_port), 
    .port_id(port_id) 
    );
	 
    Puertos_de_entrada Puertos_de_entrada (
    .rst(reset), 
    .clk(clk), 
    .listo(listo), 
    .listo_lee(listo), 
    .listo_escribe(listo), 
    .seleccion(port_id), 
    .salida_picoblaze(in_port),
	 .tipo_escritura(tipo_escritura),
	 .RG1(RG1),
	 .RG2(RG2),
	 .RG3(RG3),
	 .Guardar(Guardar),
	 .crono_reset(alarma)
    );
	 
	Puertos_de_salida Puertos_de_salida  (
    .Write_Strobe(write_strobe), 
    .Out_Port(out_port), 
    .Port_ID(port_id), 
	 .bandera(estado_m),
    .RESET_MAQUINA(reset), 
	 .secuencia_direccion(direccion),
    .reset(reset), 
    .clk(clk), 
    .REGISTRO_DIRECCION(Dir), 
    .REGISTRO_DATO(Dato), 
    .arranque_inicio(contro_listo), 
    .arranque_lee(contro_lee), 
    .arranque_escribe(contro_escribe)
    );
	 
	 //---------------------------------------------------------------------------------------------------------------
	 assign PB_in=1;
	// assign estado_m=0;
	 
	 Contador_Control_de_Tiempos Contador_Control_de_Tiempos (
    .reset(reset), 
    .clk(clk), 
    .PB_in(PB_in), 
    .enable_inicio(contro_listo), 
    .enable_escribir(contro_escribe), 
    .enable_leer(contro_lee), 
    .estado_m(estado_m), 
    .c_5(c_5)
    );
	 
	 Control_de_Tiempos Control_de_Tiempos (
    .enable_inicio(contro_listo), 
    .enable_escribir(contro_escribe), 
    .clk(clk), 
    .enable_leer(contro_lee), 
    .estado(c_5), //
    .Estado_m(estado_m), //
    .A_D(A_D), 
    .CS(CS), 
    .RD(RD), 
    .WR(WR), 
    .HI(HI), 
    .Dato_Dir(Dato_Dir), 
    .listo(listo), 
    .en_out(en_out)
    );
	 
	 
	 triestado_salida triestado_salida (
    .Deco_out(salida_bus), 
    .en(~HI), 
    .RTC_in(RTC_in)
    );
	 
	 multiplexor_de_salida multiplexor_de_salida (
    .direccion(Dir), 
    .dato(Dato), 
    .seleccion(Dato_Dir), 
    .salida_bus(salida_bus)
    );
	//___________________________________________________________________________________

	
	MainActivity modulo_generacion_VGA (
    .CLK(clk), 
    .d0(d_dia), 
    .d1(u_dia), 
    .d2(d_mes), 
    .d3(u_mes), 
    .d4(d_year), 
    .d5(u_year), 
    .d6(d_hor), 
    .d7(u_hor), 
    .d8(d_min), 
    .d9(u_min), 
    .d10(d_seg), 
    .d11(u_seg), 
    .d12(d_hor_crono), 
    .d13(u_hor_crono), 
    .d14(d_min_cr), 
    .d15(u_min_cr), 
    .d16(d_seg_crono), 
    .d17(u_seg_crono),
    .d18(alarma),   
	 .COLOUR_OUT(COLOUR_OUT), 
    .HS(hsync), 
    .VS(vsync)
    );
//---------------------------------------------------------------	
wire seleccion;
wire [7:0] OUT1,OUT2,OUT3;

wire [2:0] activacion;
wire act1,act2,act3;
assign act1=activacion[0];
assign act2=activacion[1];
assign act3=activacion[2];
	
	decodificador_enable decodificador_enable (
    .direccion(direccion), 
    .reset(reset), 
    .enable(enable),
	 .clk(clk)
    );

	
	registro_segundos_VGA registro_segundos_VGA (
	 .clk(clk), 
    .reset(reset),
    .ACT(act1),
	 .seleccion(seleccion),
    .dseg(OUT1), 
    .EN(en_out),
    .EN_deco(EN_deco_1),	 
    .dato_seg(dato_seg)
    );

	registro_minutos_VGA registro_minutos_VGA (
    .clk(clk), 
    .reset(reset),
    .ACT(act1),
    .seleccion(seleccion),	 
    .dseg(OUT2), 
    .EN(en_out), 
    .EN_deco(EN_deco_2), 
    .dato_seg(dato_min)
    );
	 
	 registro_horas_VGA registro_horas_VGA (
    .clk(clk), 
    .reset(reset),
    .ACT(act1),
    .seleccion(seleccion),	 
    .dseg(OUT3), 
    .EN(en_out), 
    .EN_deco(EN_deco_3), 
    .dato_seg(dato_hor)
    );
	 
	 registro_dia_VGA registro_dia_VGA (
    .clk(clk), 
    .reset(reset),
    .ACT(act2),
    .seleccion(seleccion),	 
    .dseg(OUT3), 
    .EN(en_out), 
    .EN_deco(EN_deco_5), 
    .dato_seg(dato_dia)
    );

	registro_mes_VGA registro_mes_VGA (
    .clk(clk), 
    .reset(reset), 
	 .ACT(act2),
    .seleccion(seleccion),	 
    .dseg(OUT2), 
    .EN(en_out), 
    .EN_deco(EN_deco_5), 
    .dato_seg(dato_mes)
    );
	 
	 registro_year_VGA registro_year_VGA (
    .clk(clk), 
    .reset(reset), 
	 .ACT(act2),	
    .dseg(OUT1),
    .seleccion(seleccion),	 
    .EN(en_out), 
    .EN_deco(EN_deco_4), 
    .dato_seg(dato_year)
    );


MUX_DATOSVGA MUX_DATOSVGA (
    .seleccion(seleccion), 
    .BUS(RTC_out), 
    .RG1(RG1), 
    .RG2(RG2), 
    .RG3(RG3), 
    .OUT1(OUT1), 
    .OUT2(OUT2), 
    .OUT3(OUT3)
    );


DECO_VGA DECO_VGA (
    .Fs(tipo_escritura), 
    .clk(clk), 
    .reset(reset), 
    .activacion(activacion)
    );
	 
wire [7:0]Contador_1,Contador_2,Contador_3;
	 
Control TECLADO (
    .clk(clk), 
    .rst(rst), 
    .reset_guardar(contro_escribe), 
    .ps2d(ps2d), 
    .ps2c(ps2c), 
    .dato_1(RG1), 
    .dato_2(RG2), 
    .dato_3(RG3), 
    .configurando(seleccion), 
    .Fs(tipo_escritura), 
    .guardar(Guardar)
    );
 
 
  

	 
registro_segundos_crono_vga registro_segundos_crono_vga (
    .clk(clk), 
    .reset(reset), 
    .seleccion(seleccion), 
    .dseg(OUT1), 
    .EN(en_out), 
    .EN_deco(EN_deco_7), 
    .ACT(act3), 
    .dato_seg(dato_seg_crono)
    );
	 
	 

registro_min_CRONOMETRO registro_min_CRONOMETRO (
    .clk(clk), 
    .reset(reset), 
    .seleccion(seleccion), 
    .dseg(OUT2), 
    .EN(en_out), 
    .EN_deco(EN_deco_8), 
    .ACT(act3), 
    .dato_min(dato_min_cr)
    );

registro_horas_crono_vga registro_horas_crono_vga (
    .clk(clk), 
    .reset(reset), 
    .seleccion(seleccion), 
    .dseg(OUT3), 
    .EN(en_out), 
    .EN_deco(EN_deco_9), 
    .ACT(act3), 
    .dato_seg(dato_hor_crono)
    );
wire AAA;
deteccion_alerta deteccion_alerta (
    .dato1(DATO1), 
    .dato2(DATO2), 
    .dato3(DATO3), 
    .VGA1(dato_seg_crono), 
    .VGA2(dato_min_cr), 
    .VGA3(dato_hor_crono), 
    .clk(clk), 
    .reset(reset), 
    .alarma(alarma),
	 .AAA(AAA),
	 .rst_alarma(rst_alarma)
    );
	 
registro_almacenamiento registro_almacenamiento (
    .dato1(RG1), 
    .dato2(RG2), 
    .dato3(RG3), 
    .tecla(tecla), 
    .guardar(contro_escribe), 
    .clk(clk), 
    .reset(reset), 
    .salida1(DATO1), 
    .salida2(DATO2), 
    .salida3(DATO3),
	 .AAA(AAA)
    );



endmodule
