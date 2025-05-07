module main (
    input  logic        clk,    // 50MHz
    input  logic        rst,
    input  logic [6:0]  sw,
    output logic        hsync,
    output logic        vsync,
    output logic        sync_b,
    output logic        blank_b,
    output logic [7:0]  red,
    output logic [7:0]  green,
    output logic [7:0]  blue,
    output logic        vgaclk
);

    logic [9:0] x, y;
    logic pll_locked;

    logic [6:0] sw_rising_edge;
    logic [2:0] board [5:0][6:0]; // 6 filas, 7 columnas (para Conecta 4)

    // PLL para generar vgaclk
    clkpll pll_inst (
        .refclk   (clk),
        .rst      (rst),
        .outclk_0 (vgaclk),
        .locked   (pll_locked)
    );

    // Detector de flanco de subida
    rising_edge_detector redet_inst (
        .clk         (vgaclk),
        .reset       (rst),
        .signal_in   (sw),
        .rising_edge (sw_rising_edge)
    );

    // Controlador VGA
    vgaController vga_inst (
        .vgaclk  (vgaclk),
        .hsync   (hsync),
        .vsync   (vsync),
        .sync_b  (sync_b),
        .blank_b (blank_b),
        .x       (x),
        .y       (y)
    );

    // Lógica del juego: coloca fichas y actualiza el tablero
    gameLogic game_inst (
        .clk            (vgaclk),
        .rst            (rst),
        .sw_rising_edge (sw_rising_edge),
        .board          (board)
    );

    // Generador de video: solo dibuja en pantalla
    videoGen video_inst (
        .vgaclk (vgaclk),
        .x      (x),
        .y      (y),
        .board  (board),
        .red    (red),
        .green  (green),
        .blue   (blue)
    );

endmodule