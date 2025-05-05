// videoGen.sv
// -----------------
// Mapea (x,y) + estado de tablero → color RGB (8 bits/canal)
module videoGen (
    input  logic        blank_b,        // 1 = zona visible
    input  logic [9:0]  x, y,           // Coordenadas de píxel
    input  logic [83:0] board_state,    // 2 bits×42 celdas
    input  logic [83:0] winner_play,    // 1 bit×42 celdas
    input  logic        theres_a_winner,// 1 = hay ganador
    output logic [7:0]  r, g, b         // Color
);
    localparam int LEFT_MARGIN = 40,
                   CELL_SIZE   = 80,
                   COLS        = 7,
                   ROWS        = 6;

    integer col, row, idx;
    logic [1:0] cell_val;

    always @(*) begin
        // Fondo negro
        r = 0; g = 0; b = 0;
        // Solo dentro del tablero
        if (blank_b &&
            x >= LEFT_MARGIN && x < LEFT_MARGIN + COLS*CELL_SIZE &&
            y < ROWS*CELL_SIZE) begin

            col = (x - LEFT_MARGIN) / CELL_SIZE;
            row = y / CELL_SIZE;
            idx = (row * COLS + col) * 2;

            cell_val = board_state[idx +: 2];
            if      (cell_val == 2'b01) r = 8'hFF;  // Jugador 1 (rojo)
            else if (cell_val == 2'b10) b = 8'hFF;  // Jugador 2 (azul)

            if (theres_a_winner && winner_play[row*COLS + col]) begin
                r = 8'hFF; g = 8'hFF; b = 8'hFF;      // Celdas ganadoras en blanco
            end
        end
    end
endmodule
