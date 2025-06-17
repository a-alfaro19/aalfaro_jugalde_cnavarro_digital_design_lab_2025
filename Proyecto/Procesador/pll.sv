module pll(
	input logic inclk0,
	output logic c0
);
	logic toggle;
	initial begin
		toggle = 0;
	end
	
	always @(posedge inclk0) begin
		toggle <= ~toggle;
	end
	
	assign c0 = toggle;
endmodule