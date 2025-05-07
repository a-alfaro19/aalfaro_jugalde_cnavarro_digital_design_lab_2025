module FSM_Game (
    input logic clk,
    input logic rst,
    input logic start_player_1,  // Interruptor para que empiece PLAYER_1
    input logic start_player_2,  // Interruptor para que empiece PLAYER_2
    input logic timer_out,    // Señal de que el tiempo de turno expiró
    input logic player_mov, // Jugador realizo jugada
    input logic full_board,    // Bandera de que el tablero está lleno
    input logic winner, // Bandera de victoria detectada
    output logic [2:0] current_state // Estado actual del FSM
);

    // Estados
    typedef enum logic [2:0] {
        START,        // Estado inicial
        PLAYER_1,     // Jugador 1
        PLAYER_2,     // Jugador 2
        WIN,          // Ganador
        DRAW          // Empate
    } state_t;

    state_t state, next_state;
    logic next_turn;

    // Logica para el estado actual
    always_ff @(posedge clk or negedge rst) begin
    if (!rst)                  // <- reset activo en bajo
        state <= START;
    else
        state <= next_state;
end

    // Lógica para el siguiente estado
    always_comb begin
        next_turn = (timer_out || player_mov) && (!winner && !full_board);
        next_state = state;
        
        case (state)
            START: begin
                // En START, esperamos que uno de los interruptores active el juego
                if (start_player_1) 
                    next_state = PLAYER_1;  // Si start_player_1 es 1, ir a PLAYER_1
                else if (start_player_2)
                    next_state = PLAYER_2;  // Si start_player_2 es 1, ir a PLAYER_2
                else
                    next_state = START;     // Si no, mantenemos el estado en START
            end

            PLAYER_1: begin
                // En PLAYER_1, cambiamos de turno o vamos a WIN/DRAW
                if (next_turn) 
                    next_state = PLAYER_2;  // Pasa a PLAYER_2 si el turno acaba
                else if (winner)
                    next_state = WIN;  // Si hay un ganador, pasa a WIN
                else if (full_board)
                    next_state = DRAW;  // Si el tablero está lleno, pasa a DRAW
            end

            PLAYER_2: begin
                // En PLAYER_2, cambiamos de turno o vamos a WIN/DRAW
                if (next_turn) 
                    next_state = PLAYER_1;  // Pasa a PLAYER_1 si el turno acaba
                else if (winner)
                    next_state = WIN;  // Si hay un ganador, pasa a WIN
                else if (full_board)
                    next_state = DRAW;  // Si el tablero está lleno, pasa a DRAW
            end

            WIN: begin
                // En WIN, permanecemos en WIN (esperando reset o nuevo juego)
                next_state = WIN;
            end

            DRAW: begin
                // En DRAW, permanecemos en DRAW (esperando reset o nuevo juego)
                next_state = DRAW;
            end

            default: begin
                next_state = START;  // En caso de un estado desconocido, volvemos a START
            end
        endcase
    end

    // Salida: Estado actual del FSM
    assign current_state = state;

endmodule