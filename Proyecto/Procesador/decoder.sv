module decoder(input logic [1:0] Op,
	input logic [5:0] Funct,
	input logic [3:0] Rd,
	output logic [1:0] FlagW,
	output logic PCS, RegW, MemW,
	output logic MemtoReg, ALUSrc,
	output logic [1:0] ImmSrc, RegSrc,
	output logic [2:0] ALUControl);
	
	logic [9:0] controls;
	logic Branch, ALUOp;

	// Main Decoder
	always_comb
		casex(Op)
			// Data-processing immediate
			2'b00: begin
			  // BX instruction (funct = 000001) → branch to register
			  if (Funct == 6'b000001)
				 controls = 10'b0000000010; // Branch (RegW = 0)
			  else if (Funct[5]) 
				 controls = 10'b0000101001; // DP Immediate
			  else 
				 controls = 10'b0000001001; // DP Register
			end

			// LDR
			2'b01: if (Funct[0]) 
			  controls = 10'b0001111000;
			// STR
			else 
			  controls = 10'b1001110100;

			// Branch or Branch with Link
			2'b10: begin 
			  if (Funct[5]) // BL → bit[24] == 1
				 controls = 10'b0110100010; // RegW = 1 → guardar PC en LR
			  else
				 controls = 10'b0110000010; // B sin link
			end

			// Unimplemented
			default: controls = 10'bxxxxxxxxxx;
		 endcase

	assign {RegSrc, ImmSrc, ALUSrc, MemtoReg,
	RegW, MemW, Branch, ALUOp} = controls;
	
	// ALU Decoder
	always_comb begin
		if (ALUOp) begin // which DP Instr?
				case (Funct[4:1])
					4'b0100: ALUControl = 3'b000; // ADD
					4'b0010: ALUControl = 3'b001; // SUB
					4'b0011: ALUControl = 3'b111; // RSB 
					4'b0000: ALUControl = 3'b010; // AND
					4'b1100: ALUControl = 3'b011; // ORR
					4'b1101: ALUControl = 3'b100; // LSL (shift lógica)
					4'b1001: ALUControl = 3'b101; // MUL
					4'b1011: ALUControl = 3'b110; // MOV
					default: ALUControl = 3'bxxx; // No soportado
				endcase

			// update flags if S bit is set (C & V only for arith)
			FlagW[1] = Funct[0];
			FlagW[0] = Funct[0] &
				(ALUControl == 3'b000 | ALUControl == 3'b001);
				
		end else begin
			ALUControl = 3'b000; // add for non-DP instructions
			FlagW = 2'b00; // don't update Flags
		end
	end

	// PC Logic
	assign PCS = ((Rd == 4'b1111) & RegW) | Branch;

endmodule