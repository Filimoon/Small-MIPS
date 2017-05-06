`timescale 1ns / 1ps

module alu_tb();

	localparam AND = 4'b0000, OR = 4'b0001,   ADD = 4'b0010;
	localparam SUB = 4'b0110, SOLT = 4'b0111, NOR = 4'b1100;

	reg  signed [31:0] i_op1, i_op2;
	reg         [3:0]  i_control;
	wire signed [31:0] o_result;
	wire               o_zf;
	
	reg signed [31:0] golden;
	
	alu alu_inst (.i_op1 (i_op1),
	              .i_op2 (i_op2),
	              .i_control (i_control),
	              .o_result (o_result),
	              .o_zf (o_zf));

	initial begin
		i_op1 = 32;
		i_op2 = -8;
		#1 i_control = AND;  golden = 32 & (-8);
		#1 i_control = OR;   golden = 32 | (-8);
		#1 i_control = ADD;  golden = 32 + (-8);
		#1 i_control = SUB;  golden = 32 - (-8);
		#1 i_control = SOLT; golden = 0;
		#1 i_control = NOR;  golden = ~(32 | (-8));
		#1;
		$finish();
	end
endmodule
