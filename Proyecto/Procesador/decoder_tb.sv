`timescale 1ns/1ps

module decoder_tb;

  // Entradas
  logic [1:0] Op;
  logic [5:0] Funct;
  logic [3:0] Rd;

  // Salidas
  logic [1:0] FlagW;
  logic PCS, RegW, MemW;
  logic MemtoReg, ALUSrc;
  logic [1:0] ImmSrc, RegSrc, ALUControl;

  // Instancia del módulo
  decoder dut (
    .Op(Op),
    .Funct(Funct),
    .Rd(Rd),
    .FlagW(FlagW),
    .PCS(PCS),
    .RegW(RegW),
    .MemW(MemW),
    .MemtoReg(MemtoReg),
    .ALUSrc(ALUSrc),
    .ImmSrc(ImmSrc),
    .RegSrc(RegSrc),
    .ALUControl(ALUControl)
  );

  // Procedimiento de prueba
  initial begin
    $display("=== Testbench Decoder ===");

    // --- DP inmediato (ADD)
    Op = 2'b00; Funct = 6'b1_00100; Rd = 4'd1;
    #1 $display("DP Inm: RegSrc=%b ImmSrc=%b ALU=%b FlagW=%b PCS=%b", RegSrc, ImmSrc, ALUControl, FlagW, PCS);

    // --- DP registro (SUB con S)
    Op = 2'b00; Funct = 6'b0_00101; Rd = 4'd2; // SUB S
    #1 $display("DP Reg: RegSrc=%b ImmSrc=%b ALU=%b FlagW=%b PCS=%b", RegSrc, ImmSrc, ALUControl, FlagW, PCS);

    // --- LDR
    Op = 2'b01; Funct = 6'b000001; Rd = 4'd3;
    #1 $display("LDR   : RegSrc=%b ImmSrc=%b MemtoReg=%b ALUSrc=%b RegW=%b MemW=%b", RegSrc, ImmSrc, MemtoReg, ALUSrc, RegW, MemW);

    // --- STR
    Op = 2'b01; Funct = 6'b000000; Rd = 4'd4;
    #1 $display("STR   : RegSrc=%b ImmSrc=%b MemtoReg=%b ALUSrc=%b RegW=%b MemW=%b", RegSrc, ImmSrc, MemtoReg, ALUSrc, RegW, MemW);

    // --- B (branch)
    Op = 2'b10; Funct = 6'bxxxxxx; Rd = 4'd0; // Rd no importa
    #1 $display("BRANCH: RegSrc=%b ImmSrc=%b Branch=1 PCS=%b", RegSrc, ImmSrc, PCS);

    // --- DP al PC (ej: MOV PC, Rx)
    Op = 2'b00; Funct = 6'b0_11000; Rd = 4'b1111;
    #1 $display("DP to PC: PCS=%b RegW=%b", PCS, RegW);

    $display("=== Fin del test ===");
    $finish;
  end

endmodule
