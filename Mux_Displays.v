`timescale 1ns / 1ps

module Mux_Displays(
    input [1:0] select,
    input [3:0] dato_D1,
	 input [3:0] dato_D2,
    output reg [3:0] y
    );
always @*
	begin
		case (select)
			2'b01: y=dato_D2;
			2'b10: y=dato_D1;
			default: y=dato_D1;		
		endcase
end
endmodule
