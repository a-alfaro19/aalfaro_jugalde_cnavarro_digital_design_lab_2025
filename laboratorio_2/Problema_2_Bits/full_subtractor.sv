// -----------------------------------------
// Full Subtractor: Resta tres bits (A, B, Bin)
// -----------------------------------------

module full_subtractor (
	input logic a, b, bin,      // Entradas: A, B y Borrow In
	output logic diff, bout     // Salida: Diferencia y Borrow Out
);

	logic d1, b1, b2; // Señales internas
	
	// Se usan dos Half Subtractors para construir el Full Subtractor
	half_subtractor HS1 (.a(a), .b(b), .diff(d1), .borrow(b1)); 
	half_subtractor HS2 (.a(d1), .b(bin), .diff(diff), .borrow(b2));
	
	// Se calcula el Borrow Out
	assign bout = b1 | b2;
	
endmodule
