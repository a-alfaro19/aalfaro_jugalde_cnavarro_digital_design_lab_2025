`timescale 1ns / 1ps

module alu_tb;

  // Entradas
  logic [31:0] SrcA, SrcB;
  logic [3:0]  ALUControl;

  // Salidas
  logic [31:0] ALUResult;
  logic [3:0]  ALUFlags;

  // Instanciar ALU
  alu dut (
    .SrcA(SrcA),
    .SrcB(SrcB),
    .ALUControl(ALUControl),
    .ALUResult(ALUResult),
    .ALUFlags(ALUFlags)
  );

  // Procedimiento de prueba
  initial begin
    $display("=== ALU Testbench ===");

    // AND
    SrcA = 32'hF0F0F0F0; SrcB = 32'h0F0F0F0F; ALUControl = 4'b0000; #1;
    $display("AND: %h & %h = %h, Flags = %b", SrcA, SrcB, ALUResult, ALUFlags);

    // OR
    SrcA = 32'hF0F0F0F0; SrcB = 32'h0F0F0F0F; ALUControl = 4'b0001; #1;
    $display("OR : %h | %h = %h, Flags = %b", SrcA, SrcB, ALUResult, ALUFlags);

    // ADD sin overflow
    SrcA = 32'd100; SrcB = 32'd50; ALUControl = 4'b0010; #1;
    $display("ADD: %d + %d = %d, Flags = %b", SrcA, SrcB, ALUResult, ALUFlags);

    // ADD con overflow
    SrcA = 32'h7FFFFFFF; SrcB = 32'd1; ALUControl = 4'b0010; #1;
    $display("ADD overflow: %h + %h = %h, Flags = %b", SrcA, SrcB, ALUResult, ALUFlags);

    // SUB sin overflow
    SrcA = 32'd100; SrcB = 32'd50; ALUControl = 4'b0110; #1;
    $display("SUB: %d - %d = %d, Flags = %b", SrcA, SrcB, ALUResult, ALUFlags);

    // SUB con overflow
    SrcA = 32'h80000000; SrcB = 32'd1; ALUControl = 4'b0110; #1;
    $display("SUB overflow: %h - %h = %h, Flags = %b", SrcA, SrcB, ALUResult, ALUFlags);

    // SLT (signed less than)
    SrcA = -5; SrcB = 3; ALUControl = 4'b0111; #1;
    $display("SLT: %0d < %0d = %0d, Flags = %b", SrcA, SrcB, ALUResult, ALUFlags);

    SrcA = 10; SrcB = -5; ALUControl = 4'b0111; #1;
    $display("SLT: %0d < %0d = %0d, Flags = %b", SrcA, SrcB, ALUResult, ALUFlags);

    // NOR
    SrcA = 32'hAAAAAAAA; SrcB = 32'h55555555; ALUControl = 4'b1100; #1;
    $display("NOR: ~(%h | %h) = %h, Flags = %b", SrcA, SrcB, ALUResult, ALUFlags);

    // Caso cero (Z flag)
    SrcA = 32'd5; SrcB = 32'd5; ALUControl = 4'b0110; #1;
    $display("SUB Z=1: %d - %d = %d, Flags = %b", SrcA, SrcB, ALUResult, ALUFlags);

    $display("=== Fin del testbench ===");
    $finish;
  end

endmodule
