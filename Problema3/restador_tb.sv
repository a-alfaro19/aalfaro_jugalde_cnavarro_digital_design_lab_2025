`timescale 1ns/1ps

module restador_tb ();
	
	logic clk;
	logic rst;
	
	// Señales para los diferentes tamaños de contador
	logic [1:0] count_2; // Para N=2 bits
	logic [3:0] count_4; // Para N=4 bits
	logic [5:0] count_6; // Para N=6 bits

	// Instancias del módulo con diferentes valores de N
	decrement_counter #(.N(2)) uut_2 (
		.clk(clk),
		.rst(rst),
		.count(count_2)
	);

	decrement_counter #(.N(4)) uut_4 (
		.clk(clk),
		.rst(rst),
		.count(count_4)
	);

	decrement_counter #(.N(6)) uut_6 (
		.clk(clk),
		.rst(rst),
		.count(count_6)
	);

	// Generación del reloj (Período = 10 unidades de tiempo)
	always #5 clk = ~clk;
	
	initial begin 
		// Mensaje de inicio
		$display("=========================================");
		$display("Iniciando testbench...");
		$display("=========================================");

		// Inicialización
		clk = 0;
		rst = 1;   // Activar reset
		#10 rst = 0; // Desactivar reset

		// Monitoreo de las señales en consola
		$display("Tiempo  | count_2 | count_4 | count_6 ");
		$monitor("%t    | %b       | %b       | %b", 
				  $time, count_2, count_4, count_6);

		// Esperar suficientes ciclos para ver la cuenta regresiva
		#200; 

		$display("=========================================");
		$display("Testbench finalizado.");
		$display("=========================================");
		$stop;
		end
	
endmodule