module BCD_to_7Seg (
    input logic [3:0] bcd,     // Dígito BCD (0-9)
    output logic [6:0] seg      // Segmentos a-g (activos en bajo)
);

    always_comb begin
        case(bcd)
            0:  seg = 7'b0000001;  // 0 (todos los segmentos encendidos excepto g)
            1:  seg = 7'b1001111;  // 1 (solo b y c encendidos)
            2:  seg = 7'b0010010;  // 2
            3:  seg = 7'b0000110;  // 3
            4:  seg = 7'b1001100;  // 4
            5:  seg = 7'b0100100;  // 5
            6:  seg = 7'b0100000;  // 6
            7:  seg = 7'b0001111;  // 7
            8:  seg = 7'b0000000;  // 8 (todos los segmentos encendidos)
            9:  seg = 7'b0000100;  // 9
            default: seg = 7'b1111111;  // Apagado (todos los segmentos apagados)
        endcase
    end

endmodule