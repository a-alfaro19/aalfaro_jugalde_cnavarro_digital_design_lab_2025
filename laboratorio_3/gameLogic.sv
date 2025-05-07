module gameLogic (
    input  logic        clk,
    input  logic        rst,
    input  logic [6:0]  pulses,            // Flancos de subida de los switches
    input  logic [1:0]  jugador,           // Jugador actual (01 para J1, 10 para J2)
    input  logic        juego_terminado,   // Si el juego ha terminado, se bloquea
    output logic        inserted,          // Señal que indica si se insertó una ficha
    output logic [2:0]  board [5:0][6:0]   // Tablero del juego
);

    parameter ROWS = 6;
    parameter COLS = 7;

    typedef enum logic [1:0] {IDLE, INSERTANDO, COOLDOWN} state_t;
    state_t state = IDLE;

    logic [6:0] pulse_buffer = 0;
    logic [2:0] col_insertar = 0;
    logic [23:0] cooldown_counter = 0;
    logic pulse_consumido = 0;
    logic inserted_flag = 0;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            pulse_buffer <= 0;
            cooldown_counter <= 0;
            pulse_consumido <= 0;
            inserted <= 0;
            inserted_flag <= 0;

            for (int i = 0; i < ROWS; i++)
                for (int j = 0; j < COLS; j++)
                    board[i][j] <= 3'b000;

        end else begin
            inserted <= inserted_flag;
            inserted_flag <= 0;

            // Si ya hay un ganador, no permitir más inserciones
            if (juego_terminado) begin
                state <= IDLE;
                pulse_buffer <= 0;
                inserted_flag <= 0;
                cooldown_counter <= 0;
                pulse_consumido <= 0;
            end else begin
                if (state == IDLE)
                    pulse_buffer <= pulse_buffer | pulses;

                case (state)
                    IDLE: begin
                        pulse_consumido <= 0;
                        // Detectar qué columna tiene el pulso
                        for (int col = 0; col < 7; col++) begin
                            if (pulse_buffer[col]) begin
                                col_insertar <= col;
                                state <= INSERTANDO;
                                break;
                            end
                        end
                    end

                    INSERTANDO: begin
                        if (!pulse_consumido) begin
                            for (int row = 5; row >= 0; row--) begin
                                if (board[row][col_insertar] == 3'b000) begin
                                    board[row][col_insertar] <= (jugador == 2'b01) ? 3'b001 : 3'b010;
                                    pulse_buffer[col_insertar] <= 1'b0;
                                    pulse_consumido <= 1;
                                    inserted_flag <= 1;
                                    cooldown_counter <= 0;
                                    state <= COOLDOWN;
                                    break;
                                end
                            end

                            // Si la columna está llena, se limpia el pulso y regresa a IDLE
                            if (board[0][col_insertar] != 3'b000) begin
                                pulse_buffer[col_insertar] <= 1'b0;
                                state <= IDLE;
                            end
                        end
                    end

                    COOLDOWN: begin
                        // Tiempo de espera para evitar rebotes
                        if (cooldown_counter >= 12_500_000) begin
                            cooldown_counter <= 0;
                            state <= IDLE;
                        end else begin
                            cooldown_counter <= cooldown_counter + 1;
                        end
                    end
                endcase
            end
        end
    end

endmodule