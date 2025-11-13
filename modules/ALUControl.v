module ALUControl (
    input  wire [1:0] alu_op,
    input  wire [2:0] funct3,
    input  wire [6:0] funct7,
    output reg  [3:0] alu_control
);

    always @(*) begin
        case (alu_op)
            2'b00: alu_control = 4'b0000; // Load/Store = ADD
            2'b01: begin // Branches
                case (funct3)
                    3'b000: alu_control = 4'b0001; // BEQ = SUB
                    3'b001: alu_control = 4'b0001; // BNE = SUB
                    3'b100: alu_control = 4'b1000; // BLT = SLT
                    3'b101: alu_control = 4'b1000; // BGE = SLT
                    3'b110: alu_control = 4'b1001; // BLTU
                    3'b111: alu_control = 4'b1001; // BGEU
                    default: alu_control = 4'b0000;
                endcase
            end
            2'b10: begin // R-type
                case ({funct7, funct3})
                    {7'b0000000, 3'b000}: alu_control = 4'b0000; // ADD
                    {7'b0100000, 3'b000}: alu_control = 4'b0001; // SUB
                    {7'b0000000, 3'b111}: alu_control = 4'b0010; // AND
                    {7'b0000000, 3'b110}: alu_control = 4'b0011; // OR
                    {7'b0000000, 3'b100}: alu_control = 4'b0100; // XOR
                    {7'b0000000, 3'b001}: alu_control = 4'b0101; // SLL
                    {7'b0000000, 3'b101}: alu_control = 4'b0110; // SRL
                    {7'b0100000, 3'b101}: alu_control = 4'b0111; // SRA
                    {7'b0000000, 3'b010}: alu_control = 4'b1000; // SLT
                    {7'b0000000, 3'b011}: alu_control = 4'b1001; // SLTU
                    default: alu_control = 4'b0000;
                endcase
            end
            2'b11: begin // I-type ALU (immediate)
                case (funct3)
                    3'b000: alu_control = 4'b0000; // ADDI
                    3'b111: alu_control = 4'b0010; // ANDI
                    3'b110: alu_control = 4'b0011; // ORI
                    3'b100: alu_control = 4'b0100; // XORI
                    3'b010: alu_control = 4'b1000; // SLTI
                    3'b011: alu_control = 4'b1001; // SLTIU
                    3'b001: alu_control = 4'b0101; // SLLI
                    3'b101: alu_control = (funct7 == 7'b0100000) ? 4'b0111 : 4'b0110; // SRAI/SRLI
                    default: alu_control = 4'b0000;
                endcase
            end
            default: alu_control = 4'b0000;
        endcase
    end
endmodule

