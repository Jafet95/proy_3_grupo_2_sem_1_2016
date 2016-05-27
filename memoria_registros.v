`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:23:16 04/12/2016 
// Design Name: 
// Module Name:    memoria_registros 
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
module memoria_registros_VGA
( 
	input clk, reset,
	
	input cs_seg_hora,cs_min_hora,cs_hora_hora,
	input cs_dia_fecha,cs_mes_fecha,cs_jahr_fecha,
	input cs_seg_timer,cs_min_timer,cs_hora_timer,
	
	input hold_seg_hora,hold_min_hora,hold_hora_hora,
	input hold_dia_fecha,hold_mes_fecha,hold_jahr_fecha,
	input hold_seg_timer,hold_min_timer,hold_hora_timer,
	
	input hold_banderas_config,
	
	input [7:0] data_PicoBlaze,
	
	input [7:0] count_seg_hora,count_min_hora,count_hora_hora,
	input [7:0] count_dia_fecha,count_mes_fecha,count_jahr_fecha,
	input [7:0] count_seg_timer,count_min_timer,count_hora_timer,
	
	output [7:0] out_seg_hora,out_min_hora,out_hora_hora,
	output [7:0] out_dia_fecha,out_mes_fecha,out_jahr_fecha,
	output [7:0] out_seg_timer,out_min_timer,out_hora_timer,
	
	output[7:0] out_banderas_config
);
	 
//wire flag1,flag2,flag3;
reg flag_done_timer;
//assign flag_done_timer = (flag1 && flag2 && flag3)? 1'b1:1'b0;
wire cs_banderas_config;

assign cs_banderas_config = 1'b0;
 
////////instancia reg seg_hora
Registro_Universal #(.N(8))
instancia_seg_hora (
	 .hold(hold_seg_hora),
    .in_rtc_dato(data_PicoBlaze), 
    .in_count_dato(count_seg_hora), 
    .clk(clk), 
    .reset(reset), 
    .chip_select(cs_seg_hora), 
    .out_dato(out_seg_hora)
    );
////////instancia reg min_hora
Registro_Universal #(.N(8))
 instancia_min_hora (
	 .hold(hold_min_hora),
    .in_rtc_dato(data_PicoBlaze), 
    .in_count_dato(count_min_hora), 
    .clk(clk), 
    .reset(reset), 
    .chip_select(cs_min_hora), 
    .out_dato(out_min_hora)
    );
////////instancia reg hora_hora
Registro_Universal #(.N(8))
instancia_hora_hora (
	 .hold(hold_hora_hora),
    .in_rtc_dato(data_PicoBlaze), 
    .in_count_dato(count_hora_hora), 
    .clk(clk), 
    .reset(reset), 
    .chip_select(cs_hora_hora), 
    .out_dato(out_hora_hora)
    );
////////instancia reg dia_fecha
Registro_Universal #(.N(8))
instancia_dia_fecha (
	 .hold(hold_dia_fecha),
    .in_rtc_dato(data_PicoBlaze), 
    .in_count_dato(count_dia_fecha), 
    .clk(clk), 
    .reset(reset), 
    .chip_select(cs_dia_fecha), 
    .out_dato(out_dia_fecha)
    );
////////instancia reg mes_fecha
Registro_Universal #(.N(8))
instancia_mes_fecha (
	 .hold(hold_mes_fecha),
    .in_rtc_dato(data_PicoBlaze), 
    .in_count_dato(count_mes_fecha), 
    .clk(clk), 
    .reset(reset),  
    .chip_select(cs_mes_fecha), 
    .out_dato(out_mes_fecha)
    );
////////instancia reg jahr_fecha
Registro_Universal #(.N(8))
instancia_jahr_fecha (
	 .hold(hold_jahr_fecha),	
    .in_rtc_dato(data_PicoBlaze), 
    .in_count_dato(count_jahr_fecha), 
    .clk(clk), 
    .reset(reset), 
    .chip_select(cs_jahr_fecha), 
    .out_dato(out_jahr_fecha)
    );
////////instancia reg seg_timer
Registro_Universal #(.N(8))
instancia_seg_timer (
	 .hold(hold_seg_timer),
    .in_rtc_dato(data_PicoBlaze), 
    .in_count_dato(count_seg_timer), 
    .clk(clk), 
    .reset(reset), 
    .chip_select(cs_seg_timer),
    .out_dato(out_seg_timer) 
    );
////////instancia reg min_timer
Registro_Universal #(.N(8))
instancia_min_timer (
	 .hold(hold_min_timer),
    .in_rtc_dato(data_PicoBlaze), 
    .in_count_dato(count_min_timer), 
    .clk(clk), 
    .reset(reset), 
    .chip_select(cs_min_timer), 
    .out_dato(out_min_timer)
    );
////////instancia reg hora_timer
Registro_Universal #(.N(8))
instancia_hora_timer(
	 .hold(hold_hora_timer),
    .in_rtc_dato(data_PicoBlaze), 
    .in_count_dato(count_hora_timer), 
    .clk(clk), 
    .reset(reset), 
    .chip_select(cs_hora_timer),
    .out_dato(out_hora_timer)
    );
////////instancia reg banderas_config
Registro_Universal #(.N(8))
instancia_bandera_config(
	 .hold(hold_banderas_config),
    .in_rtc_dato(data_PicoBlaze), 
    .in_count_dato(8'b0), 
    .clk(clk), 
    .reset(reset), 
    .chip_select(cs_banderas_config),
    .out_dato(out_banderas_config)
    );

/*
//Para generar flag_done_timer
always@(posedge clk)
begin
	if(reset) flag_done_timer <= 1'b0;
	else if((rtc_seg_timer == count_seg_timer)&&(rtc_min_timer == count_min_timer)&&((count_hora_timer!=0)||(count_min_timer!=0)||(count_seg_timer!=0))&&(estado_alarma==0)) flag_done_timer <= 1'b1;
	else flag_done_timer <= 1'b0;
end
	 
	 
///////  FSM para alarma timer //////////

localparam [1:0]
espera_conf = 2'b00,
conf = 2'b01,
timer_run = 2'b10,
alarma_on = 2'b11;

reg [1:0] state_reg , state_next;
//// secuancial
always@(posedge clk , posedge reset) 
begin
if (reset) state_reg = espera_conf;
else state_reg = state_next;
end
/// combinacional
always@*
begin
state_next = state_reg ; 
case (state_reg)
	espera_conf: begin
	flag_mostrar_count = 1'b1;
	estado_alarma = 1'b0;
		if(sw2) state_next = conf;
		else state_next = espera_conf;
	end
	conf: begin
	flag_mostrar_count = 1'b1;
	estado_alarma = 1'b0;
	if(~sw2) state_next = timer_run;
	else state_next = conf;
	end
	timer_run: begin
	flag_mostrar_count = 1'b0;
	estado_alarma = 1'b0;
	if (flag_done_timer) state_next = alarma_on;
	else state_next = timer_run;
	end
	alarma_on: begin
	flag_mostrar_count = 1'b1;
	estado_alarma = 1'b1;
	if (desactivar_alarma) state_next = espera_conf;
	else state_next = alarma_on;
	end
endcase
end

/////////////////////////////////////////
*/
endmodule 
