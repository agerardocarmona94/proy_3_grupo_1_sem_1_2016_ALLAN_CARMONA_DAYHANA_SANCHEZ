`timescale 1ns / 1ps

module Contador_Displays( //para activar los ánodos de los displays
    input ck,
    input rst,
    output reg [1:0] an
    );
	 
reg [1:0]cont;

always @(posedge ck or posedge rst)
	begin
		if (rst)
			begin
				an <=2'b11;
				cont=0;
			end
		else if (cont==2'd2)
			cont=0;
		else
			begin
				an<=2'b11;
				an[cont]<=0;
				cont=cont+1'b1;
			end
	end

endmodule
