`timescale 1ns/1ps
module tb_pc_reg;
    reg clk; reg rst; reg [31:0] pc_next; wire[31:0] pc;
    pc_reg u1 (.clk(clk), .rst(rst), .pc_next(pc_next), .pc(pc));
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        $display("Starting PC Register Testbench\n");
        rst = 1;
        pc_next = 32'h00000000;
        #12;
        rst = 0;
        pc_next = 32'h00000004;  // pc should become 4
        @(posedge clk);
        $display("pc=%h", pc);
        pc_next = 32'h00000008;  // pc should become 8
        @(posedge clk);
        $display("pc=%h", pc);
        pc_next = 32'h00000020;  // pc should become 20
        @(posedge clk);
        $display("pc=%h", pc);
        rst = 1;
        @(posedge clk);
        $display("pc=%h", pc);
        rst = 0;
        pc_next = 32'h00000010;
        @(posedge clk);
        $display("pc=%h", pc);
        $display("\nPC Register Testbench Completed.");
        $finish;
    end

endmodule

