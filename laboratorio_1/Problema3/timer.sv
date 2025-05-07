module timer (
    input  logic clk,
    input  logic rst,
    input  logic enable,
    output logic timeout,
    output logic [3:0] segundos_decenas,
    output logic [3:0] segundos_unidades
);

    parameter CYCLES_10S = 250_000_000; // 10 segundos con un reloj de 25 MHz
    logic [27:0] counter;
    logic [6:0] segundos = 10;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            timeout <= 0;
            segundos <= 10;
        end else if (enable) begin
            if (counter == 25_000_000) begin // 1 segundo (25 MHz)
                counter <= 0;
                if (segundos == 0) begin
                    timeout <= 1;
                    segundos <= 10; // Resetea el conteo
                end else begin
                    segundos <= segundos - 1;
                    timeout <= 0;
                end
            end else begin
                counter <= counter + 1;
                timeout <= 0;
            end
        end else begin
            counter <= 0;
            timeout <= 0;
        end
    end

    // Conversión a BCD
    assign segundos_decenas = segundos / 10;
    assign segundos_unidades = segundos % 10;

endmodule