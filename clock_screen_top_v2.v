`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jafet Chaves Barrantes
// 
// Create Date:    16:10:41 03/22/2016 
// Design Name: 
// Module Name:    Clock_screen_top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module controlador_VGA
(
input wire clock, reset,
input wire [3:0] digit0_HH, digit1_HH, digit0_MM, digit1_MM, digit0_SS, digit1_SS,//
digit0_DAY, digit1_DAY, digit0_MES, digit1_MES, digit0_YEAR, digit1_YEAR,//
digit0_HH_T, digit1_HH_T, digit0_MM_T, digit1_MM_T, digit0_SS_T, digit1_SS_T,//Decenas y unidades para los números en pantalla (18 inputs de 3 bits)
input wire AM_PM,//Entrada para conocer si en la información de hora se despliega AM o PM
input wire [1:0] config_mode,//Cuatro estados del modo configuración
input wire [1:0] cursor_location,//Marca la posición del cursor en modo configuración
input wire formato_hora,//Señal que indica si la hora esta en formato 12 hrs o 24 hrs (0->24 hrs)
input wire estado_alarma,
output wire hsync, vsync,
output wire [7:0] RGB
//output wire pixel_tick
);

wire [9:0] pixel_x,pixel_y;
wire video_on; 
wire pixel_tick;
reg [7:0] RGB_reg, RGB_next;
wire text_on, graph_on, pic_on;
wire [7:0] fig_RGB, text_RGB, pic_RGB;
wire pic_ring_on;
wire pic_ringball_on, AMPM_on;

//Para generar parpadeo de 4 Hz
// Bits del contador para generar una señal periódica de (2^N)*10ns
localparam N =24;//~3Hz

reg [N-1:0] blink_reg;
reg blink;

localparam N_cursor = 25;//~2Hz

reg [N_cursor-1:0] blink_cursor_reg;
reg blink_cursor;

//Instanciaciones

timing_generator_VGA instancia_timing_generator_VGA
(
.clk(clock),
.reset(reset),
.hsync(hsync),
.vsync(vsync),
.video_on(video_on),
.p_tick(pixel_tick),
.pixel_x(pixel_x), 
.pixel_y(pixel_y)
);

generador_figuras instancia_generador_figuras
(
.video_on(video_on),//señal que indica que se encuentra en la región visible de resolución 640x480
.pixel_x(pixel_x), 
.pixel_y(pixel_y),//coordenadas xy de cada pixel
.graph_on(graph_on),
.fig_RGB(fig_RGB) //12 bpp (4 bits para cada color)
);

generador_caracteres instancia_generador_caracteres
(
.clk(clock),
.digit0_HH(digit0_HH), .digit1_HH(digit1_HH), .digit0_MM(digit0_MM), .digit1_MM(digit1_MM), .digit0_SS(digit0_SS), .digit1_SS(digit1_SS),//
.digit0_DAY(digit0_DAY), .digit1_DAY(digit1_DAY), .digit0_MES(digit0_MES), .digit1_MES(digit1_MES), .digit0_YEAR(digit0_YEAR), .digit1_YEAR(digit1_YEAR),//
.digit0_HH_T(digit0_HH_T), .digit1_HH_T(digit1_HH_T), .digit0_MM_T(digit0_MM_T), .digit1_MM_T(digit1_MM_T), .digit0_SS_T(digit0_SS_T), .digit1_SS_T(digit1_SS_T),//Decenas y unidades para los números en pantalla (18 inputs de 3 bits)
.AM_PM(AM_PM),//Entrada para conocer si en la información de hora se despliega AM o PM
.config_mode(config_mode),
.cursor_location(cursor_location),//Marca la posición del cursor en modo configuración
.pixel_x(pixel_x), .pixel_y(pixel_y),
.parpadeo(blink_cursor),
.text_on(text_on),
.AMPM_on(AMPM_on), //Localización de esos respectivos textos
.text_RGB(text_RGB) //8 bpp
);

generador_imagenes instancia_generador_imagenes
(
.video_on(video_on),//señal que indica que se encuentra en la región visible de resolución 640x480
.pixel_x(pixel_x), 
.pixel_y(pixel_y),
.pic_ring_on(pic_ring_on),
.pic_ringball_on(pic_ringball_on),
.pic_on(pic_on),
.pic_RGB(pic_RGB)
);

//=============================================
// Contador para generar pulso de parpadeo
//=============================================

always @(posedge clock, posedge reset)
begin
	if (reset)begin blink_reg <= 0; blink <= 0; end
	
	else
	begin
		if (blink_reg == 24'd16666666)
			begin
			blink_reg <= 0;
			blink <= ~blink;
			end
		else
			blink_reg <= blink_reg + 1'b1;
	end
end

//Parpadeo cursor
always @(posedge clock, posedge reset)
begin
	if (reset)begin blink_cursor_reg <= 0; blink_cursor <= 0; end
	
	else
	begin
		if (blink_cursor_reg == 25'd24999999)
			begin
			blink_cursor_reg <= 0;
			blink_cursor <= ~blink_cursor;
			end
		else
			blink_cursor_reg <= blink_cursor_reg + 1'b1;
	end
end		
//____________________________________________________________________________________________________________

//Multiplexación entre texto, figuras o imágenes

always@*
begin

	if(~video_on)
	RGB_next = "0";//Fuera la pantalla visible
	
	else
		if(text_on) RGB_next = text_RGB;
		else if (AMPM_on && formato_hora) RGB_next = text_RGB;
		else if (graph_on) RGB_next = fig_RGB;
		else if (pic_on) RGB_next = pic_RGB;
		else if (pic_ringball_on && estado_alarma && blink) RGB_next = pic_RGB;
		else if (pic_ring_on && estado_alarma && blink) RGB_next = pic_RGB;
		else RGB_next = 8'h00;//Fondo negro
end

always @(posedge clock)
if (pixel_tick) RGB_reg <= RGB_next;

//Salida al monitor VGA
assign RGB = RGB_reg;

endmodule
