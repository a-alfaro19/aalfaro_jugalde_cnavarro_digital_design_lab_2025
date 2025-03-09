module sumadorUnBit_tb();
	logic a, b, c_in, s, c_out;
	bit all_tests_passed = 1;
	
	sumadorUnBit modulo(a, b, c_in, s, c_out);
	
	initial begin
		$display("Tiempo | a      | b      | c_in      | s      | c_out");
		$monitor("%0t    | %b | %b | %b | %b | %b", $time, a, b, c_in, s, c_out);
		
		// Casos de prueba
		
		a = 0; b = 0; c_in = 0; #10;
		assert (c_out === 0 && s === 0) else begin
		$error("Prueba 001 fallida.");
		all_tests_passed = 0;
		end

		a = 0; b = 0; c_in = 1; #10;
		assert (c_out === 0 && s === 1) else begin
		$error("Prueba 002 fallida.");
		all_tests_passed = 0;
		end

		a = 0; b = 1; c_in = 0; #10;
		assert (c_out === 0 && s === 1) else begin
		$error("Prueba 003 fallida.");
		all_tests_passed = 0;
		end

		a = 0; b = 1; c_in = 1; #10;
		assert (c_out === 1 && s === 0) else begin
		$error("Prueba 004 fallida.");
		all_tests_passed = 0;
		end

		a = 1; b = 0; c_in = 0; #10;
		assert (c_out === 0 && s === 1) else begin
		$error("Prueba 005 fallida.");
		all_tests_passed = 0;
		end

		a = 1; b = 0; c_in = 1; #10;
		assert (c_out === 1 && s === 0) else begin
		$error("Prueba 006 fallida.");
		all_tests_passed = 0;
		end

		a = 1; b = 1; c_in = 0; #10;
		assert (c_out === 1 && s === 0) else begin
		$error("Prueba 007 fallida.");
		all_tests_passed = 0;
		end

		a = 1; b = 1; c_in = 1; #10;
		assert (c_out === 1 && s === 1) else begin
		$error("Prueba 008 fallida.");
		all_tests_passed = 0;
		end
		 
		if (all_tests_passed) begin
			$display("Todas las pruebas han pasado correctamente.");
		end
			
		$stop;
	end
endmodule