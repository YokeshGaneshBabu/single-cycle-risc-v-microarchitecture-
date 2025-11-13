module control_unit (
    input  wire [6:0] opcode,
    output reg        reg_write,
    output reg        mem_write,
    output reg        mem_read,
    output reg        mem_to_reg,
    output reg        alu_src,
    output reg        branch,
    output reg [1:0]  alu_op,
    output reg [1:0]  imm_src
);

    always @(*) begin
        reg_write = 0;
        mem_write = 0;
        mem_read  = 0;
        mem_to_reg= 0;
        alu_src   = 0;
        branch    = 0;
        alu_op    = 2'b00;
        imm_src   = 2'b00;

        case (opcode)
            7'b0110011: begin // R-type
                reg_write = 1;
                alu_src   = 0;   // second ALU operand = rs2
                alu_op    = 2'b10; 
            end

            7'b0010011: begin // I-type ALU
                reg_write = 1;
                alu_src   = 1;   // second operand = imm
                alu_op    = 2'b11; 
                imm_src   = 2'b00; // I-type immediate
            end

            7'b0000011: begin // Load (LW)
                reg_write = 1;
                mem_read  = 1;
                mem_to_reg= 1;   // write data from memory
                alu_src   = 1;   // base + imm
                alu_op    = 2'b00; // ADD
                imm_src   = 2'b00; // I-type imm
            end

            7'b0100011: begin // Store (SW)
                mem_write = 1;
                alu_src   = 1;   // base + imm
                alu_op    = 2'b00; // ADD
                imm_src   = 2'b01; // S-type imm
            end

            7'b1100011: begin // Branch 
                branch    = 1;
                alu_src   = 0;   // compare rs1, rs2
                alu_op    = 2'b01; // branch ALUOp
                imm_src   = 2'b10; // B-type imm
            end

            default: begin
               
            end
        endcase
    end
endmodule

