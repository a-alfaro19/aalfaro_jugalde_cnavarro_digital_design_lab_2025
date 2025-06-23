module decoder(
    input  logic [1:0] Op,
    input  logic [5:0] Funct,
    input  logic [3:0] Rd,
    output logic [1:0] FlagW,
    output logic       PCS, RegW, MemW,
    output logic       MemtoReg, ALUSrc,
    output logic [1:0] ImmSrc, 
    output logic [1:0] RegSrc,
    output logic [2:0] ALUControl,
    output logic       isBL             // <== NUEVA SALIDA
);

    logic [9:0] controls;
    logic Branch, ALUOp;
    logic [1:0] regsrc_internal;

    // Detecta instrucción BX LR
    logic is_bx;
    assign is_bx = (Op == 2'b00) && (Funct == 6'b001001) && (Rd == 4'b1110);

    // Detecta instrucción BL
    assign isBL = (Op == 2'b10) && (Funct[0] == 1'b1);

    always_comb begin
        FlagW      = 2'b00;
        ALUControl = 3'b000;
        controls   = 10'b0000000000;

        if (is_bx) begin
            controls        = 10'b0000000000;
            regsrc_internal = 2'b10;
        end else if (isBL) begin
            controls        = 10'b0110101000;  // Branch=1, RegW=1
            regsrc_internal = 2'b10;
        end else begin
            case (Op)
                2'b00: controls = (Funct[5]) ? 10'b0000101001 : 10'b0000001001;
                2'b01: controls = (Funct[0]) ? 10'b0001111000 : 10'b1001110100;
                2'b10: controls = 10'b0110100010;
                default: controls = 10'bxxxxxxxxxx;
            endcase

            regsrc_internal = controls[9:8];

            if (controls[0]) begin
                case (Funct[4:1])
                    4'b0100: ALUControl = 3'b000;
                    4'b0010: ALUControl = 3'b001;
                    4'b0000: ALUControl = 3'b010;
                    4'b1100: ALUControl = 3'b011;
                    4'b1101: ALUControl = 3'b100;
                    4'b1001: ALUControl = 3'b101;
                    4'b1011: ALUControl = 3'b110;
                    default: ALUControl = 3'bxxx;
                endcase
                FlagW[1] = Funct[0];
                FlagW[0] = Funct[0] & (ALUControl == 3'b000 || ALUControl == 3'b001);
            end
        end
    end

    assign {ImmSrc, ALUSrc, MemtoReg, RegW, MemW, Branch, ALUOp} = controls[7:1];
    assign RegSrc = regsrc_internal;
    assign PCS = ((Rd == 4'b1111) & RegW) | Branch | is_bx;
endmodule
