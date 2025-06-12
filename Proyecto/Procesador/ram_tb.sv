module ram_tb();

logic clock, wren, rst;

logic [15:0] address;

logic [31:0]  data;

logic [31:0] q;

ram mem(address, clock, data, wren, q);

endmodule