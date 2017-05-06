`timescale 1ns / 1ps

module main_tb();

	reg clk, rst_n;
	
	main main_inst (.clk   (clk),
	                .rst_n (rst_n));

	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end
	
	initial begin
		rst_n = 0;
		@ (negedge clk) rst_n = 1;
		//#1000; // 140
		//$finish();
		
		//forever @ (negedge clk) $stop();
		forever @ (negedge clk) if(main_inst.o_pc == 32'h0c0) $stop();
	end
endmodule
