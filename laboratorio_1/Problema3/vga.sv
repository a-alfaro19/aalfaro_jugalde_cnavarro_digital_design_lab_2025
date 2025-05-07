module vga(
	input logic clk,
	input logic [83:0] board_state,    // 2 bits por celda × 42
	input logic [83:0] winner_play,    // 1 bit por celda
	input logic theres_a_winner,
	input logic [2:0] current_state,

	output logic vgaclk,
	output logic hsync, vsync,
	output logic sync_b, blank_b,
	output logic [7:0] r, g, b
);

	logic [9:0] x, y;

	// Generador de reloj VGA
	pll vgapll(
		.inclk0(clk),
		.c0(vgaclk)
	);

	// Controlador VGA
	vgaController vgaCont(
		.vgaclk(vgaclk),
		.hsync(hsync),
		.vsync(vsync),
		.sync_b(sync_b),
		.blank_b(blank_b),
		.x(x),
		.y(y)
	);

	// Generador de video con entrada de estado del juego
	videoGen vgaVideoGen(
		.blank_b(blank_b),
		.x(x),
		.y(y),
		.board_state(board_state),
		.winner_play(winner_play),
		.theres_a_winner(theres_a_winner),
		.current_state(current_state),
		.r(r),
		.g(g),
		.b(b)
	);

endmodule
