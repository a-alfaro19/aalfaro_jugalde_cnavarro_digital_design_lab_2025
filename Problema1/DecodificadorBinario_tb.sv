module DecodificadorBinario_tb;

    logic [3:0] binary_in;
    logic [7:0] bcd_out;    

    DecodificadorBinario uut (
        .binary_in(binary_in),
        .bcd_out(bcd_out)
    );

    initial begin
        binary_in = 4'b0000;  // 0
        #40;
        $display("Entrada: %b, Salida BCD: %b", binary_in, bcd_out);

        binary_in = 4'b0101;  // 5
        #40;
        $display("Entrada: %b, Salida BCD: %b", binary_in, bcd_out);

        binary_in = 4'b1001;  // 9
        #40;
        $display("Entrada: %b, Salida BCD: %b", binary_in, bcd_out);

        binary_in = 4'b1010;  // 10
        #40;
        $display("Entrada: %b, Salida BCD: %b", binary_in, bcd_out);

        binary_in = 4'b1011;  // 11
        #40;
        $display("Entrada: %b, Salida BCD: %b", binary_in, bcd_out);

        binary_in = 4'b1100;  // 12
        #40;
        $display("Entrada: %b, Salida BCD: %b", binary_in, bcd_out);

        binary_in = 4'b1110;  // 14
        #40;
        $display("Entrada: %b, Salida BCD: %b", binary_in, bcd_out);

        binary_in = 4'b1111;  // 15
        #40;
        $display("Entrada: %b, Salida BCD: %b", binary_in, bcd_out);

    end

endmodule