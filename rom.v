`timescale 1ns / 1ps

module rom
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=8)
(
	input [(ADDR_WIDTH-1):0] i_addr,
	output [(DATA_WIDTH-1):0] o_data
);

	reg [DATA_WIDTH-1:0] rom_data [2**ADDR_WIDTH-1:0];
	
	initial
	begin
		$readmemh("codes/kr.dat", rom_data, 0);
	end
	
	assign o_data = rom_data[i_addr];

endmodule
