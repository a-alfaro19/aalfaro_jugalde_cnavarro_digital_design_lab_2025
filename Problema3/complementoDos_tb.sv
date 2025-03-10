module complementoDos_tb();

	parameter N = 4;
	logic [N-1:0] a, y;
	
	bit all_tests_passed = 1;
	
	complementoDos #(.N(N)) modulo(
		.a(a),
		.y(y)
	);
	
	initial begin
		$display("Tiempo | a      | y (Complemento a Dos)");
		$monitor("%0t    | %b | %b", $time, a, y);
	
		// Casos para números negativos
		a = 4'b1001; #10;
		assert (y === 4'b0111) else begin 
			$error("Prueba 000 fallida."); 
			all_tests_passed = 0;
		end
		
		a = 4'b1000; #10; 
		assert (y === 4'b1000) else begin 
			 $error("Prueba 001 fallida."); 
			 all_tests_passed = 0;
		end

		a = 4'b1001; #10; 
		assert (y === 4'b0111) else begin 
			 $error("Prueba 002 fallida."); 
			 all_tests_passed = 0;
		end

		a = 4'b1010; #10; 
		assert (y === 4'b0110) else begin 
			 $error("Prueba 003 fallida."); 
			 all_tests_passed = 0;
		end

		a = 4'b1011; #10; 
		assert (y === 4'b0101) else begin 
			 $error("Prueba 004 fallida."); 
			 all_tests_passed = 0;
		end

		a = 4'b1100; #10; 
		assert (y === 4'b0100) else begin 
			 $error("Prueba 005 fallida."); 
			 all_tests_passed = 0;
		end

		a = 4'b1101; #10; 
		assert (y === 4'b0011) else begin 
			 $error("Prueba 006 fallida."); 
			 all_tests_passed = 0;
		end

		a = 4'b1110; #10; 
		assert (y === 4'b0010) else begin 
			 $error("Prueba 007 fallida."); 
			 all_tests_passed = 0;
		end

		a = 4'b1111; #10; 
		assert (y === 4'b0001) else begin 
			 $error("Prueba 008 fallida."); 
			 all_tests_passed = 0;
		end

		// Casos para números positivos
		a = 4'b0001; #10; 
		assert (y === 4'b1111) else begin 
			 $error("Prueba 009 fallida."); 
			 all_tests_passed = 0;
		end

		a = 4'b0010; #10; 
		assert (y === 4'b1110) else begin 
			 $error("Prueba 010 fallida."); 
			 all_tests_passed = 0;
		end

		a = 4'b0011; #10; 
		assert (y === 4'b1101) else begin 
			 $error("Prueba 011 fallida."); 
			 all_tests_passed = 0;
		end

		a = 4'b0100; #10; 
		assert (y === 4'b1100) else begin 
			 $error("Prueba 012 fallida."); 
			 all_tests_passed = 0;
		end

		a = 4'b0101; #10; 
		assert (y === 4'b1011) else begin 
			 $error("Prueba 013 fallida."); 
			 all_tests_passed = 0;
		end

		a = 4'b1010; #10; 
		assert (y === 4'b0110) else begin 
			 $error("Prueba 014 fallida."); 
			 all_tests_passed = 0;
		end

		a = 4'b0111; #10; 
		assert (y === 4'b1001) else begin 
			 $error("Prueba 015 fallida."); 
			 all_tests_passed = 0;
		end

		// Casos adicionales con cambios de un solo bit para ver transiciones
		a = 4'b1000; #10; 
		assert (y === 4'b1000) else begin 
			 $error("Prueba 016 fallida."); 
			 all_tests_passed = 0;
		end

		a = 4'b1111; #10; 
		assert (y === 4'b0001) else begin 
			 $error("Prueba 017 fallida."); 
			 all_tests_passed = 0;
		end

		a = 4'b1101; #10; 
		assert (y === 4'b0011) else begin 
			 $error("Prueba 018 fallida."); 
			 all_tests_passed = 0;
		end

		a = 4'b1011; #10; 
		assert (y === 4'b0101) else begin 
			 $error("Prueba 019 repetida fallida."); 
			 all_tests_passed = 0;
		end

		a = 4'b0111; #10; 
		assert (y === 4'b1001) else begin 
			 $error("Prueba 020 fallida."); 
			 all_tests_passed = 0;
		end
		
		if (all_tests_passed) begin
			$display("Todas las pruebas han pasado correctamente.");
		end
			
		$stop;
	end
endmodule