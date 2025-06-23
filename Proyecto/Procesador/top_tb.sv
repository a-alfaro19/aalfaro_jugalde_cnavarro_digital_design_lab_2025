`timescale 1ns / 1ps

module top_tb;

    logic clk = 0, reset;
    logic [3:0] botones;

    logic [7:0] paleta_j1_y, paleta_j2_y;
    logic [31:0] bola_xy;
    logic [3:0] puntaje_j1, puntaje_j2;

    top dut (
        .clk(clk),
        .reset(reset),
        .botones(botones),
        .paleta_j1_y(paleta_j1_y),
        .paleta_j2_y(paleta_j2_y),
        .bola_xy(bola_xy),
        .puntaje_j1(puntaje_j1),
        .puntaje_j2(puntaje_j2)
    );

    always #10 clk = ~clk; // 100 MHz

    initial begin
        reset = 1;
        botones = 4'b0000;

        $display("Iniciando simulación...");
        #20;
        reset = 0;

        #50 botones = 4'b0001;
        #50 botones = 4'b0010;
        #50 botones = 4'b0000;

        repeat (100) begin
            #10;
            $display("Paleta1=%d | Paleta2=%d | Bola=%h | P1=%d | P2=%d",
					paleta_j1_y, paleta_j2_y, bola_xy, puntaje_j1, puntaje_j2);
        end

        $display("Fin de simulación");
        $finish;
    end

    // Trampa de timeout
    initial begin
        #10000;
    end

endmodule
