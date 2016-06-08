`timescale 1ns / 1ps
//-------------------------------------------------------------
/*
En este bloque se almacenan por medio de registros la salida del picoblaze segun el periferico en donde 
se desea guardar, ademas se habilitan las salidas del picoblaze por medio de las señales de control
Write strobe y port id

*/

//-------------------------------------------------------------
module Puertos_de_salida ( 
	input reset,
	input clk,
	input Write_Strobe,
	input [7:0] Out_Port,
	input [7:0] Port_ID,
	input RESET_MAQUINA , 
	output reg [7:0] REGISTRO_DIRECCION, 
	output reg [7:0] REGISTRO_DATO,
	output reg [3:0] secuencia_direccion, 
	output reg arranque_inicio, 
	output reg arranque_lee,
	output reg arranque _escribe,
	output reg [2:0]bandera 
    );

	 
	 always @(posedge clk )
	 if (reset)		//condiciones en caso de un reset se ponen las salidas todas a cero
		begin
			arranque_inicio<=1'b0;
			arranque_escribe<=1'b0;
			arranque_lee<=1'b0;
			REGISTRO_DIRECCION<=8'b00000000;
			REGISTRO_DATO<=8'b00000000;
			secuencia_datos<=4'b0000;
			bandera<=3'b0;
			
		end
	else
	begin
		if (Write_Strobe) //cuando se escriba en el picoblaze
			begin
			
			//en el siguiente case por medio del port_id se coloca el registros de cada registro de salida
			
				case (Port_ID)
					8'b00000001   : 
						begin
							if (RESET_MAQUINA)
								arranque_inicio<=1'b0;
							else
								begin
									if (Out_Port==8'b00000001) 
											begin
											arranque_inicio<=1'b1;   //EN ESTE REGISTRO SE INICIALIZA LA MAQUINA EN INICIALIZACION
											arranque_lee<=1'b0;// SE MANTIENE EN BAJO LOS DEMAS ARRANQUES DE LA MAQUINA YA QUE SOLO SE ESTA INICIALIZANDO
											arranque_escribe<=1'b0;
											end
									else 
									begin
											arranque_inicio<=1'b0; // EN CASO DE NO CUMPLIR MANTENER LOS ESTADOS
											arranque_lee<=arranque_lee;
											arranque_escribe<=arranque_escribe;
										end
								end
						end
					8'b00000010   :     //EN ESTE REGISTRO SE INICIALIZA LA MAQUINA EN ESCRITURA
						begin
							if (RESET_MAQUINA)
								arranque_escribe<=1'b0;
							else
								begin
									if (Out_Port==8'b00000001)
										begin
											arranque_escribe<=1'b1; // SE ACTIVA EL ARRANQUE DE LA PARTE DE ESCRITURA
											arranque_lee<=1'b0;
											arranque_inicio<=1'b0;
										end
									else 
									begin
											arranque_escribe<=1'b0; // EN CASO DE NO CUMPLIR SE MANTIENEN LOS ESTADOS
											arranque_lee<=arranque_lee;
											arranque_inicio<=arranque_inicio;
									end
								end
						end
					8'b00000011   : 
						begin
							if (RESET_MAQUINA) //EN ESTE REGISTRO SE INICIALIZA LA MAQUINA DE LECTURA
								arranque_lee<=1'b0;
							else
								begin
									if (Out_Port==8'b00000001)
											begin
												arranque_lee<=1'b1;  // SE ARRANCA LA MAQUINA DE LECTURA
												arranque_inicio<=1'b0;
												arranque_escribe<=1'b0;
											end
									else 
											begin
												arranque_lee<=1'b0;
												arranque_inicio<=arranque_inicio; // SI NO SE CUMPLE LA CONDICION MANTIENE EL ESTADO
												arranque_escribe<=arranque_escribe;
											end								end
						end
					8'b00000100   : REGISTRO_DATO<=Out_Port;   //EN ESTE REGISTRO SE ALMACENA EL DATO A ESCRIBIR
					
					8'b00000101   : begin
					
											REGISTRO_DIRECCION<=Out_Port;  // EN ESTE REGISTRO SE ALMACENA LA DIRECCION DE SALIDA
											
											if(Out_Port==8'hf1)    //SE UTILIZA UNA BANDERA PARA SABER EN QUE MOMENTO SE ESTA CARGANDO O GUARDANDO
												bandera<=3'b1;
											else
												bandera<=3'b0;
											
										 end
					8'b00000110   : 
										begin
											case(Out_Port)
												8'b00000000: secuencia_datos<=4'b0000; //EN ESTE REGISTRO VA LA DIRECCION EPOR LA CUAL SE VA LEYENDO O ESCRIBIENDO COMO LO PUEDE SER HORA MINUTO SEGUNDO ETC
												8'b00000001: secuencia_datos<=4'b0001;
												8'b00000010: secuencia_datos<=4'b0010;
												8'b00000011: secuencia_datos<=4'b0011;
												8'b00000100: secuencia_datos<=4'b0100;
												8'b00000101: secuencia_datos<=4'b0101;
												8'b00000110: secuencia_datos<=4'b0110;
												8'b00000111: secuencia_datos<=4'b0111;
												8'b00001000: secuencia_datos<=4'b1000;
												8'b00100001: secuencia_datos<=4'b1111;
												default: secuencia_datos<=secuencia_datos;
											endcase
										end
					default :
							begin
								arranque_inicio<=arranque_inicio;
								arranque_lee<=arranque_lee;
								arranque_escribe<=arranque_escribe;
								secuencia_datos<=secuencia_datos;
								REGISTRO_DIRECCION<=REGISTRO_DIRECCION;
								REGISTRO_DATO<=REGISTRO_DATO;
								bandera<=bandera;
							end
				endcase
			end
		else
			if (RESET_MAQUINA)
				begin
					arranque_inicio<=  1'b0;
					arranque_lee <=   1'b0;
					arranque_escribe<=1'b0;
				end
			else
				begin
					arranque_inicio<=arranque_inicio;
					arranque_lee <=arranque_lee;
					arranque_escribe<=arranque_escribe;
				end
	end
endmodule
