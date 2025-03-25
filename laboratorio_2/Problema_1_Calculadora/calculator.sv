module calculator(
    input clk,
    input [11:0] sw,      // sw[3:0] = A, sw[7:4] = B, sw[11:8] = OP
    input btn_execute,
    input btn_toggle,
    output [6:0] seg,
    output dp,
    output [3:0] an,
    output [3:0] led
);

    reg [3:0] a_reg, b_reg, op_reg;
    reg [7:0] result_reg;
    reg show_upper = 0;
    
    alu ALU(
        .a(a_reg),
        .b(b_reg),
        .op(op_reg),
        .result(result_reg),
        .flags(led)
    );
    
    seg7_decoder DISPLAY(
        .num(show_upper ? result_reg[7:4] : result_reg[3:0]),
        .Yout(seg)
    );
    
    assign an = 4'b1110;  // Activar solo primer display
    assign dp = 1'b1;     // Punto decimal apagado
    
    always @(posedge clk) begin
        if(btn_execute) begin
            a_reg <= sw[3:0];
            b_reg <= sw[7:4];
            op_reg <= sw[11:8];
        end
        if(btn_toggle) show_upper <= ~show_upper;
    end
endmodule