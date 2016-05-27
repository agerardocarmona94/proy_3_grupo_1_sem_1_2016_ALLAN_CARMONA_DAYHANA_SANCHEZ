`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:51:42 05/26/2016
// Design Name:   Registro_arranque_inicio
// Module Name:   C:/Users/lenovo/Documents/GitHub/proy_3_grupo_1_sem_1_2016_ALLAN_CARMONA_DAYHANA_SANCHEZ/TB_arranque_registro.v
// Project Name:  Proyecto_final_RTC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Registro_arranque_inicio
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TB_arranque_registro;

	// Inputs
	reg clk;
	reg rst;
	reg EN;
	reg listo;
	reg W_Strobe;
	reg [7:0] port_out;

	// Outputs
	wire dato_salida;

	// Instantiate the Unit Under Test (UUT)
	Registro_arranque_inicio uut (
		.clk(clk), 
		.rst(rst), 
		.EN(EN),
		.listo(listo),
		.W_Strobe(W_Strobe), 
		.port_out(port_out), 
		.dato_salida(dato_salida)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		EN = 0;
		W_Strobe = 0;
		port_out = 0;
		listo=0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	initial forever begin
	   #2clk = ~clk;
	end
	
	initial 
	begin
	  rst = 1;
	  #20
	  rst = 0;
	  #20
	  EN=1;
	  #40
	  port_out = 0;
	  #40
	  W_Strobe = 1;
	  #60
	  W_Strobe = 0;
	  #60
	  port_out = 1;
	  #40
	  W_Strobe = 1;
	  #60
	  W_Strobe = 0;
	  #60;
	  listo=1;
	  #100;
	  listo=0;
	  #100;
	  W_Strobe = 1;
	  #60
	  W_Strobe = 0;
	  #600;



				

		
	  $stop;
      end
endmodule

