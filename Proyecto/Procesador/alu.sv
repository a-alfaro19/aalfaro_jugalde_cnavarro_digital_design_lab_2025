module alu #(parameter N = 32) (
     input  logic [N-1:0] a, b,                 // Entradas: operandos para las operaciones de la ALU
     input  logic [2:0]   ALUControl,           // Control de la operación a realizar
     input  logic [4:0] Shamt,                  // Desplazamiento (5 bits para un rango de 0-31)
     input  logic [1:0] ShiftType,              // Tipo de desplazamiento (lógico, aritmético, rotación)
     output logic [N-1:0] Result,               // Salida del resultado de la operación
     output logic [3:0] ALUFlags                // Indicadores: [3]=N, [2]=Z, [1]=C, [0]=V
 );

   // Resultados intermedios
	logic [N-1:0] resultADD, resultSUB, resultRSB;
	logic [N-1:0] resultAND, resultOR, resultShift, resultMUL;
	logic         coutADD, coutSUB, coutRSB;
	logic         cout;

	// Suma: a + b
	adderalu #(N) adder_inst(a, b, 1'b0, resultADD, coutADD);

	// Resta: a - b
	adderalu #(N) subtractor_inst(a, ~b, 1'b1, resultSUB, coutSUB);

	// RSB: b - a
	adderalu #(N) rsb_inst(b, ~a, 1'b1, resultRSB, coutRSB);

	// Shift
	barrel_shifter b_shifter(b, ShiftType, Shamt, resultShift);

	// Multiplicación
	mulalu #(N) mul_inst(a, b, resultMUL);

	// Lógicas
	assign resultAND = a & b;
	assign resultOR  = a | b;                   

	// Selector principal de la operación
	always_comb begin
	 case (ALUControl)
		3'b000: begin Result = resultADD; cout = coutADD; end         // ADD
		3'b001: begin Result = resultSUB; cout = coutSUB; end         // SUB
		3'b111: begin Result = resultRSB; cout = coutRSB; end         // RSB
		3'b010: begin Result = resultAND; cout = 0; end               // AND
		3'b011: begin Result = resultOR;  cout = 0; end               // ORR
		3'b100: begin Result = resultShift; cout = 0; end             // SHIFT (LSL)
		3'b101: begin Result = resultMUL; cout = 0; end               // MUL
		3'b110: begin Result = a;         cout = 0; end               // MOV
		default: begin Result = 32'b0;    cout = 0; end
	 endcase
	end

	// Flags: [3]=N, [2]=Z, [1]=C, [0]=V
	assign ALUFlags[3] = Result[N-1];                 // Negative
	assign ALUFlags[2] = (Result == 0);               // Zero
	assign ALUFlags[1] = cout;                        // Carry
	assign ALUFlags[0] = 
	 (ALUControl == 3'b000 || ALUControl == 3'b001 || ALUControl == 3'b111) ?
	 ((a[N-1] & ~b[N-1] & ~Result[N-1]) | (~a[N-1] & b[N-1] & Result[N-1])) :
	 1'b0;                                           // Overflow solo en ADD/SUB/RSB

endmodule