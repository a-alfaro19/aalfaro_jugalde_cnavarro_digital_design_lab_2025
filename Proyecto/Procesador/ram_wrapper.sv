module ram_wrapper (
    input  logic        clock,
    input  logic [15:0] address,
    input  logic [31:0] data,
    input  logic        wren,
    output logic [31:0] q,

    // Señales externas
    input  logic [3:0]  botones,         // Entradas
    output logic [7:0]  paleta_j1_y,     // Salidas
    output logic [7:0]  paleta_j2_y,
    output logic [31:0] bola_xy,
    output logic [3:0]  puntaje_j1,
    output logic [3:0]  puntaje_j2
);

    // RAM interna real (altsyncram IP)
    logic [31:0] ram_q;
    logic [15:0] real_addr;
    logic [31:0] ram_data;
    logic        ram_wren;

    // Salida combinacional multiplexada entre RAM y periféricos
    always_comb begin
        case (address)
            16'h0000: q = {31'b0, botones[0]};      // J1 ↑
            16'h0001: q = {31'b0, botones[1]};      // J1 ↓
            16'h0002: q = {31'b0, botones[2]};      // J2 ↑
            16'h0003: q = {31'b0, botones[3]};      // J2 ↓
            16'h0004: q = {24'b0, paleta_j1_y};
            16'h0005: q = {24'b0, paleta_j2_y};
            16'h0006: q = bola_xy;
            16'h0007: q = {28'b0, puntaje_j1};
            16'h0008: q = {28'b0, puntaje_j2};
            default : q = ram_q;
        endcase
    end

    // Escritura a periféricos
    always_ff @(posedge clock) begin
        case (address)
            16'h0004: if (wren) paleta_j1_y <= data[7:0];
            16'h0005: if (wren) paleta_j2_y <= data[7:0];
            16'h0006: if (wren) bola_xy     <= data;
            16'h0007: if (wren) puntaje_j1  <= data[3:0];
            16'h0008: if (wren) puntaje_j2  <= data[3:0];
        endcase
    end

    // Acceso real a RAM solo si no es periférico
    assign ram_wren = (address < 16'h0000 || address > 16'h0008) ? wren : 1'b0;
    assign real_addr = address;

    ram real_ram ( 
        .address(real_addr),
        .clock(clock),
        .data(data),
        .wren(ram_wren),
        .q(ram_q)
    );

endmodule
