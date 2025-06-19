module decoder (
	input logic [1:0] Op,
	input logic [5:0] Funct,
	input logic [3:0] Rd,
	output logic [1:0] FlagW,
	output logic PCS, 
	output logic RegW, 
	output logic MemW,
	output logic MemtoReg, 
	output logic ALUSrc,
	output logic Reverse,
	output logic MemByte,
	output logic [1:0] ImmSrc, 
	output logic [1:0] RegSrc, 
	output logic [1:0] ALUControl
);
	
	logic [10:0] controls;
	logic Branch, ALUOp;

	// Main Decoder
	always_comb
		casex(Op)
		
			2'b00: // Data-Processing Instructions
				if (Funct[5]) 
					controls = 11'b00001010010; // Data-processing immediate
				else 
					controls = 11'b00000010010; // Data-processing register 
					
			2'b01: // Memory Instructions
				if (Funct[0]) 
					controls = 11'b00011110000; // LDR
				else begin
					if (Funct[2])
						controls = 11'b10011101001; // STRB
					else
						controls = 11'b10011101000; // STR
				end
					
			2'b10: // Branch Instructions
				controls = 11'b01101000100; // B
		
			default: // Unimplemented
				controls = 11'bx;
		endcase

	assign {RegSrc, ImmSrc, ALUSrc, MemtoReg,
		RegW, MemW, Branch, ALUOp, MemByte} = controls;
		
	// ALU Decoder
	always_comb begin
		// Valores por defecto (evita latchs y errores)
		Reverse     = 1'b0;
		ALUControl  = 2'b00;
		FlagW       = 2'b00;
		 
		if (ALUOp) begin // which DP Instr?
			case(Funct[4:1])
				4'b0100: // ADD
					begin 
						Reverse = 1'b0;
						ALUControl = 2'b00;
					end  
				
				4'b0010:// SUB 
					begin
						Reverse = 1'b0;
						ALUControl = 2'b01; 
					end
				
			   4'b0011: // RSB
					begin
						Reverse = 1'b1;
						ALUControl = 2'b01;
					end
				
				4'b0000: // AND
					begin	
						Reverse = 1'b0;
						ALUControl = 2'b10; 
					end
				
				4'b1100: // ORR
					begin
						Reverse = 1'b0;
						ALUControl = 2'b11; 
					end
				
				default: // unimplemented
					begin
						Reverse = 1'bx;
						ALUControl = 2'bx; 
					end
			endcase

			// update flags if S bit is set (C & V only for arith)
			FlagW[1] = Funct[0];
			FlagW[0] = Funct[0] &
			(ALUControl == 2'b00 | ALUControl == 2'b01);
			
		end else begin
			ALUControl = 2'b00; // add for non-DP instructions
			FlagW = 2'b00; // don't update Flags
		end
	end

	// PC Logic
	assign PCS = ((Rd == 4'b1111) & RegW) | Branch;

endmodule