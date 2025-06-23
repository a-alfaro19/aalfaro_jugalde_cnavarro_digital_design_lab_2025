module imem(input logic [31:0] a,
				output logic [31:0] rd);
				
	
	logic [31:0] INST_RAM[127:0];
	
	initial begin
		$readmemh("D:/Procesador/memfile.dat",INST_RAM);
		end
	
	assign rd = INST_RAM[a[31:2]]; // word aligned
	
endmodule