// column_checker.sv – Comprueba si la columna tiene al menos un espacio
module column_checker(
    input  logic [83:0] board_state,
    input  logic        check_col,
    input  logic [2:0]  column,
    output logic        column_has_space
);
    parameter int ROWS = 6, COLS = 7;
    localparam logic [1:0] EMPTY = 2'b00;
    integer row, idx;

    always @(*) begin
        column_has_space = 1'b0;
        if (check_col) begin
            for (row = ROWS - 1; row >= 0; row = row - 1) begin
                idx = (row * COLS + column) * 2;
                if (board_state[idx +: 2] == EMPTY) begin
                    column_has_space = 1'b1;
                    break;
                end
            end
        end
    end
endmodule
