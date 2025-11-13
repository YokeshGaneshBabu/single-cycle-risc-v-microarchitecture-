`timescale 1ns/1ps

module tb_instr_mem;
    reg  [31:0] addr;
    wire [31:0] instr;
    instr_mem u1 (.addr(addr), .instr(instr));
    initial begin
        $display("Starting Instruction Memory Testbench\n");
        addr = 32'h00000000; #1;
        $display("addr=%h instr=%h", addr, instr);  // expected: mem[0]
        addr = 32'h00000004; #1;
        $display("addr=%h instr=%h", addr, instr);  // expected: mem[1]
        addr = 32'h00000008; #1;
        $display("addr=%h instr=%h", addr, instr);  // expected: mem[2]
        addr = 32'h0000000C; #1;
        $display("addr=%h instr=%h", addr, instr);  // expected: mem[3]
        addr = 32'h00000010; #1;
        $display("addr=%h instr=%h", addr, instr);  // expected: mem[4]
        addr = 32'h00000034; #1;
        $display("addr=%h instr=%h", addr, instr);  // expected: mem[13]
        addr = 32'h00000048; #1;
        $display("addr=%h instr=%h", addr, instr);  // expected: mem[18]
        addr = 32'h00000060; #1;
        $display("addr=%h instr=%h", addr, instr);  // expected: NOP
        addr = 32'h00000080; #1;
        $display("addr=%h instr=%h", addr, instr);  // expected: NOP
        $display("\nInstruction Memory Testbench Completed.");
        $finish;
    end
endmodule

