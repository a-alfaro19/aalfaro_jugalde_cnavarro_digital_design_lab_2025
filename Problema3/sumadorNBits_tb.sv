module sumadorNBits_tb();

	parameter N = 8;
	logic [N-1:0] a, b, s;
	logic c_in, c_out;
	bit all_tests_passed = 1;
	
	sumadorNBits #(N) modulo (
		.a(a), 
		.b(b), 
		.c_in(c_in), 
		.s(s), 
		.c_out(c_out)
	);
	
	initial begin
		$display("Tiempo | a        | b        | c_in | s        | c_out");
		$monitor("%0t      | %b | %b | %b | %b | %b", $time, a, b, c_in, s, c_out);

		// Casos de prueba
		
		a = 8'b00000101; b = 8'b00000011; c_in = 0; #10;
		assert (s === 8'b00001000 && c_out === 0) else begin
			$error("Prueba 000 fallida.");
			all_tests_passed = 0;
		end

		a = 8'b11111111; b = 8'b00000001; c_in = 0; #10;
		assert (s === 8'b00000000 && c_out === 1) else begin
			$error("Prueba 001 fallida.");
			all_tests_passed = 0;
		end

		a = 8'b00001010; b = 8'b00000101; c_in = 1; #10;
		assert (s === 8'b00010000 && c_out === 0) else begin
			$error("Prueba 002 fallida.");
			all_tests_passed = 0;
		end

		a = 8'b01111111; b = 8'b01111111; c_in = 0; #10;
		assert (s === 8'b11111110 && c_out === 0) else begin
			$error("Prueba 003 fallida.");
			all_tests_passed = 0;
		end

		a = 8'b11111111; b = 8'b11111111; c_in = 1; #10;
		assert (s === 8'b11111111 && c_out === 1) else begin
			$error("Prueba 004 fallida.");
			all_tests_passed = 0;
		end

		a = 8'b00000000; b = 8'b00000000; c_in = 0; #10;
		assert (s === 8'b00000000 && c_out === 0) else begin
			$error("Prueba 005 fallida.");
			all_tests_passed = 0;
		end

		a = 8'b10100101; b = 8'b00000000; c_in = 0; #10;
		assert (s === 8'b10100101 && c_out === 0) else begin
			$error("Prueba 006 fallida.");
			all_tests_passed = 0;
		end

		a = 8'b10100101; b = 8'b00000000; c_in = 1; #10;
		assert (s === 8'b10100110 && c_out === 0) else begin
			$error("Prueba 007 fallida.");
			all_tests_passed = 0;
		end

		
		if (all_tests_passed) begin
			$display("Todas las pruebas han pasado correctamente.");
		end
			
		$stop;
	end
endmodule