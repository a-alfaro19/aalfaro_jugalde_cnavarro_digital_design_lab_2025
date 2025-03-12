module restador_fpga (
	input logic clk,            // Reloj
	input logic reset_sw,        // Reset asincrónico
	input logic decrement_btn,  // Botón para decrementar
	input initial_btn1,
	input initial_btn2,
	input initial_btn3,
	output logic [6:0] display_segments  // Display 7 segmentos (parte de la salida)
);

	// Señales internas
	wire [5:0] counter;
	wire [5:0] init_value;
	
	// Valor inicial desde los botones
	assign init_value[0] = initial_btn1;
	assign init_value[1] = initial_btn2;
	assign init_value[2] = initial_btn3;
	assign init_value[3] = 1'b0;
	assign init_value[4] = 1'b0;
	assign init_value[5] = 1'b0;
	
	// Instanciamos el restador de 6 bits
	restador #(
	  .N(6)  // Restador de 6 bits
	) uut (
	  .clk(clk),
	  .reset(~reset_sw),
	  .decrement_btn(~decrement_btn),
	  .init_value(init_value),
	  .out(counter)
	);
	
	// Decodificador de 7 segmentos (ejemplo)
	seven_segment_decoder decoder (
		.binary_input(counter),
		.segments(display_segments)
	);
	
endmodule
