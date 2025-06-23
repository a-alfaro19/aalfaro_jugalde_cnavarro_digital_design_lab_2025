`timescale 1ns / 1ps

module dmem_tb;

    logic clk = 0;
    logic [31:0] a, b, wd_a;
    logic we_a;
    logic [31:0] rd_a, rd_b;

    logic [31:0] out_paleta1;
    logic [31:0] out_paleta2;
    logic [31:0] out_bola;
    logic [31:0] out_puntaje1;
    logic [31:0] out_puntaje2;

    // Instancia del DUT
    dmem dut (
        .clk(clk),
        .a(a),
        .b(b),
        .wd_a(wd_a),
        .we_a(we_a),
        .rd_a(rd_a),
        .rd_b(rd_b),
        .out_paleta1(out_paleta1),
        .out_paleta2(out_paleta2),
        .out_bola(out_bola),
        .out_puntaje1(out_puntaje1),
        .out_puntaje2(out_puntaje2)
    );

    // Generar reloj de 100 MHz
    always #5 clk = ~clk;

    initial begin
        $display("=== INICIO TEST DMEM ===");
        a = 0;
        b = 0;
        wd_a = 0;
        we_a = 0;

        // Esperar unos ciclos para estabilizar RAM
        #20;

        // Leer paleta1 (mem[4] = 50)
        a = 32'h10;
        #10;
        $display("Paleta1 (esperado 50): %0d", out_paleta1);

        // Leer paleta2 (mem[5] = 60)
        a = 32'h14;
        #10;
        $display("Paleta2 (esperado 60): %0d", out_paleta2);

        // Leer bola (mem[6] = 0x003C0050)
        a = 32'h18;
        #10;
        $display("Bola (esperado 0x003C0050): %h", out_bola);

        // Leer puntaje1 (mem[7] = 2)
        a = 32'h1C;
        #10;
        $display("Puntaje1 (esperado 2): %0d", out_puntaje1);

        // Leer puntaje2 (mem[8] = 3)
        a = 32'h20;
        #10;
        $display("Puntaje2 (esperado 3): %0d", out_puntaje2);

        $display("=== FIN TEST DMEM ===");
        $finish;
    end

endmodule
