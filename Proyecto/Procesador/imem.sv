module imem(input logic [31:0] a,
            output logic [31:0] rd);

    logic [31:0] INST_RAM[0:255];

    initial begin
        $readmemh("D:/Procesador/memfile.dat", INST_RAM);
        $display("Primeras instrucciones cargadas:");
        $display("INST[0] = %h", INST_RAM[0]);
        $display("INST[1] = %h", INST_RAM[1]);
    end

    assign rd = INST_RAM[a[31:2]]; // word aligned

endmodule
