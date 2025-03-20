// ---------------------------------------------------
// Subtractor (N bits) using Two's Complement
// - Utiliza el módulo adder para realizar la resta A - B
// ---------------------------------------------------

module subtractor #(
    parameter N = 4 // Número de bits (configurable)
) (
    input logic [N-1:0] a, b,  // Entradas: A y B
    output logic [N-1:0] diff,  // Salida: Diferencia (A - B)
    output logic borrow        // Señal de borrow (1 si A < B)
);

    logic [N-1:0] b_comp;    // Complemento a uno de B
    logic cout_adder;         // Carry out del adder

    // Invertir los bits de B para obtener el complemento a uno
    assign b_comp = ~b;

    // Instanciar el sumador para calcular A + (~B + 1)
    adder #(N) adder_inst (
        .a(a),
        .b(b_comp),
        .cin(1'b1),       // Sumar 1 para complemento a dos
        .sum(diff),
        .cout(cout_adder)
    );

    // El borrow es el inverso del carry out del sumador
    assign borrow = ~cout_adder;

endmodule