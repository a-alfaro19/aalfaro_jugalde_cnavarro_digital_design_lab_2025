module barrel_shifter(
	input logic [31:0] i_data,
	input logic [1:0] i_mode,
	input logic [4:0] i_shift_count,
	output logic [31:0] o_data
);

	logic [63:0] concat_data;
	logic [31:0] asr_result;

	// Concatenación para rotaciones (duplicar datos)
	assign concat_data = {i_data, i_data};

	// Arithmetic Shift Right (ASR) con preservación del signo
	always_comb begin
		if (i_shift_count == 0) begin
			asr_result = i_data;
		end else begin
			// Sign extend el bit más significativo para completar los bits desplazados
			asr_result = $signed(i_data) >>> i_shift_count;
		end
	 end
	 
	always_comb begin
		case (i_mode)
			2'b00: // LSL (logical shift left)
				 o_data = i_data << i_shift_count;

			2'b01: // LSR (logical shift right)
				 o_data = i_data >> i_shift_count;

			2'b10: // ASR (arithmetic shift right)
				 o_data = asr_result;

			2'b11: // ROR (rotate right)
				 // Usamos la concatenación para rotar a la derecha
				 o_data = concat_data >> i_shift_count;
				 
			default:
				 o_data = 32'bx;
		endcase
	end
	
endmodule