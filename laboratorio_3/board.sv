// board.sv – Lógica del tablero con detección y verificación interna
module board (
    input  logic        clk,
    input  logic        rst,
    input  logic [2:0]  selected_col,
    input  logic [2:0]  col_to_check,
    input  logic        current_player,
    input  logic        place_token,
    input  logic        place_token_randomly,
    input  logic        check_col,
    input  logic        check_win,
    output logic        player_moved,
    output logic [83:0] board,
    output logic [83:0] winner_play,
    output logic        column_full,
    output logic        theres_a_winner,
    output logic [2:0]  winner,
    output logic        board_full
);
    parameter int ROWS = 6, COLS = 7;
    localparam logic [1:0] EMPTY = 2'b00;
    localparam logic [1:0] P1    = 2'b01, P2 = 2'b10;

    // Estado interno
    logic [83:0] board_state;
    logic [5:0]  total_tokens;
    logic [6:0]  idx;
    logic [1:0]  mark;
    logic        placed;

    // Módulos auxiliares
    logic        win_f;
    logic [2:0]  win_id;
    logic [83:0] win_cells;
    logic        col_space;

    winner_detector det (
        .board_state   (board_state),
        .check_win     (check_win),
        .theres_a_winner(win_f),
        .winner        (win_id),
        .winner_play   (win_cells)
    );

    column_checker chk (
        .board_state(board_state),
        .check_col  (check_col),
        .column     (col_to_check),
        .column_has_space(col_space)
    );

    random_col_generator gen (
        .clk                  (clk),
        .rst                  (rst),
        .place_token_randomly (place_token_randomly),
        .board_state          (board_state),
        .random_column        (),          // no lo usamos aquí
        .random_column_valid  ()           // ni en este wrapper
    );

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            board_state   <= '0;
            total_tokens  <= 0;
            player_moved  <= 0;
        end else begin
            player_moved <= 0;
            placed       <= 0;

            // Manual
            if (place_token && !placed) begin
                mark = (current_player==0)?P1:P2;
                for (int r = ROWS-1; r>=0; r--) begin
                    idx = (r*COLS + selected_col)*2;
                    if (board_state[idx +:2]==EMPTY) begin
                        board_state[idx +:2] <= mark;
                        total_tokens <= total_tokens + 1;
                        player_moved <= 1;
                        placed <= 1;
                        break;
                    end
                end
            end
            // Automático
            else if (place_token_randomly && !placed && col_space) begin
                mark = (current_player==0)?P1:P2;
                for (int r = ROWS-1; r>=0; r--) begin
                    idx = (r*COLS + col_to_check)*2;
                    if (board_state[idx +:2]==EMPTY) begin
                        board_state[idx +:2] <= mark;
                        total_tokens <= total_tokens + 1;
                        player_moved <= 1;
                        placed <= 1;
                        break;
                    end
                end
            end
        end
    end

    // Salidas
    assign board          = board_state;
    assign board_full     = (total_tokens == ROWS*COLS);
    assign column_full    = !col_space;
    assign theres_a_winner= win_f;
    assign winner         = win_id;
    assign winner_play    = win_cells;
endmodule
