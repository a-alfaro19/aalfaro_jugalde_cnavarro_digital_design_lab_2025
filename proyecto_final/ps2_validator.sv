module ps2_validator(
    input wire [10:0] i_word_1,
    input wire [10:0] i_word_2,
    input wire [10:0] i_word_3,
    input wire [10:0] i_word_4,
    output wire [7:0] o_signal_1,
    output wire [7:0] o_signal_2,
    output wire [7:0] o_signal_3,
    output wire [7:0] o_signal_4,
    output wire       mouse_valid
 );


   wire parity_1, parity_2, parity_3, parity_4, parity;
   wire start_1, start_2, start_3, start_4, start;
   wire stop1, stop2, stop3, stop4, stop;
   wire valid1, valid2, valid3, valid4;

   assign {start_1, o_signal_1, parity_1, stop1} = i_word_1;
   assign {start_2, o_signal_2, parity_2, stop2} = i_word_2;
   assign {start_3, o_signal_3, parity_3, stop3} = i_word_3;
   assign {start_4, o_signal_4, parity_4, stop4} = i_word_4;

   assign valid1 = ~^o_signal_1 == parity_1;
   assign valid2 = ~^o_signal_2 == parity_2;
   assign valid3 = ~^o_signal_3 == parity_3;
   assign valid4 = ~^o_signal_4 == parity_4;

   assign parity = valid1 && valid2 && valid3 && valid4;
   assign start = (!start_1 && !start_2 && !start_3 && !start_4);
   assign stop = (stop1 && stop2 && stop3 && stop4);
   assign mouse_valid = (start && stop && parity);

endmodule