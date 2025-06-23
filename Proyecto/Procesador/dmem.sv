module dmem(
    input logic clk,
    input logic [31:0] a, b, wd_a,
    input logic we_a,
    output logic [31:0] rd_a, rd_b,

    // NUEVAS salidas hacia top
    output logic [31:0] out_paleta1,
    output logic [31:0] out_paleta2,
    output logic [31:0] out_bola,
    output logic [31:0] out_puntaje1,
    output logic [31:0] out_puntaje2
);

    logic [16:0] _a;
    always_comb begin
        if (a[18:2] >= 70000) _a = 17'd0;
        else _a = a[18:2];
    end

    logic [31:0] wd_b = 32'd0;
    logic we_b = 0;

    RAM2 iram(
        .addr_a(_a),
        .addr_b(b[16:0]),
        .clk(clk),
        .wd_a(wd_a),
        .wd_b(wd_b),
        .we_a(we_a),
        .we_b(we_b),
        .rd_a(rd_a),
        .rd_b(rd_b),
        .out_paleta1(out_paleta1),
        .out_paleta2(out_paleta2),
        .out_bola(out_bola),
        .out_puntaje1(out_puntaje1),
        .out_puntaje2(out_puntaje2)
    );
endmodule