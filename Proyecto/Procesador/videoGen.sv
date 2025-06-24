// Generador de video: determina el color RGB de cada píxel según posición y estado del juego.
module videoGen (
    input  logic        blank_b,        // Activo alto dentro de región visible
    input  logic [9:0]  x, y,           // Coordenadas del píxel actual
    input  logic [83:0] board_state,    // (Opcional) Estado del juego / frame buffer
    input  logic [83:0] winner_play,    // (Opcional) Indicadores de casillas ganadoras
    input  logic        theres_a_winner,// Indica si hay un ganador
    input  logic [2:0]  current_state,  // (Opcional) Estado de la máquina de estados del juego
    output logic [7:0]  r, g, b         // Componentes de color del píxel (0-255)
);

    // Pixel fuera de área visible -> negro
    always_comb begin
        if (!blank_b) begin
            r = 8'd0;
            g = 8'd0;
            b = 8'd0;
        end else begin
            // Color de fondo por defecto (negro)
            r = 8'd0;
            g = 8'd0;
            b = 8'd0;

            // Paleta izquierda (blanca, ancho ~10px, centrada verticalmente)
            if ((x < 10) && (y > 210) && (y < 270)) begin
                r = 8'hFF; g = 8'hFF; b = 8'hFF;
            end

            // Paleta derecha (blanca, ancho ~10px, centrada verticalmente)
            if ((x >= 630) && (y > 210) && (y < 270)) begin
                r = 8'hFF; g = 8'hFF; b = 8'hFF;
            end

            // Pelota en el centro (8x8 píxeles)
            if ((x >= 312 && x <= 319) && (y >= 236 && y <= 243)) begin
                if (theres_a_winner) begin
                    // Si hay ganador, pintar la pelota de verde
                    r = 8'h00; g = 8'hFF; b = 8'h00;
                end else begin
                    // Pelota blanca normal
                    r = 8'hFF; g = 8'hFF; b = 8'hFF;
                end
            end
        end
    end

endmodule
