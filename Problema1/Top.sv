module Top (
    input logic [3:0] sw,      // Switches SW3-SW0
    output logic [6:0] seg,    // Segmentos del display
    output logic [3:0] an      // Ánodos de control
);

    // Conexiones internas
    logic [7:0] bcd;           // Salida BCD completa
    logic [3:0] tens, ones;    // Dígitos separados

    // Instanciar decodificador binario-BCD
    DecodificadorBinario decodificador (
        .binary_in(sw),
        .bcd_out(bcd)
    );

    // Separar dígitos
    assign tens = bcd[7:4];    // Decenas
    assign ones = bcd[3:0];    // Unidades

    // Controlador de displays
    DisplayController display (
        .tens(tens),
        .ones(ones),
        .seg(seg),
        .an(an)
    );

endmodule