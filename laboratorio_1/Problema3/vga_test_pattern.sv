module vga_test_pattern (
    input  logic clk,       // 50 MHz
    input  logic reset_n,   // Reset activo-bajo
    output logic hsync,
    output logic vsync,
    output logic [7:0] r, g, b
);

    // 1) PLL para obtener el clock de VGA (25 MHz)
    logic vgaclk;
    pll u_pll (
        .clk_in  (clk),
        .reset_n (reset_n),
        .clk_out (vgaclk)
    );

    // 2) Controlador VGA
    logic [9:0] x, y;
    logic blank_b, sync_b;
    vgaController u_vc (
        .vgaclk   (vgaclk),
        .reset_n  (reset_n),
        .hsync    (hsync),
        .vsync    (vsync),
        .blank_b  (blank_b),
        .sync_b   (sync_b),
        .x        (x),
        .y        (y)
    );

    // 3) Generación de colores simple
    always_ff @(posedge vgaclk) begin
        if (!reset_n) begin
            r <= 0;
            g <= 0;
            b <= 0;
        end else if (blank_b) begin
            // Dibujar gradiente de color
            r <= x[7:0];  // rojo depende de x
            g <= y[7:0];  // verde depende de y
            b <= 0;
        end else begin
            r <= 0;
            g <= 0;
            b <= 0;
        end
    end

endmodule