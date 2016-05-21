`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:22:07 05/17/2016 
// Design Name: 
// Module Name:    prueba_imagenes 
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
module prueba_imagenes
(
input wire clk, reset,
output wire hsync,vsync,pic_on,pixel_tick,
output wire [7:0] RGB
);

wire video_on;
wire [9:0] pixel_x, pixel_y;
//reg [11:0] RGB_reg, RGB_next;

timing_generator_VGA instancia_timing_generator_VGA
(
.clk(clk),.reset(reset),
.hsync(hsync),.vsync(vsync),.video_on(video_on),.p_tick(pixel_tick),
.pixel_x(pixel_x), .pixel_y(pixel_y)
);

picture_hora instancia_picture_hora
(
.video_on(video_on),//señal que indica que se encuentra en la región visible de resolución 640x480
.pixel_x(pixel_x), .pixel_y(pixel_y),
.pic_on(pic_on),
.pic_RGB(RGB)
);


endmodule
