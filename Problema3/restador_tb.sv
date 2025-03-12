`timescale 1ns / 1ps

module restador_tb ();
	
	// Parámetros para el test
   parameter N1 = 2;
	parameter N2 = 4;
	parameter N3 = 6;
	
	// Entradas
	logic clk;
	logic reset;
	logic enable;
	
	// Salida
   logic [N1-1:0] out1;
	logic [N2-1:0] out2;
	logic [N3-1:0] out3;
	
	
	// Instanciamos el restador
	restador #(
	  .N(N1)
	) uut_2_bits (
	  .clk(clk),
	  .reset(reset),
	  .decrement_btn(enable),
	  .init_value({N1{1'b1}}),
	  .out(out1)
	);
	
	restador #(
	  .N(N2)
	) uut_4_bits (
	  .clk(clk),
	  .reset(reset),
	  .decrement_btn(enable),
	  .init_value({N2{1'b1}}),
	  .out(out2)
	);
	
	restador #(
	  .N(N3)
	) uut_6_bits (
	  .clk(clk),
	  .reset(reset),
	  .decrement_btn(enable),
	  .init_value({N3{1'b1}}),
	  .out(out3)
	);
	
	// Generar el reloj
   always #5 clk = ~clk;  // Ciclo de reloj de 10 unidades de tiempo
	
	initial begin
		// Inicialización
		clk = 0;
		reset = 0;
		enable = 0;

		// Prueba para reset asíncrono
		#10 reset = 1;  // Activamos el reset asincrónico
		#10 enable = 1;    // Habilitamos el restador
		#10 enable = 0;    // Deshabilitamos el restador
		#10 reset = 0;   // Activamos el reset asincrónico
		#10 reset = 1;   // Desactivamos el reset asincrónico
		#10 enable = 1;    // Habilitamos el restador

		// Fin de la simulación
		#50; $finish;
	end

   initial begin
		// Chequeo de resultados
		$monitor("Time: %0t | out 1 (2 bits): %b | out 2 (4 bits): %b | out 3 (6 bits): %b", $time, out1, out2, out3);
	end
	
endmodule