module rising_edge_detector (
    input  logic        clk,
    input  logic [6:0]  signal_in,
    output logic [6:0]  rising_edge
);

    logic [6:0] signal_prev;

    always_ff @(posedge clk) begin
        signal_prev <= signal_in;
        rising_edge <= signal_in & ~signal_prev;
    end

endmodule