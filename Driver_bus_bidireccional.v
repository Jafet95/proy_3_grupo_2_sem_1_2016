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
	input in_flag_escritura,//bandera para capturar dato
	input in_flag_lectura,
	input [7:0]in_dato,//Datos de entrada para rtc
	output reg [7:0]out_dato,//Datos de salida para banco de registros
	inout tri [7:0]dato //Dato de RTC
	
    );
 
//*********************************************************
 reg [7:0]dato_secundario;
// ASIGNACION DE BUS DE 3 ESTADOS
assign dato = (in_flag_escritura)? dato_secundario : 8'bZ;

 
//CONTROLADOR DE SALIDA
always @(*)begin
	case({in_flag_escritura,in_flag_lectura})
		2'b00: begin dato_secundario = 8'd0; // SIN ACCION
		out_dato = 8'b0;
		end
		2'b01: begin dato_secundario = 8'd0;//LEER DATO
		out_dato = dato;
		end 
		2'b10: begin dato_secundario = in_dato;// ESCRIBIR DATO
		out_dato = 8'd0;
		end 
		2'b11: begin  dato_secundario = 8'd0;// SIN ACCION
		out_dato = 8'd0;
	end
	endcase	
end

endmodule
