module rom_tb();
	
	logic [15:0] address;
	logic clk, rst;
	logic [31:0]  q;
	
	rom mem(address, clk, q);
	counter cont(clk, rst, 1'b1, address);
	
	
endmodule