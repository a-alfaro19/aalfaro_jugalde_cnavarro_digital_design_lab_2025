module alu #(
    parameter N = 4  // Bits de los operandos (2,4,8,16,32)
)(
    input [N-1:0] a,
    input [N-1:0] b,
    input [3:0] op,
    output reg [2*N-1:0] result,  // Resultado de hasta 2N bits
    output reg [3:0] flags         // [carry, negativo, overflow, cero]
);

    // Conexiones para módulos
    wire [N-1:0] adder_sum, sub_diff, mult_R, div_out, mod_out;
    wire [N-1:0] and_out, or_out, xor_out, shiftL_out, shiftR_out;
    wire adder_cout, sub_bout, mult_Of;

    // Instancias de módulos parametrizados
    adder #(N) ADDER(a, b, 1'b0, adder_sum, adder_cout);
    subtractor #(N) SUBTRACTOR(a, b, 1'b0, sub_diff, sub_bout);
    multiplicador #(N) MULT(a, b, mult_Of, mult_R);
    division #(N) DIV(a, b, div_out);
    modulo #(N) MOD(a, b, mod_out);
    log_and #(N) AND(a, b, and_out);
    log_or #(N) OR(a, b, or_out);
    log_xor #(N) XOR(a, b, xor_out);
    log_shift_left #(N) SHIFT_L(a, b[$clog2(N)-1:0], shiftL_out);
    log_shift_right #(N) SHIFT_R(a, b[$clog2(N)-1:0], shiftR_out);

    always @(*) begin
        result = 0;
        flags = 0;

        case(op)
            // Suma (Flags: carry, overflow, negativo, cero)
            4'b1111: begin
                result[N-1:0] = adder_sum;
                flags[3] = adder_cout;  // Carry
                flags[1] = adder_sum[N-1];  // Negativo
                flags[0] = (adder_sum == 0);  // Cero
                // Overflow: a y b mismo signo ≠ resultado
                flags[2] = (a[N-1] == b[N-1]) && (adder_sum[N-1] != a[N-1]);
            end

            // Resta (Flags: borrow, overflow, negativo, cero)
            4'b1110: begin
                result[N-1:0] = sub_diff;
                flags[3] = sub_bout;  // Borrow
                flags[1] = sub_diff[N-1];  // Negativo
                flags[0] = (sub_diff == 0);  // Cero
                // Overflow: a y b distinto signo ≠ resultado
                flags[2] = (a[N-1] != b[N-1]) && (sub_diff[N-1] != a[N-1]);
            end

            // Multiplicación (Flags: overflow, negativo, cero)
            4'b1101: begin
                result = {mult_Of, mult_R};
                flags[1] = result[2*N-1];  // Negativo (MSB del resultado completo)
                flags[0] = (mult_R == 0);  // Cero
                flags[2] = mult_Of;  // Overflow
            end

            // División (Flags: cero, error división por cero)
            4'b1100: begin
                result[N-1:0] = (b == 0) ? {N{1'b1}} : div_out;
                flags[0] = (div_out == 0) || (b == 0);
            end

            // Módulo (Flags: cero, error módulo por cero)
            4'b1011: begin
                result[N-1:0] = (b == 0) ? {N{1'b1}} : mod_out;
                flags[0] = (mod_out == 0) || (b == 0);
            end

            // Operaciones lógicas y shifts (Flags: negativo, cero)
            default: begin
                case(op)
                    4'b1010: result[N-1:0] = and_out;  // AND
                    4'b1001: result[N-1:0] = or_out;   // OR
                    4'b1000: result[N-1:0] = xor_out;  // XOR
                    4'b0111: result[N-1:0] = shiftL_out;  // Shift Left
                    4'b0110: result[N-1:0] = shiftR_out;  // Shift Right
                endcase
                flags[1] = result[N-1];  // Negativo
                flags[0] = (result[N-1:0] == 0);  // Cero
            end
        endcase
    end
endmodule