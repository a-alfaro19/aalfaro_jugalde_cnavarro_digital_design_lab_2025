module top(
    input logic clk, reset,
    output logic [31:0] WriteData, DataAdr,
    output logic MemWrite
);

    logic [31:0] PC, Instr, ReadData;

    // Procesador y memorias
    arm arm(
        clk, reset,
        PC, Instr,
        MemWrite, DataAdr,
        WriteData, ReadData
    );

    // Instrucciones desde la ROM IP
    rom imem(
        .address(PC[17:2]), // PC es byte address; [17:2] son las 16 MSBs alineadas a palabra
        .clock(clk),
        .q(Instr)
    );

    // Datos desde la RAM IP
    ram dmem(
        .address(DataAdr[17:2]), // también alineado a palabra
        .clock(clk),
        .data(WriteData),
        .wren(MemWrite),
        .q(ReadData)
    );

endmodule
