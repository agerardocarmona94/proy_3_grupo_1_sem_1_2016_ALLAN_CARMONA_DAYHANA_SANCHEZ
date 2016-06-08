`timescale 1ns / 1ps
//módulo encargado de encapsular los bloques del control del VGA, en el ingresan todos los datos de los registros que almacenan el dato de
// hora, min, seg, dia, mes, año y los de cronometro, en sus salidas se tienen las señales de sincronización para enviar por el VGA, así
// como el bus COLOUR OUT el cual se encarga de definir el color del texto o figura a mostrar en la pantalla
module MainActivity(
 input [3:0]d0,d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15,d16,d17,d18,// digitos de fecha
	input CLK,					//clock signal
   output [7:0] COLOUR_OUT,//bit patters for colour that goes to VGA port
   output HS,					//Horizontal Synch signal that goes into VGA port
   output VS					//Vertical Synch signal that goes into VGA port
	);
	
	reg DOWNCOUNTER = 0;
	reg [7:0] COLOUR_IN, COLOUR_IN_co, COLOUR_IN_fe, COLOUR_IN_re, COLOUR_IN_cr,COLOUR_IN_al;
	reg en_conf, en_fecha, en_reloj, en_crono,en_alarma;
	wire [31:0] STATE1,STATE2, STATE3, STATE4,STATE5;
	wire TrigRefresh;			//Trigger gives a pulse when displayed refreshed
	wire [9:0] ADDRH;			//wire for getting Horizontal pixel value
	wire [8:0] ADDRV;			//wire for getting vertical pixel value
	
	clk_div clk_div (
    .clk(CLK),  
    .out_clk(CLk)
    );


	//Divisor a 25MHz		
	always @(posedge CLk)begin     
		DOWNCOUNTER <= ~DOWNCOUNTER;	//Slow down the counter to 25MHz
	end
		
	//VGA Interface gets values of ADDRH & ADDRV and by puting COLOUR_IN, gets valid output COLOUR_OUT
	VGAInterface VGA(
				.CLK(DOWNCOUNTER),
			   .COLOUR_IN (COLOUR_IN),
				.COLOUR_OUT(COLOUR_OUT),
				.HS(HS),
				.VS(VS),
				.REFRESH(TrigRefresh),
				.ADDRH(ADDRH),
				.ADDRV(ADDRV),
				.DOWNCOUNTER(DOWNCOUNTER)
				);
				
	wire [2:0] text_rgb;
	wire [9:0]text_on; 
	
	
 
	
	
	
	
// Entrada de datos de los registros se divide en buses de 4 bits, de esta manera es posible trabajar cada digito de manera independiente.	
	
	pong_text pong_text (
    .clk(DOWNCOUNTER), 
    .dig0(d0), 
    .dig1(d1), 
    .dig2(d2), 
    .dig3(d3), 
    .dig4(d4), 
    .dig5(d5), 
    .dig6(d6), 
    .dig7(d7), 
    .dig8(d8), 
    .dig9(d9), 
    .dig10(d10), 
    .dig11(d11), 
    .dig12(d12), 
    .dig13(d13), 
    .dig14(d14), 
    .dig15(d15), 
    .dig16(d16), 
    .dig17(d17),
    .dig18(d18),	 
    .pix_x(ADDRH), 
    .pix_y(ADDRV), 
    .text_on(text_on), 
    .text_rgb(text_rgb));

//-------------------COLOCACION DE IMAGENES-----------------------------------------------------
//Para la colocación de imagenes se utiliza la tecnica de mapeo de objetos
//las imágenes utilizadas son agregadas al código por medio de los archivos .list generados con el programa MATLAB

//------INFORMACIÓN DE CONFIGURACIÓN------------------------------------------------------------
	localparam  Xc = 433; // Se define la posición a ubicar la imagen
	localparam  Yc = 35;	
	reg [7:0] COLOUR_DATA [0:configuracion2-1];
	parameter configuracion2 = 17'd59823;	
	parameter configuracion2X = 8'd207;	//Se define el tamaño de la imagen
	parameter configuracion2Y = 9'd289;	
	
	initial
	$readmemh ("configuracion2.list", COLOUR_DATA);
	
	assign STATE1 = ((ADDRH-Xc)*configuracion2Y)+ADDRV-Yc;
	
	always @(posedge CLK) begin
		if (ADDRH>=Xc  && ADDRH<Xc +configuracion2X
			&& ADDRV>=Yc && ADDRV<Yc+configuracion2Y)
				begin
					COLOUR_IN_co <= COLOUR_DATA[{STATE1}];
					en_conf<=1;
				end
			else
				begin 
					COLOUR_IN_co <= 8'hFF;
					en_conf<=0;
				end
	end
//------------------------------------------------------------------------------------------------

//------TITULO-FECHA-------------------------------------------------------------------------------------
	localparam  Xf = 0;
	localparam  Yf = 45;	
	reg [7:0] COLOUR_DATA_f [0:fecha-1];
	parameter fecha = 13'd4368;	
	parameter fechaX = 7'd104;	
	parameter fechaY = 6'd42;	
	
	initial
	$readmemh ("fecha.list", COLOUR_DATA_f);
	
	assign STATE2 = ((ADDRH-Xf)*fechaY)+ADDRV-Yf;
	
	always @(posedge CLK) begin
		if (ADDRH>=Xf && ADDRH<Xf+fechaX
			&& ADDRV>=Yf && ADDRV<Yf+fechaY)
			begin
				COLOUR_IN_fe <= COLOUR_DATA_f[{STATE2}];
				en_fecha<=1;
			end
			else
			begin
				COLOUR_IN_fe <= 8'hFF;
				en_fecha<=0;
			end
	end
//------------------------------------------------------------------------------------------------

//------TITULO-RELOJ-------------------------------------------------------------------------------------
	
	localparam  Xr = 0;
	localparam  Yr = 166;	
	reg [7:0] COLOUR_DATA_r [0:reloj-1];
	parameter reloj = 13'd4554;	
	parameter relojX = 7'd99;	
	parameter relojY = 6'd46;	
	
	initial
	$readmemh ("reloj.list", COLOUR_DATA_r);
	
	assign STATE3 = ((ADDRH-Xr)*relojY)+ADDRV-Yr;
	
	always @(posedge CLK) begin
		if (ADDRH>=Xr && ADDRH<Xr+relojX
			&& ADDRV>=Yr && ADDRV<Yr+relojY)
			begin
				COLOUR_IN_re <= COLOUR_DATA_r[{STATE3}];
				en_reloj<=1;
			end
			else
			begin
				COLOUR_IN_re <= 8'hFF;
				en_reloj<=0;
			end
	end
//------------------------------------------------------------------------------------------------

//------TITULO-CRONOMETRO-------------------------------------------------------------------------------------
	
	localparam  Xcr = 0;
	localparam  Ycr = 286;	
	reg [7:0] COLOUR_DATA_cr [0:cronometro-1];
	parameter cronometro = 14'd8560;	
	parameter cronometroX = 8'd214;	
	parameter cronometroY = 6'd40;	
	
	initial
	$readmemh ("cronometro.list", COLOUR_DATA_cr);
	
	assign STATE4 = ((ADDRH-Xcr)*cronometroY)+ADDRV-Ycr;
	
	always @(posedge CLK) begin
		if (ADDRH>=Xcr && ADDRH<Xcr+cronometroX
			&& ADDRV>=Ycr && ADDRV<Ycr+cronometroY)
			begin
				COLOUR_IN_cr <= COLOUR_DATA_cr[{STATE4}];
				en_crono<=1;
			end
			else
			begin
				COLOUR_IN_cr <= 8'hFF;
				en_crono<=0;
			end
	end
//------------------------------------------------------------------------------------------------

//------ALARMA-------------------------------------------------------------------------------------
	//Se coloca una imagen extra para el momento de que se active la alarma del cronómetro el usuario tambien se pueda dar cuenta al ver la imagen
	localparam  Xal = 330;
	localparam  Yal = 330;	
	reg [7:0] COLOUR_DATA_al [0:alarma-1];
	parameter alarma = 16'd17152;	
	parameter alarmaX = 8'd134;	
	parameter alarmaY = 8'd128;	
	
	initial
	$readmemh ("alarma.list", COLOUR_DATA_al);
	
	assign STATE5 = ((ADDRH-Xal)*alarmaY)+ADDRV-Yal;
	
	always @(posedge CLK) begin
		if ((ADDRH>=Xal && ADDRH<Xal+alarmaX
			&& ADDRV>=Yal && ADDRV<Yal+alarmaY)&&d18==4'b0001)
			begin
				COLOUR_IN_al <= COLOUR_DATA_al[{STATE5}];
				en_alarma<=1;
			end
			else
			begin
				COLOUR_IN_al <= 8'hFF;
				en_alarma<=0;
			end
	end
//------------------------------------------------------------------------------------------------
wire [7:0]color;
assign color={text_rgb[2],text_rgb[2],text_rgb[1],text_rgb[1],text_rgb[1],text_rgb[0],text_rgb[0],text_rgb[0]};

//--------MUX------------------------------------------------------------------------------------
// se crea un MUX para seleccionar la imagen que será mostrada en la pantalla, esto porque se tiene una unica salida de coulour out, por lo que
//hay que especificar en que momento sale cada imagen dependiendo de la posición en la que se encuentre
//Se toman como prioridad los recuadros con los datos de los numeros y caracteres, por encima de las imágenes que contienen los titulos

always @ (posedge DOWNCOUNTER )
begin
	if (text_on[0])
		COLOUR_IN<=color;
	else if (text_on[4])
		COLOUR_IN<=color;
	else if (text_on[5])
		COLOUR_IN<=color;
	else if (text_on[9])
		COLOUR_IN<=color;
	else if (en_fecha)
		COLOUR_IN<=COLOUR_IN_fe;
	else if (en_reloj)
		COLOUR_IN<=COLOUR_IN_re;
	else if (en_crono)
		COLOUR_IN<=COLOUR_IN_cr;
	else if(en_alarma)
		COLOUR_IN<=COLOUR_IN_al;
	else if (en_conf)
	begin
		COLOUR_IN<=COLOUR_IN_co;
	end
	else 
		COLOUR_IN<=COLOUR_IN;
end
endmodule
