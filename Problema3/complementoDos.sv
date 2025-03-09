module complementoDos #(parameter N=8) (
	input logic [N-1:0] a,
	output logic [N-1:0] y
);

	always_comb
		if (a[N-1]) y = ~a + 1;
		else y = a;
		
endmodule