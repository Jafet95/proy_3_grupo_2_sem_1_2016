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
module generador_imagenes
(
input wire video_on,//señal que indica que se encuentra en la región visible de resolución 640x480
input wire [9:0] pixel_x, pixel_y,
output wire pic_ring_on, pic_ringball_on,
output wire pic_on,
output wire [7:0] pic_RGB
);

//Declaración de constantes
//Imagen HORA
localparam pic_hora_XL = 9'd256; //Límite izquierdo
localparam pic_hora_XR = 9'd384; //Límite derecho
localparam pic_hora_Y = 7'd64; //Límite inferior
localparam hora_size = 14'd8192;//Cuantas líneas de texto se deben leer (valor se encuentra en Matlab, variable COLOR_HEX)
localparam pic_hora_XY = 7'd64;

//Imagen FECHA
localparam pic_fecha_XL = 8'd128; //Límite izquierdo
localparam pic_fecha_XR = 8'd208; //Límite derecho
localparam pic_fecha_YT = 9'd320;	//Límite superior
localparam pic_fecha_YB = 9'd352; //Límite inferior
localparam pic_fecha_size = 12'd2560;// (80x32)
localparam pic_fecha_XY = 6'd32;

//Imagen TIMER
localparam pic_timer_XL = 9'd416; //Límite izquierdo
localparam pic_timer_XR = 9'd496; //Límite derecho
localparam pic_timer_YT = 9'd320;	//Límite superior
localparam pic_timer_YB = 9'd352; //Límite inferior
localparam pic_timer_size = 12'd2560;// (80x32)
localparam pic_timer_XY = 6'd32;

//Imagen RING
localparam pic_ring_XL = 10'd512; //Límite izquierdo
localparam pic_ring_XR = 10'd639; //Límite derecho
localparam pic_ring_YT = 8'd128;	//Límite superior
localparam pic_ring_YB = 8'd192; //Límite inferior
localparam pic_ring_size = 14'd8192;// (128x64)
localparam pic_ring_XY = 7'd64;

//Imagen RING ball
localparam pic_ringball_XL = 10'd544; //Límite izquierdo
localparam pic_ringball_XR = 10'd592; //Límite derecho
localparam pic_ringball_YT = 7'd64;	//Límite superior
localparam pic_ringball_YB = 7'd112; //Límite inferior
localparam pic_ringball_size = 12'd2304;// (48x48)
localparam pic_ringball_XY = 6'd48;

//Imagen LOGO
localparam pic_logo_XL = 12'd0; //Límite derecho
localparam pic_logo_XR = 8'd128; //Límite derecho
localparam pic_logo_YT = 5'd0; //Límite inferior
localparam pic_logo_YB = 5'd16; //Límite inferior
localparam pic_logo_size = 12'd2048;// (128x16)
localparam pic_logo_XY = 5'd16;

//Declaración de señales
reg [7:0] colour_data_hora [0:hora_size-1];	//datos de los colores
reg [7:0] colour_data_fecha [0:pic_fecha_size-1];	//datos de los colores
reg [7:0] colour_data_timer [0:pic_timer_size-1];	//datos de los colores
reg [7:0] colour_data_ring [0:pic_ring_size-1];	//datos de los colores
reg [7:0] colour_data_ringball [0:pic_ringball_size-1];	//datos de los colores
reg [7:0] colour_data_logo [0:pic_logo_size-1];	//datos de los colores
wire [13:0] STATE_hora; //Bits dependen de hora_size
wire [11:0] STATE_fecha; //Bits dependen de hora_size
wire [11:0] STATE_timer; //Bits dependen de hora_size
wire [13:0] STATE_ring; //Bits dependen de hora_size
wire [11:0] STATE_ringball; //Bits dependen de hora_size
wire [11:0] STATE_logo; //Bits dependen de hora_size
wire pic_hora_on, pic_fecha_on, pic_timer_on, pic_logo_on;
reg [7:0] pic_RGB_aux;

//===================================================
// Imagen HORA
//===================================================
initial 
$readmemh ("hora.list", colour_data_hora);

//Imprime la imagen de hora dentro de la región
assign pic_hora_on = (pic_hora_XL<=pixel_x)&&(pixel_x<=pic_hora_XR)&&(pixel_y<=pic_hora_Y);//Para saber cuando se está imprimiendo la imagen

assign STATE_hora = ((pixel_x-pic_hora_XL)*pic_hora_XY)+(pixel_y-pic_hora_Y); //Para generar el índice de la memoria

