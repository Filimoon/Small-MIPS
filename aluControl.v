`timescale 1ns / 1ps

module aluControl(i_aluOp, i_func, o_aluControl);
 
	input       [1:0]   i_aluOp;
	input       [5:0]   i_func;
	output  reg [3:0]   o_aluControl;
	
	always @ (i_aluOp, i_func) begin
		if (i_aluOp == 2'b00)
			o_aluControl = 4'b0010;
		else if (i_aluOp[0] == 1)
			o_aluControl = 4'b0110;
		else if (i_aluOp[1] == 1) begin
			casex (i_func)
				6'bXX0000: o_aluControl = 4'b0010;
				6'bXX0010: o_aluControl = 4'b0110;
				6'bXX0100: o_aluControl = 4'b0000;
				6'bXX0101: o_aluControl = 4'b0001;
				6'bXX1010: o_aluControl = 4'b0111;
				6'bXX0111: o_aluControl = 4'b1100; //!!!NOR
				
				6'h8:      o_aluControl = 4'b0010;
				6'hC:      o_aluControl = 4'b0000;
				default:   o_aluControl = 4'bXXXX;
			endcase
		end
		else o_aluControl = 4'bXXXX;
	end
endmodule
