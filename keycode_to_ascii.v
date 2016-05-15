`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jafet Chaves Barrantes
// 
// Create Date:    16:24:58 05/12/2016 
// Design Name: 
// Module Name:    keycode_to_ascii 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: Circuito combinacional que decodifica el código de tecla a código ASCII
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module keycode_to_ascii
(
input wire [7:0] key_code,
output reg [7:0] ascii_code
);

always@*
begin

	case(key_code)
		8'h05: ascii_code = 8'h21;//F1(!)
		8'h06: ascii_code = 8'h22;//F2(")
		8'h1c: ascii_code = 8'h41;//A
		8'h23: ascii_code = 8'h44;//D
		8'h2b: ascii_code = 8'h46;//F
		8'h33: ascii_code = 8'h48;//H
		8'h3a: ascii_code = 8'h4d;//M
		8'h2d: ascii_code = 8'h52;//R
		8'h1b: ascii_code = 8'h53;//S
		8'h2c: ascii_code = 8'h54;//T
		8'h2e: ascii_code = 8'h48;//flecha abajo (5)
		8'h25: ascii_code = 8'h48;//flecha izquierda (4)
		8'h36: ascii_code = 8'h48;//flecha derecha (6)
		8'h3e: ascii_code = 8'h48;//flecha arriba (8)
		8'h5a: ascii_code = 8'h0d;//Enter
		default ascii_code = 8'b0;//NULL char
	endcase
end


endmodule