//===================================================
// Imagen FECHA
//===================================================
initial
$readmemh ("fecha.list", colour_data_fecha);//Leer datos RBG de archivo de texto, sintetiza una ROM

//Imprime la imagen de hora dentro de la región
assign pic_fecha_on = (pic_fecha_XL<=pixel_x)&&(pixel_x<=pic_fecha_XR)&&(pic_fecha_YT<=pixel_y)&&(pixel_y<=pic_fecha_YB);//Para saber cuando se está imprimiendo la imagen

assign STATE_fecha = ((pixel_x-pic_fecha_XL)*pic_fecha_XY)+(pixel_y-pic_fecha_YT); //Para generar el índice de la memoria

//===================================================
// Imagen TIMER
//===================================================
initial
$readmemh ("timer.list", colour_data_timer);//Leer datos RBG de archivo de texto, sintetiza una ROM

//Imprime la imagen de hora dentro de la región
assign pic_timer_on = (pic_timer_XL<=pixel_x)&&(pixel_x<=pic_timer_XR)&&(pic_timer_YT<=pixel_y)&&(pixel_y<=pic_timer_YB);//Para saber cuando se está imprimiendo la imagen

assign STATE_timer = ((pixel_x-pic_timer_XL)*pic_timer_XY)+(pixel_y-pic_timer_YT); //Para generar el índice de la memoria

//===================================================
// Imagen RING
//===================================================
initial
$readmemh ("ring.list", colour_data_ring);//Leer datos RBG de archivo de texto, sintetiza una ROM

//Imprime la imagen de hora dentro de la región
assign pic_ring_on = (pic_ring_XL<=pixel_x)&&(pixel_x<=pic_ring_XR)&&(pic_ring_YT<=pixel_y)&&(pixel_y<=pic_ring_YB);//Para saber cuando se está imprimiendo la imagen

assign STATE_ring = ((pixel_x-pic_ring_XL)*pic_ring_XY)+(pixel_y-pic_ring_YT); //Para generar el índice de la memoria

//===================================================
// Imagen RING BALL
//===================================================
initial
$readmemh ("ring_ball_2.list", colour_data_ringball);//Leer datos RBG de archivo de texto, sintetiza una ROM

//Imprime la imagen de hora dentro de la región
assign pic_ringball_on = (pic_ringball_XL<=pixel_x)&&(pixel_x<=pic_ringball_XR)&&(pic_ringball_YT<=pixel_y)&&(pixel_y<=pic_ringball_YB);//Para saber cuando se está imprimiendo la imagen

assign STATE_ringball = ((pixel_x-pic_ringball_XL)*pic_ringball_XY)+(pixel_y-pic_ringball_YT); //Para generar el índice de la memoria

//===================================================
// Imagen LOGO
//===================================================
initial
$readmemh ("logo.list", colour_data_logo);//Leer datos RBG de archivo de texto, sintetiza una ROM

//Imprime la imagen de hora dentro de la región
assign pic_logo_on = (pixel_x<=pic_logo_XR)&&(pixel_y<=pic_logo_YB);//Para saber cuando se está imprimiendo la imagen

assign STATE_logo = ((pixel_x-pic_logo_XL)*pic_logo_XY)+(pixel_y-pic_logo_YT); //Para generar el índice de la memoria


//Multiplexa el RGB
always @*
begin	
	if(~video_on)
		pic_RGB_aux = 8'b0;//fondo negro
	
	else 
		if(pic_hora_on) pic_RGB_aux = colour_data_hora[{STATE_hora}];
		else if (pic_fecha_on) pic_RGB_aux = colour_data_fecha[{STATE_fecha}];
		else if (pic_timer_on) pic_RGB_aux = colour_data_timer[{STATE_timer}];
		else if (pic_ring_on) pic_RGB_aux = colour_data_ring[{STATE_ring}];
		else if (pic_ringball_on) pic_RGB_aux = colour_data_ringball[{STATE_ringball}];
		else if (pic_logo_on) pic_RGB_aux = colour_data_logo[{STATE_logo}];
		else pic_RGB_aux = 8'b0;//fondo negro	
end
//assign pic_RGB = 	{pic_RGB_aux[7:5],1'b0,pic_RGB_aux[4:2],1'b0,pic_RGB_aux[1:0],2'b0};	//Rellena pic_RGB para pasar de 8 bits a 12 bits
assign pic_RGB = pic_RGB_aux;//Para 8 bits (Nexys 3)
assign pic_on = pic_hora_on | pic_timer_on | pic_fecha_on | pic_logo_on;

endmodule
