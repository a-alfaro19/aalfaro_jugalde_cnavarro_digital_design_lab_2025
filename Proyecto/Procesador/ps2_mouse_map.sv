module ps2_mouse_map(
 input wire        mouse_module_clk,
 input wire        mouse_module_reset,
 input wire [7:0]  signal_1,
 input wire [7:0]  signal_2,
 input wire [7:0]  signal_3,
 input wire [7:0]  signal_4,
 output wire [7:0] mouse_x,
 output wire [7:0] mouse_y,
 output wire       sign_x,
 output wire       sign_y,
 output wire       left_click,
 output wire       right_click,
 output wire       x_overflowerflow,
 output wire       y_overflowerflow
 );

   assign mouse_x = signal_2;
   assign mouse_y = signal_3;
   assign {x_overflowerflow, y_overflowerflow} = signal_1[1:0];
   assign {sign_x, sign_y} = signal_1[3:2];
   assign {left_click, right_click} = signal_1[7:6];
endmodule