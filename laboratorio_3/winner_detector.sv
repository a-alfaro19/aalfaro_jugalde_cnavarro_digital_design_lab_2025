module winner_detector (
    input logic [83:0] board_state,
	 input logic check_win,
    output logic theres_a_winner,
    output logic [2:0] winner,
    output logic [83:0] winner_play
);

    parameter ROWS = 6;
    parameter COLS = 7;
    parameter EMPTY = 2'b00;
    parameter PLAYER_1 = 2'b01;
    parameter PLAYER_2 = 2'b10;

    always_comb begin
		if (check_win) begin
			theres_a_winner = 0;
			winner = 3'd0;
			winner_play = 84'b0;
	
			for (int row = 0; row < ROWS; row++) begin
				for (int col = 0; col < COLS; col++) begin
					 logic [1:0] cell_value;
					 int base_idx = (row * COLS + col) * 2;
					 cell_value = board_state[base_idx +: 2];

					 if (cell_value != EMPTY) begin
						  // Horizontal →
						  if (col <= COLS - 4) begin
								if (board_state[base_idx +: 2] == cell_value &&
									 board_state[base_idx + 2*1 +: 2] == cell_value &&
									 board_state[base_idx + 2*2 +: 2] == cell_value &&
									 board_state[base_idx + 2*3 +: 2] == cell_value) begin
									 theres_a_winner = 1;
									 winner = (cell_value == PLAYER_1) ? 3'd1 : 3'd2;
									 winner_play[row * COLS + col] = 1;
									 winner_play[row * COLS + col + 1] = 1;
									 winner_play[row * COLS + col + 2] = 1;
									 winner_play[row * COLS + col + 3] = 1;
								end
						  end

						  // Vertical ↓
						  if (row <= ROWS - 4) begin
								int i1 = ((row + 1) * COLS + col) * 2;
								int i2 = ((row + 2) * COLS + col) * 2;
								int i3 = ((row + 3) * COLS + col) * 2;
								if (board_state[i1 +: 2] == cell_value &&
									 board_state[i2 +: 2] == cell_value &&
									 board_state[i3 +: 2] == cell_value) begin
									 theres_a_winner = 1;
									 winner = (cell_value == PLAYER_1) ? 3'd1 : 3'd2;
									 winner_play[row * COLS + col] = 1;
									 winner_play[(row + 1) * COLS + col] = 1;
									 winner_play[(row + 2) * COLS + col] = 1;
									 winner_play[(row + 3) * COLS + col] = 1;
								end
						  end

						  // Diagonal ↘
						  if (row <= ROWS - 4 && col <= COLS - 4) begin
								int i1 = ((row + 1) * COLS + (col + 1)) * 2;
								int i2 = ((row + 2) * COLS + (col + 2)) * 2;
								int i3 = ((row + 3) * COLS + (col + 3)) * 2;
								if (board_state[i1 +: 2] == cell_value &&
									 board_state[i2 +: 2] == cell_value &&
									 board_state[i3 +: 2] == cell_value) begin
									 theres_a_winner = 1;
									 winner = (cell_value == PLAYER_1) ? 3'd1 : 3'd2;
									 winner_play[row * COLS + col] = 1;
									 winner_play[(row + 1) * COLS + col + 1] = 1;
									 winner_play[(row + 2) * COLS + col + 2] = 1;
									 winner_play[(row + 3) * COLS + col + 3] = 1;
								end
						  end

						  // Diagonal ↗
						  if (row >= 3 && col <= COLS - 4) begin
								int i1 = ((row - 1) * COLS + (col + 1)) * 2;
								int i2 = ((row - 2) * COLS + (col + 2)) * 2;
								int i3 = ((row - 3) * COLS + (col + 3)) * 2;
								if (board_state[i1 +: 2] == cell_value &&
									 board_state[i2 +: 2] == cell_value &&
									 board_state[i3 +: 2] == cell_value) begin
									 theres_a_winner = 1;
									 winner = (cell_value == PLAYER_1) ? 3'd1 : 3'd2;
									 winner_play[row * COLS + col] = 1;
									 winner_play[(row - 1) * COLS + col + 1] = 1;
									 winner_play[(row - 2) * COLS + col + 2] = 1;
									 winner_play[(row - 3) * COLS + col + 3] = 1;
								end
						  end
					 end
				end
			end
		end else begin 
			theres_a_winner = 0;
			winner = 3'd0;
			winner_play = 84'b0;
		end
	end

endmodule