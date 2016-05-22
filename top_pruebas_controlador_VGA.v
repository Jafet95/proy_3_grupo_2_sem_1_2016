`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:05:24 03/30/2016 
// Design Name: 
// Module Name:    Bloque_Top_pruebas 
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

module Bloque_Top_pruebas
(
input clock_FPGA, reset,
input [1:0]sw,
output hsync, vsync,
output [7:0]RGB
);

wire [3:0] digit0_HH, digit1_HH, digit0_MM, digit1_MM, digit0_SS, digit1_SS,//
digit0_DAY, digit1_DAY, digit0_MES, digit1_MES, digit0_YEAR, digit1_YEAR,//
digit0_HH_T, digit1_HH_T, digit0_MM_T, digit1_MM_T, digit0_SS_T, digit1_SS_T;

wire AM_PM;
wire [1:0] funcion;
wire [1:0] cursor_location;
wire timer_end;//bandera proveniente del RTC que indica la finalizaci�n del tiempo del timer
wire formato_hora;//Se�al que indica si la hora esta en formato 12 hrs o 24 hrs (0->24 hrs)

bloque_prueba_frames instancia_bloque_prueba_frames
(
.sw(sw),
.digit0_HH(digit0_HH), .digit1_HH(digit1_HH), .digit0_MM(digit0_MM), .digit1_MM(digit1_MM), .digit0_SS(digit0_SS), .digit1_SS(digit1_SS),//
.digit0_DAY(digit0_DAY), .digit1_DAY(digit1_DAY), .digit0_MES(digit0_MES), .digit1_MES(digit1_MES), .digit0_YEAR(digit0_YEAR), .digit1_YEAR(digit1_YEAR),//
.digit0_HH_T(digit0_HH_T), .digit1_HH_T(digit1_HH_T), .digit0_MM_T(digit0_MM_T), .digit1_MM_T(digit1_MM_T), .digit0_SS_T(digit0_SS_T), .digit1_SS_T(digit1_SS_T),//Decenas y unidades para los n�meros en pantalla (18 inputs de 3 bits)
.AM_PM(AM_PM),//Entrada para conocer si en la informaci�n de hora se despliega AM o PM
.funcion(funcion),//2-bits: cuatro estados del modo configuraci�n
.cursor_location(cursor_location),//Marca la posici�n del cursor en modo configuraci�n
.timer_end(timer_end),//bandera proveniente del RTC que indica la finalizaci�n del tiempo del timer
.formato_hora(formato_hora)//Se�al que indica si la hora esta en formato 12 hrs o 24 hrs (0->24 hrs)
);

controlador_VGA instancia_controlador_VGA
(
.clock(clock_FPGA), .reset(reset),
.digit0_HH(digit0_HH), .digit1_HH(digit1_HH), .digit0_MM(digit0_MM), .digit1_MM(digit1_MM), .digit0_SS(digit0_SS), .digit1_SS(digit1_SS),//
.digit0_DAY(digit0_DAY), .digit1_DAY(digit1_DAY), .digit0_MES(digit0_MES), .digit1_MES(digit1_MES), .digit0_YEAR(digit0_YEAR), .digit1_YEAR(digit1_YEAR),//
.digit0_HH_T(digit0_HH_T), .digit1_HH_T(digit1_HH_T), .digit0_MM_T(digit0_MM_T), .digit1_MM_T(digit1_MM_T), .digit0_SS_T(digit0_SS_T), .digit1_SS_T(digit1_SS_T),//Decenas y unidades para los n�meros en pantalla (18 inputs de 3 bits)
.AM_PM(AM_PM),//Entrada para conocer si en la informaci�n de hora se despliega AM o PM
.config_mode(funcion),//1-bit: OR de los tres estados del modo configuraci�n
.cursor_location(cursor_location),//Marca la posici�n del cursor en modo configuraci�n
.formato_hora(formato_hora),//Se�al que indica si la hora esta en formato 12 hrs o 24 hrs (0->24 hrs)
.estado_alarma(timer_end),//bandera proveniente del RTC que indica la finalizaci�n del tiempo del timer
.hsync(hsync),.vsync(vsync),
.RGB(RGB)
);


endmodule

