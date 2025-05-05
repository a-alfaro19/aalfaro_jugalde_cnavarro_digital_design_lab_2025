// pll.sv – Clock divider para generar vgaclk (~25 MHz) con reset activo-bajo
module pll (
    input  logic clk_in,
    input  logic reset_n,
    output logic clk_out
);
    // Divide por 2: clk_out toggle en cada flanco
    always_ff @(posedge clk_in or negedge reset_n) begin
        if (!reset_n)
            clk_out <= 1'b0;
        else
            clk_out <= ~clk_out;
    end
endmodule
