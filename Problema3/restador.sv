module restador #(N=6) (
	input logic clk,
	input logic reset,
	input logic decrement_btn,
	input logic [2:0] init_value, 
	output reg [N-1:0] out      
);
	
	always_ff @(posedge clk or negedge reset) begin
		if (~reset) out <= init_value;
		else if (decrement_btn) begin
			if (out == 0) out <= init_value;
			else out <= out - 1'b1;
		end
	end
 
endmodule