`timescale 1ns/1ps
module tb_ALU;
    reg  [31:0] A, B; reg  [1:0]  alu_op;reg  [2:0]  funct3; reg  [6:0]  funct7;
    wire [3:0]  alu_ctrl; wire [31:0] result; wire zero;
    ALUControl u1(.alu_op(alu_op), .funct3(funct3),.funct7(funct7),.alu_control(alu_ctrl));
    ALU u2 (.a(A),.b(B),.alu_control(alu_ctrl),.result(result),.zero(zero),.less(less));
    initial begin
        alu_op = 2'b10;                 // R-type ALU op
        A = 32'd10; B = 32'd5;
        funct3 = 3'b000; funct7 = 7'b0000000;
        #10 $display("ADD : %0d + %0d = %0d", A, B, result);
        
        A = 32'd10; B = 32'd5;
        funct3 = 3'b000; funct7 = 7'b0100000;
        #10 $display("SUB : %0d - %0d = %0d", A, B, result);
        
        A = 32'hF0F0; B = 32'h0FF0;
        funct3 = 3'b111; funct7 = 7'b0000000;
        #10 $display("AND : %h & %h = %h", A, B, result);

        A = 32'hF0F0; B = 32'h0FF0;
        funct3 = 3'b110; funct7 = 7'b0000000;
        #10 $display("OR  : %h | %h = %h", A, B, result);

        alu_op = 2'b00;                 // I-type ALU op (add)
        A = 32'd10; B = 32'd20;        
        funct3 = 3'b000; funct7 = 7'b0000000;
        #10 $display("ADDI: %0d + %0d = %0d", A, B, result);
        $finish;
    end
endmodule

