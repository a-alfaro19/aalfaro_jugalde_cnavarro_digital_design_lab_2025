module multiplicador

    #(parameter N = 4)(
    input logic [N-1:0] x,   //Primer num de entrada
    input logic [N-1:0] y,   //Segundo num de entrada
    output logic [N-1:0] Of, //Overflow de salida
    output logic [N-1:0] R   //Resultado a obtener
	 
);

    // Matriz de productos parciales, aqui se almacenan los resultados parciales
	 
    logic [2*N-1:0] Pp[N-1:0];

    // Inicialización del primer producto parcial
	 
    assign Pp[0] = { {(2*N-1)-N+1{1'b0}}, x & {N{y[0]}} };

    // Asignación de los valores de salida
	 
    assign Of = Pp[N-1][(2*N)-1:N]; // Overflow
    assign R = Pp[N-1][N-1:0];      // Resultado sin considerar el overflow

    genvar i;
    
    generate
        for(i=1; i<N ; i++) begin: Sum_pp
            
            // Ajuste de tamaño de la matriz de productos parciales
				
            if (i+1<N) begin
                assign Pp[i][2*N-1:N+i+1] = {(N-i){1'b0}};
            end
            
            // Suma de los productos parciales con un sumador de bits variable
				
            adder#(N+i) adder_b(
				
                .a(Pp[i-1][N+i-1:0]),
					 // Nuevo producto parcial
                .b({ x & {N{y[i]}} , {i{1'b0}} }), 
                .cin(1'b0),
                .sum(Pp[i][N+i-1:0]),
                .cout(Pp[i][N+i])
					 
            );
        end
    endgenerate
endmodule