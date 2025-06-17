module Counter #(
	parameter N = 8
) (
	input logic clock, reset, enable,
	output logic [N-1:0] q
);

always_ff @ (negedge clock or posedge reset)
	if (reset) q = 8'h00;
	else
		if (enable) q = q + 1'b1;

endmodule