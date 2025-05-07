module videoGen (
    input  logic        vgaclk,
    input  logic [9:0]  x,
    input  logic [9:0]  y,
    input  logic [6:0]  sw_rising_edge, // se recibe el flanco detectado
    output logic [7:0]  red,
    output logic [7:0]  green,
    output logic [7:0]  blue
);

    localparam CELL_W = 91;
    localparam CELL_H = 80;
    localparam NUM_COLS = 7;
    localparam NUM_ROWS = 6;

    logic [2:0] board[NUM_ROWS-1:0][NUM_COLS-1:0];
    logic [2:0] col;
    logic [2:0] row;
    logic [6:0] cx;
    logic [6:0] cy;
    logic [2:0] current_player;

    // Variables para sincronizar el flanco con vgaclk
    logic [6:0] sw_sync_1, sw_sync_2;
    logic [6:0] sw_edge_vgaclk;

    // Sincronizador de flanco de subida
    always_ff @(posedge vgaclk) begin
        sw_sync_1 <= sw_rising_edge;
        sw_sync_2 <= sw_sync_1;
        sw_edge_vgaclk <= sw_sync_1 & ~sw_sync_2;  // Flanco de subida detectado
    end

    // Inicialización del tablero
    initial begin
        for (int i = 0; i < NUM_ROWS; i++)
            for (int j = 0; j < NUM_COLS; j++)
                board[i][j] = 0;
        current_player = 1;
    end

    // Colocación de ficha solo en el primer flanco de subida
    always_ff @(posedge vgaclk) begin
        for (int i = 0; i < NUM_COLS; i++) begin
            if (sw_edge_vgaclk[i]) begin // Verificamos si hubo un flanco de subida
                for (int r = NUM_ROWS-1; r >= 0; r--) begin
                    if (board[r][i] == 0) begin
                        board[r][i] = current_player;
                        current_player = (current_player == 1) ? 2 : 1; // Cambiar de jugador
                        break;
                    end
                end
            end
        end
    end

    // Generación de la imagen VGA
    always_comb begin
        red   = 8'h00;
        green = 8'h00;
        blue  = 8'h00;

        col = x / CELL_W;
        row = y / CELL_H;
        cx = x % CELL_W;
        cy = y % CELL_H;

        if (col < NUM_COLS && row < NUM_ROWS) begin
            case (board[row][col])
                1: begin red = 8'hFF; green = 8'h00; blue = 8'h00; end
                2: begin red = 8'hFF; green = 8'hFF; blue = 8'h00; end
                default: begin red = 8'h00; green = 8'h00; blue = 8'h80; end
            endcase
        end
    end

endmodule
