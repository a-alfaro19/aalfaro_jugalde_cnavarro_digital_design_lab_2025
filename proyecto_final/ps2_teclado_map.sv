module ps2_teclado_map (
    input  wire        clk,
    input  wire        reset,
    input  wire        valid,
    input  wire [7:0]  data_in,          // Byte recibido desde ps2_validator
    output reg  [7:0]  key_code,         // Código de tecla (último recibido)
    output reg         key_pressed,      // 1 = presionada, 0 = liberada
    output reg         extended          // 1 si es código extendido (E0)
);

    // Estados internos
    typedef enum logic [1:0] {
        IDLE,
        GOT_E0,
        GOT_F0,
        GOT_E0_F0
    } state_t;

    state_t state, next_state;

    // Máquina de estados: transición
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state       <= IDLE;
            key_code    <= 8'h00;
            key_pressed <= 1'b0;
            extended    <= 1'b0;
        end else if (valid) begin
            case (state)
                IDLE: begin
                    case (data_in)
                        8'hE0: state <= GOT_E0;
                        8'hF0: state <= GOT_F0;
                        default: begin
                            key_code    <= data_in;
                            key_pressed <= 1'b1;  // Tecla presionada
                            extended    <= 1'b0;
                            state       <= IDLE;
                        end
                    endcase
                end

                GOT_E0: begin
                    if (data_in == 8'hF0)
                        state <= GOT_E0_F0;
                    else begin
                        key_code    <= data_in;
                        key_pressed <= 1'b1; // Tecla extendida presionada
                        extended    <= 1'b1;
                        state       <= IDLE;
                    end
                end

                GOT_F0: begin
                    key_code    <= data_in;
                    key_pressed <= 1'b0; // Tecla liberada
                    extended    <= 1'b0;
                    state       <= IDLE;
                end

                GOT_E0_F0: begin
                    key_code    <= data_in;
                    key_pressed <= 1'b0; // Tecla extendida liberada
                    extended    <= 1'b1;
                    state       <= IDLE;
                end

            endcase
        end
    end

endmodule
