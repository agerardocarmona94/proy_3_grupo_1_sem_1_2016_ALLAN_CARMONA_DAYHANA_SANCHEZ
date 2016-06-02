`timescale 1ns / 1ps

module Deco_dato_display(
	input f1,f2,f3,
	input [N-1:0] dato_hora, dato_min, dato_seg, dato_dia,dato_mes,dato_year,
	input [P-1:0] posicion,
	output reg [N-1:0] dato_display
    );
parameter N=8;
parameter P=2;

always@*
begin
	if (f1||f3)
		case (posicion)
			0: dato_display<= dato_hora;
			1: dato_display<= dato_min;
			2: dato_display<= dato_seg;
			default: dato_display<= dato_hora;
		endcase
	else if (f2)
		case (posicion)
			0: dato_display<= dato_dia;
			1: dato_display<= dato_mes;
			2: dato_display<= dato_year;
			default: dato_display<= dato_dia;
		endcase
	else 
		case (posicion)
			0: dato_display<= dato_dia;
			1: dato_display<= dato_mes;
			2: dato_display<= dato_year;
			default: dato_display<= dato_dia;
		endcase
end

endmodule
