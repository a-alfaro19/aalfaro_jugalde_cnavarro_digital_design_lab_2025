// vgaController.sv
// -----------------
// Temporización VGA 640×480 @60 Hz
module vgaController (
    input  logic        vgaclk,    // Reloj de píxel (~25 MHz)
    input  logic        reset_n,   // Reset activo-bajo
    output logic        hsync,     // HSYNC (activo-bajo)
    output logic        vsync,     // VSYNC (activo-bajo)
    output logic        blank_b,   // 1 = zona visible
    output logic        sync_b,    // HSYNC & VSYNC compuesto
    output logic [9:0]  x,         // 0…799
    output logic [9:0]  y          // 0…524
);
    // Parámetros de temporización
    localparam int H_ACTIVE = 640, H_FP = 16, H_PW = 96, H_BP = 48;
    localparam int V_ACTIVE = 480, V_FP = 10, V_PW = 2,  V_BP = 33;
    localparam int H_TOTAL  = H_ACTIVE + H_FP + H_PW + H_BP; // 800
    localparam int V_TOTAL  = V_ACTIVE + V_FP + V_PW + V_BP; // 525

    // Contador de posición
    always_ff @(posedge vgaclk or negedge reset_n) begin
        if (!reset_n) begin
            x <= 0; y <= 0;
        end else begin
            if (x == H_TOTAL - 1) begin
                x <= 0;
                y <= (y == V_TOTAL - 1) ? 0 : y + 1;
            end else begin
                x <= x + 1;
            end
        end
    end

    // Señales de sincronía y blanking
    always_comb begin
        hsync   = ~((x >= H_ACTIVE + H_FP) && (x < H_ACTIVE + H_FP + H_PW));
        vsync   = ~((y >= V_ACTIVE + V_FP) && (y < V_ACTIVE + V_FP + V_PW));
        blank_b = (x < H_ACTIVE) && (y < V_ACTIVE);
        sync_b  = hsync & vsync;
    end
endmodule
