module datapath (
	input logic clk, 
	input logic reset,
	input logic [1:0] RegSrc,
	input logic RegWrite,
	input logic [1:0] ImmSrc,
	input logic ALUSrc,
	input logic Reverse,
	input logic [1:0] ALUControl,
	input logic MemtoReg,
	input logic PCSrc,
	output logic [3:0] ALUFlags,
	output logic [31:0] PC,
	input logic [31:0] Instr,
	output logic [31:0] ALUResult, 
	output logic [31:0] WriteData,
	input logic [31:0] ReadData
);
	
	logic [31:0] PCNext, PCPlus4, PCPlus8;
	logic [31:0] ExtImm, SrcA, SrcB, Result;
	logic [3:0] RA1, RA2;
	logic [31:0] RD1, RD2;

	// next PC logic
	mux2 #(32) pcmux(PCPlus4, Result, PCSrc, PCNext);
	flopr #(32) pcreg(clk, reset, PCNext, PC);
	adder #(32) pcadd1(PC, 32'b100, PCPlus4);
	adder #(32) pcadd2(PCPlus4, 32'b100, PCPlus8);

	// register file logic
	mux2 #(4) ra1mux(Instr[19:16], 4'b1111, RegSrc[0], RA1);
	mux2 #(4) ra2mux(Instr[3:0], Instr[15:12], RegSrc[1], RA2);
	regfile rf(clk, RegWrite, RA1, RA2,
					Instr[15:12], Result, PCPlus8,
					RD1, RD2);
	mux2 #(32) resmux(ALUResult, ReadData, MemtoReg, Result);
	extend ext(Instr[23:0], ImmSrc, ExtImm);

	// ALU logic
	mux2 #(32) srcamux( // Mux para determinar SrcA
		.d1(RD1), 
		.d0(RD2), 
		.s(Reverse), 
		.y(SrcA)
	); 		  
	mux2 #(32) Wdmux( // Mux para determinar WriteData
		.d0(RD1), 
		.d1(RD2), 
		.s(Reverse), 
		.y(WriteData)
	); 	  
	mux2 #(32) srcbmux( // Mux para determinar SrcB
		.d0(WriteData), 
		.d1(ExtImm), 
		.s(ALUSrc), 
		.y(SrcB)
	); 
	alu alu(SrcA, SrcB, ALUControl, ALUResult, ALUFlags);

endmodule