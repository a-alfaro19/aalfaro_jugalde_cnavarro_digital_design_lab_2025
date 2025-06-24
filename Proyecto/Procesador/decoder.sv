module decoder(
    input logic [1:0] Op,               // Campo Op para determinar el tipo de instrucción (2 bits)
    input logic [5:0] Funct,            // Código de función para especificar la operación (6 bits)
    input logic [3:0] Rd,               // Registro de destino (4 bits)
    output logic [1:0] FlagW,           // Señales para escribir en los flags N, Z, C, V
    output logic PCS,                   // Señal para actualizar el PC
    output logic RegW, MemW,            // Señales para habilitar escritura en registros y memoria
    output logic MemtoReg, ALUSrc,      // Controles de flujo de datos (ALU/memoria a registros)
    output logic [1:0] ImmSrc, RegSrc,  // Controles para inmediatos y fuentes de registros
    output logic [2:0] ALUControl       // Control para la operación de la ALU
);

  // Señales internas
  logic [9:0] controls;                // Control combinado para señales principales
  logic Branch, ALUOp;                 // Señales intermedias: Branch para instrucciones de salto, ALUOp para tipo de operación en la ALU
  
  // Decodificador principal para generar las señales de control
  always_comb
    casex (Op)
      // Caso: Data-processing immediate (instrucciones de procesamiento de datos)
      2'b00: if (Funct[5]) 
                controls = 10'b0000101001; // Instrucción con inmediato y S-bit activo
             else 
                controls = 10'b0000001001; // Instrucción con inmediato sin S-bit activo
      
      // Caso: LDR y STR
      2'b01: if (Funct[0]) 
                controls = 10'b0001111000; // LDR: Carga desde memoria
             else 
                controls = 10'b1001110100; // STR: Almacena en memoria
      
      // Caso: B (branch)
      2'b10: controls = 10'b0110100010; // Instrucción de salto incondicional (Branch)
      
      // Caso: No implementado
      default: controls = 10'bx;        // Indefinido para operaciones no soportadas
    endcase

  // Descomposición de las señales de control desde la variable combinada `controls`
  assign {RegSrc, ImmSrc, ALUSrc, MemtoReg, RegW, MemW, Branch, ALUOp} = controls;
  
  // Decodificador de la ALU
  always_comb
    if (ALUOp) begin // Determinar la operación de la ALU en función del campo Funct
        case (Funct[4:1])
          4'b0100: ALUControl = 3'b000; // ADD
          4'b0010: ALUControl = 3'b001; // SUB
          4'b0000: ALUControl = 3'b010; // AND
          4'b1100: ALUControl = 3'b011; // ORR
          4'b1101: ALUControl = 3'b100; // Shift
          4'b1001: ALUControl = 3'b101; // MUL
          4'b1011: ALUControl = 3'b110; // MOV (código ajustado para MOV)
          default: ALUControl = 3'bx;   // Operación no soportada
        endcase
        
        // Actualización de los flags si el S-bit está activo
        FlagW[1] = Funct[0];           // Actualiza los flags NZCV si S-bit está activo
        FlagW[0] = Funct[0] & 
                   (ALUControl == 3'b000 | ALUControl == 3'b001); // Actualiza C y V solo en ADD/SUB
    end else begin
        ALUControl = 3'b000;           // Default: ADD para instrucciones no DP
        FlagW = 2'b00;                 // No actualiza flags en este caso
    end
  
  // Lógica del PC (Program Counter)
  assign PCS = ((Rd == 4'b1111) & RegW) | Branch;
  // PCS se activa si:
  // - El destino (Rd) es PC (codificado como `1111`) y hay escritura en registros (RegW activo).
  // - O si la instrucción es un Branch (salto condicional o incondicional).
  
endmodule