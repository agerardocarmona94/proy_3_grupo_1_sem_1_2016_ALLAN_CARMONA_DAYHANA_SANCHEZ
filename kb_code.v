//Listing 9.3
// C�digo utilizado para detectar el momento en el que el paquete de datos recibido del teclado es F0, para estar
//seguros que el siguiente c�digo corresponde al de la tecla
`timescale 1ns / 1ps

module kb_code
 //  #(parameter W_SIZE = 2)  // 2^W_SIZE words in FIFO
   (
    input wire clk, reset,
    input wire ps2d, ps2c, 
    output wire [7:0] key_code,
	 output reg got_code_tick
   );

   // constant declaration
   localparam BRK = 8'hf0; // break code

   // symbolic state declaration
   localparam
      wait_brk = 1'b0,
      get_code = 1'b1;

   // signal declaration
   reg state_reg, state_next;
   wire [7:0] scan_out;
   
   assign key_code=scan_out;

   // body
   //====================================================
   // instantiation
   //====================================================
   // instantiate ps2 receiver
   ps2_rx ps2_rx_unit
      (.clk(clk), 
		 .reset(reset), 
		 .rx_en(1'b1),
       .ps2d(ps2d), 
		 .ps2c(ps2c),
       .rx_done_tick(scan_done_tick), 
		 .dout(scan_out));

   //=======================================================
   // FSM to get the scan code after F0 received
   //=======================================================
   // state registers
// la maquina de estados detecta cuando el c�digo es F0, e inmediatamente se va a captura el dato de la tecla
   always @(posedge clk, posedge reset)
      if (reset)
         state_reg <= wait_brk;
      else
         state_reg <= state_next;

   // next-state logic
   always @*
   begin
      got_code_tick = 1'b0;
      state_next = state_reg;
		
      case (state_reg)
         wait_brk:  // wait for F0 of break code
            if (scan_done_tick==1'b1 && scan_out==BRK) // Realiza la comparaci�n
				begin
					state_next = get_code;
					got_code_tick =1'b0;
				end
				
			get_code:  // get the following scan code
            if (scan_done_tick)
				begin
					got_code_tick =1'b1; // se�al que indica cuando el c�digo es el de la tecla
					state_next = wait_brk;
				end
			default :
				begin
					got_code_tick =got_code_tick;
					state_next = state_next;
				end
      endcase
   end

endmodule 
