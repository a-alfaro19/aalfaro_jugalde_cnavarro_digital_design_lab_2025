module top(
    input logic clk, reset,
    input logic [3:0] botones,          // Botones físicos: J1 up/down, J2 up/down

    output logic [7:0] paleta_j1_y,     // Salida paleta jugador 1 (Y)
    output logic [7:0] paleta_j2_y,     // Salida paleta jugador 2 (Y)
    output logic [31:0] bola_xy,        // Coordenadas bola: {Y[15:0], X[15:0]}
    output logic [3:0] puntaje_j1,      // Puntaje J1
    output logic [3:0] puntaje_j2       // Puntaje J2
);

    logic [31:0] PC, Instr, ReadData;
    logic [31:0] WriteData, DataAdr;
    logic MemWrite;
	 
	 logic [31:0] ram_paleta_j1_y, ram_paleta_j2_y;
    logic [31:0] ram_bola_xy, ram_puntaje_j1, ram_puntaje_j2;

    // --- Procesador ARM
    arm processor (
        .clk(clk),
        .reset(reset),
        .PC(PC),
        .Instr(Instr),
        .MemWrite(MemWrite),
        .ALUResult(DataAdr),
        .WriteData(WriteData),
        .ReadData(ReadData)
    );

    // --- ROM de instrucciones
    imem imem_inst(
    .a(PC),
    .rd(Instr)
);

    dmem dmem_inst(
        .clk(clk),
        .a(DataAdr),
        .b(32'd0),
        .wd_a(WriteData),
        .we_a(MemWrite),
        .rd_a(ReadData),
        .rd_b(),

        // Lecturas para salidas del juego
        .out_paleta1(ram_paleta_j1_y),
        .out_paleta2(ram_paleta_j2_y),
        .out_bola(ram_bola_xy),
        .out_puntaje1(ram_puntaje_j1),
        .out_puntaje2(ram_puntaje_j2)
    );
	 
	 always @(posedge clk) begin
    $display("PC = %h | DataAdr = %h | MemWrite = %b | WriteData = %h", PC, DataAdr, MemWrite, WriteData);
	end

    // Asignar las salidas
    assign paleta_j1_y = ram_paleta_j1_y[7:0];
    assign paleta_j2_y = ram_paleta_j2_y[7:0];
    assign bola_xy     = ram_bola_xy;
    assign puntaje_j1  = ram_puntaje_j1[3:0];
    assign puntaje_j2  = ram_puntaje_j2[3:0];


endmodule
