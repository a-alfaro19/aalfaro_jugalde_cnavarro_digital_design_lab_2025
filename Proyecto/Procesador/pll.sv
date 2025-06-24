// PLL simplificado: genera reloj VGA (~25MHz) a partir de reloj sistema (~50MHz).
module pll (
    input  logic inclk0,   // Reloj de entrada (ej. 50 MHz)
    output logic c0        // Reloj de salida (~25 MHz)
);
    // Flip-flop divisor por 2
    logic toggle;
    initial toggle = 1'b0;
    always @(posedge inclk0) begin
        toggle <= ~toggle;
    end
    assign c0 = toggle;

endmodule
