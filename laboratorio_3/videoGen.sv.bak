// videoGen.sv
// -----------------
// Mapea (x,y) + estado de tablero → color RGB (8 bits/canal)
module videoGen (
    input  logic        blank_b,         // 1 = zona visible
    input  logic [9:0]  x, y,            // Coordenadas de píxel
    input  logic [83:0] board_state,     // 2 bits × 42 celdas
    input  logic [83:0] winner_play,     // 1 bit × 42 celdas
    input  logic        theres_a_winner, // 1 = hay ganador
    input  logic [2:0]  current_state,   // Estado del juego
    output logic [7:0]  r, g, b          // Color
);

    // Parámetros del tablero y pantalla
    localparam int LEFT_MARGIN   = 40;
    localparam int CELL_SIZE     = 80;
    localparam int COLS          = 7;
    localparam int ROWS          = 6;
    localparam int SCREEN_W      = 640;
    localparam int SCREEN_H      = 480;

    // Estados de la FSM
    localparam IDLE     = 3'd0;
    localparam PLAY1    = 3'd1;
    localparam PLAY2    = 3'd2;
    localparam GAMEOVER = 3'd3;

    // Parámetros del círculo (radio) y color de fondo del tablero
    localparam int RADIUS    = CELL_SIZE/2 - 8;
    localparam int RADIUS2   = RADIUS * RADIUS;

    integer col, row, idx;
    integer cell_x, cell_y, dx, dy;
    logic [1:0] cell_val;
    
    // Letras "START" (sin cambios)
    logic [4:0] char_S [0:6] = '{5'b01110, 5'b10000, 5'b10000, 5'b01110, 5'b00001, 5'b00001, 5'b11110};
    logic [4:0] char_T [0:6] = '{5'b11111, 5'b00100, 5'b00100, 5'b00100, 5'b00100, 5'b00100, 5'b00100};
    logic [4:0] char_A [0:6] = '{5'b01110, 5'b10001, 5'b10001, 5'b11111, 5'b10001, 5'b10001, 5'b10001};
    logic [4:0] char_R [0:6] = '{5'b11110, 5'b10001, 5'b10001, 5'b11110, 5'b10100, 5'b10010, 5'b10001};

    always @(*) begin
        // Fondo negro por defecto
        r = 8'd0; g = 8'd0; b = 8'd0;

        // Pantalla de inicio
        if (current_state == IDLE) begin
            if (x >= (SCREEN_W/2 - 125) && x < (SCREEN_W/2 + 125) &&
                y >= (SCREEN_H/2 - 35) && y < (SCREEN_H/2 + 35)) begin
                // ... (mismo dibujo de "START" que antes)
                integer c, f;
                logic pixel_on;
                c = (x - (SCREEN_W/2 - 125)) / 10;
                f = (y - (SCREEN_H/2 - 35)) / 10;
                pixel_on = 0;
                if (c < 25 && f < 7) begin
                    case (c / 5)
                        0: pixel_on = char_S[f][c % 5];
                        1: pixel_on = char_T[f][c % 5];
                        2: pixel_on = char_A[f][c % 5];
                        3: pixel_on = char_R[f][c % 5];
                        4: pixel_on = char_T[f][c % 5];
                        default: pixel_on = 0;
                    endcase
                end
                if (pixel_on) begin
                    r = 8'hFF; g = 8'hFF; b = 8'hFF;
                end
            end
        end
        // Modo juego: dibujar tablero Connect4
        else if ((current_state == PLAY1 || current_state == PLAY2) && blank_b) begin
            // Área del tablero
            if (x >= LEFT_MARGIN && x < LEFT_MARGIN + COLS*CELL_SIZE && y < ROWS*CELL_SIZE) begin
                // 1) Fondo del tablero (azul)
                r = 8'd0; g = 8'd0; b = 8'hC0;

                // 2) Índices de celda
                col = (x - LEFT_MARGIN) / CELL_SIZE;
                row = y / CELL_SIZE;
                idx = (row * COLS + col) * 2;
                cell_val = board_state[idx +: 2];

                // 3) Coordenadas dentro de la celda
                cell_x = (x - LEFT_MARGIN) % CELL_SIZE;
                cell_y = y % CELL_SIZE;
                dx = cell_x - CELL_SIZE/2;
                dy = cell_y - CELL_SIZE/2;

                // 4) Pinta círculo si está dentro del radio
                if (dx*dx + dy*dy < RADIUS2) begin
                    // Hueco vacío: negro
                    r = 8'd0; g = 8'd0; b = 8'd0;
                    // Ficha jugador 1: rojo
                    if (cell_val == 2'b01) begin
                        r = 8'hFF; g = 8'd0; b = 8'd0;
                    end
                    // Ficha jugador 2: amarillo
                    else if (cell_val == 2'b10) begin
                        r = 8'hFF; g = 8'hFF; b = 8'd0;
                    end
                    // Resaltado si gana
                    if (theres_a_winner && winner_play[row*COLS + col]) begin
                        r = 8'hFF; g = 8'hFF; b = 8'hFF;
                    end
                end
            end
        end
    end
endmodule