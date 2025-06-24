// Módulo top VGA: conecta PLL, controlador VGA y generador de video con señales del juego.
module vga (
    input  logic        clk,             // Reloj de sistema (ej. 50 MHz)
    input  logic [83:0] board_state,     // Estado del juego (frame buffer / puntuaciones)
    input  logic [83:0] winner_play,     // Indicadores de celdas ganadoras (no usado en Pong)
    input  logic        theres_a_winner, // Indica si hay un ganador
    input  logic [2:0]  current_state,   // Estado de la máquina del juego
    output logic        vgaclk,          // Reloj de píxel generado por el PLL
    output logic        hsync, vsync,    // Señales de sincronización VGA
    output logic        sync_b, blank_b, // Señales de control VGA adicionales
    output logic [7:0]  r, g, b          // Salidas de color RGB para VGA
);
    logic [9:0] x, y; // Coordenadas actuales de píxel

    // Generador de reloj VGA (PLL/divisor)
    pll vga_pll (
        .inclk0(clk),
        .c0(vgaclk)
    );

    // Controlador VGA: genera sync y coord. usando vgaclk
    vga_controller vga_ctrl (
        .vgaclk(vgaclk),
        .hsync(hsync),
        .vsync(vsync),
        .sync_b(sync_b),
        .blank_b(blank_b),
        .x(x),
        .y(y)
    );

    // Generador de video: convierte estado del juego en color de píxel
    videoGen video_gen (
        .blank_b(blank_b),
        .x(x),
        .y(y),
        .board_state(board_state),
        .winner_play(winner_play),
        .theres_a_winner(theres_a_winner),
        .current_state(current_state),
        .r(r),
        .g(g),
        .b(b)
    );

endmodule
