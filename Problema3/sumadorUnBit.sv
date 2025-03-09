module sumadorUnBit (
	input logic a, b, c_in,
	output logic s, c_out
	
);

	assign s = a ^ b ^ c_in;
	assign c_out = (a & b) + (a & c_in) + (b & c_in);
	
endmodule