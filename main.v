`timescale 1ns / 1ps

module main(clk, rst_n);

	// Common wires
	input       clk;
	input       rst_n;
	wire        regDst;
	wire        regWrite;
	wire        aluSrc;
	wire  [1:0] aluOp;
	wire        memWrite;
	wire        memToReg;
	wire        PcSrc;
	wire        jump;
	wire        branch;
	wire        aluConI;
	// pc wires
	wire [31:0] i_pc;
	wire [31:0] o_pc;
	// rom wires
	wire  [7:0] i_addr;
	wire [31:0] instruction;
	// regFile wires
	wire  [4:0] readAddrReg1, readAddrReg2, writeAddrReg;
    wire [31:0] writeDataReg;
    wire [31:0] readDataReg1, readDataReg2;
    // signExtend wires
    wire [31:0] dataExtended;
    // aluControl wires
    wire [3:0] aluCtrl;
    wire [5:0] aluAction;
    // alu wires
    wire signed [31:0] dataOp1, dataOp2;
	wire signed [31:0] aluResult;
	wire               aluZero;
	// ram wires
	wire [31:0] ramData;
	// summ wires
	wire signed [31:0] addPcRes;
	wire signed [31:0] brResult;
	// shift by 2 wires
	wire  [31:0]   dataShifted;
	// instr shift wires
	wire  [27:0] instrShifted;
	// some muxes wires
	wire  [31:0] brAddr;

	pc pc_inst (.i_clk   (clk),
	            .i_rst_n (rst_n),
	            .i_pc    (i_pc),
	            .o_pc    (o_pc));
	
	rom rom_inst (.i_addr (i_addr),
	              .o_data (instruction));
	              
	regFile regFile_inst (.i_clk     (clk),
                          .i_we      (regWrite),
                          .i_raddr1  (readAddrReg1),
                          .i_raddr2  (readAddrReg2),
                          .i_waddr   (writeAddrReg),
                          .i_wdata   (writeDataReg),
                          .o_rdata1  (readDataReg1),
                          .o_rdata2  (readDataReg2));
	              
	mux2in1 mux2in1_regDst_inst (.i_dat0 (instruction[20:16]),
	                             .i_dat1 (instruction[15:11]),
	                             .i_control (regDst),
	                             .o_dat (writeAddrReg));
	                      
	signExtend signExtend_inst (.i_data (instruction[15:0]),
	                            .o_data (dataExtended));
	
	mux2in1 mux2in1_aluSrc_inst (.i_dat0    (readDataReg2),
	                             .i_dat1    (dataExtended),
	                             .i_control (aluSrc),
	                             .o_dat     (dataOp2));
	
	aluControl aluControl_inst (.i_aluOp      (aluOp),
	                            .i_func       (aluAction),
	                            .o_aluControl (aluCtrl));
	
	alu alu_inst (.i_op1     (dataOp1),
	              .i_op2     (dataOp2),
	              .i_control (aluCtrl),
	              .o_result  (aluResult),
	              .o_zf      (aluZero));
	
	ram ram_inst (.i_clk  (clk),
	              .i_we   (memWrite),
	              .i_addr (aluResult[8:2]),
	              .i_data (readDataReg2),
	              .o_data (ramData));
	
	mux2in1 mux2in1_memToReg_inst (.i_dat0    (aluResult),
	                               .i_dat1    (ramData),
	                               .i_control (memToReg),
	                               .o_dat     (writeDataReg));
	
	shiftLeftBy2 shiftLeftBy2_inst (.i_data (dataExtended),
	                                .o_data (dataShifted));
	
	adder adder_PC_inst (.i_op1    (o_pc),
	                     .i_op2    (32'h4),
	                     .i_c0     (1'h0),
	                     .o_result (addPcRes),
	                     .o_ov     ());
	
	adder adder_br_inst (.i_op1    (addPcRes),
	                     .i_op2    (dataShifted),
	                     .i_c0     (1'h0),
	                     .o_result (brResult),
	                     .o_ov     ());
	
	mux2in1 mux2in1_PcSrc_inst (.i_dat0    (addPcRes),
	                            .i_dat1    (brResult),
	                            .i_control (PcSrc),
	                            .o_dat     (brAddr));
	
	control control_inst (.i_instrCode (instruction[31:26]),
	                      .o_regDst    (regDst),
	                      .o_jump      (jump),
	                      .o_branch    (branch),
	                      .o_memToReg  (memToReg),
	                      .o_aluOp     (aluOp),
                          .o_memWrite  (memWrite),
                          .o_aluSrc    (aluSrc),
                          .o_regWrite  (regWrite),
                          .o_aluConI   (aluConI));
	
	shiftLeftBy2 shiftLeftBy2_j_inst (.i_data (instruction[25:0]),
	                                  .o_data (instrShifted));
	
	mux2in1 mux2in1_j_inst (.i_dat0    (brAddr),
	                        .i_dat1    ({addPcRes[31:28], instrShifted[27:0]}),
	                        .i_control (jump),
	                        .o_dat     (i_pc));
	                        
	mux2in1 mux2in1_aluConI_inst (.i_dat0    (instruction[5:0]),
	                              .i_dat1    (instruction[31:26]),
	                              .i_control (aluConI),
	                              .o_dat     (aluAction));
	
	
	assign i_addr = o_pc[9:2];
	
	assign readAddrReg1 = instruction[25:21];
	assign readAddrReg2 = instruction[20:16];
	
	assign dataOp1 = readDataReg1;
	
	assign PcSrc = branch & aluZero;
endmodule
