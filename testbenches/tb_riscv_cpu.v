`timescale 1ns/1ps
module tb_riscv_cpu;
    reg clk; reg rst;
    riscv_cpu u1 (.clk(clk), .rst(rst));
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        $display("Starting RISC-V CPU Testbench\n");
        rst = 1;
        #20 rst = 0;
        repeat (40) begin
            @(posedge clk);
            #1; $display("pc=%h instr=%h", u1.pc, u1.instr);
        end
        $display("\nFinal Register File State:");
        $display("x0  = %h", u1.RF.regs[0]);
        $display("x1  = %h", u1.RF.regs[1]);
        $display("x2  = %h", u1.RF.regs[2]);
        $display("x3  = %h", u1.RF.regs[3]);
        $display("x4  = %h", u1.RF.regs[4]);
        $display("x5  = %h", u1.RF.regs[5]);
        $display("x6  = %h", u1.RF.regs[6]);
        $display("x7  = %h", u1.RF.regs[7]);
        $display("x8  = %h", u1.RF.regs[8]);
        $display("x9  = %h", u1.RF.regs[9]);
        $display("x10 = %h", u1.RF.regs[10]);
        $display("x11 = %h", u1.RF.regs[11]);
        $display("x12 = %h", u1.RF.regs[12]);
        $display("x13 = %h", u1.RF.regs[13]);
        $display("x14 = %h", u1.RF.regs[14]);
        $display("x15 = %h", u1.RF.regs[15]);
        $display("x16 = %h", u1.RF.regs[16]);
        $display("x17 = %h", u1.RF.regs[17]);
        $display("x18 = %h", u1.RF.regs[18]);
        $display("\nCPU Testbench Completed.");
        $finish;
    end
endmodule

