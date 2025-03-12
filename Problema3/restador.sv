module restador #(N=6) (
	input logic clk,
	input logic rst,
	output logic [N-1:0] count
);

	always_ff @(posedge clk or posedge rst) begin
		if (rst)
			count <= {N{1'b1}};
		else
			count <= count - 1'b1;
	end

endmodule