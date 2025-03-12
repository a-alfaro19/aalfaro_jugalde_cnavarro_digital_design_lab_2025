module DisplayController (
    input logic [3:0] tens,    // Dígito de decenas (BCD)
    input logic [3:0] ones,    // Dígito de unidades (BCD)
    output logic [6:0] seg,    // Segmentos del display
    output logic [3:0] an      // Ánodos de control
);

    // Registros internos
    logic [1:0] sel;           // Selector de display
    logic [6:0] seg_tens;      // Segmentos para decenas
    logic [6:0] seg_ones;      // Segmentos para unidades
    logic [15:0] refresh_cnt;  // Contador de refresco

    // Convertidores BCD a 7 segmentos
    BCD_to_7Seg convertidor_decenas (
        .bcd(tens),
        .seg(seg_tens)
    );

    BCD_to_7Seg convertidor_unidades (
        .bcd(ones),
        .seg(seg_ones)
    );


    // Multiplexación de displays
    assign sel = refresh_cnt[15:14];  // Control de velocidad

    always_comb begin
        case(sel)
            2'b00: begin  // Mostrar unidades
                an = 4'b1110;    // AN0 activo
                seg = seg_ones;
            end
            2'b01: begin  // Mostrar decenas
                an = 4'b1101;    // AN1 activo
                seg = seg_tens;
            end
            default: begin
                an = 4'b1111;    // Todos apagados
                seg = 7'b1111111;
            end
        endcase
    end

endmodule