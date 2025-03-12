module DecodificadorBinario (
    input logic [3:0] binary_in,
    output logic [7:0] bcd_out
);

	logic [3:0] tens, ones;

	assign tens = (binary_in >= 10) ? 1 : 0;

	assign ones = (binary_in >= 10) ? (binary_in - 10) : binary_in;

	assign bcd_out = {tens, ones};

endmodule