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
	input [7:0]port_id,in_dato,
	input write_strobe,read_strobe,
	output reg_a_d,reg_cs,reg_rd,reg_wr,
	output reg[7:0]out_dato,
	output flag_done,
	inout [7:0]dato
	
    );
 

reg en_funcion;
reg [7:0]addr_RAM,dato_escribir;
wire [7:0]dato_leido;
reg [7:0]next_out_dato;
reg [7:0]reg_addr_RAM, reg_dato_escribir,reg_dato_leido;
reg reg_escribir_leer,escribir_leer;
wire direccion_dato;
/// I/O Datos
Driver_bus_bidireccional instance_driver_bus_bidireccional (
    .in_flag_escritura(~reg_wr), 
    .in_flag_lectura(~reg_rd), 
    .in_direccion_dato(direccion_dato), 
    .in_dato(dato_escribir), 
    .out_reg_dato(dato_leido),  
    .addr_RAM(addr_RAM), 
    .dato(dato)
    );

//Generador de se�ales de control
signal_control_rtc_generator instance_signal_control_rtc_generator (
    .clk(clk), 
    .reset(reset), 
    .in_escribir_leer(escribir_leer), 
    .en_funcion(en_funcion), 
    .reg_a_d(reg_a_d), 
    .reg_cs(reg_cs), 
    .reg_wr(reg_wr), 
    .reg_rd(reg_rd), 
    .out_direccion_dato(direccion_dato), 
    .flag_done(flag_done)
    );



// logica secuencial
always@(negedge clk , posedge reset) begin
	if (reset)begin
		addr_RAM <= 8'h0;
		dato_escribir <= 8'h0;
		escribir_leer <= 1'b0;
		out_dato <= 8'b0;
	end
	else begin
		addr_RAM <= reg_addr_RAM;
		dato_escribir <= reg_dato_escribir;
		escribir_leer <= reg_escribir_leer;
		out_dato <= next_out_dato;
		
	end
end

// logica combinacional para port_id
always@* begin

	if (~reg_rd) next_out_dato = dato_leido;
	next_out_dato = out_dato;
	
	if ( write_strobe == 1'b1 || read_strobe == 1'b1) begin
	// inicio de secuencia de lectura_escritura rtc
	if(port_id == 8'h0E) en_funcion = 1'b1;
	else en_funcion = 1'b0;
	
	case (port_id)
	8'h00: begin //actualiza direccion
	reg_addr_RAM = in_dato;
	reg_dato_escribir = dato_escribir; 
	reg_escribir_leer = escribir_leer;
	end
	8'h01: begin // actualiza dato
	reg_dato_escribir = in_dato;
	reg_addr_RAM = addr_RAM;
	reg_escribir_leer = escribir_leer;
	end
	8'h0E: begin // inicia secuancia de rtc
	reg_addr_RAM = addr_RAM;
	reg_dato_escribir = dato_escribir;
	reg_escribir_leer = in_dato[0];
	end
	default: begin
	reg_addr_RAM = addr_RAM;
	reg_dato_escribir = dato_escribir;
	reg_escribir_leer = escribir_leer;
	end
	endcase	
	end
	
	else begin
	reg_addr_RAM = addr_RAM;
	reg_dato_escribir = dato_escribir;
	reg_escribir_leer = escribir_leer;
	en_funcion = 1'b0;
	end
	
end


endmodule
