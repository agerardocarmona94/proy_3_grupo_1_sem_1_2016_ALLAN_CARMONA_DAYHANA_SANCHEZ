`timescale 1ns / 1ps
//-----------------------------------------------------------------------------------
/*
 En este modulo se encuentran instanciados el picoplaze y el programa en 
 ensamblador para controlar todas las funciones del rtc

*/
//-----------------------------------------------------------------------------------


module PicoBlaze6(
input wire interrupt,
input wire sleep,					//se declaran las entradas y salidas del módulo en donde
input wire clk,					//todas las señales son provenientes del picoblaze
input [7:0]in_port,
input rst,
output write_strobe,
output [7:0]out_port,
output [7:0]port_id
   );

wire bram_enable,contro_listo,contro_lee,contro_escribe;
wire [7:0] Dir,Dato;
wire [11:0] address;
wire rdl;
wire [17:0] instruction;
wire reset;


assign reset= rdl || rst; 

kcpsm6 kcpsm6 (
    .address(address), 
    .instruction(instruction), 
    .bram_enable(bram_enable), 
    .in_port(in_port), 
    .out_port(out_port), 
    .port_id(port_id), 
    .write_strobe(write_strobe), 
    .k_write_strobe(k_write_strobe), 
    .read_strobe(read_strobe), 
    .interrupt(interrupt), 
    .interrupt_ack(interrupt_ack), 
    .sleep(sleep), 
    .reset(reset), 
    .clk(clk)
    );
 
ENSAMBLADOR ENSAMBLADOR (
    .address(address), 
    .instruction(instruction), 
    .enable(bram_enable), 
    .rdl(rdl), 
    .clk(clk)
    );

endmodule
