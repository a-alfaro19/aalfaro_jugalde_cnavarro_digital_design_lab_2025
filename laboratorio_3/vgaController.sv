// vgaController.sv – Generación de sincronías VGA 640×480@60Hz
module vgaController(
    input  logic        vgaclk,
    input  logic        reset_n,
    output logic        hsync,
    output logic        vsync,
    output logic        blank_b,
    output logic        sync_b,
    output logic [9:0]  x,
    output logic [9:0]  y
);
    // Temporizaciones estándar VGA 640×480
    localparam int WIDTH  = 640,  HFP   = 16, HSYNC = 96, HBP = 48;
    localparam int HEIGHT = 480,  VFP   = 10, VSYNC = 2,  VBP = 33;
    localparam int HMAX   = WIDTH + HFP + HSYNC + HBP; // 800
    localparam int VMAX   = HEIGHT + VFP + VSYNC + VBP; // 525

    // Contadores de posición de haz
    always_ff @(posedge vgaclk or negedge reset_n) begin
        if (!reset_n) begin
            x <= 0; y <= 0;
        end else begin
            if (x == HMAX - 1) begin
                x <= 0;
                y <= (y == VMAX - 1) ? 0 : y + 1;
            end else begin
                x <= x + 1;
            end
        end
    end

    // Generación de hsync/vsync y blanking
    always_comb begin
        // HSYNC activo-bajo durante HSYNC
        hsync   = !((x >= WIDTH + HFP) && (x < WIDTH + HFP + HSYNC));
        // VSYNC activo-bajo durante VSYNC
        vsync   = !((y >= HEIGHT + VFP) && (y < HEIGHT + VFP + VSYNC));
        blank_b = (x < WIDTH) && (y < HEIGHT);     // zona visible
        sync_b  = hsync & vsync;                   // sync compuesto
    end
endmodule
