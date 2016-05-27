`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:28:03 05/26/2016
// Design Name:   DECO_REGISTROS_SALIDA
// Module Name:   C:/Users/lenovo/Documents/GitHub/proy_3_grupo_1_sem_1_2016_ALLAN_CARMONA_DAYHANA_SANCHEZ/TB_DECO_REG_SALIDA.v
// Project Name:  Proyecto_final_RTC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DECO_REGISTROS_SALIDA
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TB_DECO_REG_SALIDA;

	// Inputs
	reg [7:0] port_id;
	reg clk;
	reg rst;
	reg W_Strobe;
	reg listo;
	reg [7:0] port_out;

	// Outputs
	wire [7:0] direccion;
	wire [7:0] dato;
	wire arranque_inicio;
	wire arranque_leer;
	wire arranque_escribir;

	// Instantiate the Unit Under Test (UUT)
	DECO_REGISTROS_SALIDA uut (
		.port_id(port_id), 
		.clk(clk), 
		.rst(rst), 
		.W_Strobe(W_Strobe), 
		.listo(listo), 
		.port_out(port_out), 
		.direccion(direccion), 
		.dato(dato), 
		.arranque_inicio(arranque_inicio), 
		.arranque_leer(arranque_leer), 
		.arranque_escribir(arranque_escribir)
	);

	initial begin
		// Initialize Inputs
		port_id = 0;
		clk = 0;
		rst = 0;
		W_Strobe = 0;
		listo = 0;
		port_out = 0;

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
		port_id = 8'd2;
		#4;
		port_out = 8'd12;
		#4;
		W_Strobe = 1;
		#10;
		W_Strobe = 0;
		#10
		port_id = 8'd1;
		#4;
		port_out = 8'd4;
		#4;
		W_Strobe = 1;
		#10;
		W_Strobe = 0;
		#10;
		port_id = 8'd4;
		#4;
		port_out = 8'd1;
		#4;
		W_Strobe = 1;
		#10;
		W_Strobe = 0;
		#10;
		port_id = 8'd3;
		#4;
		port_out = 8'd1;
		#4;
		W_Strobe = 1;
		#10;
		W_Strobe = 0;
		#10;
		port_id = 8'd5;
		#4;
		port_out = 8'd1;
		#4;
		W_Strobe = 1;
		#10;
		W_Strobe = 0;
		#20
		listo=1;
		#20
		listo=0;
		#20;
		rst=1;
		#1000
		
		
		

				

		
	  $stop;
	 
	end

endmodule

