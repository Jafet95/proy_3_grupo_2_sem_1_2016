`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jafet Chaves Barrantes
// 
// Create Date:    11:05:08 05/26/2016 
// Design Name: 
// Module Name:    microcontrolador 
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
module microcontrolador
(
input wire clk, reset,
input wire interrupt,
input wire	[7:0]	in_port,
output wire write_strobe, k_write_strobe, read_strobe,
output wire	interrupt_ack,
output wire	[7:0]	port_id,
output wire	[7:0]	out_port
);

//Conexiones entre la memoria de programa y el kcpsm6
wire	[11:0]	address;
wire	[17:0]	instruction;
wire	bram_enable;
wire	kcpsm6_sleep;         
wire	kcpsm6_reset;         
wire	rdl;

assign kcpsm6_reset = reset | rdl;
assign kcpsm6_sleep = 1'b0;

//Instanciaciones del procesador y la memoria de programa
kcpsm6 #(
.interrupt_vector	(12'h3FF),
.scratch_pad_memory_size(64),
.hwbuild		(8'h00))
instancia_processor(
.address 		(address),
.instruction 	(instruction),
.bram_enable 	(bram_enable),
.port_id 		(port_id),
.write_strobe 	(write_strobe),
.k_write_strobe 	(k_write_strobe),
.out_port 		(out_port),
.read_strobe 	(read_strobe),
.in_port 		(in_port),
.interrupt 		(interrupt),
.interrupt_ack 	(interrupt_ack),
.reset 		(kcpsm6_reset),
.sleep		(kcpsm6_sleep),
.clk 			(clk));

ROM_programa #(
.C_FAMILY		   ("S6"),   	//Family 'S6' or 'V6'
.C_RAM_SIZE_KWORDS	(2),  	//Program size '1', '2' or '4'
.C_JTAG_LOADER_ENABLE	(0))  	//Include JTAG Loader when set to '1' 
instancia_ROM_programa (    				//Name to match your PSM file
.rdl 			(rdl),
.enable 		(bram_enable),
.address 		(address),
.instruction 	(instruction),
.clk 			(clk));

endmodule
