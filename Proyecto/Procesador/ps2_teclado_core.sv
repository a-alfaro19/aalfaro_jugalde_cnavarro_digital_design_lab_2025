module ps2_teclado_core (
    input  wire       clk,
    input  wire       reset_n,
    input  wire       ps2_clk,
    input  wire       ps2_data,
    output wire [7:0] key_code,
    output wire       key_pressed,
    output wire       extended,
    output wire       valid
);

    wire [10:0] word;
    wire [7:0]  signal;
    wire        signal_valid;

    wire [10:0] word_1_dummy, word_2_dummy, word_3_dummy;
    wire        ready;

    ps2_signal signal_inst (
        .mouse_module_clk(clk),
        .mouse_module_reset(~reset_n),
        .PS2CLK(ps2_clk),
        .PS2Data(ps2_data),
        .word_1(word),
        .word_2(word_1_dummy),
        .word_3(word_2_dummy),
        .word_4(word_3_dummy),
        .ready_signal(ready)
    );

    ps2_validator validator_inst (
        .i_word_1(word),
        .i_word_2(11'd0),
        .i_word_3(11'd0),
        .i_word_4(11'd0),
        .o_signal_1(signal),
        .o_signal_2(),
        .o_signal_3(),
        .o_signal_4(),
        .mouse_valid(signal_valid)
    );

    ps2_teclado_map teclado_map_inst (
        .clk(clk),
        .reset(~reset_n),
        .valid(signal_valid),
        .data_in(signal),
        .key_code(key_code),
        .key_pressed(key_pressed),
        .extended(extended)
    );

    assign valid = signal_valid;

endmodule
