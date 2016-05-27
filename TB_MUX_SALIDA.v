`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:30:17 05/25/2016
// Design Name:   MUX_SALIDA
// Module Name:   C:/Users/lenovo/Documents/GitHub/proy_3_grupo_1_sem_1_2016_ALLAN_CARMONA_DAYHANA_SANCHEZ/TB_MUX_SALIDA.v
// Project Name:  Proyecto_final_RTC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MUX_SALIDA
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TB_MUX_SALIDA;

	// Inputs
	reg [7:0] direccion;
	reg [7:0] dato;
	reg seleccion;

	// Outputs
	wire [7:0] salida_bus;

	// Instantiate the Unit Under Test (UUT)
	MUX_SALIDA uut (
		.direccion(direccion), 
		.dato(dato), 
		.seleccion(seleccion), 
		.salida_bus(salida_bus)
	);

	initial begin
		// Initialize Inputs
		direccion = 0;
		dato = 0;
		seleccion = 0;

		// Wait 100 ns for global reset to finish
		#100;
      
		dato=8'hAA;
		direccion=8'hFF;
		#10;
		seleccion = 1;
		#10;
		seleccion = 0;
		#10;
		seleccion = 1;
		#10;
		seleccion = 0;
		#10;
		dato=8'h22;
		#10;
		direccion=8'h33;
		#10;
		seleccion = 1;
		#10;
		seleccion = 0;
		#10;
		
		
		
		// Add stimulus here

	end
      
endmodule

