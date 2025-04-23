module FSM(input clk, rst, m, t0,
				output increment, rst_timer, sel);

logic [1:0] state, next_state;				

// logica de estado actual
always_ff @ (posedge clk or posedge rst)
	if (rst) state = 2'b00;
	else
		state = next_state;

// logica del siguiente estado
always_comb
			case(state)
				2'b00: if (m) next_state = 2'b01; else next_state = 2'b10;
				2'b01: next_state = 2'b00;
				2'b10: if (t0) next_state = 2'b11; else next_state = 2'b00;
				2'b11: if (rst) next_state = 2'b00; else next_state = state;
				default: next_state = 2'b00;
			endcase

// salidas
assign increment = (state == 2'b01);
assign rst_timer = (state == 2'b01);
assign sel = (state == 2'b11);		
			
endmodule			