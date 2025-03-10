module restadorParametrizable_tb();

	logic clk;
	logic reset_n;
	
	logic [1:0] a_2_bits, b_2_bits, s_2_bits;
	logic [3:0] a_4_bits, b_4_bits, s_4_bits;
	logic [7:0] a_8_bits, b_8_bits, s_8_bits;
	logic c_out_2_bits, c_out_4_bits, c_out_8_bits;
	bit all_tests_passed = 1;
	
	// Instancia del modulo
	restadorParametrizable #(2) dut_2_bits (
		.clk(clk),
	   .reset(reset_n),
		.a(a_2_bits),
		.b(b_2_bits),
		.s(s_2_bits), 
		.c_out(c_out_2_bits)
	);
	
	restadorParametrizable #(4) dut_4_bits (
		.clk(clk),
	   .reset(reset_n),
		.a(a_4_bits),
		.b(b_4_bits),
		.s(s_4_bits), 
		.c_out(c_out_4_bits)
	);
	
	restadorParametrizable #(8) dut_8_bits (
		.clk(clk),
	   .reset(reset_n),
		.a(a_8_bits),
		.b(b_8_bits),
		.s(s_8_bits), 
		.c_out(c_out_8_bits)
	);
	
	// Generación del clock
	always #5 clk = ~clk; // Periodo de 10 unidades de tiempo
		
	initial begin
//		$display("Probando clock y reset.");
//		clk = 0;
//		reset_n = 0;
//		
//		$display("reset_n inicial: %b", reset_n);
//		#10;
		
		// Enciende reset
//		reset_n = 1;
//		
//		$display("reset_n después de 10 unidades: %b", reset_n);
//		#10;
		
		// Inicialización
		clk = 0;
		reset_n = 0; // Aplicamos reset asíncrono
		
		
		$display("Probando casos de 2 bits.");
		$display("Tiempo | a        | b        | s        | c_out");
		$monitor("%0t      | %b | %b | %b | %b", $time, a_2_bits, b_2_bits, s_2_bits, c_out_2_bits);
		
		// Casos de prueba para 2 bits
		a_2_bits = 2'b01; b_2_bits = 2'b00; #10;
		assert(s_2_bits === 2'b01) else begin
			$error("Prueba 000 fallida.");
			all_tests_passed = 0;
		end

		a_2_bits = 2'b11; b_2_bits = 2'b01; #10;
		assert(s_2_bits === 2'b10) else begin
			$error("Prueba 001 fallida.");
			all_tests_passed = 0;
		end

		a_2_bits = 2'b10; b_2_bits = 2'b01; #10;
		assert(s_2_bits === 2'b01) else begin
			$error("Prueba 002 fallida.");
			all_tests_passed = 0;
		end

		a_2_bits = 2'b01; b_2_bits = 2'b10; #10;
		assert(s_2_bits === 2'b11) else begin
			$error("Prueba 003 fallida.");
			all_tests_passed = 0;
		end

		a_2_bits = 2'b00; b_2_bits = 2'b00; #10;
		assert(s_2_bits === 2'b00) else begin
			$error("Prueba 004 fallida.");
			all_tests_passed = 0;
		end
		
		$display("\nProbando casos de 4 bits.");
		$display("Tiempo | a        | b        | s        | c_out");
		$monitor("%0t      | %b | %b | %b | %b", $time, a_4_bits, b_4_bits, s_4_bits, c_out_4_bits);

		// Casos de prueba para 4 bits
		$display("4 bits test cases:");
		a_4_bits = 4'b0001; b_4_bits = 4'b0000; #10;
		assert(s_4_bits === 4'b0001) else begin
			$error("Prueba 005 fallida.");
			all_tests_passed = 0;
		end

		a_4_bits = 4'b0011; b_4_bits = 4'b0001; #10;
		assert(s_4_bits === 4'b0010) else begin
			$error("Prueba 006 fallida.");
			all_tests_passed = 0;
		end

		a_4_bits = 4'b0101; b_4_bits = 4'b0011; #10;
		assert(s_4_bits === 4'b0010) else begin
			$error("Prueba 007 fallida.");
			all_tests_passed = 0;
		end

		a_4_bits = 4'b1000; b_4_bits = 4'b0100; #10;
		assert(s_4_bits === 4'b0100) else begin
			$error("Prueba 008 fallida.");
			all_tests_passed = 0;
		end

		a_4_bits = 4'b1111; b_4_bits = 4'b0111; #10;
		assert(s_4_bits === 4'b1000) else begin
			$error("Prueba 009 fallida.");
			all_tests_passed = 0;
		end

		$display("\nProbando casos de 8 bits.");
		$display("Tiempo | a        | b        | s        | c_out");
		$monitor("%0t      | %b | %b | %b | %b", $time, a_8_bits, b_8_bits, s_8_bits, c_out_8_bits);
		
		// Casos de prueba para 8 bits
		$display("8 bits test cases:");
		a_8_bits = 8'b00000001; b_8_bits = 8'b00000000; #10;
		assert(s_8_bits === 8'b00000001) else begin
			$error("Prueba 010 fallida.");
			all_tests_passed = 0;
		end

		a_8_bits = 8'b00000011; b_8_bits = 8'b00000001; #10;
		assert(s_8_bits === 8'b00000010) else begin
			$error("Prueba 011 fallida.");
			all_tests_passed = 0;
		end

		a_8_bits = 8'b00000101; b_8_bits = 8'b00000011; #10;
		assert(s_8_bits === 8'b00000010) else begin
			$error("Prueba 012 fallida.");
			all_tests_passed = 0;
		end

		a_8_bits = 8'b11111000; b_8_bits = 8'b00000100; #10;
		assert(s_8_bits === 8'b11110100) else begin
			$error("Prueba 013 fallida.");
			all_tests_passed = 0;
		end

		a_8_bits = 8'b11111111; b_8_bits = 8'b01111111; #10;
		assert(s_8_bits === 8'b10000000) else begin
			$error("Prueba 014 fallida.");
			all_tests_passed = 0;
		end
		
		if (all_tests_passed) begin
			$display("Todas las pruebas han pasado correctamente.");
		end
			
		$stop;
	end
endmodule
