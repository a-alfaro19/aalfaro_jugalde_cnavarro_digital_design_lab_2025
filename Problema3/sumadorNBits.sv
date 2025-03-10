module sumadorNBits #(parameter N=8) (
	input logic [N-1:0] a, b,
	input logic c_in,
	output logic [N-1:0] s,
	output logic c_out
);

	logic [N:0] carries; // Carries generados por la suma en cadena
	assign carries[0] = c_in; // Asignar carry inicial
	
	genvar i;
	generate
		for (i = 0; i < N; i++) begin : sumasUnBit
			sumadorUnBit sumadorUnBit(
				.a(a[i]), // Numero A
				.b(b[i]), // Numero B
				.c_in(carries[i]), // Carry
				.s(s[i]), // Resultado de suma
				.c_out(carries[i+1]) // Carry del resultado
			);
		end
	endgenerate
	
	assign c_out = carries[N]; // Obtener el ultimo carry

endmodule
	