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
	logic MemByte;

	logic [31:0] WriteData, DataAdr;
	logic MemWrite;

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
	rom imem (
		.address(PC[17:2]),  // dirección alineada a palabra
		.clock(clk),
		.q(Instr)
	);

	// --- RAM de datos + periféricos
	ram_wrapper dmem (
		.clock(clk),
		.address(DataAdr[17:2]),
		.data(WriteData),
		.wren(MemWrite),
		.q(ReadData),
		.botones(botones),
		.paleta_j1_y(paleta_j1_y),
		.paleta_j2_y(paleta_j2_y),
		.bola_xy(bola_xy),
		.puntaje_j1(puntaje_j1),
		.puntaje_j2(puntaje_j2)
	);


endmodule
