//Listing 9.5

`timescale 1ns / 1ps

module Keyboard 
   (
    input wire clk, reset,
    input wire ps2d, ps2c,
	 input I_ack,
	 output [N-1:0] key_code,
	 output wire got_code_tick,
	 output reg f1,f2,f3, listo_conf
   );
	
   parameter N=8;
   


   // Escaneo teclado
	kb_code kb_code (
    .clk(clk), 
    .reset(reset), 
    .ps2d(ps2d), 
    .ps2c(ps2c), 
    .key_code(key_code), 
    .got_code_tick(got_code_tick)
    );
	
	always @ (posedge clk)
	begin
	if (I_ack)
		listo_conf<=0;
	else
		begin
		 if (key_code== 8'h05)
			 begin f1<=1; f2<=0; f3<=0; listo_conf<=0; end
		 else if (key_code== 8'h06)
			 begin f2<=1; f1<=0; f3<=0; listo_conf<=0; end
		 else if (key_code== 8'h04)
			 begin f3<=1; f1<=0; f2<=0; listo_conf<=0; end
		 else if (key_code== 8'h79)
			begin f1<=0; f2<=0; f3<=0; listo_conf<=1; end // + 
		 end
	end

	
endmodule 
