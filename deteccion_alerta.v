`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//En este modulo se detecta cuando los datos de la alarma son iguales para que se active la alarma 
//////////////////////////////////////////////////////////////////////////////////
module deteccion_alerta(
input [7:0] dato1,dato2,dato3,VGA1,VGA2,VGA3,
input clk,reset,AAA,rst_alarma,
output reg [3:0] alarma

    );
   always @(posedge clk)
      if (reset||rst_alarma) begin
         alarma <=0;
      end else if ((dato1==VGA1)&&(dato2==VGA2)&&(dato3==VGA3)&&(AAA==1)&&((VGA1!=0))) begin
           alarma <=1;
      end else begin
		      alarma <=alarma;
		end

endmodule
