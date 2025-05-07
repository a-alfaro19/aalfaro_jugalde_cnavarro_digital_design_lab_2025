module DisplayController (
    input  logic        clk,
    input  logic        rst,
    input  logic [3:0]  segundos_unidades,
    input  logic [3:0]  segundos_decenas,
    output logic [6:0]  display_unidades,  // Salida para el display de unidades
    output logic [6:0]  display_decenas    // Salida para el display de decenas
);

    // ===============================
    // Decodificación para 7 segmentos
    // ===============================
    always_comb begin
        // Decodificación del dígito de unidades (Ánodo Común, 0 = encendido)
        case (segundos_unidades)
            4'd0: display_unidades = 7'b1000000; // 0
            4'd1: display_unidades = 7'b1111001; // 1
            4'd2: display_unidades = 7'b0100100; // 2
            4'd3: display_unidades = 7'b0110000; // 3
            4'd4: display_unidades = 7'b0011001; // 4
            4'd5: display_unidades = 7'b0010010; // 5
            4'd6: display_unidades = 7'b0000010; // 6
            4'd7: display_unidades = 7'b1111000; // 7
            4'd8: display_unidades = 7'b0000000; // 8
            4'd9: display_unidades = 7'b0010000; // 9
            default: display_unidades = 7'b1111111; // Apagado
        endcase
        
        // Decodificación del dígito de decenas (Ánodo Común, 0 = encendido)
        case (segundos_decenas)
            4'd0: display_decenas = 7'b1000000; // 0
            4'd1: display_decenas = 7'b1111001; // 1
            4'd2: display_decenas = 7'b0100100; // 2
            4'd3: display_decenas = 7'b0110000; // 3
            4'd4: display_decenas = 7'b0011001; // 4
            4'd5: display_decenas = 7'b0010010; // 5
            4'd6: display_decenas = 7'b0000010; // 6
            4'd7: display_decenas = 7'b1111000; // 7
            4'd8: display_decenas = 7'b0000000; // 8
            4'd9: display_decenas = 7'b0010000; // 9
            default: display_decenas = 7'b1111111; // Apagado
        endcase
    end
endmodule
