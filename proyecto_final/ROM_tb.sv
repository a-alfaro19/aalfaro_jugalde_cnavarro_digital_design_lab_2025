module ROM_tb();

	logic [7:0] address, q;
	logic clock, reset;

	ROM mem(address, clock, q);
	Counter cont(clock, reset, 1'b1, address);
	
endmodule