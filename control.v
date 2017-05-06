`timescale 1ns / 1ps

module control(i_instrCode, 
               o_regDst,
               o_jump, 
               o_branch,
               o_memToReg,
               o_aluOp,
               o_memWrite,
               o_aluSrc,
               o_regWrite,
               o_aluConI);
  
//	input     [15:0]  i_instrCode;
	input      [5:0]  i_instrCode;
	output reg        o_regDst;
	output reg        o_jump; 
	output reg        o_branch;
	output reg        o_memToReg;
	output reg [1:0]  o_aluOp;
	output reg        o_memWrite;
	output reg        o_aluSrc;
	output reg        o_regWrite;
	output reg        o_aluConI;

	always @ (i_instrCode) begin
		case (i_instrCode)
			// R-type
			6'h00:	begin
						o_regDst   = 1;
						o_aluSrc   = 0;
						o_memToReg = 0;
						o_regWrite = 1;
						o_memWrite = 0;
						o_branch   = 0;
						o_aluOp    = 2'b10;
						o_jump     = 0;
						o_aluConI  = 0;
					end
			// addi and andi
			6'h08:  begin
						o_regDst   = 0;
						o_aluSrc   = 1;
						o_memToReg = 0;
						o_regWrite = 1;
						o_memWrite = 0;
						o_branch   = 0;
						o_aluOp    = 2'b10;
						o_jump     = 0;
						o_aluConI  = 1;
			        end
			6'h0C:  begin
						o_regDst   = 0;
						o_aluSrc   = 1;
						o_memToReg = 0;
						o_regWrite = 1;
						o_memWrite = 0;
						o_branch   = 0;
						o_aluOp    = 2'b10;
						o_jump     = 0;
						o_aluConI  = 1;
			        end
			// lw
			6'h23:	begin
						o_regDst   = 0;
						o_aluSrc   = 1;
						o_memToReg = 1;
						o_regWrite = 1;
						o_memWrite = 0;
						o_branch   = 0;
						o_aluOp    = 2'b00;
						o_jump     = 0;
						o_aluConI  = 0;
					end
			// sw
			6'h2B:	begin
						o_regDst   = 1'bX;
						o_aluSrc   = 1;
						o_memToReg = 1'bX;
						o_regWrite = 0;
						o_memWrite = 1;
						o_branch   = 0;
						o_aluOp    = 2'b00;
						o_jump     = 0;
						o_aluConI  = 0;
					end
			// beg
			6'h04:	begin
						o_regDst   = 1'bX;
						o_aluSrc   = 0;
						o_memToReg = 1'bX;
						o_regWrite = 0;
						o_memWrite = 0;
						o_branch   = 1;
						o_aluOp    = 2'b01;
						o_jump     = 0;
						o_aluConI  = 0;
					end
			// j
			6'h02:	begin
						o_regDst   = 1'bX;
						o_aluSrc   = 1'b0;
						o_memToReg = 1'bX;
						o_regWrite = 0;
						o_memWrite = 0;
						o_branch   = 1'bX;
						o_aluOp    = 2'b00;
						o_jump     = 1;
						o_aluConI  = 0;
					end
			default:begin
						o_regDst   = 1'bX;
						o_aluSrc   = 1'b0;
						o_memToReg = 1'bX;
						o_regWrite = 1'b0;
						o_memWrite = 1'b0;
						o_branch   = 1'b0;
						o_aluOp    = 2'b00;
						o_jump     = 1'b0;
						o_aluConI  = 0;
					end
		endcase
	end
	
endmodule
