`timescale 1ns / 1ps

module control_tb();
	
	wire  [5:0]  i_instrCode;
	wire        o_regDst;
	wire        o_jump; 
	wire        o_branch;
	wire        o_memToReg;
	wire [1:0]  o_aluOp;
	wire        o_memWrite;
	wire        o_aluSrc;
	wire        o_regWrite;
	
	reg  [7:0] i_addr;
	wire  [31:0] o_data;
	
	integer i;	

	control control_inst (.i_instrCode (i_instrCode),
	                      .o_regDst (o_regDst),
	                      .o_jump (o_jump),
	                      .o_branch (o_branch),
	                      .o_memToReg (o_memToReg),
	                      .o_aluOp (o_aluOp),
                          .o_memWrite (o_memWrite),
                          .o_aluSrc (o_aluSrc),
                          .o_regWrite (o_regWrite));
                          
    rom rom_inst (.i_addr (i_addr),
	              .o_data (o_data));
	              
	assign i_instrCode = o_data[31:26];
 
	initial begin
		for (i = 0; i < 13; i=i+1) begin
			i_addr = i;
			#1;
		end
		$finish();
	end
 endmodule
 
