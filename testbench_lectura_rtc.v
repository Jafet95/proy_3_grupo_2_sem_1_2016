`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:56:16 05/24/2016
// Design Name:   Controlador_reloj_digital
// Module Name:   D:/TEC/I 2016/Lab Digitales/Proyecto III/Proyecto Xillinx/Proyecto_3/testbench_controlador_reloj_digital.v
// Project Name:  Proyecto_3
// Target Device:  
// Tool versions:   
// Description: 
//
// Verilog Test Fixture created by ISE for module: Controlador_reloj_digital
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// ////////////////////////////////////////////////////////////////////////////////

module testbench_controlador_reloj_digital;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire reg_a_d;
	wire reg_cs;
	wire reg_rd;
	wire reg_wr;
	wire [7:0]port_id;
	wire [7:0]out_port;
	wire[7:0]fin_lectura_escritura;

	// Bidirs
	wire [7:0] dato; 

	// Instantiate the Unit Under Test (UUT)
	Controlador_reloj_digital uut (
		.clk(clk), 
		.reset(reset), 
		.reg_a_d(reg_a_d), 
		.reg_cs(reg_cs), 
		.reg_rd(reg_rd), 
		.reg_wr(reg_wr), 
		.port_id(port_id),
		.out_port(out_port),
		.fin_lectura_escritura(fin_lectura_escritura),
		.dato(dato)
	);
always #5 clk = ~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		#10 reset = 0;
		

		// Wait 100 ns for global reset to finish
		#100000 $stop;
        
		// Add stimulus here

	end
      
endmodule

