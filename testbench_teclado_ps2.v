`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:23:18 05/16/2016
// Design Name:   controlador_teclado_ps2
// Module Name:   C:/Users/Jafet/Documents/Proyectos Dis.Sist.Digitales/III_Proyecto_Laboratorio_Sistemas_Digitales/Archivos .v/proy_3_grupo_2_sem_1_2016/testbench_teclado_ps2.v
// Project Name:  III_Proyecto_Laboratorio_Sistemas_Digitales
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: controlador_teclado_ps2
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbench_teclado_ps2;

	// Inputs
	reg clk;
	reg reset;
	reg ps2data;
	reg ps2clk;

	// Outputs
	wire [7:0] ascii_code;

	// Instantiate the Unit Under Test (UUT)
	controlador_teclado_ps2 uut (
		.clk(clk), 
		.reset(reset), 
		.ps2data(ps2data), 
		.ps2clk(ps2clk), 
		.ascii_code(ascii_code)
	);
	
	//Para generar clock de 100 MHz
	initial begin
	clk = 0;
	forever #5 clk = ~clk;
	end
	
/*	//Para generar clock de 10 kHz (ps2)
	initial begin
	ps2clk = 0;
	forever #50000 ps2clk = ~ps2clk;
	end
*/

	initial begin
		// Initialize Inputs
		reset = 1;
		ps2data = 0;
		ps2clk = 1;

		// Wait 100 ns for global reset to finish
		#100;
		
		reset = 0;
        
		// Add stimulus here
		
		//F0
		#50005
		ps2clk = 1;
		ps2data = 0;//Bit de inicio
		
		#50000
		ps2clk = 0;
		
		#50000
		ps2clk = 1;
		ps2data = 0;//Bit 0 (1C)

		#50000
		ps2clk = 0;
		
		#50000
		ps2clk = 1;
		ps2data = 0;//Bit 1 (1C)

		#50000
		ps2clk = 0;
		
		#50000
		ps2clk = 1;
		ps2data = 0;//Bit 2 (1C)
		
		#50000
		ps2clk = 0;
		
		#50000
		ps2clk = 1;
		ps2data = 0;//Bit 3 (1C)
		
		#50000
		ps2clk = 0;
		
		#50000
		ps2clk = 1;
		ps2data = 1;//Bit 4 (1C)

		#50000
		ps2clk = 0;
		
		#50000
		ps2clk = 1;
		ps2data = 1;//Bit 5 (1C)

		#50000
		ps2clk = 0;
		
		#50000
		ps2clk = 1;
		ps2data = 1;//Bit 6 (1C)

		#50000
		ps2clk = 0;
		
		#50000
		ps2clk = 1;
		ps2data = 1;//Bit 7 (1C)

		#50000
		ps2clk = 0;
		
		#50000
		ps2clk = 1;
		ps2data = 1;//Bit paridad (par=1)

		#50000
		ps2clk = 0;
		
		#50000
		ps2clk = 1;
		ps2data = 1;//Bit parada
		
		#50000
		ps2clk = 0;

		//1C
		#50000
		ps2clk = 1;
		ps2data = 0;//Bit de inicio
		
		#50000
		ps2clk = 0;
		
		#50000
		ps2clk = 1;
		ps2data = 0;//Bit 0 (1C)

		#50000
		ps2clk = 0;
		
		#50000
		ps2clk = 1;
		ps2data = 0;//Bit 1 (1C)

		#50000
		ps2clk = 0;
		
		#50000
		ps2clk = 1;
		ps2data = 1;//Bit 2 (1C)
		
		#50000
		ps2clk = 0;
		
		#50000
		ps2clk = 1;
		ps2data = 1;//Bit 3 (1C)
		
		#50000
		ps2clk = 0;
		
		#50000
		ps2clk = 1;
		ps2data = 1;//Bit 4 (1C)

		#50000
		ps2clk = 0;
		
		#50000
		ps2clk = 1;
		ps2data = 0;//Bit 5 (1C)

		#50000
		ps2clk = 0;
		
		#50000
		ps2clk = 1;
		ps2data = 0;//Bit 6 (1C)

		#50000
		ps2clk = 0;
		
		#50000
		ps2clk = 1;
		ps2data = 0;//Bit 7 (1C)

		#50000
		ps2clk = 0;
		
		#50000
		ps2clk = 1;
		ps2data = 1;//Bit paridad (par=1)

		#50000
		ps2clk = 0;
		
		#50000
		ps2clk = 1;
		ps2data = 1;//Bit parada
		
		#50000
		ps2clk = 1;
		
		#200000$stop;		
	end
      
endmodule

