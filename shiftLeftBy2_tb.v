`timescale 1ns / 1ps

module shiftLeftBy2_tb();

	reg   [31:0]   i_data;
	wire  [31:0]   o_data;
	
	shiftLeftBy2 shiftLeftBy2_inst (.i_data (i_data),
	                                .o_data (o_data));
	                                
	initial begin
		i_data = 32'hFFFF_FFFF;
		#1;
		if (o_data == 32'hFFFF_FFFC)
			$display ("shiftLeftBy2 -> Test -- OK");
		else
			$display ("!shiftLeftBy2 -> Test -- NOT OK");
	end

endmodule
