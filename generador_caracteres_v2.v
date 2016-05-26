`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jafet Chaves Barrantes
// 
// Create Date:    18:28:34 03/22/2016 
// Design Name: 
// Module Name:    Generador_Caracteres 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: Este módulo se encarga de generar el texto que se requiere en la imagen del monitor.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module generador_caracteres
(
input wire clk,
input wire [3:0] digit0_HH, digit1_HH, digit0_MM, digit1_MM, digit0_SS, digit1_SS,//
digit0_DAY, digit1_DAY, digit0_MES, digit1_MES, digit0_YEAR, digit1_YEAR,//
digit0_HH_T, digit1_HH_T, digit0_MM_T, digit1_MM_T, digit0_SS_T, digit1_SS_T,//Decenas y unidades para los números en pantalla (18 inputs de 3 bits)
input wire AM_PM,//Entrada para conocer si en la información de hora se despliega AM o PM
input wire parpadeo,//parpadeo del cursor
input wire [1:0] config_mode,//Cuatro estados del modo configuración
input wire [1:0] cursor_location,//Marca la posición del cursor en modo configuración
input wire [9:0] pixel_x, pixel_y,//Coordenada de cada pixel
output wire AMPM_on, //Localización de esos respectivos textos
output wire text_on, //10 "textos" en total en pantalla (bandera de indica que se debe escribir texto)
output reg [7:0] text_RGB //8 bpp (Nexys 3)
);

//Declaración de señales

//Font ROM (caracteres 16x32)
wire [11:0] rom_addr; //ASCII 7-bits + Fila 5-bits
reg [6:0] char_addr; //ASCII 7-bits
reg [4:0] row_addr; //Direccion de fila del patrón de caracter en particular(5 bits)
reg [3:0] bit_addr; //Columna del pixel particular de un patrón de caracter (4 bits)
wire [15:0] font_word;//Fila de pixeles del patrón de caracter en particular (16 bits)
wire font_bit;//1 pixel del font_word específicado por bit_addr

//Direcciones "auxiliares" para cada uno de los dígitos de los números a mostrar
reg [6:0] char_addr_digHORA, char_addr_digFECHA, char_addr_digTIMER, char_addr_AMPM;
wire [4:0] row_addr_digHORA, row_addr_digFECHA, row_addr_digTIMER,  row_addr_AMPM;
wire [3:0] bit_addr_digHORA, bit_addr_digFECHA, bit_addr_digTIMER, bit_addr_AMPM; 
wire digHORA_on, digFECHA_on, digTIMER_on;
	
//Instanciación de la font ROM
ROM_16x32 Instancia_ROM_16x32
(.clk(clk), .addr(rom_addr), .data(font_word));

//Descripción de comportamiento

//1.Dígitos para representar la HORA(tamaño de fuente 16x32)
assign digHORA_on = (pixel_y[9:5]==4)&&(pixel_x[9:4]>=16)&&(pixel_x[9:4]<=23);
assign row_addr_digHORA = pixel_y[4:0];
assign bit_addr_digHORA = pixel_x[3:0];

always@*
begin

	case(pixel_x[6:4])
	3'b000: char_addr_digHORA = {3'b011, digit1_HH};//(decenas hrs)
	3'b001: char_addr_digHORA = {3'b011, digit0_HH};//(unidades hrs)
	3'b010: char_addr_digHORA = 7'h3a;//:
	3'b011: char_addr_digHORA = {3'b011, digit1_MM};//(decenas min)
	3'b100: char_addr_digHORA = {3'b011, digit0_MM};//(unidades min)
	3'b101: char_addr_digHORA = 7'h3a;//:
	3'b110: char_addr_digHORA = {3'b011, digit1_SS};//(decenas s)
	3'b111: char_addr_digHORA = {3'b011, digit0_SS};//(unidades s)
	endcase
	
end

//2.Dígitos para representar la FECHA(tamaño de fuente 16x32)
assign digFECHA_on = (pixel_y[9:5]==12)&&(pixel_x[9:4]>=7)&&(pixel_x[9:4]<=14);
assign row_addr_digFECHA = pixel_y[4:0];
assign bit_addr_digFECHA = pixel_x[3:0];

always@*
begin
	case(pixel_x[6:4])
	3'b111: char_addr_digFECHA = {3'b011, digit1_DAY};//(decenas DIA)
	3'b000: char_addr_digFECHA = {3'b011, digit0_DAY};//(unidades DIA)
	3'b001: char_addr_digFECHA = 7'h2f;//"/"
	3'b010: char_addr_digFECHA = {3'b011, digit1_MES};//(decenas MES)
	3'b011: char_addr_digFECHA = {3'b011, digit0_MES};//(unidades MES)
	3'b100: char_addr_digFECHA = 7'h2f;//"/"
	3'b101: char_addr_digFECHA = {3'b011, digit1_YEAR};//(decenas AÑO)
	3'b110: char_addr_digFECHA = {3'b011, digit0_YEAR};//(unidades	AÑO)
	endcase	
end

//3.Dígitos para la cuenta del TIMER(tamaño de fuente 16x32)
assign digTIMER_on = (pixel_y[9:5]==12)&&(pixel_x[9:4]>=25)&&(pixel_x[9:4]<=32);
assign row_addr_digTIMER = pixel_y[4:0];
assign bit_addr_digTIMER = pixel_x[3:0];

always@*
begin
	case(pixel_x[6:4])
	3'b001: char_addr_digTIMER = {3'b011, digit1_HH_T};//(decenas hrs)
	3'b010: char_addr_digTIMER = {3'b011, digit0_HH_T};//(unidades hrs)
	3'b011: char_addr_digTIMER = 7'h3a;//:
	3'b100: char_addr_digTIMER = {3'b011, digit1_MM_T};//(decenas min)
	3'b101: char_addr_digTIMER = {3'b011, digit0_MM_T};//(unidades min)
	3'b110: char_addr_digTIMER = 7'h3a;//:
	3'b111: char_addr_digTIMER = {3'b011, digit1_SS_T};//(decenas s)
	3'b000: char_addr_digTIMER = {3'b011, digit0_SS_T};//(decenas s)
	endcase	
end

//4.Palabra AM o PM(tamaño de fuente 16x32)
assign AMPM_on = (pixel_y[9:5]==1)&&(pixel_x[9:4]>=26)&&(pixel_x[9:4]<=27);
assign row_addr_AMPM = pixel_y[4:0];
assign bit_addr_AMPM = pixel_x[3:0];

always@*
begin
	case(pixel_x[4])
	
	1'b0:
	begin
	case(AM_PM)//AM_PM = 0: se escribe AM
	1'b0: char_addr_AMPM = 7'h61;//A
	1'b1: char_addr_AMPM = 7'h64;//P
	endcase
	end
	
	1'b1: char_addr_AMPM = 7'h63;//M
	endcase	
end

//Multiplexar las direcciones para font ROM y salida RBG
always @*
begin

text_RGB = 8'b0;//Fondo negro
	
	if(digHORA_on)
		begin
		char_addr = char_addr_digHORA;
      row_addr = row_addr_digHORA;
      bit_addr = bit_addr_digHORA;
			//(0: Los dos dígitos a la derecha, 1: Los dos dígitos intermedios, 2: Los dos dígitos a la izquierda, 3: Ubicación de AM/PM)
			//Evalúa que se está configurando (0: modo normal, 1: config.hora, 2: config.fecha, 3: config.timer)
			if(font_bit) text_RGB = 8'h00; //Negro
			else if ((parpadeo)&&(~font_bit)&&(config_mode == 1)&&(pixel_y[9:5]==4)&&(pixel_x[9:4]>=16)&&(pixel_x[9:4]<=17)&&(cursor_location==2)) 
			text_RGB =8'hFF;//Hace un cursor si se está en modo configuración
			else if ((parpadeo)&&(~font_bit)&&(config_mode == 1)&&(pixel_y[9:5]==4)&&(pixel_x[9:4]>=19)&&(pixel_x[9:4]<=20)&&(cursor_location==1))
			text_RGB = 8'hFF;//Hace un cursor si se está en modo configuración
			else if ((parpadeo)&&(~font_bit)&&(config_mode == 1)&&(pixel_y[9:5]==4)&&(pixel_x[9:4]>=22)&&(pixel_x[9:4]<=23)&&(cursor_location==0))
			text_RGB = 8'hFF;//Hace un cursor si se está en modo configuración
			else if(~font_bit) text_RGB = 8'h1E;//Fondo del texto igual al de los recuadros
		end

	else if(digFECHA_on)
		begin
		char_addr = char_addr_digFECHA;
      row_addr = row_addr_digFECHA;
      bit_addr = bit_addr_digFECHA;
			//(0: Los dos dígitos a la derecha, 1: Los dos dígitos intermedios, 2: Los dos dígitos a la izquierda, 3: Ubicación de día semana)
			if(font_bit) text_RGB =8'h00; //Negro
			else if ((parpadeo)&&(~font_bit)&&(config_mode == 2)&&(pixel_y[9:5]==12)&&(pixel_x[9:4]>=7)&&(pixel_x[9:4]<=8)&&(cursor_location==2))
			text_RGB = 8'hFF;//Hace un cursor si se está en modo configuración
			else if ((parpadeo)&&(~font_bit)&&(config_mode == 2)&&(pixel_y[9:5]==12)&&(pixel_x[9:4]>=10)&&(pixel_x[9:4]<=11)&&(cursor_location==1))
			text_RGB = 8'hFF;//Hace un cursor si se está en modo configuración
			else if ((parpadeo)&&(~font_bit)&&(config_mode == 2)&&(pixel_y[9:5]==12)&&(pixel_x[9:4]>=13)&&(pixel_x[9:4]<=14)&&(cursor_location==0))
			text_RGB = 8'hFF;//Hace un cursor si se está en modo configuración
			else if(~font_bit) text_RGB = 8'h1E;//Fondo del texto igual al de los recuadros
		end
	
	else if ((digTIMER_on))
		begin
		char_addr = char_addr_digTIMER;
      row_addr = row_addr_digTIMER;
      bit_addr = bit_addr_digTIMER;
			//(0: Los dos dígitos a la derecha, 1: Los dos dígitos intermedios, 2: Los dos dígitos a la izquierda)
			if(font_bit) text_RGB = 8'h00; //Negro
			else if ((parpadeo)&&(~font_bit)&&(config_mode == 3)&&(pixel_y[9:5]==12)&&(pixel_x[9:4]>=25)&&(pixel_x[9:4]<=26)&&(cursor_location==2)) 
			text_RGB = 8'hFF;//Hace un cursor si se está en modo configuración
			else if ((parpadeo)&&(~font_bit)&&(config_mode == 3)&&(pixel_y[9:5]==12)&&(pixel_x[9:4]>=28)&&(pixel_x[9:4]<=29)&&(cursor_location==1))
			text_RGB = 8'hFF;//Hace un cursor si se está en modo configuración
			else if ((parpadeo)&&(~font_bit)&&(config_mode == 3)&&(pixel_y[9:5]==12)&&(pixel_x[9:4]>=31)&&(pixel_x[9:4]<=32)&&(cursor_location==0))
			text_RGB = 8'hFF;//Hace un cursor si se está en modo configuración
			else if(~font_bit) text_RGB = 8'h1E;//Fondo del texto igual al de los recuadros
		end
		
	else
		begin
		char_addr = char_addr_AMPM;
      row_addr = row_addr_AMPM;
      bit_addr = bit_addr_AMPM;
			if(font_bit) text_RGB = 8'hFF; //Blanco
		end
		
end

assign text_on = digHORA_on|digFECHA_on|digTIMER_on;//3 bloques de texto en total

//Interfaz con la font ROM
assign rom_addr = {char_addr, row_addr};
assign font_bit = font_word[~bit_addr];

endmodule
/*
Nota: Los 10 textos a mostrar son
1.La palabra HORA
2.Los dígitos para la hora
3.Los números de la fecha
4.El día de la semana
5.La palabra TIMER
6.Los dígitos para la cuenta del timer
7.La palabra RING
8.AM o PM
9.RTC DISPLAY v1.0
*/