`timescale 1ns / 1ps
//-----------------------------------------------------------------
/*En este modulo se decodifica la activcion de los enable de cada registro que van al VGA
*/
//-------------------------------------------------------------------
module decodificador_enable(
input wire [7:0] direccion,  //la entrada corresponde a la direccion que va recorriendo el picoblaze en las secuencias de lectura y escritura
input reset,clk,
output reg [8:0]enable 
    );

   always @(posedge clk)
      if (reset)
         enable <= 9'h00;
      else
         case (direccion)
            8'b0000  : enable <= 9'b000000001;
            8'b0001  : enable <= 9'b000000010;   //como se observa hay un bit para cada enable en el decodificador
            8'b0010  : enable <= 9'b000000100;
            8'b0011  : enable <= 9'b000001000;
            8'b0100  : enable <= 9'b000010000;
            8'b0101  : enable <= 9'b000100000;
            8'b0110  : enable <= 9'b001000000;
            8'b0111  : enable <= 9'b010000000;
				8'b1000  : enable <= 9'b100000000;
            default :  enable <= 9'b000000000;
         endcase
		
endmodule
