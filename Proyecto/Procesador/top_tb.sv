module top_tb();
  logic        clk;
  logic        reset;
  logic [31:0] WriteData, DataAdr;
  logic        MemWrite;

  // instantiate device to be tested
  top_test dut(clk, reset, WriteData, DataAdr, MemWrite);
  
  // initialize test
  initial
    begin
      reset <= 1; # 22; reset <= 0;
    end

  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end

  // check results
  always @(negedge clk)
    begin
      if(MemWrite) begin
        if(DataAdr === 100 & WriteData === 254) begin
          $display("Simulation succeeded");
          $stop;
        end else if (DataAdr !== 96) begin
          $display("Simulation failed");
          $stop;
        end
      end
    end
endmodule

module top_test(input  logic        clk, reset, 
           output logic [31:0] WriteData, DataAdr, 
           output logic        MemWrite);

  logic [31:0] PC, Instr, ReadData;
  logic MemByte;   // used to tell if load/store only one byte

  // instantiate processor and memories
  arm arm(clk, reset, PC, Instr, MemWrite, MemByte, 
          DataAdr, WriteData, ReadData);
  imem imem(PC, Instr);
  dmem dmem(clk, MemWrite, MemByte, DataAdr, WriteData, ReadData);
endmodule

module dmem(input  logic        clk, we, MemByte,
            input  logic [31:0] a, wd,
            output logic [31:0] rd);

  logic [31:0] RAM[63:0];

  assign rd = RAM[a[31:2]]; // word aligned

  always_ff @(posedge clk)
  begin
    if (we)
    begin
      if (~MemByte)
        RAM[a[31:2]] <= {23'b0,wd[7:0]}; // One Byte
      else
         RAM[a[31:2]] <= wd;  // Full Register
    end
  end
endmodule

module imem(input  logic [31:0] a,
            output logic [31:0] rd);

  logic [31:0] RAM[63:0];

  initial
      $readmemh("memfile2.dat",RAM);

  assign rd = RAM[a[31:2]]; // word aligned
endmodule