module arm(
	input logic clk, 
	input logic reset,
	output logic [31:0] PC,
	input logic [31:0] Instr,
	output logic MemWrite,
	output logic MemByte,
	output logic [31:0] ALUResult, 
	output logic [31:0] WriteData,
	input logic [31:0] ReadData
);

	logic [3:0] ALUFlags;
	logic RegWrite, ALUSrc, 
			MemtoReg, PCSrc,
			Reverse;
	logic [1:0] RegSrc, ImmSrc, ALUControl;

	controller c(clk, reset, Instr[31:12], ALUFlags,
					 RegSrc, RegWrite, ImmSrc,
					 ALUSrc, Reverse, MemByte, ALUControl,
					 MemWrite, MemtoReg, PCSrc);

	datapath dp(clk, reset,
					RegSrc, RegWrite, ImmSrc,
					ALUSrc, Reverse, ALUControl,
					MemtoReg, PCSrc,
					ALUFlags, PC, Instr,
					ALUResult, WriteData, ReadData);

endmodule