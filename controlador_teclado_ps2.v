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

//Declaración de señales de conexión
wire [10:0] dout;
wire rx_done_tick;
wire gotten_code_flag;
wire [7:0] key_code;
reg [7:0] key_code_reg, key_code_next;

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
.dout(dout[8:1]),//Utilizar solo los bits que realmente contienen el código de la tecla [8:1]
.gotten_code_flag(gotten_code_flag) //Bandera para actualizar el FIFO
);

keycode_to_ascii instancia_keycode_to_ascii
(
.key_code(key_code),
.ascii_code(ascii_code)
);

//===================================================
// Registro para conservar la última tecla presionada
//===================================================

//Secuencial
always@(posedge clk)
	begin
		if(reset)
			key_code_reg <= 8'b0;
		else
			key_code_reg <= key_code_next;
	end
//Lógica de estado siguiente
always@*
	begin
		case(gotten_code_flag)
			1'b0://Hold
				key_code_next = key_code_reg;
			1'b1://Escribe
				key_code_next = dout[8:1]; //Utilizar solo los bits que realmente contienen el código de la tecla
		endcase
	end
assign key_code = key_code_reg;
endmodule
