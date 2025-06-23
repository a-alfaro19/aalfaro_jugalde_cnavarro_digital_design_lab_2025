module arm(
    input  logic clk, reset,
    output logic [31:0] PC,
    input  logic [31:0] Instr,
    output logic MemWrite,
    output logic [31:0] ALUResult, WriteData,
    input  logic [31:0] ReadData
);

    logic [3:0] ALUFlags;
    logic RegWrite, ALUSrc, MemtoReg, PCSrc;
    logic [1:0] RegSrc, ImmSrc;
    logic [2:0] ALUControl;  // ← Corrige a [2:0], no [1:0] como lo tenías

    // Ya no uses CtrlInstr ni lo recortes
    controller c(
        .clk(clk),
        .reset(reset),
        .Instr(Instr),          // ← Pasa todo el vector
        .ALUFlags(ALUFlags),
        .RegSrc(RegSrc),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .ALUControl(ALUControl),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .PCSrc(PCSrc),
        .isBL()
    );

    datapath dp(
        .clk(clk),
        .reset(reset),
        .RegSrc(RegSrc),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .ALUControl(ALUControl),
        .MemtoReg(MemtoReg),
        .PCSrc(PCSrc),
        .ALUFlags(ALUFlags),
        .PC(PC),
        .Instr(Instr),
        .ALUResult(ALUResult),
        .WriteData(WriteData),
        .ReadData(ReadData)
    );

endmodule
