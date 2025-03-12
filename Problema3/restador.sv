module restador #(N=6) (
	input logic reset,
	input logic decrement_btn,
	input logic [N-1:0] init_value, 
	output reg [N-1:0] out      
);
	 
	always_ff @(negedge decrement_btn or negedge reset) begin
		if (~reset) out <= init_value;
		else if (~decrement_btn) begin
			if (out == 0) out <= init_value;
			else out <= out - 1;
		end

	end
 
endmodule