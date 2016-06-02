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
	input [7:0] port_id,
	input [1:0] config_mode,
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
case(config_mode)

2'b00://Modo normal
	if (write_strobe) begin
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
		hold_banderas_config = 1'b1;
	end
	8'h04: begin
		hold_seg_hora = 1'b1;
		hold_min_hora= 1'b0;
		hold_hora_hora= 1'b1;
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b1;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b1;
		hold_banderas_config = 1'b1;
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
		hold_banderas_config = 1'b1;
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
		hold_banderas_config = 1'b1;
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
		hold_banderas_config = 1'b1;
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
		hold_banderas_config = 1'b1;
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
		hold_banderas_config = 1'b1;
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
		hold_banderas_config = 1'b1;
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
		hold_banderas_config = 1'b1;
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
		hold_banderas_config = 1'b0;
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
		hold_hora_timer= 1'b0;
		hold_banderas_config = 1'b1;
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
		hold_banderas_config = 1'b1;
	end

2'b01://Configura hora
begin
	hold_seg_hora = 1'b0;
	hold_min_hora= 1'b0;
	hold_hora_hora= 1'b0;
	
	if (write_strobe) begin
	case(port_id)
	
	8'h06: begin
		hold_dia_fecha= 1'b0;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b1;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b1;
		hold_banderas_config = 1'b1;
	end
	8'h07: begin
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b0;
		hold_jahr_fecha= 1'b1;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b1;
		hold_banderas_config = 1'b1;
	end
	8'h08: begin
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b0;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b1;
		hold_banderas_config = 1'b1;
	end
	8'h0A: begin
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b1;
		hold_seg_timer= 1'b0;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b1;
		hold_banderas_config = 1'b1;
	end
	8'h0B: begin
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b1;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b0;
		hold_hora_timer= 1'b1;
		hold_banderas_config = 1'b1;
	end
	8'h0C: begin
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b1;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b0;
		hold_banderas_config = 1'b1;
	end
	8'h0D: begin
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b1;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b1;
		hold_banderas_config = 1'b0;
	end 
	default: begin
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b1;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b1;
		hold_banderas_config = 1'b1;
	end
	endcase
	end
	
	else begin
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b1;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b1;
		hold_banderas_config = 1'b1;
	end
end

2'b10://Configura fecha
begin
	hold_dia_fecha= 1'b0;
	hold_mes_fecha= 1'b0;
	hold_jahr_fecha= 1'b0;
	
	if (write_strobe) begin
	case(port_id)
	8'h03:begin
		hold_seg_hora = 1'b0;
		hold_min_hora= 1'b1;
		hold_hora_hora= 1'b1;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b1;
		hold_banderas_config = 1'b1;
	end
	8'h04:begin
		hold_seg_hora = 1'b1;
		hold_min_hora= 1'b0;
		hold_hora_hora= 1'b1;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b1;
		hold_banderas_config = 1'b1;
	end
	8'h05:begin
		hold_seg_hora = 1'b1;
		hold_min_hora= 1'b1;
		hold_hora_hora= 1'b0;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b1;
		hold_banderas_config = 1'b1;
	end
	8'h0A: begin
		hold_seg_hora = 1'b1;
		hold_min_hora= 1'b1;
		hold_hora_hora= 1'b1;
		hold_seg_timer= 1'b0;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b1;
		hold_banderas_config = 1'b1;
	end
	8'h0B: begin
		hold_seg_hora = 1'b1;
		hold_min_hora= 1'b1;
		hold_hora_hora= 1'b1;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b0;
		hold_hora_timer= 1'b1;
		hold_banderas_config = 1'b1;
	end
	8'h0C: begin
		hold_seg_hora = 1'b1;
		hold_min_hora= 1'b1;
		hold_hora_hora= 1'b1;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b0;
		hold_banderas_config = 1'b1;
	end
	8'h0D: begin
		hold_seg_hora = 1'b1;
		hold_min_hora= 1'b1;
		hold_hora_hora= 1'b1;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b1;
		hold_banderas_config = 1'b0;
	end	
	default: begin
		hold_seg_hora = 1'b1;
		hold_min_hora= 1'b1;
		hold_hora_hora= 1'b1;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b1;
		hold_banderas_config = 1'b1;
	end
	endcase
	end
	
	else begin
		hold_seg_hora = 1'b1;
		hold_min_hora= 1'b1;
		hold_hora_hora= 1'b1;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b1;
		hold_banderas_config = 1'b1;
	end
end

2'b11://Configura timer
begin
	hold_seg_timer= 1'b0;
	hold_min_timer= 1'b0;
	hold_hora_timer= 1'b0;	

	if (write_strobe) begin
	case(port_id)
	8'h03: begin
		hold_seg_hora = 1'b0;
		hold_min_hora= 1'b1;
		hold_hora_hora= 1'b1;
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b1;
		hold_banderas_config = 1'b1;
	end
	8'h04: begin
		hold_seg_hora = 1'b1;
		hold_min_hora= 1'b0;
		hold_hora_hora= 1'b1;
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b1;
		hold_banderas_config = 1'b1;
	end
	8'h05: begin
		hold_seg_hora = 1'b1;
		hold_min_hora= 1'b1;
		hold_hora_hora= 1'b0;
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b1;
		hold_banderas_config = 1'b1;
	end
	8'h06: begin
		hold_seg_hora = 1'b1;
		hold_min_hora= 1'b1;
		hold_hora_hora= 1'b1;
		hold_dia_fecha= 1'b0;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b1;
		hold_banderas_config = 1'b1;
	end
	8'h07: begin
		hold_seg_hora = 1'b1;
		hold_min_hora= 1'b1;
		hold_hora_hora= 1'b1;
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b0;
		hold_jahr_fecha= 1'b1;
		hold_banderas_config = 1'b1;
	end
	8'h08: begin
		hold_seg_hora = 1'b1;
		hold_min_hora= 1'b1;
		hold_hora_hora= 1'b1;
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b0;
		hold_banderas_config = 1'b1;
	end
	8'h0D: begin
		hold_seg_hora = 1'b1;
		hold_min_hora= 1'b1;
		hold_hora_hora= 1'b1;
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b1;
		hold_banderas_config = 1'b0;
	end
	default: begin
		hold_seg_hora = 1'b1;
		hold_min_hora= 1'b1;
		hold_hora_hora= 1'b1;
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b1;
		hold_banderas_config = 1'b1;
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
		hold_banderas_config = 1'b1;
	end
end
default: begin
		hold_seg_hora = 1'b0;
		hold_min_hora= 1'b0;
		hold_hora_hora= 1'b0;
		hold_dia_fecha= 1'b0;
		hold_mes_fecha= 1'b0;
		hold_jahr_fecha= 1'b0;
		hold_seg_timer = 1'b0;
		hold_min_timer = 1'b0;
		hold_hora_timer = 1'b0;
end
endcase
end
endmodule

