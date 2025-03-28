module alu_top #(
    parameter N = 32  // Bits de los operandos
)(
    input clk, reset,
    input [N-1:0] a, b,
    input [3:0] op,
    output [2*N-1:0] result,
    output [3:0] flags
);

    // Registros de entrada/salida
    reg [N-1:0] a_reg, b_reg;
    reg [3:0] op_reg;
    reg [2*N-1:0] result_reg;
    reg [3:0] flags_reg;

    // Lógica combinacional (ALU)
    wire [2*N-1:0] alu_result;
    wire [3:0] alu_flags;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            a_reg <= 0;
            b_reg <= 0;
            op_reg <= 0;
            result_reg <= 0;
            flags_reg <= 0;
        end else begin
            a_reg <= a;
            b_reg <= b;
            op_reg <= op;
            result_reg <= alu_result;
            flags_reg <= alu_flags;
        end
    end

    // Instancia de la ALU
    alu #(N) alu_inst(
        .a(a_reg),
        .b(b_reg),
        .op(op_reg),
        .result(alu_result),
        .flags(alu_flags)
    );

    assign result = result_reg;
    assign flags = flags_reg;
endmodule