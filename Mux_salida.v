`timescale 1ns / 1ps

module Deco_salida(
	input f1,f2,f3,
	input [N-1:0] dato_hora, dato_min, dato_seg, dato_dia, dato_mes, dato_year,
	output reg [N-1:0] dato_1, dato_2, dato_3
    );

parameter N=8;

always @*
begin
	if (f1)
	begin
		dato_1<= dato_hora;
		dato_2<= dato_min;
		dato_3<= dato_seg;
	end
	else if (f2)
	begin
		dato_1<= dato_dia;
		dato_2<= dato_mes;
		dato_3<= dato_year;
	end
	else if (f3)
	begin
		dato_1<= dato_hora;
		dato_2<= dato_min;
		dato_3<= dato_seg;
	end
	else
	begin
		dato_1<= dato_1;
		dato_2<= dato_2;
		dato_3<= dato_3;
	end
end

endmodule
