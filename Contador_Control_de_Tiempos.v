`timescale 1ns / 1ps
//---------------------------------------------------------------------
/*
Este modulo es una parte de la maquina de estados que controla la secuencia de lectura o escritura +
en el rtc, para poder concretar ciclos bien sincronizados para el RTC se utilizó una cuenta interna de manera que cumplan los tiempos descritos en la hoja de datos




*/
//---------------------------------------------------------------------
module Contador_Control_de_Tiempos(
    input reset,
    input clk,
	 input PB_in,
	 input enable_inicio,  //esta señal es para que arranque el inicio de la maquina      
	 input enable_escribir,//esta señal es para que se active la escritura de la maquina 
	 input enable_leer, //esta señal es para que se active la lectura de la maquina 
	 input [2:0] estado_m, //antigua entrada que no se utiliza
    output [3:0] c_5 //salida del estado actual
    );
	 
	 reg [5:0] Cuenta_Interna = 0;
	 reg [3:0] Estado = 0;
	 reg posicion = 0;
	 
	 assign c_5 = Estado;

	 
	 
	 always @(posedge clk )
	 if (reset)
	 begin
	    Estado = 0;
       Cuenta_Interna <= 0; 
	 end 
	 else
	 begin
	 begin
	    if ((enable_escribir && PB_in) || enable_inicio || (estado_m==3'd4) ) //señales de habilitacion para escribir o inicializar
		 begin
			 if (posicion == 1)
			 begin
			    posicion <= 0;
			    Estado = 0;
			    Cuenta_Interna <= 0;
			 end
          else 	
          begin			 
		       case (Estado)
			       4'd0: if (Cuenta_Interna == 6'd20 )
                      begin
					          Estado = 4'd1;
						       Cuenta_Interna <= 6'd0;
                      end		
                      else 
                      begin
					          Estado = Estado;
						       Cuenta_Interna <= Cuenta_Interna + 6'd1;
                      end		
					 4'd1: if (Cuenta_Interna == 6'd20 )
							 begin
								 Estado = 4'd2;
								 Cuenta_Interna <= 6'd0;
							 end		
							 else 
							 begin
								 Estado = Estado;
								 Cuenta_Interna <= Cuenta_Interna + 6'd1;
							 end		
					 4'd2: if (Cuenta_Interna == 6'd20 )
							 begin
								 Estado = 4'd3;
								 Cuenta_Interna <= 6'd0;
							 end		
							 else 
							 begin
								 Estado = Estado;
								 Cuenta_Interna <= Cuenta_Interna + 6'd1;
							 end		
					 4'd3: if (Cuenta_Interna == 6'd10)
							 begin
								 Estado = 4'd4;
								 Cuenta_Interna <= 6'd0;
							 end		
							 else 
							 begin
								 Estado = Estado;
								 Cuenta_Interna <= Cuenta_Interna + 6'd1;
							 end	
					 4'd4: if (Cuenta_Interna == 6'd10 )
							 begin
								 Estado = 4'd5;
								 Cuenta_Interna <= 6'd0;
							 end		
							 else 
							 begin
								 Estado = Estado;
								 Cuenta_Interna <= Cuenta_Interna + 6'd1;
							 end					 
					 4'd5: if (Cuenta_Interna == 6'd20 )
							 begin
								 Estado = 4'd6;
								 Cuenta_Interna <= 6'd0;
							 end		
							 else 
							 begin
								 Estado = Estado;
								 Cuenta_Interna <= Cuenta_Interna + 6'd1;
							 end		
					 4'd6: if (Cuenta_Interna == 6'd60 )
							 begin
								 Estado = 4'd7;
								 Cuenta_Interna <= 6'd0;
							 end		
							 else 
							 begin
								 Estado = Estado;
								 Cuenta_Interna <= Cuenta_Interna + 6'd1;
							 end		
					 4'd7: if (Cuenta_Interna == 6'd20 )
							 begin
								 Estado = 4'd8;
								 Cuenta_Interna <= 6'd0;
							 end		
							 else 
							 begin
								 Estado = Estado;
								 Cuenta_Interna <= Cuenta_Interna + 6'd1;
							 end		
					 4'd8: if (Cuenta_Interna == 6'd10 )
							 begin
								 Estado = 4'd9;
								 Cuenta_Interna <= 6'd0;
							 end		
							 else 
							 begin
								 Estado = Estado;
								 Cuenta_Interna <= Cuenta_Interna + 6'd1;
							 end		
					 4'd9: if (Cuenta_Interna == 6'd10 )
							 begin
								 Estado = 4'd10;
								 Cuenta_Interna <= 6'd0;
							 end		
							 else 
							 begin
								 Estado = Estado;
								 Cuenta_Interna <= Cuenta_Interna + 6'd1;
							 end		
					 4'd10: if (Cuenta_Interna == 6'd50 )
							 begin
								 Estado = 4'd11;
								 Cuenta_Interna <= 6'd0;
							 end		
							 else 
							 begin
								 Estado = Estado;
								 Cuenta_Interna <= Cuenta_Interna + 6'd1;
							 end
					 4'd11: if (Cuenta_Interna == 6'd10 )
							 begin
								 Estado = 4'd0;
								 Cuenta_Interna <= 6'd0;
							 end		
							 else 
							 begin
								 Estado = Estado;
								 Cuenta_Interna <= Cuenta_Interna + 6'd1;
							 end	
					 default: begin
									Estado = Estado;
									Cuenta_Interna <= Cuenta_Interna;
								end 	
               endcase	
            end				 
		   end
		 else //activacion de lectura
		 if (enable_leer)
		 begin
		    if (posicion == 0)
			 begin
			    posicion <= 1;
			    Estado = 0;
			    Cuenta_Interna <= 0;
			 end
			 else
			 begin
				 case (Estado)
					 4'd0: if (Cuenta_Interna == 6'd20 )
							 begin
								 Estado = 4'd1;
								 Cuenta_Interna <= 6'd0;
							 end		
							 else 
							 begin
								 Estado = Estado;
								 Cuenta_Interna <= Cuenta_Interna + 6'd1;
							 end		
					 4'd1: if (Cuenta_Interna == 6'd20 )
							 begin
								 Estado = 4'd2;
								 Cuenta_Interna <= 6'd0;
							 end		
							 else 
							 begin
								 Estado = Estado;
								 Cuenta_Interna <= Cuenta_Interna + 6'd1;
							 end		
					 4'd2: if (Cuenta_Interna == 6'd20 )
							 begin
								 Estado = 4'd3;
								 Cuenta_Interna <= 6'd0;
							 end		
							 else 
							 begin
								 Estado = Estado;
								 Cuenta_Interna <= Cuenta_Interna + 6'd1;
							 end		
					 4'd3: if (Cuenta_Interna == 6'd10)
							 begin
								 Estado = 4'd4;
								 Cuenta_Interna <= 6'd0;
							 end		
							 else 
							 begin
								 Estado = Estado;
								 Cuenta_Interna <= Cuenta_Interna + 6'd1;
							 end	
					 4'd4: if (Cuenta_Interna == 6'd10 )
							 begin
								 Estado = 4'd5;
								 Cuenta_Interna <= 6'd0;
							 end		
							 else 
							 begin
								 Estado = Estado;
								 Cuenta_Interna <= Cuenta_Interna + 6'd1;
							 end					 
					 4'd5: if (Cuenta_Interna == 6'd20 )
							 begin
								 Estado = 4'd6;
								 Cuenta_Interna <= 6'd0;
							 end		
							 else 
							 begin
								 Estado = Estado;
								 Cuenta_Interna <= Cuenta_Interna + 6'd1;
							 end		
					 4'd6: if (Cuenta_Interna == 6'd60 )
							 begin
								 Estado = 4'd7;
								 Cuenta_Interna <= 6'd0;
							 end		
							 else 
							 begin
								 Estado = Estado;
								 Cuenta_Interna <= Cuenta_Interna + 6'd1;
							 end		
					 4'd7: if (Cuenta_Interna == 6'd20 )
							 begin
								 Estado = 4'd8;
								 Cuenta_Interna <= 6'd0;
							 end		
							 else 
							 begin
								 Estado = Estado;
								 Cuenta_Interna <= Cuenta_Interna + 6'd1;
							 end		
					 4'd8: if (Cuenta_Interna == 6'd10 )
							 begin
								 Estado = 4'd9;
								 Cuenta_Interna <= 6'd0;
							 end		
							 else 
							 begin
								 Estado = Estado;
								 Cuenta_Interna <= Cuenta_Interna + 6'd1;
							 end		
					 4'd9: if (Cuenta_Interna == 6'd10 )
							 begin
								 Estado = 4'd10;
								 Cuenta_Interna <= 6'd0;
							 end		
							 else 
							 begin
								 Estado = Estado;
								 Cuenta_Interna <= Cuenta_Interna + 6'd1;
							 end		
					 4'd10: if (Cuenta_Interna == 6'd50 )
							 begin
								 Estado = 4'd11;
								 Cuenta_Interna <= 6'd0;
							 end		
							 else 
							 begin
								 Estado = Estado;
								 Cuenta_Interna <= Cuenta_Interna + 6'd1;
							 end
					 4'd11: if (Cuenta_Interna == 6'd10 )
							 begin
								 Estado = 4'd0;
								 Cuenta_Interna <= 6'd0;
							 end		
							 else 
							 begin
								 Estado = Estado;
								 Cuenta_Interna <= Cuenta_Interna + 6'd1;
							 end	
					 default: begin
									Estado = Estado;
									Cuenta_Interna <= Cuenta_Interna;
								 end 	
               endcase
            end		
		   end 
			else
         begin
			   Estado = 0;
			   Cuenta_Interna <= 0;
         end	
		end
		end
		
   endmodule
