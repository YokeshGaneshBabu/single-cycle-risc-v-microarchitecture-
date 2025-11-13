`timescale 1ns/1ps
module tb_control_unit;
    reg [6:0] opcode;
    wire reg_write, mem_write, mem_read, mem_to_reg, alu_src, branch;
    wire [1:0] alu_op, imm_src;
    control_unit uut (
        .opcode(opcode),
        .reg_write(reg_write),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .mem_to_reg(mem_to_reg),
        .alu_src(alu_src),
        .branch(branch),
        .alu_op(alu_op),
        .imm_src(imm_src)
    );
    initial begin
        $display("Testing Control Unit\n");
        opcode = 7'b0110011;
        #10;
        $display("R-type: reg_write=%b, mem_write=%b, mem_read=%b, mem_to_reg=%b, alu_src=%b, branch=%b, alu_op=%b, imm_src=%b",
                 reg_write, mem_write, mem_read, mem_to_reg, alu_src, branch, alu_op, imm_src);
        // Test I-type ALU (ADDI, ANDI, ORI)
        opcode = 7'b0010011;
        #10;
        $display("I-type: reg_write=%b, mem_write=%b, mem_read=%b, mem_to_reg=%b, alu_src=%b, branch=%b, alu_op=%b, imm_src=%b",
                 reg_write, mem_write, mem_read, mem_to_reg, alu_src, branch, alu_op, imm_src);
        // Test Load (LW)
        opcode = 7'b0000011;
        #10;
        $display("Load: reg_write=%b, mem_write=%b, mem_read=%b, mem_to_reg=%b, alu_src=%b, branch=%b, alu_op=%b, imm_src=%b",
                 reg_write, mem_write, mem_read, mem_to_reg, alu_src, branch, alu_op, imm_src);
        // Test Store (SW)
        opcode = 7'b0100011;
        #10;
        $display("Store: reg_write=%b, mem_write=%b, mem_read=%b, mem_to_reg=%b, alu_src=%b, branch=%b, alu_op=%b, imm_src=%b",
                 reg_write, mem_write, mem_read, mem_to_reg, alu_src, branch, alu_op, imm_src);
        // Test Branch (BEQ, BNE)
        opcode = 7'b1100011;
        #10;
        $display("Branch: reg_write=%b, mem_write=%b, mem_read=%b, mem_to_reg=%b, alu_src=%b, branch=%b, alu_op=%b, imm_src=%b",
                 reg_write, mem_write, mem_read, mem_to_reg, alu_src, branch, alu_op, imm_src);

        $finish;
    end
endmodule

