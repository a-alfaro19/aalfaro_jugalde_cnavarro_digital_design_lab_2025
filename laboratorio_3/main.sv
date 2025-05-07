module main (
    input  logic        clk,    // 50MHz
    input  logic        rst,
    input  logic [6:0]  sw,
    output logic        hsync,
    output logic        vsync,
    output logic        sync_b,
    output logic        blank_b,
    output logic [7:0]  red,
    output logic [7:0]  green,
    output logic [7:0]  blue,
    output logic        vgaclk
);

    logic [9:0] x, y;
    logic pll_locked;

    logic [6:0] sw_rising_edge;

    // PLL para generar vgaclk
    clkpll pll_inst (
        .refclk   (clk),
        .rst      (rst),
        .outclk_0 (vgaclk),
        .locked   (pll_locked)
    );

    // Detector de flanco de subida (usa clk lento, no vgaclk)
    rising_edge_detector redet_inst (
        .clk        (vgaclk),
        .signal_in  (sw),
        .rising_edge(sw_rising_edge)
    );

    // VGA Controller
    vgaController vga_inst (
        .vgaclk (vgaclk),
        .hsync  (hsync),
        .vsync  (vsync),
        .sync_b (sync_b),
        .blank_b(blank_b),
        .x      (x),
        .y      (y)
    );

    // Video Generator
    videoGen video_inst (
        .vgaclk         (vgaclk),
        .x              (x),
        .y              (y),
        .sw_rising_edge (sw_rising_edge),  // Se pasa la señal procesada
        .red            (red),
        .green          (green),
        .blue           (blue)
    );

endmodule
