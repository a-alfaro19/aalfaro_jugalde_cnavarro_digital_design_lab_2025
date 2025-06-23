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

    always_ff @(posedge clk) begin
        if (we_a) mem[addr_a] <= wd_a;
        if (we_b) mem[addr_b] <= wd_b;
    end

    assign rd_a = mem[addr_a];
    assign rd_b = mem[addr_b];

    // NUEVO: lectura fija para salidas del top
    assign out_paleta1  = mem[32'h40000010 >> 2];
	assign out_paleta2  = mem[32'h40000014 >> 2];
	assign out_bola     = mem[32'h40000018 >> 2];
	assign out_puntaje1 = mem[32'h4000001C >> 2];
	assign out_puntaje2 = mem[32'h40000020 >> 2];
endmodule

