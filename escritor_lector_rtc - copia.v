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
module escritor_lector_rtc_2
(
	input wire clk,reset,
	input wire [7:0] in_dato, port_id,
	input wire write_strobe, k_write_strobe, read_strobe,
	output wire reg_a_d,reg_cs,reg_rd,reg_wr,
	output wire[7:0]out_dato,
	output reg flag_done,
	inout [7:0]dato
);

wire fin_lectura_escritura; 
reg en_funcion;
reg [7:0]addr_RAM,dato_escribir;
//wire [7:0]dato_leido;
reg [7:0]reg_addr_RAM, reg_dato_escribir,reg_dato_leido;
reg reg_escribir_leer,escribir_leer;


reg state_reg_flag,state_next_flag;//Para la m�quina de estados que controla el flag_done

wire direccion_dato;//conexi�n interna
/// I/O Datos
Driver_bus_bidireccional instance_driver_bus_bidireccional (
	 .clk(clk),
    .in_flag_escritura(~reg_wr), 
    .in_flag_lectura(~reg_rd), 
    .in_direccion_dato(direccion_dato), //bandera para saber si se debe escribir direccion/dato
    .in_dato(dato_escribir), 
    .out_reg_dato(out_dato),  
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
    .flag_done(fin_lectura_escritura)
    );
	 
//Para habilitar el generador de se�ales	 
always@(posedge clk)
begin
	if(port_id == 8'h0E) en_funcion <= 1'b1;
	else en_funcion <= 1'b0;
end

// logica secuencial
always@(negedge clk , posedge reset) begin
	if (reset)begin
		addr_RAM <= 8'h0;
		dato_escribir <= 8'h0;
		escribir_leer <= 1'b0;
	end
	else begin
		addr_RAM <= reg_addr_RAM;
		dato_escribir <= reg_dato_escribir;
		escribir_leer <= reg_escribir_leer;
		
	end
end

// logica combinacional para port_id
always@* begin
	if (write_strobe == 1'b1 || k_write_strobe == 1'b1) begin
	// inicio de secuencia de lectura_escritura rtc
	
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
	end
	
end

/// maquina de estados para manipular fin lectura escritura
always @ (negedge clk, posedge reset) begin 
	if (reset) state_reg_flag <= 1'b0;
	else state_reg_flag <= state_next_flag;
end

always@* 
begin
state_next_flag = state_reg_flag;
	case (state_reg_flag)
	1'b0: begin
		flag_done = 8'h00;
		if (fin_lectura_escritura == 1) state_next_flag = 1'b1;
		else state_next_flag = 1'b0;
		end
	1'b1: begin
		flag_done = 8'h01;
		if(port_id == 8'h0F && read_strobe == 1)  state_next_flag = 1'b0;//Cuando el micro lee el dato se baja la bandera
		else  state_next_flag = 1'b1; 		
	end
	endcase
end

endmodule
