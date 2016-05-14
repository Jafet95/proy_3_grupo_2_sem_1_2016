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
input wire video_on,//señal que indica que se encuentra en la región visible de resolución 640x480
input wire [9:0] pixel_x, pixel_y,
output wire pic_on,
output wire [11:0] pic_RGB
);

//Declaración de constantes
localparam pic_hora_XL = 256; //Límite izquierdo
localparam pic_hora_XR = 384; //Límite derecho
localparam pic_hora_Y = 64; //Límite inferior
localparam hora_size = 8192;//Cuantas líneas de texto se deben leer (valor se encuentra en Matlab, variable COLOR_HEX)
localparam X = 10'd280;
localparam Y = 10'd200;
localparam  pic_hora_XY = 10'd80;

//Declaración de señales
reg [7:0] colour_data [0:hora_size-1];	//datos de los colores
wire [13:0] STATE;//Bits dependen de hora_size
reg [7:0] pic_RGB_aux;

initial
$readmemh ("hora.list", colour_data);

//Imprime la imagen de hora dentro de la región
assign pic_on = (pic_hora_XL<=pixel_x)&&(pixel_x<=pic_hora_XR)&&(pixel_y<=pic_hora_Y);//Para saber cuando se está imprimiendo la imagen

assign STATE = (pixel_x-X)*pic_hora_XY+(pixel_y-Y); //Para generar el índice de la memoria

//Multiplexa el RGB
always @*
begin	
	if(~video_on)
		pic_RGB_aux = 12'b0;//fondo negro
	
	else 
		if(pic_on) pic_RGB_aux = colour_data[{STATE}];
		else pic_RGB_aux = 12'b0;//fondo negro	
end
assign pic_RGB = 	{pic_RGB_aux[7:5],1'b0,pic_RGB_aux[4:2],1'b0,pic_RGB_aux[1:0],2'b0};	//Rellena pic_RGB para pasar de 8 bits a 12 bits
endmodule
