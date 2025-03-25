module alu(
    input [3:0] a,
    input [3:0] b,
    input [3:0] op,
    output reg [7:0] result,
    output reg [3:0] flags  // [carry, negativo, overflow, cero]
);

    // Conexiones para módulos
    wire [3:0] adder_sum, sub_diff, mult_R, div_out, mod_out;
    wire [3:0] and_out, or_out, xor_out, shiftL_out, shiftR_out;
    wire adder_cout, sub_bout, mult_Of;
    
    // Instancias de módulos
    adder #(4) ADDER(
        .a(a),
        .b(b),
        .cin(1'b0),
        .sum(adder_sum),
        .cout(adder_cout)
    );
    
    subtractor #(4) SUBTRACTOR(
        .a(a),
        .b(b),
        .bin(1'b0),
        .diff(sub_diff),
        .bout(sub_bout)
    );
    
    multiplicador #(4) MULT(
        .x(a),
        .y(b),
        .Of(mult_Of),
        .R(mult_R)
    );
    
    division #(4) DIV(
        .a(a),
        .b(b),
        .div(div_out)
    );
    
    modulo #(4) MOD(
        .a(a),
        .b(b),
        .mod(mod_out)
    );
    
    log_and #(4) AND(
        .a(a),
        .b(b),
        .out(and_out)
    );
    
    log_or #(4) OR(
        .a(a),
        .b(b),
        .out(or_out)
    );
    
    log_xor #(4) XOR(
        .a(a),
        .b(b),
        .out(xor_out)
    );
    
    log_shift_left #(4) SHIFT_L(
        .a(a),
        .shift_amount(b[2:0]),
        .out(shiftL_out)
    );
    
    log_shift_right #(4) SHIFT_R(
        .a(a),
        .shift_amount(b[2:0]),
        .out(shiftR_out)
    );

    always @(*) begin
        result = 8'b0;
        flags = 4'b0;
        
        case(op)
            4'b1111: begin  // Suma
				    if(adder_sum == 0) flags[0] = 1;
                result[3:0] = adder_sum;
                flags[3] = adder_cout;
            end
            4'b1110: begin  // Resta
				    if(sub_diff == 0) flags[0] = 1;
                result[3:0] = sub_diff;
                flags[2] = sub_bout;
            end
            4'b1101: begin  // Multiplicación
                result = {mult_Of, mult_R};
                flags[1] = |mult_Of;
					 if(mult_R == 0) flags[0] = 1;
            end
            4'b1100: begin  // División
                if(b == 0) flags[0] = 1;
                else result[3:0] = div_out;
            end
            4'b1011: begin  // Módulo
                if(mod_out == 0) flags[0] = 1;
                else result[3:0] = mod_out;
            end
				
            4'b1010: begin
					if(and_out == 0) flags[0] = 1;
					result[3:0] = and_out;  // AND
				end
            4'b1001: begin
					if(or_out == 0) flags[0] = 1;
					result[3:0] = or_out;   // OR
				end
            4'b1000: begin
					if(xor_out == 0) flags[0] = 1;
					result[3:0] = xor_out;  // XOR
				end
            4'b0111: begin
					if(shiftL_out == 0) flags[0] = 1;
					result[3:0] = shiftL_out; // Shift Left
				end
            4'b0110: begin
					if(shiftR_out == 0) flags[0] = 1;
					result[3:0] = shiftR_out; // Shift Right
				end
        endcase
    end
endmodule