`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jafet Chaves Barrantes
// 
// Create Date:    11:22:27 03/22/2016 
// Design Name: 
// Module Name:    generador_figuras 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: Este m�dulo debe encargarse de generar recuadros que encierran a la hora, fecha, timer,
//as� como la figura de "ring" para el timer.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module generador_figuras
(
input wire video_on,//se�al que indica que se encuentra en la regi�n visible de resoluci�n 640x480
input wire [9:0] pixel_x, pixel_y,//coordenadas xy de cada pixel
output wire graph_on,
output reg [7:0] fig_RGB //8 bpp (Nexys 3)
);

//Declaraci�n de constantes y se�ales

//Coordenas xy de la regi�n visible
localparam MAX_X = 640;
localparam MAX_Y = 480;

//L�mites del recuadro para la hora (320x192)
localparam BOX_H_XL = 160; //L�mite izquierdo
localparam BOX_H_XR = 479; //L�mite derecho
localparam BOX_H_YT = 64;// L�mite superior
localparam BOX_H_YB = 255;//L�mite inferior

//L�mites del recuadro para la fecha (256x96)
localparam BOX_F_XL = 48;//L�mite izquierdo
localparam BOX_F_XR = 303;//L�mite derecho
localparam BOX_F_YT = 352;//L�mite superior
localparam BOX_F_YB = 447;//L�mite inferior

//L�mites del recuadro para el timer (256x96)
localparam BOX_T_XL = 336;//L�mite izquierdo
localparam BOX_T_XR = 591;//L�mite derecho
localparam BOX_T_YT = 352;//L�mite superior
localparam BOX_T_YB = 447;//L�mite inferior

//Se�ales de salida de los objetos
wire BOX_H_on, BOX_F_on, BOX_T_on;
wire [7:0] BOX_H_RGB, BOX_F_RGB, BOX_T_RGB;

/*Para rellenar con p�xeles dentro de los l�mites 
de los objetos*/

//Recuadro HORA
assign BOX_H_on = (BOX_H_XL<=pixel_x)&&(pixel_x<=BOX_H_XR)
						&&(BOX_H_YT<=pixel_y)&&(pixel_y<=BOX_H_YB);

assign BOX_H_RGB = 8'h1E;//Turquesa oscuro

//Recuadro FECHA
assign BOX_F_on = (BOX_F_XL<=pixel_x)&&(pixel_x<=BOX_F_XR)
						&&(BOX_F_YT<=pixel_y)&&(pixel_y<=BOX_F_YB);

assign BOX_F_RGB = 8'h1E;//Turquesa oscuro

//Recuadro TIMER
assign BOX_T_on = (BOX_T_XL<=pixel_x)&&(pixel_x<=BOX_T_XR)
						&&(BOX_T_YT<=pixel_y)&&(pixel_y<=BOX_T_YB);

assign BOX_T_RGB = 8'h1E;//Turquesa oscuro

//Multiplexar la salida RGB
always @*
begin	
	if(~video_on)
		fig_RGB = 8'b0;//fondo negro
	
	else
		if (BOX_H_on) fig_RGB = BOX_H_RGB;
		else if (BOX_F_on) fig_RGB = BOX_F_RGB;
		else if (BOX_T_on) fig_RGB = BOX_T_RGB;
		else fig_RGB = 8'b0;//fondo negro
end

assign graph_on = BOX_H_on | BOX_F_on | BOX_T_on;
	
endmodule
