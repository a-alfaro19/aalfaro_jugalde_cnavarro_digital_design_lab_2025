module alu (
    input  logic [31:0] SrcA,      // Operando A
    input  logic [31:0] SrcB,      // Operando B
    input  logic [3:0]  ALUControl,// Control para seleccionar la operación
    output logic [31:0] ALUResult, // Resultado de la operación
    output logic [3:0]  ALUFlags   // Flags: [Zero, CarryOut, Negative, Overflow]
);

    logic [32:0] alu_sum;   // Para suma con carry out

    always_comb begin
        // Default outputs
        ALUResult = 32'b0;
        ALUFlags = 4'b0;

        case (ALUControl)
            4'b0000: begin // AND
                ALUResult = SrcA & SrcB;
            end
            4'b0001: begin // OR
                ALUResult = SrcA | SrcB;
            end
            4'b0010: begin // ADD
                alu_sum = {1'b0, SrcA} + {1'b0, SrcB};
                ALUResult = alu_sum[31:0];
                ALUFlags[1] = alu_sum[32]; // CarryOut
                // Overflow detection para suma de enteros con signo
                ALUFlags[0] = ( (SrcA[31] == SrcB[31]) && (ALUResult[31] != SrcA[31]) );
            end
            4'b0110: begin // SUB (SrcA - SrcB)
                alu_sum = {1'b0, SrcA} - {1'b0, SrcB};
                ALUResult = alu_sum[31:0];
                ALUFlags[1] = alu_sum[32]; // Borrow flag (CarryOut inverted para resta)
                // Overflow para resta
                ALUFlags[0] = ( (SrcA[31] != SrcB[31]) && (ALUResult[31] != SrcA[31]) );
            end
            4'b0111: begin // SLT (Set Less Than, signed)
                ALUResult = ($signed(SrcA) < $signed(SrcB)) ? 32'd1 : 32'd0;
            end
            4'b1100: begin // NOR
                ALUResult = ~(SrcA | SrcB);
            end
            default: begin
                ALUResult = 32'b0;
            end
        endcase

        // Zero flag: 1 si ALUResult es cero
        ALUFlags[3] = (ALUResult == 32'b0) ? 1'b1 : 1'b0;

        // Negative flag: igual al bit más significativo del resultado
        ALUFlags[2] = ALUResult[31];
    end

endmodule
