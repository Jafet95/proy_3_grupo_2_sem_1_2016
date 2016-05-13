`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jafet Chaves Barrantes
// 
// Create Date:    14:31:45 05/12/2016 
// Design Name: 
// Module Name:    identificador_teclas 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: FSM que evalúa la detección el "break code" F0, y extraer codigo de la tecla correspondiente (código siguiente)
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module identificador_teclas
(
input wire clk, reset,
input wire rx_done_tick,
input wire [7:0] dout,//Utilizar solo los bits que realmente contienen el código de la tecla
output reg gotten_code_flag //Bandera para actualizar el FIFO
);

//Declaración de constantes
localparam break_code = 8'hF0;

//Declaración simbólica de estados
localparam wait_break_code = 1'b0;
localparam get_code = 1'b1;

//Declaración de señales
reg state_next, state_reg;

//=================================================
// FSM
//=================================================

// Estado FSM y registros de datos

always @(posedge clk, posedge reset)
	if (reset)
		state_reg <= wait_break_code;
	else
		state_reg <= state_next;
		
// Lógica de siguiente estado siguiente de la FSM
always @*
begin
	gotten_code_flag = 1'b0;
	state_next = state_reg;
	case (state_reg)
		wait_break_code:  // Espera "break code"
			if (rx_done_tick == 1'b1 && dout == break_code)
				state_next = get_code;
		get_code:  // Obtener el próximo código
			if (rx_done_tick)
				begin
					gotten_code_flag =1'b1;
					state_next = wait_break_code;
				end
	endcase
end
		
endmodule
