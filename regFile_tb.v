`timescale 1ns / 1ps

module regFile_tb();

	reg i_clk, i_we;
    reg [4:0] i_raddr1, i_raddr2, i_waddr;
    reg [31:0] i_wdata;
    wire [31:0] o_rdata1, o_rdata2;
    
    regFile regFile_inst (.i_clk (i_clk),
                          .i_we (i_we),
                          .i_raddr1 (i_raddr1),
                          .i_raddr2 (i_raddr2),
                          .i_waddr (i_waddr),
                          .i_wdata (i_wdata),
                          .o_rdata1 (o_rdata1),
                          .o_rdata2 (o_rdata2));
    
    initial begin
		i_clk = 0;
		forever #5 i_clk = ~i_clk;
	end
	
	initial begin
		i_we = 0;
		i_raddr1 = 5'b00000;
		i_raddr2 = 5'b00000;
		i_waddr = 5'b00000;
		i_wdata = 32'd0;
		
		@ (negedge i_clk);
		i_raddr1 = 5'h01;
		i_waddr = 5'h01;
		i_we = 1;
		i_wdata = 32'hDEAD_BEEF;
		#1;
		if (o_rdata1 == 32'hDEAD_BEEF)
			$display ("!regFile -> Write test 1 -- NOT OK");
		else
			$display ("regFile -> Write test 1 -- OK");
			
		@ (negedge i_clk);
		if (o_rdata1 == 32'hDEAD_BEEF)
			$display ("regFile -> Write test 2 -- OK");
		else
			$display ("!regFile -> Write test 2 -- NOT OK");
		
		i_waddr = 5'h03;
		i_wdata = 32'hABBA_BAAB;
		@ (negedge i_clk);
		i_we = 0;
		#1 i_raddr2 = 5'h1;
		#1;
		if (o_rdata2 == 32'hDEAD_BEEF)
			$display ("regFile -> Read test 1 -- OK");
		else
			$display ("!regFile -> Read test 1 -- NOT OK");
			
		#1 i_raddr1 = 5'h3;
		#1;
		if (o_rdata1 == 32'hABBA_BAAB)
			$display ("regFile -> Read test 2 -- OK");
		else
			$display ("!regFile -> Read test 2 -- NOT OK");
		
		@ (negedge i_clk);
		i_we = 1;
		i_waddr = 0;
		i_wdata = 32'hDEAD_BEEF;
		@ (negedge i_clk);
		i_raddr1 = 0;
		#1;
		if (o_rdata1 == 32'hDEAD_BEEF)
			$display ("!regFile -> Zero reg test -- NOT OK");
		else
			$display ("regFile -> Zero reg test -- OK");
		@ (negedge i_clk);
			
		$finish();
	end

endmodule
