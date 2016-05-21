`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jafet Chaves Barrantes
// 
// Create Date:    20:32:40 05/17/2016 
// Design Name: 
// Module Name:    picture_timer 
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
module generador_imagenes
(
input clk,
input reset,
input wire video_on,//señal que indica que se encuentra en la región visible de resolución 640x480
input wire [9:0] pixel_x, pixel_y,
output wire pic_on,
output wire [7:0] pic_RGB
);

//Declaración de constantes
localparam pic_hora_XL = 256; //Límite izquierdo
localparam pic_hora_XR = 384; //Límite derecho
localparam pic_hora_YB = 64; //Límite inferior
localparam pic_hora_size = 8192;// (128x64)

localparam pic_timer_XL = 416; //Límite izquierdo
localparam pic_timer_XR = 496; //Límite derecho
localparam pic_timer_YT = 416;	//Límite superior
localparam pic_timer_YB = 479; //Límite inferior
localparam pic_timer_size = 2560;// (80x32)

localparam pic_ring_XL = 512; //Límite izquierdo
localparam pic_ring_XR = 639; //Límite derecho
localparam pic_ring_YT = 128;	//Límite superior
localparam pic_ring_YB = 191; //Límite inferior
localparam pic_ring_size = 8192;// (128x64)

localparam pic_ringball_XL = 544; //Límite izquierdo
localparam pic_ringball_XR = 592; //Límite derecho
localparam pic_ringball_YT = 64;	//Límite superior
localparam pic_ringball_YB = 112; //Límite inferior
localparam pic_ringball_size = 2304;// (48x48)

localparam pic_logo_XR = 128; //Límite derecho
localparam pic_logo_YB = 16; //Límite inferior
localparam pic_logo_size = 2048;// (128x16)

//Declaración de señales
reg [7:0] pic_RGB_aux;
reg [7:0] colour_data_hora [0:pic_hora_size-1];	//datos de los colores
reg [7:0] colour_data_timer [0:pic_timer_size-1];	//datos de los colores
reg [7:0] colour_data_ring [0:pic_ring_size-1];	//datos de los colores
reg [7:0] colour_data_ringball [0:pic_ringball_size-1];	//datos de los colores
reg [7:0] colour_data_logo [0:pic_logo_size-1];	//datos de los colores
wire pic_hora_on, pic_timer_on, pic_ring_on, pic_ringball_on, pic_logo_on;

reg [12:0] index_counter_hora_reg, index_counter_hora_next;
wire [12:0] index_counter_hora;

reg [11:0] index_counter_timer_reg, index_counter_timer_next;
wire [11:0] index_counter_timer;

reg [12:0] index_counter_ring_reg, index_counter_ring_next;
wire [12:0] index_counter_ring;

reg [11:0] index_counter_ringball_reg, index_counter_ringball_next;
wire [11:0] index_counter_ringball;

reg [10:0] index_counter_logo_reg, index_counter_logo_next;
wire [10:0] index_counter_logo;

//Contadores para recorrer la memoria
always @(posedge clk)//Todos los contadores tienen la misma lógica de asignación de estados
	begin
		if(reset)
			begin
			index_counter_hora_reg <= 0;
			index_counter_timer_reg <= 0;
			index_counter_ring_reg <= 0;
			index_counter_ringball_reg <= 0;
			index_counter_logo_reg <= 0;
			end
		else
			begin
			index_counter_hora_reg <= index_counter_hora_next;
			index_counter_timer_reg <= index_counter_timer_next;
			index_counter_ring_reg <= index_counter_ring_next;
			index_counter_ringball_reg <= index_counter_ringball_next;
			index_counter_logo_reg <= index_counter_logo_next;
			end		
	end
	

//===================================================
// Imagen HORA
//===================================================
initial
$readmemh ("hora.list", colour_data_hora);//Leer datos RBG de archivo de texto, sintetiza una ROM

//Imprime la imagen de hora dentro de la región
assign pic_hora_on = (pic_hora_XL<=pixel_x)&&(pixel_x<=pic_hora_XR)&&(pixel_y<=pic_hora_YB);//Para saber cuando se está imprimiendo la imagen

always@*
	begin
		if(pic_hora_on)
			begin
			index_counter_hora_next = index_counter_hora_reg + 1'b1;
			end
			
		else
			begin
			index_counter_hora_next = 0;
			end
	end

assign index_counter_hora = index_counter_hora_reg;

//===================================================
// Imagen TIMER
//===================================================
initial
$readmemh ("timer.list", colour_data_timer);//Leer datos RBG de archivo de texto, sintetiza una ROM

//Imprime la imagen de hora dentro de la región
assign pic_timer_on = (pic_timer_XL<=pixel_x)&&(pixel_x<=pic_timer_XR)&&(pic_timer_YT<=pixel_y)&&(pixel_y<=pic_timer_YB);//Para saber cuando se está imprimiendo la imagen

always@*
	begin
		if(pic_timer_on)
			begin
			index_counter_timer_next = index_counter_timer_reg + 1'b1;
			end
			
		else
			begin
			index_counter_timer_next = 0;
			end
	end

assign index_counter_timer = index_counter_timer_reg;

//===================================================
// Imagen RING
//===================================================
initial
$readmemh ("ring.list", colour_data_ring);//Leer datos RBG de archivo de texto, sintetiza una ROM

//Imprime la imagen de hora dentro de la región
assign pic_ring_on = (pic_ring_XL<=pixel_x)&&(pixel_x<=pic_ring_XR)&&(pic_ring_YT<=pixel_y)&&(pixel_y<=pic_ring_YB);//Para saber cuando se está imprimiendo la imagen

always@*
	begin
		if(pic_ring_on)
			begin
			index_counter_ring_next = index_counter_ring_reg + 1'b1;
			end
			
		else
			begin
			index_counter_ring_next = 0;
			end
	end

assign index_counter_ring = index_counter_ring_reg;

//===================================================
// Imagen RING BALL
//===================================================
initial
$readmemh ("ring_ball.list", colour_data_ringball);//Leer datos RBG de archivo de texto, sintetiza una ROM

//Imprime la imagen de hora dentro de la región
assign pic_ringball_on = (pic_ringball_XL<=pixel_x)&&(pixel_x<=pic_ringball_XR)&&(pic_ringball_YT<=pixel_y)&&(pixel_y<=pic_ringball_YB);//Para saber cuando se está imprimiendo la imagen

always@*
	begin
		if(pic_ringball_on)
			begin
			index_counter_ringball_next = index_counter_ringball_reg + 1'b1;
			end
			
		else
			begin
			index_counter_ringball_next = 0;
			end
	end

assign index_counter_ringball = index_counter_ringball_reg;

//===================================================
// Imagen LOGO
//===================================================
initial
$readmemh ("logo.list", colour_data_logo);//Leer datos RBG de archivo de texto, sintetiza una ROM

//Imprime la imagen de hora dentro de la región
assign pic_logo_on = (pixel_x<=pic_logo_XR)&&(pixel_y<=pic_logo_YB);//Para saber cuando se está imprimiendo la imagen

always@*
	begin
		if(pic_logo_on)
			begin
			index_counter_logo_next = index_counter_logo_reg + 1'b1;
			end
			
		else
			begin
			index_counter_logo_next = 0;
			end
	end

assign index_counter_logo = index_counter_logo_reg;

//------------------------------------------------------------------------------------------------------------------------

//Multiplexa el RGB
always @*
begin	
	if(~video_on)
		pic_RGB_aux = 12'b0;//fondo negro
	
	else 
		if(pic_hora_on) pic_RGB_aux = colour_data_hora[index_counter_hora];
		else if (pic_timer_on) pic_RGB_aux = colour_data_timer[index_counter_timer];
		else if (pic_ring_on) pic_RGB_aux = colour_data_ring[index_counter_ring];
		else if (pic_ringball_on) pic_RGB_aux = colour_data_ringball[index_counter_ringball];
		else if (pic_logo_on) pic_RGB_aux = colour_data_logo[index_counter_logo];
		else pic_RGB_aux = 12'b0;//fondo negro	
end

//assign pic_RGB = 	{pic_RGB_aux[7:5],1'b0,pic_RGB_aux[4:2],1'b0,pic_RGB_aux[1:0],2'b0};	//Rellena pic_RGB para pasar de 8 bits a 12 bits
assign pic_RGB = pic_RGB_aux;//Para 8 bits (Nexys 3)
assign pic_on = pic_hora_on | pic_timer_on| pic_ring_on| pic_ringball_on| pic_logo_on;

endmodule
