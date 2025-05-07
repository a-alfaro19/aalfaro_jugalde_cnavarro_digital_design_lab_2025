module falling_edge_detector #(
    parameter N = 7
)(
    input  logic clk,
    input  logic reset,
    input  logic [N-1:0] signal_in,
    output logic [N-1:0] falling_edge
);

    logic [N-1:0] sync0, sync1;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            sync0 <= {N{1'b0}};
            sync1 <= {N{1'b0}};
        end else begin
            sync0 <= signal_in;
            sync1 <= sync0;
        end
    end

    assign falling_edge = ~sync0 & sync1;

endmodule