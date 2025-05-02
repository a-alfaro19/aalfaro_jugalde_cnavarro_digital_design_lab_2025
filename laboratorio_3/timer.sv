module timer (
	input logic clk, // Señal de Reloj
	input logic rst, // Señal de Reset
	input logic start, // Señal de inicio
	output logic time_out // Señal de finalizado
);

	logic [3:0] count = 4'b0000;	// Cuenta del contador
	logic [3:0] t_f = 10; 			// Duración del turno (10 segundos)
	
	always_ff @ (posedge clk or posedge rst) 
		if (rst) 
			// Reiniciar la cuenta cuando se activa el reset.
			count <= 4'b0000;
		else if (start)
			// Aumentar la cuenta si la señal de inicio está activa.
			count <= count + 1;
		
	// Generar señal de finalización
	assign time_out = (count >= t_f * 1000 / 2);

endmodule