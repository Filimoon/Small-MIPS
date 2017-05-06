`timescale 1ns / 1ps

module ram_tb();

	reg         i_clk, i_we;
	reg   [4:0] i_addr;
	reg  [31:0] i_data;
	wire [31:0] o_data;
	
	ram ram_inst (.i_clk  (i_clk),
	              .i_we   (i_we),
	              .i_addr (i_addr),
	              .i_data (i_data),
	              .o_data (o_data));
	              
	 initial begin
		i_clk = 0;
		forever #5 i_clk = ~i_clk;
	 end
	 
	 initial begin
		i_we = 0;
		i_addr = 5'd3;
		i_data = 32'hABBA_DEAD;
		@ (negedge i_clk);
		i_we = 1;
		@ (negedge i_clk);
		i_addr = 5'd31;
		i_data = 32'hDEAD_BEEF;
		@ (negedge i_clk);
		#1;
		$finish();
	 end
endmodule
