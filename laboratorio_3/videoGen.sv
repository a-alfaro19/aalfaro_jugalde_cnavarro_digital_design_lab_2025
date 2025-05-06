// videoGen.sv
// -----------------
// Mapea (x,y) + estado de tablero → color RGB (8 bits/canal)
module videoGen (
    input  logic        blank_b,        // 1 = zona visible
    input  logic [9:0]  x, y,           // Coordenadas de píxel
    input  logic [83:0] board_state,    // 2 bits × 42 celdas
    input  logic [83:0] winner_play,    // 1 bit × 42 celdas
    input  logic        theres_a_winner,// 1 = hay ganador
    input  logic [2:0]  current_state,  // Estado del juego
    output logic [7:0]  r, g, b         // Color
);

    localparam int LEFT_MARGIN  = 40,
                   CELL_SIZE    = 80,
                   COLS         = 7,
                   ROWS         = 6,
                   SCREEN_WIDTH  = 640,
                   SCREEN_HEIGHT = 480;

    integer col, row, idx;
    logic [1:0] cell_val;
    logic       pixel_on;

    // Letras "START", cada una es una matriz de 7x5 bits (fila × columna)
    logic [4:0] char_S [0:6] = '{5'b01110, 5'b10000, 5'b10000, 5'b01110, 5'b00001, 5'b00001, 5'b11110};
    logic [4:0] char_T [0:6] = '{5'b11111, 5'b00100, 5'b00100, 5'b00100, 5'b00100, 5'b00100, 5'b00100};
    logic [4:0] char_A [0:6] = '{5'b01110, 5'b10001, 5'b10001, 5'b11111, 5'b10001, 5'b10001, 5'b10001};
    logic [4:0] char_R [0:6] = '{5'b11110, 5'b10001, 5'b10001, 5'b11110, 5'b10100, 5'b10010, 5'b10001};

    always @(*) begin
        // Fondo negro por defecto
        r = 0; g = 0; b = 0;

        // Pantalla de inicio (solo si current_state == 0)
        if (current_state == 3'd0) begin
            // Área donde se dibujará "START"
            if (x >= (SCREEN_WIDTH / 2 - 125) && x < (SCREEN_WIDTH / 2 + 125) &&
                y >= (SCREEN_HEIGHT / 2 - 35) && y < (SCREEN_HEIGHT / 2 + 35)) begin

                col = (x - (SCREEN_WIDTH / 2 - 125)) / 10; // 25 columnas
                row = (y - (SCREEN_HEIGHT / 2 - 35)) / 10;  // 7 filas

                pixel_on = 0;
                if (col < 25 && row < 7) begin
                    case (col / 5)
                        0: pixel_on = char_S[row][col % 5];
                        1: pixel_on = char_T[row][col % 5];
                        2: pixel_on = char_A[row][col % 5];
                        3: pixel_on = char_R[row][col % 5];
                        4: pixel_on = char_T[row][col % 5];
                        default: pixel_on = 0;
                    endcase
                end

                if (pixel_on) begin
                    r = 8'hFF; g = 8'hFF; b = 8'hFF; // Letras en blanco
                end
            end
        end
        // Tablero solo si estamos en PLAYER_1 o PLAYER_2
        else if ((current_state == 3'd1 || current_state == 3'd2) &&
                 blank_b && x >= LEFT_MARGIN && x < LEFT_MARGIN + COLS*CELL_SIZE && y < ROWS*CELL_SIZE) begin

            col = (x - LEFT_MARGIN) / CELL_SIZE;
            row = y / CELL_SIZE;
            idx = (row * COLS + col) * 2;

            cell_val = board_state[idx +: 2];
            if (cell_val == 2'b01) begin
                r = 8'hFF; g = 0; b = 0;   // Jugador 1 (rojo)
            end
            else if (cell_val == 2'b10) begin
                r = 0; g = 0; b = 8'hFF;   // Jugador 2 (azul)
            end

            if (theres_a_winner && winner_play[row * COLS + col]) begin
                r = 8'hFF; g = 8'hFF; b = 8'hFF; // Celdas ganadoras en blanco
            end
        end
    end
endmodule