// ps2_mouse_core.sv - Proyecto reducido: solo control PS/2 del mouse

module ps2_mouse_core (
    input  wire clk,
    input  wire reset_n,
    input  wire ps2_clk,
    input  wire ps2_data,
    output wire [7:0] mouse_x,
    output wire [7:0] mouse_y,
    output wire       sign_x,
    output wire       sign_y,
    output wire       left_click,
    output wire       right_click,
    output wire       x_overflow,
    output wire       y_overflow,
    output wire       mouse_valid
);

    wire [10:0] word_1, word_2, word_3, word_4;
    wire [7:0]  signal_1, signal_2, signal_3, signal_4;
    wire        valid, ready;

    assign mouse_valid = ready && valid;

    ps2_signal signal_inst (
        .mouse_module_clk(clk),
        .mouse_module_reset(~reset_n),
        .PS2CLK(ps2_clk),
        .PS2Data(ps2_data),
        .word_1(word_1),
        .word_2(word_2),
        .word_3(word_3),
        .word_4(word_4),
        .ready_signal(ready)
    );

    ps2_validator validator_inst (
        .i_word_1(word_1),
        .i_word_2(word_2),
        .i_word_3(word_3),
        .i_word_4(word_4),
        .o_signal_1(signal_1),
        .o_signal_2(signal_2),
        .o_signal_3(signal_3),
        .o_signal_4(signal_4),
        .mouse_valid(valid)
    );

    ps2_mouse_map map_inst (
        .mouse_module_clk(clk),
        .mouse_module_reset(~reset_n),
        .signal_1(signal_1),
        .signal_2(signal_2),
        .signal_3(signal_3),
        .signal_4(signal_4),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .sign_x(sign_x),
        .sign_y(sign_y),
        .left_click(left_click),
        .right_click(right_click),
        .x_overflowerflow(x_overflow),
        .y_overflowerflow(y_overflow)
    );

endmodule
