// videoGen.sv – Mapea el estado del tablero a color RGB
module videoGen(
    input  logic        blank_b,
    input  logic [9:0]  x,
    input  logic [9:0]  y,
    input  logic [83:0] board_state,
    input  logic [83:0] winner_play,
    input  logic        theres_a_winner,
    output logic [7:0]  r,
    output logic [7:0]  g,
    output logic [7:0]  b
);
    // Parámetros de diseño
    localparam int LEFT_MARGIN = 40;
    localparam int CELL_SIZE   = 80;
    localparam int COLS        = 7;
    localparam int ROWS        = 6;

    // Variables internas
    integer col, row, idx;
    logic [1:0] cell_val;

    always @(*) begin
        // Color de fondo
        r = 8'h00;
        g = 8'h00;
        b = 8'h00;

        // Sólo pintamos dentro del área visible del tablero
        if (blank_b
            && x >= LEFT_MARGIN 
            && x < LEFT_MARGIN + COLS*CELL_SIZE
            && y < ROWS*CELL_SIZE) begin

            // Determinar fila y columna de celda
            col = (x - LEFT_MARGIN) / CELL_SIZE;
            row = y / CELL_SIZE;
            idx = (row * COLS + col) * 2;

            // Leer valor de la celda (2 bits)
            cell_val = board_state[idx +: 2];

            // Asignar color según el jugador
            if (cell_val == 2'b01) begin
                // Jugador 1 → Rojo
                r = 8'hFF;
            end
            else if (cell_val == 2'b10) begin
                // Jugador 2 → Azul
                b = 8'hFF;
            end

            // Si hay ganador y esta celda pertenece a la jugada ganadora, resaltamos en blanco
            if (theres_a_winner && winner_play[row*COLS + col]) begin
                r = 8'hFF;
                g = 8'hFF;
                b = 8'hFF;
            end
        end
    end
endmodule
