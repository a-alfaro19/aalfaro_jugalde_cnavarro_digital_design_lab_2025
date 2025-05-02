module column_checker(
    input logic [83:0] board_state,
	 input logic check_col,
    input logic [2:0] column,
    output logic column_has_space
);

	parameter ROWS = 6;
	parameter COLS = 7;
	parameter EMPTY = 2'b00;

	always_comb begin
		if (check_col) begin
			column_has_space  = 0;

			for (int row = ROWS - 1; row >= 0; row--) begin
				int index = (row * COLS + column) * 2;
				if (board_state[index +: 2] == EMPTY) begin
					column_has_space  = 1;
					break; // encontramos el espacio en la columna
				end
			end
		end else begin
			column_has_space  = 0;
		end
	end

endmodule