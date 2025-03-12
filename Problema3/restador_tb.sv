`timescale 1ns / 1ps

module restador_tb ();
	
	logic reset;
	logic decrement_btn;
	logic [2:0] init_value_2b, init_value_4b, init_value_6b;
	logic [1:0] out_2b; // Para la instancia de 2 bits
	logic [3:0] out_4b; // Para la instancia de 4 bits
	logic [5:0] out_6b; // Para la instancia de 6 bits

	
	
	// Instanciamos el módulo con distintos tamaños de N
	restador #(2) uut_2b (
	 .reset(reset),
	 .decrement_btn(decrement_btn),
	 .init_value(init_value_2b),
	 .out(out_2b)
	);

	restador #(4) uut_4b (
	 .reset(reset),
	 .decrement_btn(decrement_btn),
	 .init_value(init_value_4b),
	 .out(out_4b)
	);

	restador #(6) uut_6b (
	 .reset(reset),
	 .decrement_btn(decrement_btn),
	 .init_value(init_value_6b),
	 .out(out_6b)
	);
	
	
	initial begin
		// Inicialización
		init_value_2b = 2'b11;  // 3
		init_value_4b = 4'b1010; // 10
		init_value_6b = 6'b111100; // 60
		
		reset = 0; #5; reset = 1;
		decrement_btn = 1;

		// Mostrar valores iniciales
		#5;
		$display("Inicio: out_2b = %d, out_4b = %d, out_6b = %d", out_2b, out_4b, out_6b);


		// Prueba de decremento
		#10 decrement_btn = 0; #10 decrement_btn = 1;
		#10 decrement_btn = 0; #10 decrement_btn = 1;
		#10 decrement_btn = 0; #10 decrement_btn = 1;

		// Mostrar después de varios decrementos
		#10;
		$display("Después de decrementos: out_2b = %d, out_4b = %d, out_6b = %d", out_2b, out_4b, out_6b);

		// Prueba de reset
		#10 reset = 0; #10 reset = 1;

		// Mostrar después del reset
		#10;
		$display("Después de reset: out_2b = %d, out_4b = %d, out_6b = %d", out_2b, out_4b, out_6b);

		// Terminar simulación
		#10 $finish;
	end
	
endmodule