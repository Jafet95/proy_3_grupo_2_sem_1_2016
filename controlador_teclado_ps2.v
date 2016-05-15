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
output wire [7:0] ascii_code
);

//Declaración de constantes
localparam W = 2; // número de bits de dirección del FIFO
localparam B = 8; // Tamaño de la dirección del FIFO

//Declaración de señales de conexión
wire [10:0] dout;
wire rx_done_tick;
wire gotten_code_flag;
wire rd_key_code;
wire fifo_empty_flag;
wire [7:0] key_code;

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
.dout(dout[8:1]),//Utilizar solo los bits que realmente contienen el código de la tecla
.gotten_code_flag(gotten_code_flag) //Bandera para actualizar el FIFO
);

fifo
#(.B(B), // número de bits de cada palabra
.W(W))  // número de bits de dirección (capacidad máxima 2^W) 

instancia_fifo
(
.clk(clk),
.reset(reset),
.rd(rd_key_code),//Señal de lectura del FIFO
.wr(gotten_code_flag),//Señal de escritura del FIFO
.w_data(dout[8:1]),
.empty(fifo_empty_flag),
.full(),
.r_data(key_code)
);

keycode_to_ascii instancia_keycode_to_ascii
(
.key_code(key_code),
.ascii_code(ascii_code)
);

assign rd_key_code = ~fifo_empty_flag;//Si no está vacío se lee el FIFO
endmodule
