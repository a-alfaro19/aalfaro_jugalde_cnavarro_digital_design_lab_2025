module column_checker(
    input  logic [83:0] board_state,
    input  logic        check_col,
    input  logic [2:0]  column,
    output logic        column_has_space
);
    parameter int ROWS = 6;
    parameter int COLS = 7;
    localparam logic [1:0] EMPTY = 2'b00;

    // Variables de bucle e indicador interno
    integer row, idx;
    logic   found;

    // Lógica puramente combinacional
    always @(*) begin
        found = 1'b0;
        if (check_col) begin
            for (row = ROWS-1; row >= 0; row = row - 1) begin
                idx = (row * COLS + column) * 2;
                if (board_state[idx +: 2] == EMPTY) begin
                    found = 1'b1;
                end
            end
        end
        column_has_space = found;
    end

endmodule
