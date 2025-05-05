// vga.sv – Top‐level integrando VGA y lógica de juego
module vga (
    input  logic       clk,       // 50 MHz
    input  logic       reset_n,   // reset activo-bajo
    output logic       hsync,
    output logic       vsync,
    output logic [7:0] r,
    output logic [7:0] g,
    output logic [7:0] b
);
    // Pll y clock de pixel
    logic vgaclk;
    pll u_pll (
        .clk_in  (clk),
        .reset_n (reset_n),
        .clk_out (vgaclk)
    );

    // Sincronías VGA
    logic [9:0] x, y;
    logic       blank_b, sync_b;
    vgaController u_vga (
        .vgaclk   (vgaclk),
        .reset_n  (reset_n),
        .hsync    (hsync),
        .vsync    (vsync),
        .blank_b  (blank_b),
        .sync_b   (sync_b),
        .x        (x),
        .y        (y)
    );

    // Variables de juego
    logic [83:0] board_state, winner_play;
    logic        theres_a_winner, board_full, player_moved;
    logic [2:0]  current_state;
    logic        current_player;

    // FSM de turnos (rst activo-alto = ~reset_n)
    logic timer_out;
    FSM_Game u_fsm (
        .clk           (vgaclk),
        .rst           (~reset_n),
        .start_default (1'b1),
        .timer_out     (timer_out),
        .player_mov    (player_moved),
        .full_board    (board_full),
        .winner        (theres_a_winner),
        .current_state (current_state)
    );

    // Determinar jugador actual
    assign current_player = (current_state == 3'd2);

    // Señales de “auto-jugada”
    logic check_col = 1'b1, check_win = 1'b1;
    logic place_token_randomly = 1'b1;

    // Lógica del tablero (rst activo-alto)
    board u_board (
        .clk                  (vgaclk),
        .rst                  (~reset_n),
        .selected_col         (3'd0),             // ignorable en modo random
        .col_to_check         (3'd0),             // ignorable en modo random
        .current_player       (current_player),
        .place_token          (1'b0),             // nunca manual
        .place_token_randomly (place_token_randomly),
        .check_col            (check_col),
        .check_win            (check_win),
        .player_moved         (player_moved),
        .board                (board_state),
        .winner_play          (winner_play),
        .column_full          (),
        .board_full           (board_full),
        .theres_a_winner      (theres_a_winner),
        .winner               ()
    );

    // Generación de color
    videoGen u_video (
        .blank_b         (blank_b),
        .x               (x),
        .y               (y),
        .board_state     (board_state),
        .winner_play     (winner_play),
        .theres_a_winner (theres_a_winner),
        .r               (r),
        .g               (g),
        .b               (b)
    );
endmodule
