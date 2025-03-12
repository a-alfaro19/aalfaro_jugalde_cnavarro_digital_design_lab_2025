module restador_fpga (
	input logic reset_sw,        // Reset asincrónico
	input logic decrement_btn,  // Botón para decrementar
	input initial_btn1,
	input initial_btn2,
	input initial_btn3,
	output reg [6:0] segA, // 7-seg A
	output reg [6:0] segB  // 7-seg B
);
	// Parameter
	parameter N = 6;

	// Señales internas
	reg [N-1:0] counter;
	wire [5:0] init_value;
	
	// Valor inicial desde los botones
	assign init_value[0] = initial_btn1;
	assign init_value[1] = 1'b0;
	assign init_value[2] = initial_btn2;
	assign init_value[3] = 1'b0;
	assign init_value[4] = 1'b0;
	assign init_value[5] = initial_btn3;
	
	// Instanciamos el restador de 6 bits
	restador #(.N(N)) uut (
	  .reset(reset_sw),
	  .decrement_btn(decrement_btn),
	  .init_value(init_value),
	  .out(counter)
	);
	
	// Decodificador de 7 segmentos 
	seven_segment_decoder #(.N(N)) decoder (
		.count(counter),
		.segA(segA),
		.segB(segB)
	);
	
endmodule
