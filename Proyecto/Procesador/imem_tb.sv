`timescale 1ns / 1ps

module imem_tb;

    // Señales para conectar al DUT
    logic [31:0] a;
    logic [31:0] rd;

    // Instancia de la memoria de instrucciones
    imem dut (
        .a(a),
        .rd(rd)
    );

    // Ruta de prueba
    initial begin
        // Mostrar mensaje de inicio
        $display("=== Inicio de simulación de IMEM ===");

        // Leer algunas posiciones válidas
        for (int i = 0; i < 10; i++) begin
            a = i * 4; // Direcciones alineadas a palabra
            #1; // Esperar propagación
            $display("Dirección: %h | Instrucción: %h", a, rd);
        end

        // Fin
        $display("=== Fin de simulación ===");
        $finish;
    end

endmodule