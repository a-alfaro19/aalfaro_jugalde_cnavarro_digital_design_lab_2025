// ---------------------------------------------------
// Operación lógica XOR (N bits)
// ---------------------------------------------------

module log_xor #(
	parameter N = 4 // Número de bits (parámetro configurable)
) (
	input logic [N-1:0] a, b, 	// Entradas: Dos operandos de N bits
	output logic [N-1:0] out  // Salida de la suma
);

	assign out = a ^ b;
	
endmodule