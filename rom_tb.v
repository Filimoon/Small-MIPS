`timescale 1ns / 1ps

module rom_tb();

	reg  [7:0] i_addr;
	wire  [31:0] o_data;
	
	rom rom_inst (.i_addr (i_addr),
	              .o_data (o_data));
	
	initial begin
		i_addr = 0;
		#1;
		i_addr = 1;
		#1;
		i_addr = 2;
		#1;
		i_addr = 3;
		#1;
		i_addr = 4;
		#1;
		$finish();
	end

endmodule
