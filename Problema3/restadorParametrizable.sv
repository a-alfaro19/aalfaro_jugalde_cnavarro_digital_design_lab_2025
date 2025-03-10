module restadorParametrizable #(parameter N=8) (
	input logic clk,
	input logic reset,
	input logic [N-1:0] a, b,
	output logic [N-1:0] s,
	output logic c_out
);

	logic [N-1:0] b_complemento; // Complemento a Dos de B
	logic [N-1:0] resultado_suma; // Resultado de la suma
	logic c_out_suma; // Carry de la suma
	
	
	complementoDos #(N) complemento ( // Complemento a B
		.a(b), // Entrada
		.y(b_complemento) // Salida
	);
	
	sumadorNBits #(N) suma ( // Suma de A + (B Complemento)
		.a(a),
		.b(b_complemento),
		.c_in(1'b0), // Acarreo inicial
		.s(resultado_suma), // Resultado Suma
		.c_out(c_out_suma) // Acarreo del resultado
	);
	
	// Reset
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			s <= 'b0;
			c_out <= 'b0;
		end else begin 
			s <= resultado_suma;
			c_out <= c_out_suma;
		end
	end


endmodule