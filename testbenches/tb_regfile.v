`timescale 1ns/1ps
module tb_regfile;
    reg clk;
    reg  rst;
    reg  reg_write;
    reg  [4:0]  rs1, rs2, rd;
    reg  [31:0] rd_data;
    wire [31:0] rs1_data;
    wire [31:0] rs2_data;
    regfile u1 (.clk(clk),.rst(rst), .reg_write(reg_write),.rs1(rs1),.rs2(rs2),.rd(rd),.rd_data(rd_data),.rs1_data(rs1_data),.rs2_data(rs2_data));
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        $display("Starting Register File Testbench\n");
        rst = 1;
        reg_write = 0;
        rd = 0;
        rd_data = 0;
        rs1 = 0;
        rs2 = 0;
        #10 rst = 0;   
        // Write to register x5
        reg_write = 1;
        rd = 5;
        rd_data = 32'h000000AA;
        #10;
        // Read back x5
        rs1 = 5;
        rs2 = 5;
        #1 $display("Read x5  rs1_data=%h  rs2_data=%h", rs1_data, rs2_data); 
        // expected: AA
        // Write to register x10
        rd = 10;
        rd_data = 32'h12345678;
        #10;
        rs1 = 10;
        #1 $display("Read x10 rs1_data=%h", rs1_data); 
        // expected: 12345678
        // writing to x0 (should be 0)
        rd = 0;
        rd_data = 32'hFFFFFFFF;
        #10;
        rs1 = 0;
        #1 $display("Read x0 rs1_data=%h", rs1_data); 
        // expected: 00000000
        // Write and read two different registers
        rd = 3;
        rd_data = 32'hA5A5A5A5;
        #10;
        rd = 7;
        rd_data = 32'h5A5A5A5A;
        #10;
        rs1 = 3;
        rs2 = 7;
        #1 $display("Read x3=%h  x7=%h", rs1_data, rs2_data);
        // expected: A5A5A5A5 and 5A5A5A5A
        $display("\nRegister File Testbench Completed.");
        $finish;
    end
endmodule

