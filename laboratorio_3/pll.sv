// pll.sv
// -----------------
// Divide 50 MHz → ~25 MHz con reset activo-bajo
module pll (
    input  logic clk_in,    // Reloj principal 50 MHz
    input  logic reset_n,   // Reset activo-bajo
    output logic clk_out    // Reloj de píxel ~25 MHz
);
    always_ff @(posedge clk_in or negedge reset_n) begin
        if (!reset_n)
            clk_out <= 1'b0;
        else
            clk_out <= ~clk_out;
    end
endmodule
