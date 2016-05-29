`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:26:26 05/17/2016 
// Design Name: 
// Module Name:    Driver_bus_bidireccional 
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
module Driver_bus_bidireccional(
	input clk,
	input in_flag_escritura,//bandera para capturar dato
	input in_flag_lectura,
	input in_direccion_dato,
	input [7:0]in_dato,//Datos de entrada para rtc
	output reg [7:0]out_reg_dato,//Datos de salida para banco de registros
	input [7:0]addr_RAM,//Dato de direccion para RAM
	inout tri [7:0]dato //Dato de RTC
    );
 
reg [7:0]dato_secundario;
reg [7:0]next_out_dato;
//*********************************************************
 
// ASIGNACION DE BUS DE 3 ESTADOS
assign dato = (in_flag_escritura)? dato_secundario : 8'bZ;

//LOGICA SECUENCIAL
always@(posedge clk) begin
	out_reg_dato <= next_out_dato;
end

//CONTROLADOR DE SALIDA
always @(*)
begin
	case({in_flag_escritura,in_flag_lectura,in_direccion_dato})
		3'b000: begin dato_secundario = 8'd0; //NO DEBE PASAR
		next_out_dato = out_reg_dato;
		end
		3'b011: begin dato_secundario = 8'd0;//LEER DATO
		next_out_dato = dato;
		end 
		3'b100: begin dato_secundario = addr_RAM;// ESCRIBIR DIRECCION RAM
		next_out_dato = out_reg_dato;
		end 
		3'b101: begin  dato_secundario = in_dato;// ESCRIBE DATO
		next_out_dato = out_reg_dato;
		end
		default: begin
		dato_secundario = 8'd0; //NO DEBE PASAR
		next_out_dato = out_reg_dato;
		end
	
	endcase
end


endmodule
