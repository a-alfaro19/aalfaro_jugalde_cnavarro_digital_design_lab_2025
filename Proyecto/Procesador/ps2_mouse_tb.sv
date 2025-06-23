`timescale 1ns / 1ps

module ps2_mouse_tb;

    // Señales del testbench
    logic clk;
    logic reset_n;
    logic ps2_clk;
    logic ps2_data;

    wire [7:0] mouse_x;
    wire [7:0] mouse_y;
    wire sign_x, sign_y;
    wire left_click, right_click;
    wire x_overflow, y_overflow;
    wire mouse_valid;

    // Generación del reloj de sistema (50 MHz)
    initial clk = 0;
    always #10 clk = ~clk;

    // DUT
    ps2_mouse_core uut (
        .clk(clk),
        .reset_n(reset_n),
        .ps2_clk(ps2_clk),
        .ps2_data(ps2_data),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .sign_x(sign_x),
        .sign_y(sign_y),
        .left_click(left_click),
        .right_click(right_click),
        .x_overflow(x_overflow),
        .y_overflow(y_overflow),
        .mouse_valid(mouse_valid)
    );

    // Simulación del protocolo PS/2 (más lenta)
    task send_ps2_byte(input [7:0] data);
        integer i;
        reg parity;
        begin
            // Start bit
            ps2_data = 0;
            #(100_000); // ~100 us por bit
            ps2_clk = 0; #(50_000); ps2_clk = 1; #(50_000);

            // Data bits (LSB first)
            parity = 1;
            for (i = 0; i < 8; i = i + 1) begin
                ps2_data = data[i];
                parity = parity ^ data[i];
                ps2_clk = 0; #(50_000); ps2_clk = 1; #(50_000);
            end

            // Paridad impar
            ps2_data = parity;
            ps2_clk = 0; #(50_000); ps2_clk = 1; #(50_000);

            // Stop bit
            ps2_data = 1;
            ps2_clk = 0; #(50_000); ps2_clk = 1; #(50_000);

            // Tiempo de reposo
            ps2_data = 1;
            #(200_000);
        end
    endtask

    // Estímulo inicial
    initial begin
        // Inicialización
        ps2_clk = 1;
        ps2_data = 1;
        reset_n = 0;
        #(100);
        reset_n = 1;
        #(500);

        // Enviar 4 bytes: 3 útiles + 1 dummy
        send_ps2_byte(8'b00000001);  // Byte 1: botón izquierdo
        send_ps2_byte(8'd5);         // Byte 2: desplazamiento X
        send_ps2_byte(8'd10);        // Byte 3: desplazamiento Y
        send_ps2_byte(8'h00);        // Byte 4: dummy

        #(1_000_000); // esperar suficiente

        $finish;
    end

    // Monitor de salida
    always @(posedge clk) begin
        if (mouse_valid) begin
            $display("[%0t ns] 🖱️ Mouse válido:", $time);
            $display("  X = %0d (%s), Y = %0d (%s)", 
                     mouse_x, sign_x ? "-" : "+", 
                     mouse_y, sign_y ? "-" : "+");
            $display("  Botón izquierdo: %b, derecho: %b", 
                     left_click, right_click);
            $display("  Overflow X: %b, Y: %b", 
                     x_overflow, y_overflow);
        end
    end

endmodule
