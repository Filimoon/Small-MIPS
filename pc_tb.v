`timescale 1ns / 1ps

module pc_tb();

	reg i_clk, i_rst_n;
	reg [31:0] i_pc;
	wire [31:0] o_pc;
	
	pc pc_inst (.i_clk (i_clk),
	            .i_rst_n (i_rst_n),
	            .i_pc (i_pc),
	            .o_pc (o_pc));
	
	initial begin
		i_clk = 0;
		forever #5 i_clk = ~i_clk;
	end
	
	initial begin
		i_pc = 32'h1234_5678;
		i_rst_n = 0;
		
		@ (negedge i_clk);
		if (o_pc == 32'h0)
			$display("Reset -- OK");
		else
			$display("! Reset -- NOT OK");
		i_rst_n = 1;
		
		@ (negedge i_clk);
		if (o_pc == 32'h1234_5678)
			$display("1234_5678 -- OK");
		else
			$display("! 1234_5678 -- NOT OK");
		i_pc = 32'hFFFF_FFFF;
		
		@ (negedge i_clk);
		if (o_pc == 32'hFFFF_FFFF)
			$display("FFFF_FFFF -- OK");
		else
			$display("! FFFF_FFFF -- NOT OK");
		$finish();
	end
endmodule
