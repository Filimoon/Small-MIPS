`timescale 1ns / 1ps

module alu(i_op1, i_op2, i_control, o_result, o_zf);

	localparam AND = 4'b0000, OR = 4'b0001,   ADD = 4'b0010;
	localparam SUB = 4'b0110, SOLT = 4'b0111, NOR = 4'b1100; //SOLT - Set On Less then
  
	input      signed [31:0]  i_op1, i_op2;
	input             [3:0]   i_control;
	output reg signed [31:0]  o_result;
	output                    o_zf;
	
	always @ (i_op1, i_op2, i_control) begin
		case (i_control)
			AND:  o_result = i_op1 & i_op2;
			OR:   o_result = i_op1 | i_op2;
			ADD:  o_result = i_op1 + i_op2;
			SUB:  o_result = i_op1 - i_op2;
			SOLT: o_result = i_op1 < i_op2 ? 32'd1 : 32'd0;
			NOR:  o_result = ~(i_op1 | i_op2);
			
			default: o_result = 32'dX;
		endcase
	end
	
	assign o_zf = o_result?0:1;
	  
endmodule
