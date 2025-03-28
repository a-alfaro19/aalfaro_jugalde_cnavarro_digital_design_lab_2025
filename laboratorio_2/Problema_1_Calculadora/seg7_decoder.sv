module seg7_decoder(
    input [3:0] num,
    output reg [6:0] Yout
);

    always @(*) begin
        case(num)
            4'h0: Yout = 7'b0000001;  // 0
            4'h1: Yout = 7'b1001111;  // 1
            4'h2: Yout = 7'b0010010;  // 2
            4'h3: Yout = 7'b0000110;  // 3
            4'h4: Yout = 7'b1001100;  // 4
            4'h5: Yout = 7'b0100100;  // 5
            4'h6: Yout = 7'b0100000;  // 6
            4'h7: Yout = 7'b0001111;  // 7
            4'h8: Yout = 7'b0000000;  // 8
            4'h9: Yout = 7'b0000100;  // 9
            4'hA: Yout = 7'b0001000;  // A
            4'hB: Yout = 7'b1100000;  // B
            4'hC: Yout = 7'b0110001;  // C
            4'hD: Yout = 7'b1000010;  // D
            4'hE: Yout = 7'b0110000;  // E
            4'hF: Yout = 7'b0111000;  // F
        endcase
    end
endmodule