`timescale 1ns / 1ps

module top_tb;

    // Señales de entrada
    logic clk;
    logic reset;
    logic [3:0] botones;

    // Señales de salida
    logic [7:0] paleta_j1_y;
    logic [7:0] paleta_j2_y;
    logic [31:0] bola_xy;
    logic [3:0] puntaje_j1;
    logic [3:0] puntaje_j2;

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

    // Generador de reloj: 50 MHz (periodo 20 ns)
    always #10 clk = ~clk;

    // Proceso de estimulación
    initial begin
        // Inicialización
        clk = 0;
        reset = 1;
        botones = 4'b0000;

        // Espera de reset
        #100;
        reset = 0;

        // Espera unos ciclos para observar el estado inicial
        #200;

        // Simula que el jugador 1 presiona "arriba"
        botones[0] = 1;
        #40;
        botones[0] = 0;

        // Simula que el jugador 2 presiona "abajo"
        #100;
        botones[3] = 1;
        #40;
        botones[3] = 0;

        // Ejecuta más ciclos y observa el juego
        #1000;

        // Fin de simulación
        $stop;
    end

endmodule