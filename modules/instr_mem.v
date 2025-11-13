module instr_mem (
    input  wire [31:0] addr,
    output wire [31:0] instr
);
    reg [31:0] mem [0:255];  // 1 KB instruction memory
    
    assign instr = mem[addr[9:2]];  // Word-aligned access
    
    // Declare loop variable outside initial block (Verilog style)
    integer i;
    
    // Initialize with test program
    initial begin
        // Simple test program
        
        // Test 1: R-type instructions
        mem[0] = 32'h00500093;  // addi x1, x0, 5      # x1 = 5
        mem[1] = 32'h00a00113;  // addi x2, x0, 10     # x2 = 10
        mem[2] = 32'h002081b3;  // add  x3, x1, x2     # x3 = x1 + x2 = 15
        mem[3] = 32'h40208233;  // sub  x4, x1, x2     # x4 = x1 - x2 = -5
        mem[4] = 32'h002092b3;  // sll  x5, x1, x2     # x5 = x1 << x2
        
        // Test 2: I-type ALU instructions
        mem[5] = 32'h00f08313;  // addi x6, x1, 15     # x6 = x1 + 15 = 20
        mem[6] = 32'h0020f393;  // andi x7, x1, 2      # x7 = x1 & 2
        mem[7] = 32'h0020e413;  // ori  x8, x1, 2      # x8 = x1 | 2
        
        // Test 3: Load/Store instructions
        mem[8] = 32'h00100493;  // addi x9, x0, 1      # x9 = 1
        mem[9] = 32'h00902023;  // sw   x9, 0(x0)      # mem[0] = x9
        mem[10] = 32'h00002503; // lw   x10, 0(x0)     # x10 = mem[0]
        
        // Test 4: Branch instructions
        mem[11] = 32'h00500593; // addi x11, x0, 5     # x11 = 5
        mem[12] = 32'h00500613; // addi x12, x0, 5     # x12 = 5
        mem[13] = 32'h00b60463; // beq  x12, x11, 8    # if x12==x11, PC+8
        mem[14] = 32'h00100693; // addi x13, x0, 1     # x13 = 1 (skipped)
        mem[15] = 32'h00200713; // addi x14, x0, 2     # x14 = 2 (executed)
        
        // Test 5: BNE (Branch Not Equal)
        mem[16] = 32'h00300793; // addi x15, x0, 3     # x15 = 3
        mem[17] = 32'h00400813; // addi x16, x0, 4     # x16 = 4
        mem[18] = 32'h01079463; // bne  x15, x16, 8    # if x15!=x16, PC+8
        mem[19] = 32'h00100893; // addi x17, x0, 1     # x17 = 1 (skipped)
        mem[20] = 32'h00200913; // addi x18, x0, 2     # x18 = 2 (executed)
        
        // Initialize rest of memory to NOP (addi x0, x0, 0)
        for (i = 21; i < 256; i = i + 1) begin
            mem[i] = 32'h00000013;  // NOP
        end
    end
endmodule