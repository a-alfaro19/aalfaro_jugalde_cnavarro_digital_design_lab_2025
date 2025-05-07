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
	 output logic [6:0] display,
	 output logic [6:0] anode,
    output logic        vgaclk
);

    logic [9:0] x, y;
    logic pll_locked;

    logic [6:0] sw_rising_edge;
    logic [6:0] sw_falling_edge;
    logic [2:0] board_logic [5:0][6:0];   // Tablero de gameLogic
    logic [2:0] board_winner [5:0][6:0];  // Tablero de checkWinner
    logic [2:0] board_out [5:0][6:0];     // Tablero final para videoGen
    logic [1:0] jugador;                  
    logic inserted;                      
    logic juego_terminado;


    
    logic [3:0] segundos_decenas;
    logic [3:0] segundos_unidades;

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

    // Alternancia de jugadores
    always_ff @(posedge vgaclk or posedge rst) begin
        if (rst) begin
            jugador <= 2'b01; // Inicia con el jugador 1 (rojo)
        end else if (inserted) begin
            jugador <= (jugador == 2'b01) ? 2'b10 : 2'b01;
        end
    end
	 
	 timer timer_inst (
        .clk(vgaclk),
        .rst(rst),
        .enable(1'b1),
        .timeout(),
        .segundos_decenas(segundos_decenas),
        .segundos_unidades(segundos_unidades)
    );

    // Controlador de Display de 7 segmentos
    DisplayController display_ctrl (
        .clk(vgaclk),
        .rst(rst),
        .segundos_unidades(segundos_unidades),
        .segundos_decenas(segundos_decenas),
        .display_unidades(display[6:0]), // Conexión directa al display de unidades
        .display_decenas(anode[6:0])    // Conexión directa al display de decenas
    );

    // Lógica del juego: coloca fichas y actualiza el tablero
    gameLogic game_inst (
        .clk            (vgaclk),
        .rst            (rst),
        .pulses         (sw_rising_edge),
        .jugador        (jugador),
        .juego_terminado(juego_terminado),
        .inserted       (inserted),
        .board          (board_logic)  // Tablero generado por la lógica
    );

    // Verificación de ganador
    checkWinner winner_inst (
        .clk             (vgaclk),
        .rst             (rst),
        .board           (board_logic),
        .board_out       (board_winner),
        .juego_terminado (juego_terminado)
    );

    // MUX para seleccionar el tablero final
    always_comb begin
        if (juego_terminado) begin
            // Si hay un ganador, el tablero ganador se muestra
            for (int i = 0; i < 6; i++) begin
                for (int j = 0; j < 7; j++) begin
                    board_out[i][j] = board_winner[i][j];
                end
            end
        end else begin
            // Caso normal, se muestra el tablero de la lógica
            for (int i = 0; i < 6; i++) begin
                for (int j = 0; j < 7; j++) begin
                    board_out[i][j] = board_logic[i][j];
                end
            end
        end
    end

    // Generador de video
    videoGen video_inst (
        .vgaclk (vgaclk),
        .x      (x),
        .y      (y),
        .board  (board_out),
        .red    (red),
        .green  (green),
        .blue   (blue)
    );

endmodule