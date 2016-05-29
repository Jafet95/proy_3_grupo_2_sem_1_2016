`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:49:19 05/27/2016 
// Design Name: 
// Module Name:    prueba_lectura_rtc 
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
module prueba_lectura_rtc
(
input wire clk, reset,
inout [7:0]dato,
output wire AD, CS, WR, RD,
output [7:0]port_id,out_port,wire_in_port,
output reg[7:0]fin_lectura_escritura,
output hold_seg_hora,
output [7:0] RGB,
output hsync, vsync
); 

//Conexiones internas
reg [7:0]in_port;
assign wire_in_port = in_port;
//wire [7:0]out_port;
//wire [7:0]port_id;
wire write_strobe;
wire k_write_strobe;
wire read_strobe;
wire interrupt;
// conexiones banco de registros a VGA
wire [7:0]out_seg_hora,out_min_hora,out_hora_hora;
wire [7:0]out_dia_fecha,out_mes_fecha,out_jahr_fecha,out_dia_semana;
wire [7:0]out_seg_timer,out_min_timer,out_hora_timer;

//////////////////////////// hold's
//wire hold_seg_hora; 
wire hold_min_hora; 
wire hold_hora_hora; 
wire hold_dia_fecha; 
wire hold_mes_fecha; 
wire hold_jahr_fecha; 
wire hold_dia_semana; 
wire hold_seg_timer;
wire hold_min_timer; 
wire hold_hora_timer;
// wire hold_banderas_config;
//////////////////////


wire flag_done;
//reg [7:0]fin_lectura_escritura;
wire [7:0]wire_out_dato;

reg state_reg_flag,state_next_flag;

assign interrupt = 1'b0;

microcontrolador instancia_microcontrolador 
(
    .clk(clk), 
    .reset(reset), 
    .interrupt(interrupt), 
    .in_port(in_port), 
    .write_strobe(write_strobe), 
    .k_write_strobe(), 
    .read_strobe(read_strobe), 
    .interrupt_ack(), 
    .port_id(port_id), 
    .out_port(out_port)
);

controlador_VGA instancia_controlador_VGA 
(
    .clock(clk), 
    .reset(reset), 
    .digit0_HH(out_hora_hora[3:0]), .digit1_HH(out_hora_hora[7:4]), .digit0_MM(out_min_hora[3:0]), .digit1_MM(out_min_hora[7:4]), .digit0_SS(out_seg_hora[3:0]), .digit1_SS(out_seg_hora[7:4]),//
	 .digit0_DAY(out_dia_fecha[3:0]), .digit1_DAY(out_dia_fecha[7:4]), .digit0_MES(out_mes_fecha[3:0]), .digit1_MES(out_mes_fecha[7:4]), .digit0_YEAR(out_jahr_fecha[3:0]), .digit1_YEAR(out_jahr_fecha[7:4]),//
	 .digit0_HH_T(out_hora_timer[3:0]), .digit1_HH_T(out_hora_timer[7:4]), .digit0_MM_T(out_min_timer[3:0]), .digit1_MM_T(out_min_timer[7:4]), .digit0_SS_T(out_seg_timer[3:0]), .digit1_SS_T(out_seg_timer[7:4]),//Decenas y unidades para los números en pantalla (18 inputs de 3 bits)
    .AM_PM(1'b0), 
    .config_mode(2'b0), 
    .cursor_location(2'b0), 
    .formato_hora(1'b1), 
    .estado_alarma(1'b0), 
    .hsync(hsync), 
    .vsync(vsync), 
    .RGB(RGB)
    );

memoria_registros_VGA instancia_memoria_registros_VGA 
(
    .clk(clk), 
    .reset(reset), 
    .cs_seg_hora(1'b0), 
    .cs_min_hora(1'b0), 
    .cs_hora_hora(1'b0), 
    .cs_dia_fecha(1'b0), 
    .cs_mes_fecha(1'b0), 
    .cs_jahr_fecha(1'b0), 
    .cs_seg_timer(1'b0), 
    .cs_min_timer(1'b0), 
    .cs_hora_timer(1'b0), 
    .hold_seg_hora(hold_seg_hora), 
    .hold_min_hora(hold_min_hora), 
    .hold_hora_hora(hold_hora_hora), 
    .hold_dia_fecha(hold_dia_fecha), 
    .hold_mes_fecha(hold_mes_fecha), 
    .hold_jahr_fecha(hold_jahr_fecha), 
    .hold_seg_timer(hold_seg_timer), 
    .hold_min_timer(hold_min_timer), 
    .hold_hora_timer(hold_hora_timer), 
    .hold_banderas_config(1'b1), 
    .data_PicoBlaze(out_port), 
    .count_seg_hora(8'b0), 
    .count_min_hora(8'b0), 
    .count_hora_hora(8'b0), 
    .count_dia_fecha(8'b0), 
    .count_mes_fecha(8'b0), 
    .count_jahr_fecha(8'b0), 
    .count_seg_timer(8'b0), 
    .count_min_timer(8'b0), 
    .count_hora_timer(8'b0), 
    .out_seg_hora(out_seg_hora), 
    .out_min_hora(out_min_hora), 
    .out_hora_hora(out_hora_hora), 
    .out_dia_fecha(out_dia_fecha), 
    .out_mes_fecha(out_mes_fecha), 
    .out_jahr_fecha(out_jahr_fecha), 
    .out_seg_timer(out_seg_timer), 
    .out_min_timer(out_min_timer), 
    .out_hora_timer(out_hora_timer), 
    .out_banderas_config()
);

deco_hold_registros instancia_deco_hold_registros (
    .write_strobe(write_strobe), 
    .port_id(port_id), 
    .hold_seg_hora(hold_seg_hora), 
    .hold_min_hora(hold_min_hora), 
    .hold_hora_hora(hold_hora_hora), 
    .hold_dia_fecha(hold_dia_fecha), 
    .hold_mes_fecha(hold_mes_fecha), 
    .hold_jahr_fecha(hold_jahr_fecha), 
    .hold_seg_timer(hold_seg_timer), 
    .hold_min_timer(hold_min_timer), 
    .hold_hora_timer(hold_hora_timer)
    );
	 
escritor_lector_rtc instancia_escritor_lector_rtc (
    .clk(clk), 
    .reset(reset), 
    .port_id(port_id), 
    .in_dato(out_port), 
    .write_strobe(write_strobe), 
    .read_strobe(read_strobe), 
    .reg_a_d(AD), 
    .reg_cs(CS), 
    .reg_rd(RD), 
    .reg_wr(WR), 
    .out_dato(wire_out_dato), 
    .flag_done(flag_done), 
    .dato(dato)
    );

 always @ (posedge clk)
  begin
      case (port_id) 
			8'h0F : in_port <= fin_lectura_escritura;
			8'h10 : in_port <= wire_out_dato;
        default : in_port <= 8'bXXXXXXXX ;  
      endcase
  end
  
/// maquina de estados para manipular fin lectura escritura
always @ (negedge clk,posedge reset) begin 
	if (reset) state_reg_flag = 1'b0;
	else state_reg_flag = state_next_flag;
end

always@ (*) begin
state_next_flag = state_reg_flag;
	case (state_reg_flag)
	1'b0: begin
		fin_lectura_escritura = 8'h00;
		if (flag_done == 1) state_next_flag = 1'b1;
		else state_next_flag = 1'b0;
		end
	1'b1: begin
		fin_lectura_escritura = 8'h01;
		if(port_id == 8'h0F && read_strobe == 1)  state_next_flag = 1'b0;
		else  state_next_flag = 1'b1; 		
	end
	endcase
end
	 
	 

endmodule
