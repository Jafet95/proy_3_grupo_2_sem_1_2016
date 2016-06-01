`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:18:15 04/12/2016 
// Design Name: 
// Module Name:    deco_hold_registros 
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
module deco_hold_registros(
	input write_strobe,
	input [7:0]port_id,
	output reg hold_seg_hora,
	output reg hold_min_hora,
	output reg hold_hora_hora,
	output reg hold_dia_fecha,
	output reg hold_mes_fecha,
	output reg hold_jahr_fecha,
	output reg hold_seg_timer,
	output reg hold_min_timer,
	output reg hold_hora_timer,
	output reg hold_banderas_config
    );
	 
always@*
begin
if (write_strobe == 1'b1)begin
	case(port_id)
		8'h03: begin
			hold_seg_hora = 1'b0;
			hold_min_hora= 1'b1;
			hold_hora_hora= 1'b1;
			hold_dia_fecha= 1'b1;
			hold_mes_fecha= 1'b1;
			hold_jahr_fecha= 1'b1;
			hold_seg_timer= 1'b1;
			hold_min_timer= 1'b1;
			hold_hora_timer= 1'b1;
			hold_banderas_config= 1'b1;
		end
		8'h04:begin
			hold_seg_hora = 1'b1;
			hold_min_hora= 1'b0;
			hold_hora_hora= 1'b1;
			hold_dia_fecha= 1'b1;
			hold_mes_fecha= 1'b1;
			hold_jahr_fecha= 1'b1;
			hold_seg_timer= 1'b1;
			hold_min_timer= 1'b1;
			hold_hora_timer= 1'b1;
			hold_banderas_config= 1'b1;
		end
		8'h05: begin
			hold_seg_hora = 1'b1;
			hold_min_hora= 1'b1;
			hold_hora_hora= 1'b0;
			hold_dia_fecha= 1'b1;
			hold_mes_fecha= 1'b1;
			hold_jahr_fecha= 1'b1;
			hold_seg_timer= 1'b1;
			hold_min_timer= 1'b1;
			hold_hora_timer= 1'b1;
			hold_banderas_config= 1'b1;
		end
		8'h06: begin
			hold_seg_hora = 1'b1;
			hold_min_hora= 1'b1;
			hold_hora_hora= 1'b1;
			hold_dia_fecha= 1'b0;
			hold_mes_fecha= 1'b1;
			hold_jahr_fecha= 1'b1;
			hold_seg_timer= 1'b1;
			hold_min_timer= 1'b1;
			hold_hora_timer= 1'b1;
			hold_banderas_config= 1'b1;
		end
		8'h07: begin
			hold_seg_hora = 1'b1;
			hold_min_hora= 1'b1;
			hold_hora_hora= 1'b1;
			hold_dia_fecha= 1'b1;
			hold_mes_fecha= 1'b0;
			hold_jahr_fecha= 1'b1;
			hold_seg_timer= 1'b1;
			hold_min_timer= 1'b1;
			hold_hora_timer= 1'b1;
			hold_banderas_config= 1'b1;
		end
		8'h08: begin
			hold_seg_hora = 1'b1;
			hold_min_hora= 1'b1;
			hold_hora_hora= 1'b1;
			hold_dia_fecha= 1'b1;
			hold_mes_fecha= 1'b1;
			hold_jahr_fecha= 1'b0;
			hold_seg_timer= 1'b1;
			hold_min_timer= 1'b1;
			hold_hora_timer= 1'b1;
			hold_banderas_config= 1'b1;
		end
		8'h0A: begin
			hold_seg_hora = 1'b1;
			hold_min_hora= 1'b1;
			hold_hora_hora= 1'b1;
			hold_dia_fecha= 1'b1;
			hold_mes_fecha= 1'b1;
			hold_jahr_fecha= 1'b1;
			hold_seg_timer= 1'b0;
			hold_min_timer= 1'b1;
			hold_hora_timer= 1'b1;
			hold_banderas_config= 1'b1;
		end
		8'h0B: begin
			hold_seg_hora = 1'b1;
			hold_min_hora= 1'b1;
			hold_hora_hora= 1'b1;
			hold_dia_fecha= 1'b1;
			hold_mes_fecha= 1'b1;
			hold_jahr_fecha= 1'b1;
			hold_seg_timer= 1'b1;
			hold_min_timer= 1'b0;
			hold_hora_timer= 1'b1;
			hold_banderas_config= 1'b1;
		end
		8'h0C: begin
			hold_seg_hora = 1'b1;
			hold_min_hora= 1'b1;
			hold_hora_hora= 1'b1;
			hold_dia_fecha= 1'b1;
			hold_mes_fecha= 1'b1;
			hold_jahr_fecha= 1'b1;
			hold_seg_timer= 1'b1;
			hold_min_timer= 1'b1;
			hold_hora_timer= 1'b0;
			hold_banderas_config= 1'b1;
		end
		8'h0D: begin
			hold_seg_hora = 1'b1;
			hold_min_hora= 1'b1;
			hold_hora_hora= 1'b1;
			hold_dia_fecha= 1'b1;
			hold_mes_fecha= 1'b1;
			hold_jahr_fecha= 1'b1;
			hold_seg_timer= 1'b1;
			hold_min_timer= 1'b1;
			hold_hora_timer= 1'b1;
			hold_banderas_config= 1'b0;
		end
		default: begin
			hold_seg_hora = 1'b1;
			hold_min_hora= 1'b1;
			hold_hora_hora= 1'b1;
			hold_dia_fecha= 1'b1;
			hold_mes_fecha= 1'b1;
			hold_jahr_fecha= 1'b1;
			hold_seg_timer= 1'b1;
			hold_min_timer= 1'b1;
			hold_hora_timer= 1'b1;
			hold_banderas_config= 1'b1;
		end
	endcase
	end
	
	else begin 
		hold_seg_hora = 1'b1;
		hold_min_hora= 1'b1;
		hold_hora_hora= 1'b1;
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b1;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b1;
		hold_banderas_config= 1'b1;
	end
	end
	
endmodule
