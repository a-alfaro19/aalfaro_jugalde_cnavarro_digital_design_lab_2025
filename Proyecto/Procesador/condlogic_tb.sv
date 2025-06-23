`timescale 1ns/1ps

module condlogic_tb;

  // Entradas
  logic clk, reset;
  logic [3:0] Cond;
  logic [3:0] ALUFlags;
  logic [1:0] FlagW;
  logic PCS, RegW, MemW;

  // Salidas
  logic PCSrc, RegWrite, MemWrite;

  // DUT
  condlogic dut (
    .clk(clk),
    .reset(reset),
    .Cond(Cond),
    .ALUFlags(ALUFlags),
    .FlagW(FlagW),
    .PCS(PCS),
    .RegW(RegW),
    .MemW(MemW),
    .PCSrc(PCSrc),
    .RegWrite(RegWrite),
    .MemWrite(MemWrite)
  );

  // Clock
  always #5 clk = ~clk;

  task show(string msg);
    $display("%0t: %s", $time, msg);
    $display(" Cond=%b ALUFlags=%b FlagW=%b PCS=%b RegW=%b MemW=%b",
             Cond, ALUFlags, FlagW, PCS, RegW, MemW);
    $display(" PCSrc=%b RegWrite=%b MemWrite=%b", PCSrc, RegWrite, MemWrite);
    $display("----------------------------");
  endtask

  initial begin
    $display("=== Testbench condlogic ===");

    clk = 0;
    reset = 1;
    Cond = 4'b0000; // EQ
    ALUFlags = 4'b0000; // Z = 0
    FlagW = 2'b11;
    PCS = 1;
    RegW = 1;
    MemW = 1;

    #10 reset = 0;  // salir del reset
    #10;

    show("Cond=EQ, Z=0 => NO se ejecuta");

    ALUFlags = 4'b0100; // Z = 1
	 @(posedge clk); #1;
    #10 show("Cond=EQ, Z=1 => Ejecuta todo");

    Cond = 4'b0001; // NE
    ALUFlags = 4'b0000; // Z = 0
	 @(posedge clk); #1;
    #10 show("Cond=NE, Z=0 => Ejecuta todo");

    Cond = 4'b1110; // Always
    FlagW = 2'b00; // No escribir flags
	 @(posedge clk); #1;
    #10 show("Cond=AL, FlagW=00 => Ejecuta todo pero no escribe flags");

    $display("=== Fin del testbench ===");
    $finish;
  end
endmodule

