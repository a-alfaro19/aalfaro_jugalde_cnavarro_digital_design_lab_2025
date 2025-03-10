module bin2bcd (
    input logic [3:0] binary_in,
    output logic [7:0] bcd_out
);

	logic [3:0] tens, ones;

	assign tens = (binary_in >= 4'd10) ? 4'd1 : 4'd0;

	assign ones = (binary_in >= 4'd10) ? (binary_in - 4'd10) : binary_in;

	assign bcd_out = {tens, ones};

endmodule