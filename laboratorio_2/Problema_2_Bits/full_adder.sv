// -----------------------------------------
// Full Adder: Suma tres bits (A, B, Cin)
// -----------------------------------------

module full_adder (
	input logic a, b, cin, 		 // Entradas: A, B y Carry In
	output logic sum, cout		// Salida: Suma y Carry Out
);

	logic s1, c1, c2; // Señales internas
	
	// Se usan dos Half Adders para construir el Full Adder
	half_adder HA1 (.a(a), .b(b), .sum(s1), .carry(c1)); 
	half_adder HA2 (.a(s1), .b(cin), .sum(sum), .carry(c2));
	
	// Se calcula el Carry Out
	assign cout = c1 | c2;
	
endmodule
