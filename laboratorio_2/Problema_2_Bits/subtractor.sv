// ---------------------------------------------------
// Ripple-Carry Subtractor (N bits)
// - Encadena N full subtractors para restar dos números binarios
// ---------------------------------------------------

module subtractor #(
	parameter N = 4 // Número de bits (parámetro configurable)
) (
	input logic [N-1:0] a, b,    // Entradas: Minuendo y sustraendo de N bits
	input logic bin,             // Borrow de entrada
	output logic [N-1:0] diff,   // Salida de la resta
	output logic bout            // Negativo de salida
);

	logic [N:0] borrow;         // Vector de borrow interno
	assign borrow[0] = bin;     // Primer borrow es la entrada

	// Generación de N Full Subtractors con un bucle 'generate'
	genvar i;
	generate
		for (i = 0; i < N; i++) begin : subtractor_stage
			full_subtractor FS (
				.a(a[i]),
				.b(b[i]),
				.bin(borrow[i]),
				.diff(diff[i]),
				.bout(borrow[i+1])
			);
		end
	endgenerate
	
	assign bout = borrow[N]; // Borrow final
	
endmodule