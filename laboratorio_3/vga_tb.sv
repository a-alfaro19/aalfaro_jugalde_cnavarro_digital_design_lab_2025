// vga_tb.sv – Testbench con auto‐verificación de fin de juego
`timescale 1ns/1ps
module vga_tb;
    logic        clk, reset_n;
    wire         hsync, vsync;
    wire [7:0]   r, g, b;

    // Instanciamos el DUT
    vga uut (
        .clk      (clk),
        .reset_n  (reset_n),
        .hsync    (hsync),
        .vsync    (vsync),
        .r        (r),
        .g        (g),
        .b        (b)
    );

    // Reloj 50 MHz
    initial clk = 0; always #10 clk = ~clk;

    // Reset asíncrono
    initial begin
        reset_n = 0;
        #100;
        reset_n = 1;
    end

    // VCD (opcional)
    initial begin
        $dumpfile("vga_tb.vcd");
        $dumpvars(0, uut);
    end

    // Espera fin de juego y reporta
    initial begin
        // Nota: simular con vsim -access +r work.vga_tb
        wait (uut.u_board.theres_a_winner || uut.u_board.board_full);
        if (uut.u_board.theres_a_winner)
            $display("\n*** TEST PASSED: Player %0d WINS at %0t ns ***\n",
                     uut.u_board.winner, $time);
        else
            $display("\n*** TEST PASSED: DRAW (board full) at %0t ns ***\n",
                     $time);
        #1000;
        $finish;
    end
endmodule
