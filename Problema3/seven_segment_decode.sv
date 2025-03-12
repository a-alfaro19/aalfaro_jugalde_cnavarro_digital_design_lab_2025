module seven_segment_decoder #(parameter N=6) (
	input reg [N-1:0] count,
   output reg [6:0] segA, // 7-seg A
   output reg [6:0] segB  // 7-segm B
);
	
	reg [3:0] unidad; // Dígito menos significativo
   reg [3:0] decena; // Dígito más significativo
	
	reg [5:0] bin;
	wire [7:0] bcd;
	
	bin2bcd dut(
		.bin(count),
		.bcd(bcd)
	);
	
	
	always @(*) begin
		unidad = bcd[3:0];
		decena = bcd[7:4];

		case (unidad)
		 4'b0000: segA = 7'b1000000; // 0
		 4'b0001: segA = 7'b1111001; // 1
		 4'b0010: segA = 7'b0100100; // 2
		 4'b0011: segA = 7'b0110000; // 3
		 4'b0100: segA = 7'b0011001; // 4
		 4'b0101: segA = 7'b0010010; // 5
		 4'b0110: segA = 7'b0000010; // 6
		 4'b0111: segA = 7'b1111000; // 7
		 4'b1000: segA = 7'b0000000; // 8
		 4'b1001: segA = 7'b0010000; // 9
		 default: segA = 7'b1000000; // 0
		endcase

		case (decena)
		 4'b0000: segB = 7'b1000000; // 0
		 4'b0001: segB = 7'b1111001; // 1
		 4'b0010: segB = 7'b0100100; // 2
		 4'b0011: segB = 7'b0110000; // 3
		 4'b0100: segB = 7'b0011001; // 4
		 4'b0101: segB = 7'b0010010; // 5
		 4'b0110: segB = 7'b0000010; // 6
		 4'b0111: segB = 7'b1111000; // 7
		 4'b1000: segB = 7'b0000000; // 8
		 4'b1001: segB = 7'b0010000; // 9
		 default: segB = 7'b1000000; // 0
		endcase
	end	
  
endmodule