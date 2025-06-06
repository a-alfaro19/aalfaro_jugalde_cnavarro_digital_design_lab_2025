module videoGen (
    input  logic        vgaclk,
    input  logic [9:0]  x,
    input  logic [9:0]  y,
    input  logic [2:0]  board [5:0][6:0],  // Tablero recibido (6 filas x 7 columnas)
    output logic [7:0]  red,
    output logic [7:0]  green,
    output logic [7:0]  blue
);

    localparam CELL_W = 91;  // Ancho de cada celda
    localparam CELL_H = 80;  // Alto de cada celda
    localparam NUM_COLS = 7; // Número de columnas en el tablero
    localparam NUM_ROWS = 6; // Número de filas en el tablero

    logic [2:0] col;  // Columna correspondiente al pixel
    logic [2:0] row;  // Fila correspondiente al pixel
    logic [6:0] cx;   // Coordenada horizontal dentro de la celda
    logic [6:0] cy;   // Coordenada vertical dentro de la celda

    always_comb begin
        // Inicialización de colores (negro por defecto)
        red   = 8'h00;
        green = 8'h00;
        blue  = 8'h00;

        // Cálculo de columna y fila
        col = x / CELL_W;
        row = y / CELL_H;
        cx = x % CELL_W;
        cy = y % CELL_H;

        // Verificamos si las coordenadas caen dentro del tablero
        if (col < NUM_COLS && row < NUM_ROWS) begin
            // Dibujamos un borde alrededor del tablero (opcional)
            if (cx < 5 || cy < 5 || cx > (CELL_W - 6) || cy > (CELL_H - 6)) begin
                red   = 8'h00;
                green = 8'h00;
                blue  = 8'hFF; // Borde azul
            end else begin
                // Dependiendo del valor en el tablero, cambiamos el color
                case (board[row][col])
                    3'b001: begin
                        red   = 8'hFF;  // Rojo
                        green = 8'h00;
                        blue  = 8'h00;
                    end
                    3'b010: begin
                        red   = 8'hFF;  // Amarillo
                        green = 8'hFF;
                        blue  = 8'h00;
                    end
                    3'b011: begin
                        red   = 8'h00;  // Verde (cuando se detecta un ganador)
                        green = 8'hFF;
                        blue  = 8'h00;
                    end
                    default: begin
                        red   = 8'h00;  // Azul para fondo
                        green = 8'h00;
                        blue  = 8'h80;
                    end
                endcase
            end
        end
    end

endmodule