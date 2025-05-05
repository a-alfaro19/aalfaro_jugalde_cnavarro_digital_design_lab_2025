// winner_detector.sv – Detecta cuatro en línea (↓,→,↘,↗), sin declaraciones inline
module winner_detector (
    input  logic [83:0] board_state,
    input  logic        check_win,
    output logic        theres_a_winner,
    output logic [2:0]  winner,
    output logic [83:0] winner_play
);
    parameter int ROWS = 6, COLS = 7;
    localparam logic [1:0] EMPTY = 2'b00;
    localparam logic [1:0] P1    = 2'b01, P2 = 2'b10;

    // Registros de salida intermedios
    logic        win_r;
    logic [2:0]  win_id;
    logic [83:0] play_r;

    // Variables de bucle e índices
    integer row, col, base_idx, i1, i2, i3;
    logic [1:0] cv;  // valor de celda actual

    always @(*) begin
        // Inicialización por defecto
        win_r   = 1'b0;
        win_id  = 3'd0;
        play_r  = '0;

        if (check_win) begin
            for (row = 0; row < ROWS; row = row + 1) begin
                for (col = 0; col < COLS; col = col + 1) begin
                    // Calcula índice base (bits) de la celda actual
                    base_idx = (row * COLS + col) * 2;
                    cv       = board_state[base_idx +: 2];

                    if (cv != EMPTY) begin
                        // → Horizontal
                        if (col <= COLS - 4) begin
                            i1 = base_idx +  2;
                            i2 = base_idx +  4;
                            i3 = base_idx +  6;
                            if (board_state[i1 +:2]==cv &&
                                board_state[i2 +:2]==cv &&
                                board_state[i3 +:2]==cv) begin
                                win_r  = 1;
                                win_id = (cv==P1) ? 3'd1 : 3'd2;
                                play_r[row*COLS + col    ] = 1;
                                play_r[row*COLS + col + 1] = 1;
                                play_r[row*COLS + col + 2] = 1;
                                play_r[row*COLS + col + 3] = 1;
                            end
                        end

                        // ↓ Vertical
                        if (row <= ROWS - 4) begin
                            i1 = ((row+1)*COLS + col)*2;
                            i2 = ((row+2)*COLS + col)*2;
                            i3 = ((row+3)*COLS + col)*2;
                            if (board_state[i1 +:2]==cv &&
                                board_state[i2 +:2]==cv &&
                                board_state[i3 +:2]==cv) begin
                                win_r  = 1;
                                win_id = (cv==P1) ? 3'd1 : 3'd2;
                                play_r[row*COLS + col         ] = 1;
                                play_r[(row+1)*COLS + col     ] = 1;
                                play_r[(row+2)*COLS + col     ] = 1;
                                play_r[(row+3)*COLS + col     ] = 1;
                            end
                        end

                        // ↘ Diagonal principal
                        if (row <= ROWS - 4 && col <= COLS - 4) begin
                            i1 = ((row+1)*COLS + col+1)*2;
                            i2 = ((row+2)*COLS + col+2)*2;
                            i3 = ((row+3)*COLS + col+3)*2;
                            if (board_state[i1 +:2]==cv &&
                                board_state[i2 +:2]==cv &&
                                board_state[i3 +:2]==cv) begin
                                win_r  = 1;
                                win_id = (cv==P1) ? 3'd1 : 3'd2;
                                play_r[row*COLS + col         ] = 1;
                                play_r[(row+1)*COLS + col + 1 ] = 1;
                                play_r[(row+2)*COLS + col + 2 ] = 1;
                                play_r[(row+3)*COLS + col + 3 ] = 1;
                            end
                        end

                        // ↗ Diagonal secundaria
                        if (row >= 3 && col <= COLS - 4) begin
                            i1 = ((row-1)*COLS + col+1)*2;
                            i2 = ((row-2)*COLS + col+2)*2;
                            i3 = ((row-3)*COLS + col+3)*2;
                            if (board_state[i1 +:2]==cv &&
                                board_state[i2 +:2]==cv &&
                                board_state[i3 +:2]==cv) begin
                                win_r  = 1;
                                win_id = (cv==P1) ? 3'd1 : 3'd2;
                                play_r[row*COLS + col         ] = 1;
                                play_r[(row-1)*COLS + col + 1 ] = 1;
                                play_r[(row-2)*COLS + col + 2 ] = 1;
                                play_r[(row-3)*COLS + col + 3 ] = 1;
                            end
                        end
                    end
                end
            end
        end
    end

    // Conexión a salidas
    assign theres_a_winner = win_r;
    assign winner         = win_id;
    assign winner_play    = play_r;
endmodule
