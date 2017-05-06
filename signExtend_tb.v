`timescale 1ns / 1ps

module signExtend_tb();

	reg [15:0] i_data;
	wire [31:0] o_data;
	
	signExtend signExtend_inst (.i_data (i_data),
	                            .o_data (o_data));
	                            
	initial begin
		i_data = 16'hF123;
		#1;
		if (o_data == 32'hFFFF_F123)
			$display ("signExtend -> Negative -- OK");
		else
			$display ("!signExtend -> Negative -- NOT OK");
			
		i_data = 16'h7321;
		#1;
		if (o_data == 32'h0000_7321)
			$display ("signExtend -> Positive -- OK");
		else
			$display ("!signExtend -> Positive -- NOT OK");
	end

endmodule
