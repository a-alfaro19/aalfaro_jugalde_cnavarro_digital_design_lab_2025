module board (
	input logic clk,
	input logic rst,
	input logic [2:0] selected_col,
	input logic [2:0] col_to_check,
	input logic current_player, // 0 = jugador 1, 1 = jugador 2
	input logic place_token, 
	input logic place_token_randomly,
	input logic check_col,
	input logic check_win,
	output logic player_moved, // Indica que el jugador realizó un movimiento
	output logic [83:0] board, // Estado del tablero (2 bits por celda)
	output logic [83:0] winner_play, // Jugada ganadora
	output logic column_full, // Señala si la columna está llena
	output logic theres_a_winner, // Indica si hay un ganador
	output logic [2:0] winner, // Jugador ganador: 1 ó 2
	output logic board_full // Indica si el tablero está lleno
);

	parameter ROWS = 6;
	parameter COLS = 7;
	parameter EMPTY = 2'b00;
	parameter PLAYER_1 = 2'b01;
	parameter PLAYER_2 = 2'b10;

	// Variables internas
	logic [83:0] board_state; // Representación del tablero
	logic [5:0] total_tokens; // Total de fichas colocadas
	logic [6:0] cell_index; // Índice calculado para acceder a una celda
	logic [1:0] current_mark; // Marca del jugador actual
	logic token_was_placed;
	
	// Variables del winner_detector
	logic winner_detected;
	logic [2:0] detected_winner;
	logic [83:0] winner_cells; // 84 bits (una marca por celda ganadora)
	
	// Variables de column_verifier
	logic column_has_space; // Indica si hay espacio en una columna
	
	// Variables del random_col_generator
	logic [2:0] random_column;
	logic random_column_valid;
	
	// Detector de Ganador
	winner_detector detector (
		.board_state(board_state),
		.check_win(check_win),
		.theres_a_winner(winner_detected),
		.winner(detected_winner),
		.winner_play(winner_cells)
	);
	
	// Verificador de columna
	column_checker verificador (
		.board_state(board_state),
		.check_col(check_col),
		.column(col_to_check),
		.column_has_space(column_has_space)
	);
	
	// Generador de movimiento aleatorio
	random_col_generator generador_aleatorio (
		.place_token_randomly(place_token_randomly),
		.board_state(board_state),
		.random_column(random_column),
		.random_column_valid(random_column_valid)
	);
	
	always_ff @ (posedge clk or posedge rst) begin
		if (rst) begin
			// Reiniciar variables internas
			board_state <= 84'b0;
			total_tokens <= 6'd0;
			player_moved <= 0;
			token_was_placed <= 0;
			
		end else begin
			player_moved <= 0;
			token_was_placed = 0;
			
			if (place_token) begin
				// Determinar marca del jugador
				current_mark = (current_player == 0) ? PLAYER_1 : PLAYER_2;
				
				// Buscar fila vacía en la columna seleccionada
				for (int row = ROWS - 1; row >= 0; row--) begin
					// Recorre la columna desde la ultima fila hasta la primera
					cell_index = (row * COLS + selected_col) * 2;
					if (board_state[cell_index +: 2] == EMPTY && !token_was_placed) begin
						// Colocar ficha
						board_state[cell_index +: 2] <= current_mark; 
						total_tokens <= total_tokens + 1; // Aumentar cantidad de fichas colocadas
						player_moved <= 1;
						token_was_placed = 1; 
						break;
					end
				end
			end else if (place_token_randomly && random_column_valid) begin
				current_mark = (current_player == 0) ? PLAYER_1 : PLAYER_2;

				for (int row = ROWS - 1; row >= 0; row--) begin
				  cell_index = (row * COLS + random_column) * 2;
				  if (board_state[cell_index +: 2] == EMPTY && !token_was_placed) begin
						board_state[cell_index +: 2] <= current_mark;
						total_tokens <= total_tokens + 1;
						player_moved <= 1;
						token_was_placed = 1;
						break;
				  end
				end
			end
		end
	end
	
	// Asignaciones de salida
	assign board = board_state;  
	assign column_full = ~column_has_space;
	assign board_full = (total_tokens == 42); 
	assign theres_a_winner = winner_detected;
	assign winner = detected_winner;
	assign winner_play = winner_cells;

endmodule