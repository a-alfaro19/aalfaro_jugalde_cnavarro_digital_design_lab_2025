module alu (
    input  [31:0] SrcA,
    input  [31:0] SrcB,
    input  [3:0]  ALUControl,
    output reg [31:0] ALUResult,
    output reg [3:0]  ALUFlags
);

    reg [32:0] alu_sum;

    always @(*) begin
        // Defaults
        ALUResult = 32'b0;
        ALUFlags  = 4'b0000;

        case (ALUControl)
            4'b0000: ALUResult = SrcA & SrcB;
            4'b0001: ALUResult = SrcA | SrcB;
            4'b0010: begin
                alu_sum = {1'b0, SrcA} + {1'b0, SrcB};
                ALUResult = alu_sum[31:0];
                ALUFlags[1] = alu_sum[32]; // CarryOut
                ALUFlags[0] = (SrcA[31] == SrcB[31]) && (ALUResult[31] != SrcA[31]);
            end
            4'b0110: begin
                alu_sum = {1'b0, SrcA} - {1'b0, SrcB};
                ALUResult = alu_sum[31:0];
                ALUFlags[1] = alu_sum[32]; // Borrow
                ALUFlags[0] = (SrcA[31] != SrcB[31]) && (ALUResult[31] != SrcA[31]);
            end
            4'b0111: ALUResult = ($signed(SrcA) < $signed(SrcB)) ? 32'd1 : 32'd0;
            4'b1100: ALUResult = ~(SrcA | SrcB);
        endcase

        ALUFlags[3] = (ALUResult == 32'b0); // Zero
        ALUFlags[2] = ALUResult[31];        // Negative
    end

endmodule
