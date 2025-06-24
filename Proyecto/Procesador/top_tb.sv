`timescale 1 ps / 1 ps

module top_tb;

logic clk, reset;
logic [3:0] botones;
logic [7:0] paleta_j1_y, paleta_j2_y;
logic [31:0] bola_xy;
logic [3:0] puntaje_j1, puntaje_j2;

// Instancia DUT
top dut (
	.clk(clk),
	.reset(reset),
	.botones(botones),
	.paleta_j1_y(paleta_j1_y),
	.paleta_j2_y(paleta_j2_y),
	.bola_xy(bola_xy),
	.puntaje_j1(puntaje_j1),
	.puntaje_j2(puntaje_j2)
);

// Reloj de 10 ns (100 MHz)
initial clk = 0;
always #5 clk = ~clk;

initial begin
	reset = 1;
	botones = 4'b0000;
	#20;
	reset = 0;

	// Simular pulsación botones J1 up y J2 down
	#100 botones = 4'b1001;
	#50 botones = 4'b0000;

	// Simular durante un tiempo para observar cambios
	#1000;

	$stop;
end

endmodule
