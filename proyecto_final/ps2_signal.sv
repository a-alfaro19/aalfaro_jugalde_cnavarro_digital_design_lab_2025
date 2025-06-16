module ps2_signal(
                  input wire         mouse_module_clk,
                  input wire         mouse_module_reset,
                  input wire         PS2CLK,
                  input wire         PS2Data,
                  output wire [10:0] word_1,
                  output wire [10:0] word_2,
                  output wire [10:0] word_3,
                  output wire [10:0] word_4,
                  output wire        ready_signal
                  );
   reg [43:0]    fifo;
   reg [43:0]    buffer;
   reg [5:0]     counter;
   reg [1:0]     PS2Clk_sync;
   reg ready;
   reg PS2Data_reg;
   wire          PS2Clk_negedge;

   assign word_1 = fifo[33 +: 11];
   assign word_2 = fifo[22 +: 11];
   assign word_3 = fifo[11 +: 11];
   assign word_4 = fifo[0 +: 11];
   assign ready_signal = ready;
   assign PS2Clk_negedge = (PS2Clk_sync == 2'b10);

   initial
     begin
        fifo <= 44'b0;
        buffer <= 44'b0;
        counter <= 6'b0;
        PS2Clk_sync <= 2'b1;
        ready <= 1'b0;
        PS2Data_reg <= 1'b0;
     end


   always @(posedge mouse_module_clk)
     begin
        if(mouse_module_reset)
          begin
             fifo <= 44'b0;
             buffer <= 44'b0;
             counter <= 6'b0;
             ready <= 1'b0;
             PS2Clk_sync <= 2'b1;
             PS2Data_reg <= 1'b0;
          end
        else
          begin
             PS2Clk_sync <= {PS2Clk_sync[0], PS2CLK};
             PS2Data_reg <= PS2Data;

             if(PS2Clk_negedge)
               begin
                  buffer <= {buffer, PS2Data};
                  counter <= counter + 6'b1;
               end

             if(counter == 6'd44)
               begin
                  fifo <= buffer;
                  buffer <= 44'b0;
                  counter <= 6'b0;
                  ready <= 1'b1;
               end
             else
               begin
                  ready <= 1'b0;
                  fifo <= 44'b0;
               end
          end
     end
endmodule