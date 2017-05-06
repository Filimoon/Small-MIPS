`timescale 1ns / 1ps

module aluControl_tb();

	reg [1:0] i_aluOp;
	reg [5:0] i_func;
	wire [3:0] o_aluControl;
	
	aluControl aluControl_inst (.i_aluOp (i_aluOp),
	                            .i_func (i_func),
	                            .o_aluControl (o_aluControl));
	
	initial begin
		i_func = 6'b1111;
		i_aluOp = 2'b00;
		#1;
		i_aluOp = 2'b01;
		#1;
		i_aluOp = 2'b10;
		#1;
		i_func = 6'b000000;
		#1;
		i_func = 6'b000010;
		#1;
		i_func = 6'b000100;
		#1;
		i_func = 6'b000101;
		#1;
		i_func = 6'b001010;
		#1;
		$finish();
	end                            
endmodule
