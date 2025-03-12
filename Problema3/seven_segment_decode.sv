module seven_segment_decoder (
	input [5:0] binary_input,
	output [6:0] segments
);

	always @(*) begin
		case (binary_input)
			6'h00: segments = 7'b1000000; // 0
			6'h01: segments = 7'b1111001; // 1
			6'h02: segments = 7'b0100100; // 2
			6'h03: segments = 7'b0110000; // 3
			6'h04: segments = 7'b0011001; // 4
			6'h05: segments = 7'b0010010; // 5
			6'h06: segments = 7'b0000010; // 6
			6'h07: segments = 7'b1111000; // 7
			6'h08: segments = 7'b0000000; // 8
			6'h09: segments = 7'b0010000; // 9
			6'h0A: segments = 7'b0001000; // A
			6'h0B: segments = 7'b0000011; // B
			6'h0C: segments = 7'b1000110; // C
			6'h0D: segments = 7'b0100001; // D
			6'h0E: segments = 7'b0000110; // E
			6'h0F: segments = 7'b0001110; // F
			default: segments = 7'b1111111; // Apagar si no es un valor válido
		endcase
	end

endmodule
