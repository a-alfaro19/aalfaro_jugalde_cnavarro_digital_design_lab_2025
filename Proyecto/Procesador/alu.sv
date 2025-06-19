module alu #(parameter N = 32) (
    input logic [N-1:0] a,
    input logic [N-1:0] b,
    input logic [1:0] ALUControl,
    output logic [N-1:0] Result,
    output logic [3:0] ALUFlags
);

	logic [N-1:0] resultADD, resultSUB, resultAND, resultOR;
   logic	 cout, coutADD, coutSUB;
	
	adderalu #(32) adder_inst(a, b, 1'b0, resultADD, coutADD);
	adderalu #(32) subtractor_inst(a, ~b, 1'b1, resultSUB, coutSUB);
	assign resultAND = a & b;
	assign resultOR = a | b;
	
	always_comb begin
		// Valores por defecto (evita latchs y errores)
		Result = 32'b0;
		cout   = 1'b0;

		case (ALUControl)
			2'b00: // Add
				begin
					Result = resultADD;
					cout = coutADD;
				end
				
			2'b01: // Subtract
				begin
					Result = resultSUB;
					cout = coutSUB;
				end
				
			2'b10: // AND
				Result = resultAND;
				
			2'b11: // OR
				Result = resultOR;
		endcase
	end

	// ALUFlags: [3] = Negative     [2] = Zero     [1] = Carry out     [0] = oVerflow
	assign ALUFlags[3] = Result[N-1];
	assign ALUFlags[2] = ~Result;
	assign ALUFlags[1] = ~ALUControl[1] & cout;
	assign ALUFlags[0] = ~(a[N-1]^b[N-1]^ALUControl[0]) & (a[N-1]^Result[N-1])&~ALUControl[1];

endmodule
