module FSM_Game (
	input logic clk,
	input logic rst,
	input logic start_default,  // Orden de turno por defecto.
	input logic timer_out,    // Señal de que el tiempo de turno expiró
	input logic player_mov, // Jugador realizo jugada
	input logic full_board,    // Bandera de que el tablero está lleno
	input logic winner, // Bandera de victoria detectada
	output logic [2:0] current_state // Estado actual del FSM
);

	// Estados
	typedef enum logic [2:0] {
        START,
        PLAYER_1,
        PLAYER_2,
        WIN,
        DRAW
	} state_t;

	state_t state, next_state;
	logic next_turn;

	// Logica para el estado actual
	always_ff @ (posedge clk or posedge rst)
		if (rst) state <= START;
		else
			state <= next_state;
		
	// Logica para el siguiente estado
	always_comb begin
		next_turn = (timer_out || player_mov) && (!winner && !full_board);
		next_state = state;
		
		case(state)
			START: 
				if (start_default) 
					next_state = PLAYER_1; 
				else 
					next_state = PLAYER_2;
					
			PLAYER_1: 
				if (next_turn) 
					next_state = PLAYER_2;
				else if (winner)
					next_state = WIN;
				else if (full_board)
					next_state = DRAW;
				
			PLAYER_2: 
				if (next_turn) 
					next_state = PLAYER_1;
				else if (winner)
					next_state = WIN;
				else if (full_board)
					next_state = DRAW;

			default: 
				next_state = START;
		endcase
	end

	// Salidas
	assign current_state = state;

endmodule