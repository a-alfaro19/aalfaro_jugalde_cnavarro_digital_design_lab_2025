`timescale 1ns / 1ps

module top_tb;

    logic clk = 0, reset;
    logic [3:0] botones;

    logic [7:0] paleta_j1_y, paleta_j2_y;
    logic [31:0] bola_xy;
    logic [3:0] puntaje_j1, puntaje_j2;

    // Instancia del módulo top
    top dut (
        .clk(clk),
        .reset(reset),
        .botones(botones),
        .paleta_j1_y(paleta_j1_y),
        .paleta_j2_y(paleta_j2_y),
        .bola_xy(bola_xy),
        .puntaje_j1(puntaje_j1),
        .puntaje_j2(puntaje_j2)
    );

    // Clock de 100 MHz (20 ns por ciclo)
    always #10 clk = ~clk;

    // Trazado del PC e instrucción actual
    always @(posedge clk) begin
        $display("PC=%h | Instr=%h", dut.processor.PC, dut.processor.Instr);
    end

    // Secuencia de prueba
    initial begin
        reset = 1;
        botones = 4'b0000;

        $display("=== INICIO SIMULACIÓN ===");
        #20;
        reset = 0;

        // Simula entrada de botones
        #50 botones = 4'b0001;
        #50 botones = 4'b0010;
        #50 botones = 4'b0000;

        // Monitoreo de salidas
        $monitor("Tiempo %0t ns | Paleta1=%0d | Paleta2=%0d | Bola=%h | P1=%0d | P2=%0d",
                 $time, paleta_j1_y, paleta_j2_y, bola_xy, puntaje_j1, puntaje_j2);

        // Tiempo para ejecutar instrucciones
        #5000;

        $display("=== FIN SIMULACIÓN ===");
        $finish;
    end

    // Timeout por seguridad
    initial begin
        #10000;
        $display("ERROR: Timeout alcanzado. Posible cuelgue.");
        $finish;
    end

endmodule
