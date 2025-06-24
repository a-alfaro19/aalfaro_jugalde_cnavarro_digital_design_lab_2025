// VGA controller: genera hsync, vsync, blank y coordenadas x,y para 640x480@60Hz.
module vga_controller #(
    // Parámetros VGA 640×480 @60Hz
    parameter int H_ACTIVE = 10'd640, // Píxeles visibles por línea
    parameter int H_FRONT  = 10'd16,  // Front porch horizontal
    parameter int H_SYNC   = 10'd96,  // Pulso de sincronismo horizontal
    parameter int H_BACK   = 10'd48,  // Back porch horizontal
    parameter int H_TOTAL  = H_ACTIVE + H_FRONT + H_SYNC + H_BACK,

    parameter int V_ACTIVE = 10'd480, // Líneas visibles por cuadro
    parameter int V_FRONT  = 10'd10,  // Front porch vertical
    parameter int V_SYNC   = 10'd2,   // Pulso de sincronismo vertical
    parameter int V_BACK   = 10'd33,  // Back porch vertical
    parameter int V_TOTAL  = V_ACTIVE + V_FRONT + V_SYNC + V_BACK
)(
    input  logic        vgaclk,    // Reloj de píxel (~25 MHz)
    output logic        hsync,     // Señal de sincronismo horizontal (activo bajo)
    output logic        vsync,     // Señal de sincronismo vertical (activo bajo)
    output logic        sync_b,    // AND de hsync y vsync (opcional)
    output logic        blank_b,   // Activo si dentro de área visible
    output logic [9:0]  x,         // Coordenada horizontal del píxel
    output logic [9:0]  y          // Coordenada vertical del píxel
);

    // Contadores de posición (registro con asignación no bloqueante)
    always @(posedge vgaclk) begin
        if (x == H_TOTAL - 1) begin
            x <= 0;
            if (y == V_TOTAL - 1)
                y <= 0;
            else
                y <= y + 1;
        end else begin
            x <= x + 1;
        end
    end

    // Generación de señales de sincronismo (pol. negativa)
    assign hsync  = ~((x >= H_ACTIVE + H_FRONT) && (x < H_ACTIVE + H_FRONT + H_SYNC));
    assign vsync  = ~((y >= V_ACTIVE + V_FRONT) && (y < V_ACTIVE + V_FRONT + V_SYNC));
    assign sync_b = hsync && vsync;

    // Se activa la señal blank_b mientras (x,y) está dentro del área visible
    assign blank_b = (x < H_ACTIVE) && (y < V_ACTIVE);

endmodule
