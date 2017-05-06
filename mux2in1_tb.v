`timescale 1ns / 1ps

module mux2in1_tb();

	reg [31:0] i_dat0, i_dat1;
	reg i_control;
	wire [31:0] o_dat;
	
	mux2in1 mux2in1_inst (.i_dat0 (i_dat0),
	                      .i_dat1 (i_dat1),
	                      .i_control (i_control),
	                      .o_dat (o_dat));
	                      
	initial begin
		i_dat0 = 32'h1234_5678;
		i_dat1 = 32'hFFEE_AABB;
		i_control = 0;
		#1;
		if (o_dat == 32'h1234_5678)
			$display ("MUX 0 -- OK");
		else
			$display ("!MUX 0 -- NOT OK");
			
		i_control = 1;
		#1;
		if (o_dat == 32'hFFEE_AABB)
			$display ("MUX 1 -- OK");
		else
			$display ("!MUX 1 -- NOT OK");
	end

endmodule
