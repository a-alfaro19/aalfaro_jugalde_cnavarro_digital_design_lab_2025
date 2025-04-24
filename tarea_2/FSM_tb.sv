module FSM_tb;
    // Variables de prueba
    logic clk;
    logic rst;
    logic m;
    logic t0;
    logic increment;
    logic rst_timer;
    logic sel;
    logic error_flag;
    logic [7:0] maintenance_count;

    // Instancia del módulo bajo prueba (DUT)
    FSM dut (
        .clk(clk),
        .rst(rst),
        .m(m),
        .t0(t0),
        .increment(increment),
        .rst_timer(rst_timer),
        .sel(sel),
        .error_flag(error_flag),
        .maintenance_count(maintenance_count)
    );

    // Generación del reloj
    initial clk = 0;
    always #5 clk = ~clk;

    // Estímulos de prueba
    initial begin
        // Inicialización
        rst = 1;
        m = 0;
        t0 = 0;
        #10 rst = 0;

        // Prueba 1: Presionar botón de mantenimiento
        #20 m = 1;
        #10 m = 0;

        // Verificar que increment se activa y maintenance_count aumenta
        assert (increment) else $error("Test 1: Increment no activado al presionar el botón");
        #10;
        assert (maintenance_count == 1) else $error("Test 1: maintenance_count no incrementado");

        // Prueba 2: Dejar pasar el tiempo sin presionar el botón
	repeat (201) @(posedge clk);
	#1;
	assert (error_flag) else $error("Test 2: error_flag no activado tras tiempo límite");

        // Prueba 3: Reset del sistema
        #10 rst = 1;
        #10 rst = 0;

        // Verificar que error_flag se desactiva y mantenimiento se reinicia
        assert (!error_flag) else $error("Test 3: error_flag no desactivado tras reset");
        assert (maintenance_count == 0) else $error("Test 3: maintenance_count no reiniciado tras reset");

        // Prueba 4: Activar t0 para pasar a DONE
        #20 m = 1;
        #10 m = 0;
        #20 t0 = 1;
        #10 t0 = 0;

        // Verificar que incrementa correctamente en estado DONE
        assert (maintenance_count == 1) else $error("Test 4: maintenance_count incorrecto tras t0");

        // Finalizar la simulación
        #50 $stop;
    end
endmodule
