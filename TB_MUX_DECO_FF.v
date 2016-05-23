`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:48:04 05/22/2016
// Design Name:   MUX_DECO_FF
// Module Name:   C:/Users/lenovo/Documents/GitHub/proy_3_grupo_1_sem_1_2016_ALLAN_CARMONA_DAYHANA_SANCHEZ/TB_MUX_DECO_FF.v
// Project Name:  Proyecto_final_RTC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MUX_DECO_FF
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TB_MUX_DECO_FF;

	// Inputs
	reg rst;
	reg clk;
	reg listo;
	reg listo_lee;
	reg listo_escribe;
	reg [7:0] seleccion;

	// Outputs
	wire [7:0] salida_picoblaze;

	// Instantiate the Unit Under Test (UUT)
	MUX_DECO_FF uut (
		.rst(rst), 
		.clk(clk), 
		.listo(listo), 
		.listo_lee(listo_lee), 
		.listo_escribe(listo_escribe), 
		.seleccion(seleccion), 
		.salida_picoblaze(salida_picoblaze)
	);

	initial begin
		// Initialize Inputs
		rst = 0;
		clk = 0;
		listo = 0;
		listo_lee = 0;
		listo_escribe = 0;
		seleccion = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
	initial forever begin
	   #1clk = ~clk;
	end
	
	initial 
	begin
	  rst = 1;
	  #4
	  rst = 0;
	  #10
	  	listo = 1;
		#10
		listo_lee = 1;
		#10
		listo_escribe = 1;
		#10;
		seleccion = 1;
		#30;
		seleccion = 2;
		#30;
		seleccion = 3;
		#30;
		seleccion = 4;
		#30;
		seleccion = 5;
		#30;
		seleccion = 6;
		#30;
	   seleccion = 7;
		#30;
		seleccion = 8;
		#30;
		seleccion = 9;
		#30;
		seleccion = 1;
		#30;
		seleccion = 2;
		#30;
		seleccion = 3;
		#300;
		rst = 1;
	  #400
				

				

		
	  $stop;
	 
	end

endmodule

