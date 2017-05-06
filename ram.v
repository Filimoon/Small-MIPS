`timescale 1ns / 1ps

module ram(i_clk, i_addr, i_data, i_we, o_data);

	parameter DATA_WIDTH = 32;
	parameter ADDR_WIDTH = 7; //32 4-byte words 

	input                     i_clk, i_we;
	input   [ADDR_WIDTH-1:0]  i_addr;
	input   [DATA_WIDTH-1:0]  i_data;
	output  [DATA_WIDTH-1:0]  o_data;

	reg [DATA_WIDTH-1:0] data [(2**ADDR_WIDTH)-1:0];
	
	assign o_data = data[i_addr];
	
	always @ (posedge i_clk) begin
		if (i_we)
			data[i_addr] = i_data;
	end
  
endmodule
