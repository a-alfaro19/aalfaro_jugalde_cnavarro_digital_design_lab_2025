module RAM2(
    input logic [16:0] addr_a, addr_b,
    input logic clk,
    input logic [31:0] wd_a, wd_b,
    input logic we_a, we_b,
    output logic [31:0] rd_a, rd_b,

    // NUEVOS: salidas de datos del juego
    output logic [31:0] out_paleta1,
    output logic [31:0] out_paleta2,
    output logic [31:0] out_bola,
    output logic [31:0] out_puntaje1,
    output logic [31:0] out_puntaje2
);

    logic [31:0] mem [0:4095];

    // Inicialización solo para prueba de visualización
    initial begin
        mem[4] = 32'd50;                  // paleta J1
        mem[5] = 32'd60;                  // paleta J2
        mem[6] = 32'h003C0050;            // bola Y=60 (0x3C), X=80 (0x50)
        mem[7] = 32'd2;                   // puntaje J1
        mem[8] = 32'd3;                   // puntaje J2
    end

    // Escrituras sincrónicas
    always @(posedge clk) begin
        if (we_a) mem[addr_a] <= wd_a;
        if (we_b) mem[addr_b] <= wd_b;
    end

    // Lecturas asíncronas
    assign rd_a = mem[addr_a];
    assign rd_b = mem[addr_b];

    // Salidas del juego (por índice directo)
    assign out_paleta1  = mem[4]; // 0x10 >> 2
    assign out_paleta2  = mem[5]; // 0x14 >> 2
    assign out_bola     = mem[6]; // 0x18 >> 2
    assign out_puntaje1 = mem[7]; // 0x1C >> 2
    assign out_puntaje2 = mem[8]; // 0x20 >> 2

endmodule
