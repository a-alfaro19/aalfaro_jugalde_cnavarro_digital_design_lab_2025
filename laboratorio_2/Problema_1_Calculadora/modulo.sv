// ---------------------------------------------------
// Operación arimetica módulo (N bits)
// ---------------------------------------------------

module modulo #(
	parameter N = 4 // Número de bits (parámetro configurable)
) (
	input logic [N-1:0] a, b, 	// Entradas: Dos operandos de N bits
	output logic [N-1:0] mod  // Salida de la suma
);

	assign mod = a % b;
	
endmodule