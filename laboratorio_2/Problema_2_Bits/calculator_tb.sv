module calculator_tb;
    // Señales de prueba
    reg clk;
    reg [11:0] sw;
    reg btn_execute;
    reg btn_toggle;
    wire [6:0] seg;
    wire dp;
    wire [3:0] an;
    wire [3:0] led;
    
    // Instancia del DUT
    calculator uut (
        .clk(clk),
        .sw(sw),
        .btn_execute(btn_execute),
        .btn_toggle(btn_toggle),
        .seg(seg),
        .dp(dp),
        .an(an),
        .led(led)
    );

    // Generación de reloj (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Pruebas
    initial begin
        // Inicialización
        btn_execute = 0;
        btn_toggle = 0;
        sw = 0;
        #100;
        
        // ---------- SUMA (op=0000) ----------
        sw = 12'b0000_0011_0101; // 5 + 3 = 8
        btn_execute = 1; #20; btn_execute = 0; #100;
        $display("Suma 1: 5 + 3 = %d", uut.ALU.result[3:0]);
        
        sw = 12'b0000_0110_1001; // 9 + 6 = 15
        btn_execute = 1; #20; btn_execute = 0; #100;
        $display("Suma 2: 9 + 6 = %d", uut.ALU.result[3:0]);
        
        // ---------- RESTA (op=0001) ----------
        sw = 12'b0001_0011_1000; // 8 - 3 = 5
        btn_execute = 1; #20; btn_execute = 0; #100;
        $display("Resta 1: 8 - 3 = %d", uut.ALU.result[3:0]);
        
        sw = 12'b0001_0101_1100; // 12 - 5 = 7
        btn_execute = 1; #20; btn_execute = 0; #100;
        $display("Resta 2: 12 - 5 = %d", uut.ALU.result[3:0]);
        
        // ---------- MULTIPLICACIÓN (op=0010) ----------
        sw = 12'b0010_0011_0100; // 4 * 3 = 12
        btn_execute = 1; #20; btn_execute = 0; #200;
        $display("Mult 1: 4 * 3 = %d", uut.ALU.result);
        
        sw = 12'b0010_0011_0101; // 5 * 3 = 15
        btn_execute = 1; #20; btn_execute = 0; #200;
        $display("Mult 2: 5 * 3 = %d", uut.ALU.result);
        
        // ---------- DIVISIÓN (op=0011) ----------
        sw = 12'b0011_0011_1001; // 9 / 3 = 3
        btn_execute = 1; #20; btn_execute = 0; #200;
        $display("Div 1: 9 / 3 = %d", uut.ALU.result[3:0]);
        
        sw = 12'b0011_0010_1100; // 12 / 2 = 6
        btn_execute = 1; #20; btn_execute = 0; #200;
        $display("Div 2: 12 / 2 = %d", uut.ALU.result[3:0]);
        
        // ---------- MÓDULO (op=0100) ----------
        sw = 12'b0100_0011_1010; // 10 % 3 = 1
        btn_execute = 1; #20; btn_execute = 0; #200;
        $display("Mod 1: 10 %% 3 = %d", uut.ALU.result[3:0]);
        
        sw = 12'b0100_0101_1111; // 15 % 5 = 0
        btn_execute = 1; #20; btn_execute = 0; #200;
        $display("Mod 2: 15 %% 5 = %d", uut.ALU.result[3:0]);
        
        // ---------- AND (op=0101) ----------
        sw = 12'b0101_1100_1010; // 1010 & 1100 = 1000 (8)
        btn_execute = 1; #20; btn_execute = 0; #100;
        $display("AND 1: 1010 & 1100 = %b", uut.ALU.result[3:0]);
        
        sw = 12'b0101_1111_0101; // 0101 & 1111 = 0101 (5)
        btn_execute = 1; #20; btn_execute = 0; #100;
        $display("AND 2: 0101 & 1111 = %b", uut.ALU.result[3:0]);
        
        // ---------- OR (op=0110) ----------
        sw = 12'b0110_1100_1010; // 1010 | 1100 = 1110 (14)
        btn_execute = 1; #20; btn_execute = 0; #100;
        $display("OR 1: 1010 | 1100 = %b", uut.ALU.result[3:0]);
        
        sw = 12'b0110_0101_1010; // 1010 | 0101 = 1111 (15)
        btn_execute = 1; #20; btn_execute = 0; #100;
        $display("OR 2: 1010 | 0101 = %b", uut.ALU.result[3:0]);
        
        // ---------- XOR (op=0111) ----------
        sw = 12'b0111_1100_1010; // 1010 ^ 1100 = 0110 (6)
        btn_execute = 1; #20; btn_execute = 0; #100;
        $display("XOR 1: 1010 ^ 1100 = %b", uut.ALU.result[3:0]);
        
        sw = 12'b0111_1111_0101; // 0101 ^ 1111 = 1010 (10)
        btn_execute = 1; #20; btn_execute = 0; #100;
        $display("XOR 2: 0101 ^ 1111 = %b", uut.ALU.result[3:0]);
        
        // ---------- SHIFT LEFT (op=1000) ----------
        sw = 12'b1000_0001_0001; // 0001 << 1 = 0010 (2)
        btn_execute = 1; #20; btn_execute = 0; #100;
        $display("SHL 1: 0001 << 1 = %b", uut.ALU.result[3:0]);
        
        sw = 12'b1000_0010_0100; // 0100 << 2 = 0000 (0)
        btn_execute = 1; #20; btn_execute = 0; #100;
        $display("SHL 2: 0100 << 2 = %b", uut.ALU.result[3:0]);
        
        // ---------- SHIFT RIGHT (op=1001) ----------
        sw = 12'b1001_0001_1000; // 1000 >> 1 = 0100 (4)
        btn_execute = 1; #20; btn_execute = 0; #100;
        $display("SHR 1: 1000 >> 1 = %b", uut.ALU.result[3:0]);
        
        sw = 12'b1001_0010_1100; // 1100 >> 2 = 0011 (3)
        btn_execute = 1; #20; btn_execute = 0; #100;
        $display("SHR 2: 1100 >> 2 = %b", uut.ALU.result[3:0]);
    end
endmodule