// ---------------------------------------------------
// Operación arimetica división (N bits)
// ---------------------------------------------------

module division #(
	parameter N = 4 // Número de bits (parámetro configurable)
) (
	input logic [N-1:0] a, b, 	// Entradas: Dos operandos de N bits
	output logic [N-1:0] div  // Salida de la operación
);

	assign div = a / b;

endmodule	