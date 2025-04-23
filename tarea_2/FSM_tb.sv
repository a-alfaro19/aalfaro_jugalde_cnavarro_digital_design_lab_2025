module FSM_tb;

	logic clk, rst, m, t0;
	logic increment, rst_timer, sel;

	FSM dut (
		.clk(clk),
		.rst(rst),
		.m(m),
		.t0(t0),
		.increment(increment),
		.rst_timer(rst_timer),
		.sel(sel)
	);

	// Reloj: 10ns de periodo
	always #5 clk = ~clk;

	initial begin
		$display("Time\tState Outputs\t\tm t0 rst");
		$monitor("%0t\tincrement=%b rst_timer=%b sel=%b\tm=%b t0=%b rst=%b", 
					$time, increment, rst_timer, sel, m, t0, rst);
					
		 // Inicialización
		 clk = 0;
		 rst = 1; m = 0; t0 = 0;
		 #10;
		 rst = 0;

		 // Estado 00 -> 01 (m = 1)
		 m = 1;
		 @(posedge clk);  // transicion a estado 01
		 
		 // Estado 01 -> 00
		 @(posedge clk);  // transicion a estado 00
		 
		 // Estado 00 -> 10 (m = 0)
		 m = 0;           // se desactiva m para siguiente transición
		 @(posedge clk);  // transicion a estado 10

		 // Estado 10 -> 00 (t0 = 0)
		 t0 = 0;
		 @(posedge clk);  // transición automática
		 
		 // Estado 00 -> 10 (m = 0)
		 m = 0;           // se desactiva m para siguiente transición
		 @(posedge clk);  // transicion a estado 10

		 // Estado 10 -> 11 (t0 = 1)
		 t0 = 1;
		 @(posedge clk);  // transición a 11
		 
		 @(posedge clk); // Esperar un periodo

		 // Estado 11 -> 00 (con rst = 1)
		 rst = 1;
		 @(posedge clk);  // transición a 00 por reset
		 rst = 0;

		 // Final
		 #10;
		 $finish;
  end
 
 
endmodule