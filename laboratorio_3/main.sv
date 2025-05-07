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
    logic [6:0] sw_falling_edge;
    logic [2:0] board [5:0][6:0]; // 6 filas, 7 columnas (para Conecta 4)
    logic [1:0] jugador;           // Jugador actual
    logic inserted;                // Señal de ficha insertada
    logic juego_terminado;         // Señal para indicar si el juego terminó

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
    
    // Detector de flanco de bajada (por si quieres usarlo después)
    falling_edge_detector faldet_inst (
        .clk          (vgaclk),
        .reset        (rst),
        .signal_in    (sw),
        .falling_edge (sw_falling_edge)
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

    // Alternancia de jugadores
    always_ff @(posedge vgaclk or posedge rst) begin
        if (rst) begin
            jugador <= 2'b01; // Inicia con el jugador 1 (rojo)
        end else if (inserted) begin
            jugador <= (jugador == 2'b01) ? 2'b10 : 2'b01;
        end
    end

    // Lógica del juego: coloca fichas y actualiza el tablero
    gameLogic game_inst (
        .clk            (vgaclk),
        .rst            (rst),
        .pulses         (sw_rising_edge),  // Conectamos los flancos de subida
        .jugador        (jugador),         // Jugador actual
        .juego_terminado(juego_terminado), // Si el juego ha terminado
        .inserted       (inserted),        // Señal de ficha insertada
        .board          (board)            // Tablero del juego
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