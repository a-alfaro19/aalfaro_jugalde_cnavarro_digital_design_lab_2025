module random_col_generator (
	input logic clk,
	input logic rst,
	input logic place_token_randomly,
	input logic [83:0] board_state,
	output logic [2:0] random_column,
	output logic random_column_valid
);

	parameter ROWS = 6;
	parameter COLS = 7;
	parameter EMPTY = 2'b00;

	logic [2:0] temp_column;
	logic valid_column;
	logic [7:0] lfsr;
	
	int top_cell_index;
	
	// Inicializar LFSR con valor no nulo
	always_ff @(posedge clk or posedge rst) begin
		if (rst) begin
			lfsr <= 8'b10101010;
			random_column <= 3'd0;
			random_column_valid <= 0;
		end else if (place_token_randomly) begin
			valid_column = 0;
			random_column_valid <= 0;

			// Intentar encontrar una columna válida (como máximo COLS intentos)
			for (int attempts = 0; attempts < COLS; attempts++) begin
				 // Generar pseudoaleatorio con LFSR (taps 8 y 6)
				 lfsr <= {lfsr[6:0], lfsr[7] ^ lfsr[5]};
				 temp_column = lfsr[2:0] % COLS;

				 // Revisar si hay espacio en esa columna
				 top_cell_index = (0 * COLS + temp_column) * 2;
				 if (board_state[top_cell_index +: 2] == EMPTY) begin
					  random_column <= temp_column;
					  random_column_valid <= 1;
					  break;
				 end
			end

			// Si no encontró espacio en ninguna, mantener columna actual (opcional)
			if (!valid_column) begin
				 random_column <= 3'd0; // o alguna columna por defecto
			end
		end	
	end

endmodule