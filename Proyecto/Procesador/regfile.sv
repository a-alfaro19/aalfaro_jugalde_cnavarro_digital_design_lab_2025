module regfile(
    input  logic clk,
    input  logic we3,
    input  logic [3:0] ra1, ra2, wa3,
    input  logic [31:0] wd3, r15,
    output logic [31:0] rd1, rd2
);
    logic [31:0] rf[14:0];  // Solo de R0 a R14

    // Escritura en registro (evita escribir R15)
    always_ff @(posedge clk) begin
        if (we3 && wa3 != 4'b1111) begin
            rf[wa3] <= wd3;
            if (wa3 == 4'd14)
                $display("Escribiendo en LR (R14): %h", wd3);
        end
    end

    // Lectura (R15 se entrega como r15 = PC + 8)
    assign rd1 = (ra1 == 4'b1111) ? r15 : rf[ra1];
    assign rd2 = (ra2 == 4'b1111) ? r15 : rf[ra2];
endmodule
