// ---------------------------------------------------
// Ripple-Carry Adder (N bits)
// - Encadena N full adders para sumar dos números binarios
// ---------------------------------------------------

module adder #(
	parameter N = 4 // Número de bits (parámetro configurable)
) (
	input logic [N-1:0] a, b, 	 // Entradas: Dos operandos de N bits
	input logic cin, 				// Carry de entrada
	output logic [N-1:0] sum, // Salida de la suma
	output logic cout 		 // Carry de salida
);

	logic [N:0] carry; 		// Vector de acarreo interno
	assign carry[0] = cin; // Primer carry es la entrada

	// Generación(Iteración) de N Full Adders con un bucle 'generate'
	genvar i;
	generate
		for (i = 0; i < N; i++) begin : adder_stage
			full_adder FA (
				.a(a[i]),
				.b(b[i]),
				.cin(carry[i]),
				.sum(sum[i]),
				.cout(carry[i+1])
			);
		end
	endgenerate
	
	assign cout = carry[N]; // Carry final
	
endmodule