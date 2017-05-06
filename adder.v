`timescale 1ns / 1ps

module adder(i_op1, i_op2, i_c0, o_result, o_ov);

	input signed [31:0] i_op1, i_op2;
	input i_c0;
	output signed [31:0] o_result;
	output o_ov;
	
	assign {o_ov, o_result} = i_op1 + i_op2 + i_c0;
  
endmodule
