// -----------------------------------------
// Half Subtractor: Resta dos bits y genera un borrow
// -----------------------------------------

module half_subtractor (
	input logic a, b,           // Entradas
	output logic diff, borrow   // Salida de diferencia y borrow
);

	// Operaciones del Half Subtractor
	assign diff = a ^ b;        // Diferencia usando XOR
	assign borrow = ~a & b;     // Borrow usando NOT y AND
	
endmodule
