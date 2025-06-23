module videoGen_pong (
    input  logic        vgaclk,
    input  logic [9:0]  x,
    input  logic [9:0]  y,
    input  logic [9:0]  paddle1_y,   // Y centro de la paleta izquierda
    input  logic [9:0]  paddle2_y,   // Y centro de la paleta derecha
    input  logic [9:0]  ball_x,      // X centro de la bola
    input  logic [9:0]  ball_y,      // Y centro de la bola
    output logic [7:0]  red,
    output logic [7:0]  green,
    output logic [7:0]  blue
);

    // Parámetros de tamaño
    localparam SCREEN_W   = 640;
    localparam SCREEN_H   = 480;
    localparam PADDLE_W   = 10;
    localparam PADDLE_H   = 60;
    localparam BALL_SIZE  = 8;

    // Posiciones de las paletas
    localparam PADDLE1_X  = 30;
    localparam PADDLE2_X  = SCREEN_W - 30 - PADDLE_W;

    always_comb begin
        red   = 8'h00;
        green = 8'h00;
        blue  = 8'h00;

        // Paleta izquierda
        if (x >= PADDLE1_X && x < PADDLE1_X + PADDLE_W &&
            y >= paddle1_y - (PADDLE_H/2) && y < paddle1_y + (PADDLE_H/2)) begin
            red   = 8'hFF;
            green = 8'hFF;
            blue  = 8'hFF;
        end

        // Paleta derecha
        else if (x >= PADDLE2_X && x < PADDLE2_X + PADDLE_W &&
                 y >= paddle2_y - (PADDLE_H/2) && y < paddle2_y + (PADDLE_H/2)) begin
            red   = 8'hFF;
            green = 8'hFF;
            blue  = 8'hFF;
        end

        // Bola
        else if (x >= ball_x - (BALL_SIZE/2) && x < ball_x + (BALL_SIZE/2) &&
                 y >= ball_y - (BALL_SIZE/2) && y < ball_y + (BALL_SIZE/2)) begin
            red   = 8'hFF;
            green = 8'hFF;
            blue  = 8'hFF;
        end
    end

endmodule
