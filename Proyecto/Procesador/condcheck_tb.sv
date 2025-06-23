`timescale 1ns/1ps

module condcheck_tb();

  // Entradas
  logic [3:0] Cond;
  logic [3:0] Flags;

  // Salida
  logic CondEx;

  // Instancia DUT
  condcheck dut (
    .Cond(Cond),
    .Flags(Flags),
    .CondEx(CondEx)
  );

  task print_test(input string testname);
    $display("Test %s:", testname);
    $display("  Cond = %b, Flags = %b --> CondEx = %b", Cond, Flags, CondEx);
    $display("----------------------------");
  endtask

  initial begin
    $display("=== Testbench condcheck ===");

    // Flags: {neg, zero, carry, overflow}
    // Probaremos las condiciones más comunes:

    // EQ: Cond=0000, CondEx=1 si zero=1
    Cond = 4'b0000; Flags = 4'b0100; // zero=1 (bit1=1?), pero en tu asignación zero=Flags[2]
    // Con tu asignación: assign {neg, zero, carry, overflow} = Flags;
    // Flags[3]=neg, Flags[2]=zero, Flags[1]=carry, Flags[0]=overflow
    Flags = 4'b0100; // zero=1 (bit2), otros 0
    #5; print_test("EQ Z=1");

    Flags = 4'b0000; // zero=0
    #5; print_test("EQ Z=0");

    // NE: Cond=0001, CondEx=1 si zero=0
    Cond = 4'b0001; Flags = 4'b0000; // zero=0
    #5; print_test("NE Z=0");

    Flags = 4'b0100; // zero=1
    #5; print_test("NE Z=1");

    // CS: Cond=0010, CondEx=carry=1
    Cond = 4'b0010; Flags = 4'b0010; // carry=1 (bit1)
    #5; print_test("CS carry=1");

    Flags = 4'b0000; // carry=0
    #5; print_test("CS carry=0");

    // CC: Cond=0011, CondEx=~carry
    Cond = 4'b0011; Flags = 4'b0000; // carry=0
    #5; print_test("CC carry=0");

    Flags = 4'b0010; // carry=1
    #5; print_test("CC carry=1");

    // MI: Cond=0100, CondEx=neg=1
    Cond = 4'b0100; Flags = 4'b1000; // neg=1 (bit3)
    #5; print_test("MI neg=1");

    Flags = 4'b0000; // neg=0
    #5; print_test("MI neg=0");

    // PL: Cond=0101, CondEx=~neg
    Cond = 4'b0101; Flags = 4'b0000; // neg=0
    #5; print_test("PL neg=0");

    Flags = 4'b1000; // neg=1
    #5; print_test("PL neg=1");

    // VS: Cond=0110, CondEx=overflow=1
    Cond = 4'b0110; Flags = 4'b0001; // overflow=1 (bit0)
    #5; print_test("VS overflow=1");

    Flags = 4'b0000; // overflow=0
    #5; print_test("VS overflow=0");

    // VC: Cond=0111, CondEx=~overflow
    Cond = 4'b0111; Flags = 4'b0000; // overflow=0
    #5; print_test("VC overflow=0");

    Flags = 4'b0001; // overflow=1
    #5; print_test("VC overflow=1");

    // HI: Cond=1000, CondEx=carry & ~zero
    Cond = 4'b1000; Flags = 4'b0010; // carry=1, zero=0
    #5; print_test("HI carry=1 zero=0");

    Flags = 4'b0110; // carry=1 zero=1
    #5; print_test("HI carry=1 zero=1");

    // LS: Cond=1001, CondEx=~(carry & ~zero)
    Cond = 4'b1001; Flags = 4'b0110; // carry=1 zero=1
    #5; print_test("LS carry=1 zero=1");

    Flags = 4'b0010; // carry=1 zero=0
    #5; print_test("LS carry=1 zero=0");

    // GE: Cond=1010, CondEx=ge = (neg==overflow)
    Cond = 4'b1010; Flags = 4'b1001; // neg=1 overflow=1
    #5; print_test("GE neg=1 overflow=1");

    Flags = 4'b1000; // neg=1 overflow=0
    #5; print_test("GE neg=1 overflow=0");

    // LT: Cond=1011, CondEx=~ge
    Cond = 4'b1011; Flags = 4'b1000; // neg=1 overflow=0 ge=0
    #5; print_test("LT ge=0");

    Flags = 4'b1001; // neg=1 overflow=1 ge=1
    #5; print_test("LT ge=1");

    // GT: Cond=1100, CondEx=~zero & ge
    Cond = 4'b1100; Flags = 4'b1000; // zero=0 ge=0 (neg=1 overflow=0)
    #5; print_test("GT zero=0 ge=0");

    Flags = 4'b1101; // zero=0 ge=1 (neg=1 overflow=1)
    #5; print_test("GT zero=0 ge=1");

    Flags = 4'b0101; // zero=1 ge=0 (neg=0 overflow=1)
    #5; print_test("GT zero=1 ge=0");

    // LE: Cond=1101, CondEx=~(~zero & ge)
    Cond = 4'b1101; Flags = 4'b0101; // zero=1 ge=0
    #5; print_test("LE zero=1 ge=0");

    Flags = 4'b1100; // zero=0 ge=1
    #5; print_test("LE zero=0 ge=1");

    // Always: Cond=1110, CondEx=1
    Cond = 4'b1110; Flags = 4'b0000;
    #5; print_test("Always");

    $display("=== Fin del testbench ===");
    $finish;
  end

endmodule
