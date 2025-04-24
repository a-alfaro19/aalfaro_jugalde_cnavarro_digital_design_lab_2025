module FSM (
    input logic clk,          // Señal del reloj
    input logic rst,          // Señal de reset 
    input logic m,             // Botón de mantenimiento
    input logic t0,            // Señal del temporizador
    output logic increment,    // Señal para incrementar el número de mantenimientos
    output logic rst_timer,    // Señal para reiniciar temporizador
    output logic sel,           // Señal de selección
    output logic error_flag,        // Bandera de error
    output logic [7:0] maintenance_count // Registro de mantenimiento
);

    // Estados de la máquina con sus códigos binarios
    typedef enum logic [2:0] {
        IDLE     = 3'b000,
        START    = 3'b001,
        WAIT_T0  = 3'b010,
        DONE     = 3'b011,
        ERROR    = 3'b100
    } state_t;

    state_t state, next_state;

    // Contador de ciclos y de mantenimientos
    logic [7:0] counter;

    // Registro de la cantidad de mantenimientos
    logic [7:0] count_reg;

    assign maintenance_count = count_reg;

    // Registro de estado y contadores
    always_ff @ (posedge clk or posedge rst) begin
        if (rst) begin     // Reset global: se vuelve a IDLE, contadores a 0
            state <= IDLE;
            counter <= 0;
            count_reg <= 0;
        end else begin
            state <= next_state;  // Actualiza el estado

            // Contador de tiempo para IDLE
            if (state == IDLE && !m)
                counter <= counter + 1;
            else
                counter <= 0; // Reinicia contador

            // Incrementa contador de mantenimiento solo en START
            if (state == START)
                count_reg <= count_reg + 1;
        end
    end

    // Lógica de transición de estados
    always_comb begin
        case (state)
            IDLE: begin
                if (m)
                    next_state = START; // Si se presiona el botón, se va a START
                else if (counter >= 8'd200)
                    next_state = ERROR; // Se va a ERROR si pasa el tiempo
                else
                    next_state = IDLE; // Continua esperando
            end
            START:
                next_state = IDLE; // Regresa al inicio tras registrar mantenimiento
            WAIT_T0:
                next_state = t0 ? DONE : WAIT_T0;
            DONE:
                next_state = DONE; // Estado final
            ERROR:
                next_state = rst ? IDLE : ERROR; // Salida mediante reset 
            default:
                next_state = IDLE;
        endcase
    end

    // Lógica de salidas
    assign increment   = (state == START); // Se activa el incremento al registrar mantenimiento
    assign rst_timer   = (state == START); // Se reinicia en start
    assign sel         = (state == DONE); // Se activa la selección en estado DONE
    assign error_flag  = (state == ERROR); // Se activa la bandera de error

endmodule