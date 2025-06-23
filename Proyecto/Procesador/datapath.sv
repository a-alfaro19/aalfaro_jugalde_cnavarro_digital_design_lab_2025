module datapath(
    input  logic        clk, reset,
    input  logic [1:0]  RegSrc,
    input  logic        RegWrite,
    input  logic [1:0]  ImmSrc,
    input  logic        ALUSrc,
    input  logic [2:0]  ALUControl,
    input  logic        MemtoReg,
    input  logic        PCSrc,
    input  logic        isBL,         // <== NUEVO INPUT
    output logic [3:0]  ALUFlags,
    output logic [31:0] PC,
    input  logic [31:0] Instr,
    output logic [31:0] ALUResult, WriteData,
    input  logic [31:0] ReadData
);

    logic [31:0] PCNext, PCPlus4, PCPlus8;
    logic [31:0] ExtImm, SrcA, SrcB, Result;
    logic [3:0] RA1, RA2, WA3;

    // --- PC logic
    mux2 #(32) pcmux(PCPlus4, SrcA, PCSrc, PCNext);
    flopr #(32) pcreg(clk, reset, PCNext, PC);
    adder #(32) pcadd1(PC, 32'd4, PCPlus4);
    adder #(32) pcadd2(PCPlus4, 32'd4, PCPlus8);

    // --- Multiplexor extendido para RA1 y RA2
    always_comb begin
        case (RegSrc)
            2'b00: begin
                RA1 = Instr[19:16];
                RA2 = Instr[3:0];
            end
            2'b01: begin
                RA1 = Instr[19:16];
                RA2 = Instr[15:12];
            end
            2'b10: begin
                RA1 = 4'b1110; // LR
                RA2 = 4'b1111; // PC
            end
            default: begin
                RA1 = 4'b0000;
                RA2 = 4'b0000;
            end
        endcase
    end

    // --- Dirección de escritura (BL fuerza a LR)
    assign WA3 = isBL ? 4'd14 : Instr[15:12];

    // --- Registro
    regfile rf(
        .clk(clk),
        .we3(RegWrite),
        .ra1(RA1),
        .ra2(RA2),
        .wa3(WA3),
        .wd3(isBL ? PCPlus8 : Result),
        .r15(PCPlus8),
        .rd1(SrcA),
        .rd2(WriteData)
    );

    // --- ALU
    mux2 #(32) resmux(ALUResult, ReadData, MemtoReg, Result);
    extend ext(Instr[23:0], ImmSrc, ExtImm);
    mux2 #(32) srcbmux(WriteData, ExtImm, ALUSrc, SrcB);
    alu alu(SrcA, SrcB, ALUControl, Instr[11:7], Instr[6:5], ALUResult, ALUFlags);

    // --- Verificación BX LR
    always_ff @(posedge clk) begin
	 if (RegWrite && WA3 == 4'd14) begin
        $display("✅ Guardado correcto en LR (R14) con PC+8: %h", isBL ? PCPlus8 : Result);
    end
    if (PCSrc && RegSrc == 2'b10) begin
        $display(">> BX lr ejecutado. Saltando a dirección: %h", SrcA); // <== CAMBIADO
    end

    if (RegWrite && Instr[15:12] == 4'b1110) begin
        $display(">> Escribiendo en LR (R14): %h", Result);
    end
end

endmodule
