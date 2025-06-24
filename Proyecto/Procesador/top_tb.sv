`timescale 1ns/1ps

module top_tb;

    // Entradas
    reg clk, reset;
    reg [3:0] botones;

    // Salidas
    wire [7:0] paleta_j1_y, paleta_j2_y;
    wire [31:0] bola_xy;
    wire [3:0] puntaje_j1, puntaje_j2;

    // Instancia del módulo top
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

    // Generador de reloj: 100 MHz
    always #5 clk = ~clk;

    initial begin
        $display("==== SIMULACIÓN PONG ====");
        $monitor("T=%0t | Y1=%0d | Y2=%0d | Bola=%h | P1=%0d | P2=%0d", 
                  $time, paleta_j1_y, paleta_j2_y, bola_xy, puntaje_j1, puntaje_j2);

        // Inicialización
        clk = 0;
        reset = 1;
        botones = 4'b0000;

        #20;
        reset = 0;

        // Esperar a que el juego comience
        #100;

        // Botón paleta J1 arriba
        botones = 4'b0001;
        #20;
        botones = 4'b0000;

        // Esperar un tiempo
        #200;

        // Botón paleta J2 abajo
        botones = 4'b1000;
        #20;
        botones = 4'b0000;

        // Esperar que la bola se mueva y/o rebote
        #1000;

        $stop;
    end

endmodule
