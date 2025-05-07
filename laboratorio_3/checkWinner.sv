module checkWinner (
    input  logic        clk,
    input  logic        rst,
    input  logic [2:0]  board [5:0][6:0], // Tablero del juego
    output logic        juego_terminado,  // Señal de juego terminado
    output logic [2:0]  board_out [5:0][6:0] // Tablero actualizado (verde si gana)
);

    parameter ROWS = 6;
    parameter COLS = 7;

    logic [2:0] temp_board [5:0][6:0];

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            juego_terminado <= 0;
            for (int i = 0; i < ROWS; i++) begin
                for (int j = 0; j < COLS; j++) begin
                    temp_board[i][j] <= board[i][j];
                end
            end
        end else begin
            // Copiar el tablero
            for (int i = 0; i < ROWS; i++) begin
                for (int j = 0; j < COLS; j++) begin
                    temp_board[i][j] <= board[i][j];
                end
            end

            // ============================
            // = Verificación Horizontal =
            // ============================
            for (int row = 0; row < ROWS; row++) begin
                for (int col = 0; col < COLS - 3; col++) begin
                    if (board[row][col] != 3'b000 &&
                        board[row][col] == board[row][col + 1] &&
                        board[row][col] == board[row][col + 2] &&
                        board[row][col] == board[row][col + 3]) begin

                        // Cambiar a verde
                        temp_board[row][col]       <= 3'b011;
                        temp_board[row][col + 1]   <= 3'b011;
                        temp_board[row][col + 2]   <= 3'b011;
                        temp_board[row][col + 3]   <= 3'b011;
                        juego_terminado <= 1;
                    end
                end
            end

            // ===========================
            // = Verificación Vertical =
            // ===========================
            for (int col = 0; col < COLS; col++) begin
                for (int row = 0; row < ROWS - 3; row++) begin
                    if (board[row][col] != 3'b000 &&
                        board[row][col] == board[row + 1][col] &&
                        board[row][col] == board[row + 2][col] &&
                        board[row][col] == board[row + 3][col]) begin

                        // Cambiar a verde
                        temp_board[row][col]       <= 3'b011;
                        temp_board[row + 1][col]   <= 3'b011;
                        temp_board[row + 2][col]   <= 3'b011;
                        temp_board[row + 3][col]   <= 3'b011;
                        juego_terminado <= 1;
                    end
                end
            end

            // ===========================
            // = Verificación Diagonal ↘ =
            // ===========================
            for (int row = 0; row < ROWS - 3; row++) begin
                for (int col = 0; col < COLS - 3; col++) begin
                    if (board[row][col] != 3'b000 &&
                        board[row][col] == board[row + 1][col + 1] &&
                        board[row][col] == board[row + 2][col + 2] &&
                        board[row][col] == board[row + 3][col + 3]) begin

                        // Cambiar a verde
                        temp_board[row][col]       <= 3'b011;
                        temp_board[row + 1][col + 1] <= 3'b011;
                        temp_board[row + 2][col + 2] <= 3'b011;
                        temp_board[row + 3][col + 3] <= 3'b011;
                        juego_terminado <= 1;
                    end
                end
            end

            // ===========================
            // = Verificación Diagonal ↙ =
            // ===========================
            for (int row = 3; row < ROWS; row++) begin
                for (int col = 0; col < COLS - 3; col++) begin
                    if (board[row][col] != 3'b000 &&
                        board[row][col] == board[row - 1][col + 1] &&
                        board[row][col] == board[row - 2][col + 2] &&
                        board[row][col] == board[row - 3][col + 3]) begin

                        // Cambiar a verde
                        temp_board[row][col]       <= 3'b011;
                        temp_board[row - 1][col + 1] <= 3'b011;
                        temp_board[row - 2][col + 2] <= 3'b011;
                        temp_board[row - 3][col + 3] <= 3'b011;
                        juego_terminado <= 1;
                    end
                end
            end
        end
    end

    // Asignación del tablero actualizado
    assign board_out = temp_board;

endmodule