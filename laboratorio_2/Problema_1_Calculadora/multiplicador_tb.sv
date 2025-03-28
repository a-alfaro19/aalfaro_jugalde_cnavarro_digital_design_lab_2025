module multiplicador_tb;
    
    // Parámetro de tamaño de bits
    parameter N = 4;
    
    // Señales de prueba
    logic [N-1:0] x, y;
    logic [N-1:0] Of, R;
    
    // Instancia del módulo bajo prueba (DUT)
    multiplicador #(N) dut (
        .x(x),
        .y(y),
        .Of(Of),
        .R(R)
    );
    
    // Proceso de prueba
    initial begin
        // Monitor para visualizar las señales
        $monitor("Time=%0t | x=%b y=%b | R=%b Of=%b", $time, x, y, R, Of);
        
        // Casos de prueba
        x = 4'b0000; y = 4'b0000; #40;
        x = 4'b0001; y = 4'b0001; #40;
        x = 4'b0010; y = 4'b0011; #40;
        x = 4'b0101; y = 4'b0011; #40;
        x = 4'b0111; y = 4'b0110; #40;
        x = 4'b1111; y = 4'b1111; #40;
        
        // Pausa para analizar
		  
        $stop;
    end
endmodule