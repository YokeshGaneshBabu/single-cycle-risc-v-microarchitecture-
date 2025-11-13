`timescale 1ns/1ps
module tb_imm_gen;
    reg  [31:0] instr;
    reg  [1:0]  imm_src;
    wire [31:0] imm_out;
    imm_gen u1 (.instr(instr),.imm_src(imm_src),.imm_out(imm_out));
    initial begin
        $display("Starting Immediate Generator Testbench\n");
        // I-type immediate test Example: addi x1, x2, -5
        instr   = 32'b11111000000000010000000010010011; 
        imm_src = 2'b00;
        #1 $display("I-type imm_out = %h", imm_out); // expected: FFFFFB
        // S-type immediate test Example: sw x5, 12(x2)
        instr   = 32'b00000000010100010011000100100011;
        imm_src = 2'b01;
        #1 $display("S-type imm_out = %h", imm_out); // expected: 0000000C
        // B-type immediate test Example: beq x1, x2, 16
        instr   = 32'b00000000001000001000010001100011;
        imm_src = 2'b10;
        #1 $display("B-type imm_out = %h", imm_out); // expected: 00000010
        // Default case (R-type)
        instr   = 32'b00000000000000001000000000110011;
        imm_src = 2'b11;
        #1 $display("Default imm_out = %h", imm_out); // expected: 00000000
        $display("\nImmediate Generator Testbench Completed.");
        $finish;
    end
endmodule

