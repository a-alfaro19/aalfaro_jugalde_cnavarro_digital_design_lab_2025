module FSM_Game (input clk, rst, player_selection, player_move, time_out,
	valid_move, winner, full_board,
	output player_one_first, player_two_first, set_first_player, 
	create_board, start_timer, check_player_move, make_random_move, 
	make_player_move, check_winner, victory, check_full_board, draw, change_turn
);

	// Estados
	typedef enum logic [3:0] {
		INIT,
		SELECT_PLAYER_1,
		SELECT_PLAYER_2,
		CREATE_BOARD,
		PLAYER_TURN,
		CHECK_MOVE,
		RANDOM_MOVE,
		MAKE_MOVE,
		ERROR,
		CHECK_WINNER,
		VICTORY,
		END,
		CHECK_FULL_BOARD,
		DRAW,
		CHANGE_TURN
	} state_t;

	state_t state, next_state;

	// Logica para el estado actual
	always_ff @ (posedge clk or posedge rst)
		if (rst) state <= INIT;
		else
			state <= next_state;
		
	// Logica para el siguiente estado
	always_comb
		case(state)
			INIT: if (player_selection) next_state = SELECT_PLAYER_2; else next_state = SELECT_PLAYER_1;
			SELECT_PLAYER_1: next_state = CREATE_BOARD;
			SELECT_PLAYER_2: next_state = CREATE_BOARD;
			CREATE_BOARD: next_state = PLAYER_TURN;
			PLAYER_TURN: begin
				if (player_move) 
					next_state = CHECK_MOVE;
				else if (time_out)
					next_state = RANDOM_MOVE;
			end
			CHECK_MOVE: if (valid_move) next_state = MAKE_MOVE; else next_state = ERROR;
			RANDOM_MOVE: next_state = MAKE_MOVE;
			ERROR: next_state = PLAYER_TURN;
			MAKE_MOVE: next_state = CHECK_WINNER;
			CHECK_WINNER: if (winner) next_state = VICTORY; else next_state = CHECK_FULL_BOARD;
			CHECK_FULL_BOARD: if (full_board) next_state = CHANGE_TURN; else next_state = DRAW;
			VICTORY: next_state = END;
			DRAW: next_state = END;
			CHANGE_TURN: next_state = PLAYER_TURN;
		endcase

	// Salidas
	assign player_one_first = (state == SELECT_PLAYER_1);
	assign player_two_first = (state == SELECT_PLAYER_2);
	assign set_first_player = (state == SELECT_PLAYER_1 or state == SELECT_PLAYER_2);
	assign create_board = (state == CREATE_BOARD);
	assign start_timer = (state == PLAYER_TURN);
	assign check_player_move = (state == CHECK_MOVE);
	assign make_random_move = (state == RANDOM_MOVE);
	assign make_player_move = (state == MAKE_MOVE);
	assign check_winner = (state == CHECK_WINNER);
	assign check_full_board = (state == CHECK_FULL_BOARD);
	assign victory = (state == VICTORY);
	assign draw = (state == DRAW);
	assign change_turn = (state == CHANGE_TURN);


endmodule