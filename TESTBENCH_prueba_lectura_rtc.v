`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:39:35 05/28/2016
// Design Name:   prueba_lectura_rtc
// Module Name:   D:/TEC/I 2016/Lab Digitales/Proyecto III/Proyecto Xillinx/Lab_Sistemas_Digitales_3_proyecto/TESTBENCH_prueba_lectura_rtc.v
// Project Name:  Lab_Sistemas_Digitales_3_proyecto
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: prueba_lectura_rtc
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TESTBENCH_prueba_lectura_rtc;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire AD;
	wire CS;
	wire WR;
	wire RD;
	wire [7:0] RGB;
	wire hsync;
	wire vsync;
	wire [7:0]port_id,out_port,wire_in_port;
	wire [7:0]fin_lectura_escritura;
	wire hold_seg_hora;

	// Bidirs
	wire [7:0] dato;

	// Instantiate the Unit Under Test (UUT)
	prueba_lectura_rtc uut (
		.clk(clk), 
		.reset(reset), 
		.dato(dato), 
		.AD(AD), 
		.CS(CS), 
		.WR(WR), 
		.RD(RD), 
		.port_id(port_id),
		.out_port(out_port),
		.wire_in_port(wire_in_port),
		.fin_lectura_escritura(fin_lectura_escritura),
		.hold_seg_hora(hold_seg_hora),
		.RGB(RGB), 
		.hsync(hsync), 
		.vsync(vsync)
	);
always #5 clk = !clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		#5 reset = 0;
		// Wait 100 ns for global reset to finish
		#100;
		#100000 $stop;
        
		// Add stimulus here

	end
      
endmodule

