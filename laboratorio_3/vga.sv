// vga.sv
// -----------------
// Top-level VGA + tu lógica de Conecta-4 (en modo automático)
module vga (
    input  logic       clk,         // 50 MHz
    input  logic       reset_n,     // Reset activo-bajo
    output logic       hsync, vsync,
    output logic [7:0] r, g, b
);
    // 1) PLL → vgaclk (~25 MHz)
    logic vgaclk;
    pll u_pll (
        .clk_in  (clk),
        .reset_n (reset_n),
        .clk_out (vgaclk)
    );

    // 2) VGA timing
    logic [9:0] x,y; logic blank_b, sync_b;
    vgaController u_vc (
        .vgaclk   (vgaclk),
        .reset_n  (reset_n),
        .hsync    (hsync),
        .vsync    (vsync),
        .blank_b  (blank_b),
        .sync_b   (sync_b),
        .x        (x),
        .y        (y)
    );

    // 3) Señales de juego
    logic        player_moved, board_full, theres_a_winner;
    logic [2:0]  current_state, random_column;
    logic [83:0] board_state, winner_play;
    logic        random_valid, timer_out;
    logic        current_player, timer_start;
    // Siempre jugamos automático
    logic        place_token_randomly = 1'b1;

    // 4) FSM de turnos
    FSM_Game u_fsm (
        .clk           (vgaclk),
        .rst           (~reset_n),       // reset activo-alto
        .start_default (1'b1),
        .timer_out     (timer_out),
        .player_mov    (player_moved),
        .full_board    (board_full),
        .winner        (theres_a_winner),
        .current_state (current_state)
    );

    // 5) Timer
    assign timer_start = (current_state == 3'd1) || (current_state == 3'd2);
    timer u_timer (
        .clk       (vgaclk),
        .rst       (~reset_n),
        .start     (timer_start),
        .time_out  (timer_out)
    );

    // 6) Generador de columna aleatoria
    assign current_player = (current_state == 3'd2);
    random_col_generator u_rand (
        .clk                  (vgaclk),
        .rst                  (~reset_n),
        .place_token_randomly (place_token_randomly),
        .board_state          (board_state),
        .random_column        (random_column),
        .random_column_valid  (random_valid)
    );

    // 7) Lógica del tablero
    board u_board (
        .clk                  (vgaclk),
        .rst                  (~reset_n),
        .selected_col         (random_column),
        .col_to_check         (random_column),
        .current_player       (current_player),
        .place_token          (random_valid),
        .place_token_randomly (place_token_randomly),
        .check_col            (1'b1),
        .check_win            (1'b1),
        .player_moved         (player_moved),
        .board                (board_state),
        .winner_play          (winner_play),
        .column_full          (),              // no usado
        .board_full           (board_full),
        .theres_a_winner      (theres_a_winner),
        .winner               ()               // no usado
    );

    // 8) Generación de RGB
    videoGen u_vg (
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
