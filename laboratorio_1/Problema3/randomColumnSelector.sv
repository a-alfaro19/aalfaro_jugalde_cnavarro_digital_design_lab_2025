module randomColumnSelector (
    input  logic clk,                      // Reloj
    input  logic rst,                      // Reset
    input  logic enable,                   // Señal de habilitación para seleccionar una columna
    input  logic [2:0] board [5:0][6:0],   // Estado del tablero
    output logic [2:0] col_out,            // Columna seleccionada
    output logic valid                     // Señal de columna válida
);

    logic [2:0] lfsr;    // Generador de números pseudoaleatorios (3 bits para 7 columnas)
    logic [3:0] attempts; // Contador de intentos

    // Inicialización del LFSR (Linear Feedback Shift Register)
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            lfsr <= 3'b001;
            attempts <= 4'd0;
            valid <= 0;
        end else if (enable) begin
            lfsr <= {lfsr[1] ^ lfsr[0], lfsr[2], lfsr[1]};
            attempts <= attempts + 1;

            // Verificar si la columna generada tiene un espacio libre
            if (lfsr < 7 && board[0][lfsr] == 3'b000) begin
                col_out <= lfsr;
                valid <= 1;
                attempts <= 0; // Reiniciar intentos
            end else if (attempts >= 7) begin
                valid <= 0; // No se encontró una columna válida en 7 intentos
            end else begin
                valid <= 0;
            end
        end
    end

endmodule
