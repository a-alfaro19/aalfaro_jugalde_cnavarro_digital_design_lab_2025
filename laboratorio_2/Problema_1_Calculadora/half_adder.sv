// -----------------------------------------
// Half Adder: Suma dos bits y genera un carry
// -----------------------------------------

module half_adder (
	input logic a, b, 			 // Entradas
	output logic sum, carry 	// Salida de suma y acarreo
);

	// Operaciones del Half Adder
	assign sum = a ^ b; 		// Suma usando XOR
	assign carry = a & b;  // Carry usando AND
	
endmodule