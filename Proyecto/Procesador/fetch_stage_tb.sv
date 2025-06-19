`timescale 1 ps / 1 ps

module fetch_stage_tb;

	// Señales del fetch
	logic clk;
	logic rst;
	logic [31:0] next_pc;
	logic [31:0] pc_out;
	logic [31:0] instruction;
	
	// Instancia del fetch_stage
	fetch_stage uut (
	 .clk(clk),
	 .rst(rst),
	 .next_pc(next_pc),
	 .pc_out(pc_out),
	 .instruction(instruction)
	);
	
	// Generador de reloj (10 ns por ciclo → 100 MHz)
	initial begin
	 clk = 0;
	 forever #5 clk = ~clk;
	end
	
	// Estímulos del test
	initial begin
		$display("Inicio de simulación");

		// Inicialización
		rst = 1;
		next_pc = 32'h0;
		
		// Activar reset
		#20;
		rst = 0;

		// Esperar algunos ciclos de reloj con reset activo
		#20;
		rst = 1;

		// Leer varias instrucciones desde ROM
		repeat (8) begin
			@(posedge clk);
			#1;
			$display("PC = %h, Instruction = %h", pc_out, instruction);
			next_pc = next_pc + 4;
		end

		$display("Fin de simulación");
		$finish;
	end
	
endmodule