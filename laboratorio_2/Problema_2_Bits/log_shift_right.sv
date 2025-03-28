// ---------------------------------------------------
// Operación lógica Shift Right (N bits)
// ---------------------------------------------------

module log_shift_right #(
	parameter N = 4 // Número de bits (parámetro configurable)
) (
	input logic [N-1:0] a, 				// Entrada: Número de N bits
	input logic [2:0] shift_amount, // Entrada: Número de bits a mover
	output logic [N-1:0] out 		 // Salida de la operación
);

	assign out = a >> shift_amount;
	
endmodule