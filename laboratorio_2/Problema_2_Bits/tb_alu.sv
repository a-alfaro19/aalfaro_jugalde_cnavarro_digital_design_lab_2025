`timescale 1ns/1ps
module tb_alu;
    parameter N = 2;  // Cambiar este valor para 2,4,8,16,32
    
    reg clk, reset;
    reg [N-1:0] a, b;
    reg [3:0] op;
    wire [2*N-1:0] result;
    wire [3:0] flags;
    
    // Instancia de la ALU con registros (Figura 2)
    alu_top #(N) dut (
        .clk(clk),
        .reset(reset),
        .a(a),
        .b(b),
        .op(op),
        .result(result),
        .flags(flags)
    );
    
    // Generación de reloj (100 MHz inicial)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Período = 10ns -> Frec = 100 MHz
    end
    
    // Secuencia de pruebas
    initial begin
        reset = 1;
        a = 0;
        b = 0;
        op = 0;
        
        // Reset inicial
        #20 reset = 0;
        
        // Test 1: Suma máxima (provoca carry)
        op = 4'b1111;
        a = {N{1'b1}};  // Todos unos
        b = 1;
        #20;
        
        // Test 2: Multiplicación máxima (ruta crítica)
        op = 4'b1101;
        a = {N{1'b1}};
        b = {N{1'b1}};
        #20;
        
        // Test 3: Shift máximo
        op = 4'b0111;
        a = 4'b1001;    // Patrón arbitrario
        b = N-1;        // Shift máximo permitido
        #20;
        
        // Finalizar simulación
        $finish;
    end
    
    // Monitoreo de resultados
    initial begin
        $monitor("T=%0t: a=%h b=%h op=%b result=%h flags=%b",
               $time, a, b, op, result, flags);
    end
endmodule