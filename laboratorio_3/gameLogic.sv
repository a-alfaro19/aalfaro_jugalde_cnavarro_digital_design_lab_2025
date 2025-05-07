module gameLogic (
    input  logic        clk,               // Reloj VGA
    input  logic        rst,               // Reset
    input  logic [6:0]  sw_rising_edge,    // Flanco de subida de los interruptores
    input  logic [6:0]  sw_falling_edge,   // Flanco de bajada de los interruptores (detectado en el módulo principal)
    output logic [2:0]  board [5:0][6:0]   // Tablero de 6x7
);

    parameter ROWS = 6;
    parameter COLS = 7;

    logic [6:0] processed; // Evita múltiples fichas por mantener el switch presionado
    logic [6:0] sw_pulse;  // Pulsos de un solo ciclo para cada columna

    // Generar un pulso de un solo ciclo para cada flanco de subida
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            sw_pulse <= 7'b0;
        end else begin
            sw_pulse <= sw_rising_edge & ~sw_pulse; // Genera un pulso de un ciclo cuando hay un flanco de subida
        end
    end

    // Lógica principal para insertar las fichas en el tablero
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            processed <= 7'b0;
            for (int i = 0; i < ROWS; i++) begin
                for (int j = 0; j < COLS; j++) begin
                    board[i][j] <= 3'b000;
                end
            end
        end else begin
            for (int col = 0; col < COLS; col++) begin
                // Solo procesar cuando haya un pulso y no se haya procesado esta columna aún
                if (sw_pulse[col] && !processed[col]) begin
                    // Coloca la ficha solo una vez
                    for (int row = ROWS - 1; row >= 0; row--) begin
                        if (board[row][col] == 3'b000) begin
                            board[row][col] <= 3'b001; // Coloca una ficha (por ejemplo, ficha roja)
                            break;
                        end
                    end
                    processed[col] <= 1; // Marca la columna como procesada
                end

                // Libera el flag cuando el interruptor se ha soltado
                if (sw_falling_edge[col]) begin
                    processed[col] <= 0; // Permite que la columna se procese nuevamente
                end
            end
        end
    end

endmodule