`timescale 1ns / 1ps

module signExtend(i_data, o_data);
	
	input   [15:0]  i_data;
	output  [31:0]  o_data;
	
	assign o_data = {{16{i_data[15]}}, i_data};

endmodule
