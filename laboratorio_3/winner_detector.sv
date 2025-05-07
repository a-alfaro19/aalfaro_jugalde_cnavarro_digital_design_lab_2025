// winner_detector.sv – Detecta cuatro en línea (↓, →, ↘, ↗)
// Versión minimalmente modificada para eliminar inicializaciones no constantes
module winner_detector (
    input  logic [83:0] board_state,
    input  logic        check_win,
    output logic        theres_a_winner,
    output logic [2:0]  winner,
    output logic [83:0] winner_play
);

    parameter int ROWS     = 6;
    parameter int COLS     = 7;
    localparam logic [1:0]
        EMPTY    = 2'b00,
        PLAYER_1 = 2'b01,
        PLAYER_2 = 2'b10;

    always @(*) begin
        // Reset de salidas
        theres_a_winner = 1'b0;
        winner          = 3'd0;
        winner_play     = '0;

        if (check_win) begin
            // Declaramos índices sin inicialización aquí
            int base_idx;
            int i1, i2, i3;
            logic [1:0] cell_value;

            // Recorremos filas y columnas
            for (int row = 0; row < ROWS; row++) begin
                for (int col = 0; col < COLS; col++) begin
                    // Calculamos base_idx dentro del bucle
                    base_idx   = (row * COLS + col) * 2;
                    cell_value = board_state[base_idx +: 2];

                    if (cell_value != EMPTY) begin
                        // → Horizontal
                        if (col <= COLS - 4) begin
                            i1 = base_idx + 2*1;
                            i2 = base_idx + 2*2;
                            i3 = base_idx + 2*3;
                            if (board_state[i1 +: 2] == cell_value &&
                                board_state[i2 +: 2] == cell_value &&
                                board_state[i3 +: 2] == cell_value) begin
                                theres_a_winner           = 1'b1;
                                winner                    = (cell_value == PLAYER_1) ? 3'd1 : 3'd2;
                                winner_play[row*COLS+col]     = 1'b1;
                                winner_play[row*COLS+col + 1] = 1'b1;
                                winner_play[row*COLS+col + 2] = 1'b1;
                                winner_play[row*COLS+col + 3] = 1'b1;
                            end
                        end

                        // ↓ Vertical
                        if (row <= ROWS - 4) begin
                            i1 = ((row+1)*COLS + col)*2;
                            i2 = ((row+2)*COLS + col)*2;
                            i3 = ((row+3)*COLS + col)*2;
                            if (board_state[i1 +: 2] == cell_value &&
                                board_state[i2 +: 2] == cell_value &&
                                board_state[i3 +: 2] == cell_value) begin
                                theres_a_winner               = 1'b1;
                                winner                        = (cell_value == PLAYER_1) ? 3'd1 : 3'd2;
                                winner_play[row*COLS+col]         = 1'b1;
                                winner_play[(row+1)*COLS+col]     = 1'b1;
                                winner_play[(row+2)*COLS+col]     = 1'b1;
                                winner_play[(row+3)*COLS+col]     = 1'b1;
                            end
                        end

                        // ↘ Diagonal principal
                        if (row <= ROWS - 4 && col <= COLS - 4) begin
                            i1 = ((row+1)*COLS + (col+1))*2;
                            i2 = ((row+2)*COLS + (col+2))*2;
                            i3 = ((row+3)*COLS + (col+3))*2;
                            if (board_state[i1 +: 2] == cell_value &&
                                board_state[i2 +: 2] == cell_value &&
                                board_state[i3 +: 2] == cell_value) begin
                                theres_a_winner               = 1'b1;
                                winner                        = (cell_value == PLAYER_1) ? 3'd1 : 3'd2;
                                winner_play[row*COLS+col]         = 1'b1;
                                winner_play[(row+1)*COLS+col+1]     = 1'b1;
                                winner_play[(row+2)*COLS+col+2]     = 1'b1;
                                winner_play[(row+3)*COLS+col+3]     = 1'b1;
                            end
                        end

                        // ↗ Diagonal secundaria
                        if (row >= 3 && col <= COLS - 4) begin
                            i1 = ((row-1)*COLS + (col+1))*2;
                            i2 = ((row-2)*COLS + (col+2))*2;
                            i3 = ((row-3)*COLS + (col+3))*2;
                            if (board_state[i1 +: 2] == cell_value &&
                                board_state[i2 +: 2] == cell_value &&
                                board_state[i3 +: 2] == cell_value) begin
                                theres_a_winner               = 1'b1;
                                winner                        = (cell_value == PLAYER_1) ? 3'd1 : 3'd2;
                                winner_play[row*COLS+col]         = 1'b1;
                                winner_play[(row-1)*COLS+col+1]     = 1'b1;
                                winner_play[(row-2)*COLS+col+2]     = 1'b1;
                                winner_play[(row-3)*COLS+col+3]     = 1'b1;
                            end
                        end
                    end
                end
            end
        end
    end

endmodule
