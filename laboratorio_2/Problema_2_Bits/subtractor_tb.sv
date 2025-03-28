// ---------------------------------------------
// Testbench para probar el Ripple-Carry Subtractor
// ---------------------------------------------

module subtractor_tb;

	parameter int N = 4;  // Tamaño de los operandos
	logic [N-1:0] a, b;  // Operandos
	logic bin;            // Borrow In
	logic [N-1:0] diff;   // Resultado de la resta
	logic bout;           // Borrow Out
	
	// Instancia del módulo
	subtractor #(N) SUBTRACTOR (
		.a(a),
		.b(b),
		.bin(bin),
		.diff(diff),
		.bout(bout)
	); 
	
	// Simulación de pruebas
	initial begin
		$monitor("A = %b, B = %b, Bin = %b -> Diff = %b, Bout = %b", a, b, bin, diff, bout);
		
		// Casos de prueba
		a = 4'b0110; b = 4'b0011; bin = 0; #10;
		a = 4'b1001; b = 4'b0100; bin = 1; #10;
		a = 4'b1111; b = 4'b0001; bin = 0; #10;
		a = 4'b1000; b = 4'b0001; bin = 1; #10;

		$finish; // Finaliza la simulación
	end
	
endmodule