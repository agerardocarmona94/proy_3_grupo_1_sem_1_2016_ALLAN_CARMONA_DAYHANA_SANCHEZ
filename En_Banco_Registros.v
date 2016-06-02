`timescale 1ns / 1ps

module En_Banco_Registros(
	input clk, f1, f2, f3,
	input [P-1:0] posicion, //señal del contador de posición
	output reg en_hora, en_min, en_seg1,
	output reg en_dia, en_mes, en_year,
	output reg en_cr_hora, en_cr_min, en_cr_seg
    );
 parameter P=2;
 
 always @(posedge clk)
	 begin
	 if (f1)
		case (posicion)
			2'd0: begin en_hora<=1; en_min<=0; en_seg<=0; end
			2'd1: begin en_hora<=0; en_min<=1; en_seg<=0; end
			2'd2: begin en_hora<=0; en_min<=0; en_seg<=1; end
			default: begin en_hora<=0; en_min<=0; en_seg<=0; end
		endcase
	 else if (f2)
		case (posicion)
			2'd0: begin en_dia<=1; en_mes<=0; en_year<=0; end
			2'd1: begin en_dia<=0; en_mes<=1; en_year<=0; end
			2'd2: begin en_dia<=0; en_mes<=0; en_year<=1; end
			default: begin en_dia<=0; en_mes<=0; en_year<=0; end
		endcase
	else if (f3)
		case (posicion)
			2'd0: begin en_cr_hora<=1; en_cr_min<=0; en_cr_seg<=0; end
			2'd1: begin en_cr_hora<=0; en_cr_min<=1; en_cr_seg<=0; end
			2'd2: begin en_cr_hora<=0; en_cr_min<=0; en_cr_seg<=1; end
			default: begin en_cr_hora<=0; en_cr_min<=0; en_cr_seg<=0; end
		endcase 
	else 
	begin 
		en_hora<=0; en_min<=0; en_seg<=0;
		en_dia<=0; en_mes<=0; en_year<=0;
		en_cr_hora<=0; en_cr_min<=0; en_cr_seg<=0;
	end
end
endmodule
