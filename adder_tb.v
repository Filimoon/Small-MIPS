`timescale 1ns / 1ps

module adder_tb();

	reg signed [31:0] i_op1, i_op2;
	reg i_c0;
	wire signed [31:0] o_result;
	wire o_ov;
	
	adder adder_inst (.i_op1 (i_op1),
	                  .i_op2 (i_op2),
	                  .i_c0 (i_c0),
	                  .o_result (o_result),
	                  .o_ov (o_ov));

	initial begin
		i_c0 = 0;
		i_op1 = -12;
		i_op2 = 15;
		#1;
		if (o_result == 3)
			$display("OK");
		
		i_op1 = 32'hFFFF_FFFE;
		i_op2 = 5;
		#1;
		if (o_result == 3)
			$display("OK");
		i_c0 = 1;
		#1;
		$finish();
	end
endmodule
