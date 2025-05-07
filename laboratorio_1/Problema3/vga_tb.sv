`timescale 1ns/1ps

// vga_tb.sv – Testbench para el top‐level VGA integrado con la lógica de Conecta-4
module vga_tb;
    // Parámetros del tablero
    localparam int ROWS = 6;
    localparam int COLS = 7;

    // Señales de clock y reset
    logic        clk;
    logic        reset_n;

    // Salidas VGA
    wire         hsync, vsync;
    wire [7:0]   r, g, b;

    // Instancia del DUT
    vga uut (
        .clk      (clk),
        .reset_n  (reset_n),
        .hsync    (hsync),
        .vsync    (vsync),
        .r        (r),
        .g        (g),
        .b        (b)
    );

    // Generador de reloj de 50 MHz (periodo 20 ns)
    initial clk = 0;
    always #10 clk = ~clk;

    // Reset activo-bajo: 0→1 después de 100 ns
    initial begin
        reset_n = 0;
        #100;
        reset_n = 1;
    end

    // Volcado de señales a VCD para GTKWave (opcional)
    initial begin
        $dumpfile("vga_tb.vcd");
        $dumpvars(0, uut);
    end

    // Variables para el monitor ASCII del tablero
    integer row, col, idx, ply;
    logic [1:0] cell_val;

    // Monitor de jugadas y fin de partida
    always @(posedge clk) begin
        // Cuando board indique movimiento
        if (uut.u_board.player_moved) begin
            ply = uut.u_board.current_player ? 2 : 1;
            $display("\nTime %0t ns: Player %0d moved. Board state:", $time, ply);
            for (row = ROWS-1; row >= 0; row = row - 1) begin
                $write("Row %0d: ", row);
                for (col = 0; col < COLS; col = col + 1) begin
                    idx     = (row*COLS + col)*2;
                    cell_val = uut.u_board.board[idx +: 2];
                    case (cell_val)
                        2'b00: $write(". ");
                        2'b01: $write("X ");
                        2'b10: $write("O ");
                        default: $write("? ");
                    endcase
                end
                $display("");
            end
        end

        // Cuando alguien gane
        if (uut.u_board.theres_a_winner) begin
            $display("\n*** TEST PASSED: Player %0d WINS at %0t ns ***\n",
                     uut.u_board.winner, $time);
            #1000;
            $finish;
        end

        // Cuando empate
        if (uut.u_board.board_full) begin
            $display("\n*** TEST PASSED: DRAW (board full) at %0t ns ***\n",
                     $time);
            #1000;
            $finish;
        end
    end

    // Timeout para evitar simulación infinita (1 ms)
    initial begin
        #4_000_000;
        $display("\n*** TIMEOUT: No win/draw after %0t ns, aborting ***\n", $time);
        $finish;
    end

endmodule
