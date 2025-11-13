`timescale 1ns/1ps
module tb_data_mem;
    reg clk; reg mem_write; reg mem_read; reg  [31:0] addr; reg  [31:0] write_data;
    wire [31:0] read_data;
    data_mem dut ( .clk(clk), .mem_write(mem_write), .mem_read(mem_read), .addr(addr), .write_data(write_data), .read_data(read_data) );
    initial clk = 0;
    always #5 clk = ~clk;
    initial begin
        $display("TIME  op  addr    write_data   read_data");
        mem_write = 0;
        mem_read  = 0;
        addr      = 32'd0;
        write_data= 32'd0;
        #10;
        // Write word 0 (addr 0)
        addr = 32'h0000_0000; write_data = 32'hABCDDEAD; mem_write = 1; mem_read = 0;
        @(posedge clk); #1; mem_write = 0; // write happens on posedge
        $display("%4dns write addr=%h data=%h", $time, addr, write_data);
        #10;
        // Write word 4 (addr 4)
        addr = 32'h0000_0004; write_data = 32'hA1B2C3D4; mem_write = 1; mem_read = 0;
        @(posedge clk); #1; mem_write = 0;
        $display("%4dns write addr=%h data=%h", $time, addr, write_data);
        #20;
        // Read back word 0
        addr = 32'h0000_0000; mem_read = 1; mem_write = 0;
        #1; // combinational read
        $display("%4dns read  addr=%h read_data=%h", $time, addr, read_data);
        #10;
        // Read back word 4
        addr = 32'h0000_0004; mem_read = 1; mem_write = 0;
        #1;
        $display("%4dns read  addr=%h read_data=%h", $time, addr, read_data);
        #10;
        // Try reading an address with mem_read=0 (should be zero as module sets)
        mem_read = 0; addr = 32'h0000_0008;
        #1;
        $display("%4dns read (disabled) addr=%h read_data=%h", $time, addr, read_data);
        #20;
        $display("Test finished.");
        $finish;
    end
endmodule

