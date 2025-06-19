module fetch_stage (
	input logic clk, rst,
	input logic [31:0] next_pc,
	output logic [31:0] pc_out,
	output logic [31:0] instruction
);

	logic [31:0] pc;
	logic [31:0] instr;
	logic [31:0] instr_reg;
	
	// Instancia de ROM
	rom rom_inst (
		.address(pc[9:2]), 
		.clock(clk), 
		.q(instr)
	);
	
	always_ff @ (posedge clk or negedge rst) begin 
		if (!rst) pc <= 32'h0;
		else pc <= next_pc;
	end
	
	// Registro salida instrucción para estabilidad
	always_ff @(posedge clk) begin
		instr_reg <= instr;
	end
	
	assign instruction = instr_reg;
	assign pc_out = pc;

endmodule