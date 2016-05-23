`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:58:55 05/17/2016 
// Design Name: 
// Module Name:    escritor_lector_rtc 
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
module escritor_lector_rtc(
	input clk,reset,
	input [7:0]port_id,reg_direccion_escribir,reg_dato_escribir,
	input write_strobe,read_strobe,
	output [7:0]reg_dato_leido,
	output [7:0]flag_done,
	inout dato
    );
	 
/// I/O Datos

Driver_bus_bidireccional instance_name (
    .in_flag_escritura(~reg_wr), 
    .in_flag_lectura(~reg_rd), 
    .in_dato(dato_escribir), 
    .out_dato(dato_leido), 
    .dato(dato)
    );


//Generador de señales de control
signal_control_rtc_generator instance_signal_control_rtc_generator (
    .clk(clk), 
    .reset(reset), 
    .in_escribir_leer(in_escribir_leer), 
    .en_funcion(en_funcion), 
    .reg_a_d(reg_a_d), 
    .reg_cs(reg_cs), 
    .reg_wr(reg_wr), 
    .reg_rd(reg_rd), 
    .out_direccion_dato(out_direccion_dato), 
    .flag_done(flag_done)
    );

reg en_funcion;
reg [7:0]reg_address,dato_escribir,
always@(posedge clk) begin
	if ()
end

// logica combinacional para port_id
always@* begin
	case (port_id)
	8'h00: begin 
	en_funcion = 1'b1;
	reg_address = reg_direccion_escribir;
	end
	8'h01:begin
	
	end
	endcase
	
end



endmodule
