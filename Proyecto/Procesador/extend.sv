module extend(
    input logic [23:0] Instr,               // Parte relevante de la instrucción (24 bits) para decodificar el inmediato
    input logic [1:0] ImmSrc,               // Control para seleccionar el tipo de inmediato a generar
    output logic [31:0] ExtImm              // Salida: Inmediato extendido a 32 bits
);
				  
  // Bloque combinacional para generar el inmediato extendido
  always_comb
    case (ImmSrc)
        // Caso 1: Inmediato sin signo de 8 bits
        2'b00: ExtImm = {24'b0, Instr[7:0]}; 

        // Caso 2: Inmediato sin signo de 12 bits
        2'b01: ExtImm = {20'b0, Instr[11:0]}; 

        // Caso 3: Desplazamiento para instrucciones de salto (24 bits, complemento a dos)
        2'b10: ExtImm = {{6{Instr[23]}}, Instr[23:0], 2'b00}; 
   

        // Caso predeterminado: Inmediato indefinido
        default: ExtImm = 32'bx; 
        // Si ImmSrc no coincide con ningún caso, el inmediato es indefinido (generalmente para evitar comportamiento no esperado).
    endcase
endmodule