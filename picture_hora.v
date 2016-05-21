`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jafet Chaves Barrantes
// 
// Create Date:    12:44:02 05/14/2016 
// Design Name: 
// Module Name:    picture_hora 
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
module picture_hora
(
input wire video_on,//se�al que indica que se encuentra en la regi�n visible de resoluci�n 640x480
input wire [9:0] pixel_x, pixel_y,
output wire pic_on,
output wire [7:0] pic_RGB
);

//Declaraci�n de constantes
//Imagen HORA
localparam pic_hora_XL = 13'd256; //L�mite izquierdo
localparam pic_hora_XR = 384; //L�mite derecho
localparam pic_hora_Y = 13'd64; //L�mite inferior
localparam hora_size = 14'd8192;//Cuantas l�neas de texto se deben leer (valor se encuentra en Matlab, variable COLOR_HEX)
localparam pic_hora_XY = 13'd64;

//Imagen TIMER
localparam pic_timer_XL = 416; //L�mite izquierdo
localparam pic_timer_XR = 496; //L�mite derecho
localparam pic_timer_YT = 416;	//L�mite superior
localparam pic_timer_YB = 448; //L�mite inferior
localparam pic_timer_size = 2560;// (80x32)
localparam pic_timer_XY = 32;

//Imagen RING
localparam pic_ring_XL = 512; //L�mite izquierdo
localparam pic_ring_XR = 639; //L�mite derecho
localparam pic_ring_YT = 128;	//L�mite superior
localparam pic_ring_YB = 192; //L�mite inferior
localparam pic_ring_size = 8192;// (128x64)
localparam pic_ring_XY = 64;

//Imagen RING ball
localparam pic_ringball_XL = 544; //L�mite izquierdo
localparam pic_ringball_XR = 592; //L�mite derecho
localparam pic_ringball_YT = 64;	//L�mite superior
localparam pic_ringball_YB = 112; //L�mite inferior
localparam pic_ringball_size = 2304;// (48x48)
localparam pic_ringball_XY = 48;

//Imagen LOGO
localparam pic_logo_XL = 0; //L�mite derecho
localparam pic_logo_XR = 128; //L�mite derecho
localparam pic_logo_YB = 16; //L�mite inferior
localparam pic_logo_size = 2048;// (128x16)
localparam pic_logo_XY = 16;

//Declaraci�n de se�ales
reg [7:0] colour_data_hora [0:hora_size-1];	//datos de los colores
reg [7:0] colour_data_timer [0:pic_timer_size-1];	//datos de los colores
reg [7:0] colour_data_ring [0:pic_ring_size-1];	//datos de los colores
reg [7:0] colour_data_ringball [0:pic_ringball_size-1];	//datos de los colores
reg [7:0] colour_data_logo [0:pic_logo_size-1];	//datos de los colores
wire [15:0] STATE_hora; //Bits dependen de hora_size
wire [15:0] STATE_timer; //Bits dependen de hora_size
wire [15:0] STATE_ring; //Bits dependen de hora_size
wire [15:0] STATE_ringball; //Bits dependen de hora_size
wire [15:0] STATE_logo; //Bits dependen de hora_size
wire pic_hora_on, pic_timer_on, pic_ring_on, pic_ringball_on, pic_logo_on;
reg [7:0] pic_RGB_aux;

//===================================================
// Imagen HORA
//===================================================
initial
$readmemh ("hora.list", colour_data_hora);

//Imprime la imagen de hora dentro de la regi�n
assign pic_hora_on = (pic_hora_XL<=pixel_x)&&(pixel_x<=pic_hora_XR)&&(pixel_y<=pic_hora_Y);//Para saber cuando se est� imprimiendo la imagen

assign STATE_hora = ((pixel_x-pic_hora_XL)*pic_hora_XY)+(pixel_y-pic_hora_Y); //Para generar el �ndice de la memoria

//===================================================
// Imagen TIMER
//===================================================
initial
$readmemh ("timer.list", colour_data_timer);//Leer datos RBG de archivo de texto, sintetiza una ROM

//Imprime la imagen de hora dentro de la regi�n
assign pic_timer_on = (pic_timer_XL<=pixel_x)&&(pixel_x<=pic_timer_XR)&&(pic_timer_YT<=pixel_y)&&(pixel_y<=pic_timer_YB);//Para saber cuando se est� imprimiendo la imagen

assign STATE_timer = ((pixel_x-pic_timer_XL)*pic_timer_XY)+(pixel_y-pic_timer_YB); //Para generar el �ndice de la memoria

//===================================================
// Imagen RING
//===================================================
initial
$readmemh ("ring.list", colour_data_ring);//Leer datos RBG de archivo de texto, sintetiza una ROM

//Imprime la imagen de hora dentro de la regi�n
assign pic_ring_on = (pic_ring_XL<=pixel_x)&&(pixel_x<=pic_ring_XR)&&(pic_ring_YT<=pixel_y)&&(pixel_y<=pic_ring_YB);//Para saber cuando se est� imprimiendo la imagen

assign STATE_ring = ((pixel_x-pic_ring_XL)*pic_ring_XY)+(pixel_y-pic_ring_YB); //Para generar el �ndice de la memoria

//===================================================
// Imagen RING BALL
//===================================================
initial
$readmemh ("ring_ball.list", colour_data_ringball);//Leer datos RBG de archivo de texto, sintetiza una ROM

//Imprime la imagen de hora dentro de la regi�n
assign pic_ringball_on = (pic_ringball_XL<=pixel_x)&&(pixel_x<=pic_ringball_XR)&&(pic_ringball_YT<=pixel_y)&&(pixel_y<=pic_ringball_YB);//Para saber cuando se est� imprimiendo la imagen

assign STATE_ringball = ((pixel_x-pic_ringball_XL)*pic_ringball_XY)+(pixel_y-pic_ringball_YB); //Para generar el �ndice de la memoria

//===================================================
// Imagen LOGO
//===================================================
initial
$readmemh ("logo.list", colour_data_logo);//Leer datos RBG de archivo de texto, sintetiza una ROM

//Imprime la imagen de hora dentro de la regi�n
assign pic_logo_on = (pixel_x<=pic_logo_XR)&&(pixel_y<=pic_logo_YB);//Para saber cuando se est� imprimiendo la imagen

assign STATE_logo = ((pixel_x-pic_logo_XL)*pic_logo_XY)+(pixel_y-pic_logo_YB); //Para generar el �ndice de la memoria


//Multiplexa el RGB
always @*
begin	
	if(~video_on)
		pic_RGB_aux = 8'b0;//fondo negro
	
	else 
		if(pic_hora_on) pic_RGB_aux = colour_data_hora[{STATE_hora}];
		else if (pic_timer_on) pic_RGB_aux = colour_data_timer[{STATE_timer}];
		else if (pic_ring_on) pic_RGB_aux = colour_data_ring[{STATE_ring}];
		else if (pic_ringball_on) pic_RGB_aux = colour_data_ringball[{STATE_ringball}];
		else if (pic_logo_on) pic_RGB_aux = colour_data_logo[{STATE_logo}];
		else pic_RGB_aux = 8'b0;//fondo negro	
end
//assign pic_RGB = 	{pic_RGB_aux[7:5],1'b0,pic_RGB_aux[4:2],1'b0,pic_RGB_aux[1:0],2'b0};	//Rellena pic_RGB para pasar de 8 bits a 12 bits
assign pic_RGB = pic_RGB_aux;//Para 8 bits (Nexys 3)
assign pic_on = pic_hora_on | pic_timer_on| pic_ring_on| pic_ringball_on| pic_logo_on;

endmodule
