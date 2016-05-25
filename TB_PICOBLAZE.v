`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:57:33 05/24/2016
// Design Name:   PICOBLAZE
// Module Name:   C:/Users/lenovo/Documents/PROYECTO_FINAL_RTC/repositorio/Proyecto_final_RTC/TB_PICOBLAZE.v
// Project Name:  Proyecto_final_RTC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PICOBLAZE
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TB_PICOBLAZE;

	// Inputs
	reg interrupt;
	reg sleep;
	reg clk;
	reg [7:0] in_port;
	reg rst;

	// Outputs
	wire write_strobe;
	wire k_write_strobe;
	wire read_strobe;
	wire [7:0] out_port;
	wire [7:0] port_id;
	wire interrupt_ack;

	// Instantiate the Unit Under Test (UUT)
	PICOBLAZE uut (
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

	initial begin
		// Initialize Inputs
		interrupt = 0;
		sleep = 0;
		clk = 0;
		in_port = 0;
		rst = 0;

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
	#10;
	rst = 0;
	#100000;
	
	  $stop;
	 
	end

      
endmodule

