//Listing 9.5
// Este módulo se encarga de interpretar el codigo de la tecla que ha sido presionada, y así asignarle una funcion específica 
//a cada tecla que se va a utilizar.
`timescale 1ns / 1ps

module Keyboard 
   (
    input wire clk, reset,
    input wire ps2d, ps2c,
	 input reset_guardar,
	 output [N-1:0] key_code,
	 output wire got_code_tick,
	 output reg f1,f2,f3, 
	 output reg [N-1:0] guardar,
	 output reg configurando,
	 output reg [N-1:0] Fs
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

// Se utilizan las teclas F1, F2 y F3 para seleccionar configurar reloj, fecha o cronómetro, por lo que a cada
//tecla se le asigna un valor para que active cada uno de los contadores correspondientes
	
	always @ (key_code)
		begin
		if (reset_guardar)
			guardar<=0;
		else
		 if (key_code== 8'h05 && got_code_tick)
			 begin f1<=1; f2<=0; f3<=0; configurando<=1; guardar<=0; Fs<=8'hF1; end
		 else if (key_code== 8'h06 && got_code_tick)
			 begin f2<=1; f1<=0; f3<=0; configurando<=1; guardar<=0; Fs<=8'hF2; end
		 else if (key_code== 8'h04 && got_code_tick)
			 begin f3<=1; f1<=0; f2<=0; configurando<=1; guardar<=0; Fs<=8'hF3; end
		 else if (key_code== 8'h79 && got_code_tick)
			begin f1<=0; f2<=0; f3<=0; configurando<=0; guardar<=1; Fs<=8'h00; end // + 
		 else 
			begin f1<=f1; f2<=f2; f3<=f3; guardar<=guardar; configurando<=configurando; Fs<=Fs; end
		 end 
	

	
endmodule 
