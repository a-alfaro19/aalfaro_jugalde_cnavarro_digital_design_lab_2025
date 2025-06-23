module alu #(parameter N = 32)                   // Parametrización: N es el ancho de los operandos (default: 32 bits)
    (
     input  logic [N-1:0] a, b,                 // Entradas: operandos para las operaciones de la ALU
     input  logic [2:0]   ALUControl,           // Control de la operación a realizar
     input  logic [4:0] Shamt,                  // Desplazamiento (5 bits para un rango de 0-31)
     input  logic [1:0] ShiftType,              // Tipo de desplazamiento (lógico, aritmético, rotación)
     output logic [N-1:0] Result,               // Salida del resultado de la operación
     output logic [3:0] ALUFlags                // Indicadores: [3]=N, [2]=Z, [1]=C, [0]=V
    );

   // Resultados intermedios para diferentes operaciones
   logic [N-1:0] resultADD, resultSUB, resultAND, resultOR, resultShift, resultMUL;
   logic         cout, coutADD, coutSUB;        // Flags de acarreo para suma y resta

   // Instancias de componentes internos
   adderalu #(32) adder_inst(a, b, 1'b0, resultADD, coutADD);   // Instancia para suma
   adderalu #(32) subtractor_inst(a, ~b, 1'b1, resultSUB, coutSUB); // Instancia para resta
   barrel_shifter b_shifter(b, ShiftType, Shamt, resultShift);  // Instancia para desplazamientos
   mulalu #(N) mul_inst(a, b, resultMUL);       // Multiplicador (parametrizable)

   // Operaciones cambiadas para que funcionara el proce
   assign resultAND = a / b;                    
   assign resultOR = a * b;                     

   // Lógica para seleccionar la operación según ALUControl
   always_comb begin 
      case (ALUControl)
         3'b000:   // Add
         begin
            Result = resultADD;
            cout = coutADD;                     // Acarreo generado por la suma
         end

         3'b001:   // Subtract
         begin
            Result = resultSUB;
            cout = coutSUB;                     // Acarreo generado por la resta
         end

         3'b010:   // DIV
         begin
            Result = resultAND;                 // se cambió por un AND
            cout = 0;
         end

         3'b011:   // MUL
         begin
            Result = resultOR;                  // Se cambió por un ORR
            cout = 0;
         end

         3'b100:   // Shift
         begin
            Result = resultShift;               // Resultado de la operación de desplazamiento
            cout = 0;                           // Desplazamientos no generan carry
         end

         3'b101:   // CMP (Comparación)
         begin
            Result = resultMUL;                 // 
            cout = 0;
         end

         3'b110:   // MOV (Movimiento)
         begin
            Result = a;                         // Mueve el valor de `a` al resultado
            cout = 0;                           // No hay carry en MOV
         end

         default:                               // Caso por defecto (instrucción no implementada)
         begin
            Result = 32'b0;                     // Resultado por defecto es 0
            cout = 0;
         end
      endcase
   end

   // Generación de los indicadores (flags)
   // ALUFlags: [3] = Negative, [2] = Zero, [1] = Carry, [0] = Overflow
   assign ALUFlags[3] = Result[N-1];            // Bit más significativo de Result indica si es negativo
   assign ALUFlags[2] = &(~Result);             // Si todos los bits de Result son 0, Z=1 (Zero flag)
   assign ALUFlags[1] = ((~ALUControl[1]) & cout); // Carry generado en operaciones de suma/resta (no Shift)
   assign ALUFlags[0] = ~(a[N-1] ^ b[N-1] ^ ALUControl[0]) & (a[N-1] ^ Result[N-1]) & ~ALUControl[1];
   

endmodule