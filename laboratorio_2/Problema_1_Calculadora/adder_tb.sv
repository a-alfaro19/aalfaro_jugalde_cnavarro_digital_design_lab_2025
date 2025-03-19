// ---------------------------------------------
// Testbench para probar el Ripple-Carry Adder
// ---------------------------------------------

module adder_tb;

	parameter int N = 4;  // Tamaño de los operandos
	logic [N-1:0] a, b;  // Operandos
	logic cin; 			  // Carry In
	logic [N-1:0] sum; // Resultado de la suma
	logic cout; 		// Carry Out
	
	// Instancia del módulo
	adder #(N) ADDER (
		.a(a),
		.b(b),
		.cin(cin),
		.sum(sum),
		.cout(cout)
	); 
	
	// Simulación de pruebas
	initial begin
		$monitor("A = %b, B = %b, Cin = %b -> Sum = %b, Cout = %b", a, b, cin, sum, cout);
		
		// Casos de prueba
		a = 4'b0011; b = 4'b0101; cin = 0; #10;
		a = 4'b1100; b = 4'b1010; cin = 1; #10;
		a = 4'b1111; b = 4'b0001; cin = 0; #10;
		a = 4'b0000; b = 4'b0000; cin = 1; #10;

		$finish; // Finaliza la simulación
	end
	
endmodule
