`timescale 1ns/1ps
module tb_branch_unit;
    reg  [2:0] funct3;
    reg zero;
    reg less;
    reg branch;
    wire pc_src;
    branch_unit u1 (.funct3(funct3),.zero(zero),.less(less),.branch(branch),.pc_src(pc_src));
    initial begin
        $display("Starting Branch Unit Testbench\n");
        branch = 1;
        // BEQ: pc_src = zero
        funct3 = 3'b000; zero = 1; less = 0;
        #1 $display("BEQ  zero=1 pc_src=%b", pc_src); // expected: 1
        funct3 = 3'b000; zero = 0; 
        #1 $display("BEQ  zero=0 pc_src=%b", pc_src); // expected: 0
        // BNE: pc_src = ~zero
        funct3 = 3'b001; zero = 1;
        #1 $display("BNE  zero=1 pc_src=%b", pc_src); // expected: 0
        funct3 = 3'b001; zero = 0;
        #1 $display("BNE  zero=0 pc_src=%b", pc_src); // expected: 1
        // BLT: pc_src = less  (signed compare)
        funct3 = 3'b100; less = 1;
        #1 $display("BLT  less=1 pc_src=%b", pc_src); // expected: 1
        funct3 = 3'b100; less = 0;
        #1 $display("BLT  less=0 pc_src=%b", pc_src); // expected: 0
        // BGE: pc_src = ~less (signed compare)
        funct3 = 3'b101; less = 1;
        #1 $display("BGE  less=1 pc_src=%b", pc_src); // expected: 0
        funct3 = 3'b101; less = 0;
        #1 $display("BGE  less=0 pc_src=%b", pc_src); // expected: 1
        // BLTU: pc_src = less (unsigned compare)
        funct3 = 3'b110; less = 1;
        #1 $display("BLTU less=1 pc_src=%b", pc_src); // expected: 1
        funct3 = 3'b110; less = 0;
        #1 $display("BLTU less=0 pc_src=%b", pc_src); // expected: 0
        // BGEU: pc_src = ~less
        funct3 = 3'b111; less = 1;
        #1 $display("BGEU less=1 pc_src=%b", pc_src); // expected: 0
        funct3 = 3'b111; less = 0;
        #1 $display("BGEU less=0 pc_src=%b", pc_src); // expected: 1
        // branch = 0  PC never changes
        branch = 0;
        funct3 = 3'b000; zero = 1;
        #1 $display("branch=0 pc_src=%b", pc_src); // expected: 0
        $display("\nBranch Unit Testbench Completed.");
        $finish;
    end
endmodule

