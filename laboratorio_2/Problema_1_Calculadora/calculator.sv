module calculator(
    input [11:0] sw,      // sw[3:0] = A, sw[7:4] = B, sw[11:8] = OP
    output [6:0] seg,
    output dp,
    output [3:0] an,
    output [3:0] led
);

    reg [3:0] a_reg, b_reg, op_reg;
    reg [7:0] result_reg;
    reg show_upper = 0;
    
    // Instancia de la ALU
    alu ALU(
        .a(a_reg),
        .b(b_reg),
        .op(op_reg),
        .result(result_reg),
        .flags(led)
    );
    
    // Instancia del decoder de display de 7 segmentos
    seg7_decoder DISPLAY(
        .num(show_upper ? result_reg[7:4] : result_reg[3:0]),
        .Yout(seg)
    );
    
    // Asignaciones constantes
    assign an = 4'b1110;  // Activar solo el primer display
    assign dp = 1'b1;     // Punto decimal apagado
    
    // Asignación combinacional, sin depender del clk
    always @(*) begin
        // Asignar directamente los valores de los interruptores a los registros
        a_reg = sw[3:0];      // Asignar A desde sw[3:0]
        b_reg = sw[7:4];      // Asignar B desde sw[7:4]
        op_reg = sw[11:8];    // Asignar OP desde sw[11:8]
    end
endmodule
