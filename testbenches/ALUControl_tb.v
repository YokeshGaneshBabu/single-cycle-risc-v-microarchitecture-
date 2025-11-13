`timescale 1ns/1ps
module tb_ALUControl;
    reg  [1:0] alu_op;
    reg  [2:0] funct3;
    reg  [6:0] funct7;
    wire [3:0] alu_control;
    ALUControl u1(.alu_op(alu_op), .funct3(funct3),.funct7(funct7),.alu_control(alu_control));
    initial begin
        $display("Starting ALUControl Testbench\n");
        // Load / Store (ALUOp = 00)
        alu_op = 2'b00; 
        funct3 = 3'b000; 
        funct7 = 7'b0000000;
        #1 $display("Load/Store  alu_control = %b", alu_control);  
        // Branch group (ALUOp = 01)
        alu_op = 2'b01;
        funct3 = 3'b000; #1 $display("BEQ   alu_control = %b", alu_control);   // SUB
        funct3 = 3'b001; #1 $display("BNE   alu_control = %b", alu_control);   // SUB
        funct3 = 3'b100; #1 $display("BLT   alu_control = %b", alu_control);   // SLT
        funct3 = 3'b101; #1 $display("BGE   alu_control = %b", alu_control);   // SLT
        funct3 = 3'b110; #1 $display("BLTU  alu_control = %b", alu_control);   // SLTU
        funct3 = 3'b111; #1 $display("BGEU  alu_control = %b", alu_control);   // SLTU
        // R-type ALU (ALUOp = 10)
        alu_op = 2'b10;
        {funct7, funct3} = {7'b0000000, 3'b000}; #1 $display("ADD    alu_control = %b", alu_control);
        {funct7, funct3} = {7'b0100000, 3'b000}; #1 $display("SUB    alu_control = %b", alu_control);
        {funct7, funct3} = {7'b0000000, 3'b111}; #1 $display("AND    alu_control = %b", alu_control);
        {funct7, funct3} = {7'b0000000, 3'b110}; #1 $display("OR     alu_control = %b", alu_control);
        {funct7, funct3} = {7'b0000000, 3'b100}; #1 $display("XOR    alu_control = %b", alu_control);
        {funct7, funct3} = {7'b0000000, 3'b001}; #1 $display("SLL    alu_control = %b", alu_control);
        {funct7, funct3} = {7'b0000000, 3'b101}; #1 $display("SRL    alu_control = %b", alu_control);
        {funct7, funct3} = {7'b0100000, 3'b101}; #1 $display("SRA    alu_control = %b", alu_control);
        {funct7, funct3} = {7'b0000000, 3'b010}; #1 $display("SLT    alu_control = %b", alu_control);
        {funct7, funct3} = {7'b0000000, 3'b011}; #1 $display("SLTU   alu_control = %b", alu_control);
        // I-type ALU (ALUOp = 11)
        alu_op = 2'b11;
        funct3 = 3'b000; funct7 = 7'b0000000; #1 $display("ADDI   alu_control = %b", alu_control);
        funct3 = 3'b111;                    #1 $display("ANDI   alu_control = %b", alu_control);
        funct3 = 3'b110;                    #1 $display("ORI    alu_control = %b", alu_control);
        funct3 = 3'b100;                    #1 $display("XORI   alu_control = %b", alu_control);
        funct3 = 3'b010;                    #1 $display("SLTI   alu_control = %b", alu_control);
        funct3 = 3'b011;                    #1 $display("SLTIU  alu_control = %b", alu_control);
        funct3 = 3'b001;                    #1 $display("SLLI   alu_control = %b", alu_control);
        funct3 = 3'b101; funct7 = 7'b0000000; #1 $display("SRLI   alu_control = %b", alu_control);
        funct3 = 3'b101; funct7 = 7'b0100000; #1 $display("SRAI   alu_control = %b", alu_control);
        $display("\nALUControl Testbench Completed.");
        $finish;
    end
endmodule

