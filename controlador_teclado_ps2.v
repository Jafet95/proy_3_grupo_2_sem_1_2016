`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:31:09 05/12/2016 
// Design Name: 
// Module Name:    controlador_teclado_ps2 
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
module controlador_teclado_ps2
(
input wire clk, reset,
input wire ps2data, ps2clk,
);

//Declaraci�n de constantes
localparam W = 2; // n�mero de bits de direcci�n del FIFO

//Declaraci�n de se�ales de conexi�n
wire rx_done_tick;
wire gotten_code_flag;
wire rd_key_code;
wire fifo_empty_flag;

receptor_teclado_ps2 instancia_receptor_teclado_ps2   
(
.clk(clk),
.reset(reset),
.ps2data(ps2data),
.ps2clk(ps2clk),
.rx_en(1'b1),
.rx_done_tick(rx_done_tick),
.dout(dout)
);

identificador_teclas instancia_identificador_teclas
(
.clk(clk),
.reset(reset),
.rx_done_tick(rx_done_tick),
.gotten_code_flag(gotten_code_flag) //Bandera para actualizar el FIFO
);

fifo
#(.B(8), // n�mero de bits de cada palabra
.W(W))  // n�mero de bits de direcci�n (capacidad m�xima 2^W) 

instancia_fifo
(
.clk(clk),
.reset(reset),
.rd(rd_key_code),//Se�al de lectura del FIFO
.wr(gotten_code_flag),//Se�al de escritura del FIFO
.r_data(key_code)
);

keycode_to_ascii instancia_keycode_to_ascii
(
.key_code(key_code),
.ascii_code(ascii_code)
);

assign rd_key_code = ~fifo_empty_flag;
endmodule
