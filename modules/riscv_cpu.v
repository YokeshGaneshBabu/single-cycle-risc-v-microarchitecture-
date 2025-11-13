module riscv_cpu (
    input wire clk,
    input wire rst
);
    // Wires for interconnections
    wire [31:0] pc, pc_next, pc_plus4, pc_target;
    wire [31:0] instr;
    wire [31:0] imm_ext;
    wire [31:0] rs1_data, rs2_data, alu_result;
    wire [31:0] alu_src_b, write_data, mem_read_data;
    wire [4:0] rs1, rs2, rd;
    wire [2:0] funct3;
    wire [6:0] funct7, opcode;
    wire [3:0] alu_control;
    wire [1:0] alu_op, imm_src;
    wire reg_write, mem_write, mem_read, mem_to_reg, alu_src, branch, zero;
    wire pc_src;
    wire less;
    // Extract instruction fields
    assign opcode = instr[6:0];
    assign rd     = instr[11:7];
    assign funct3 = instr[14:12];
    assign rs1    = instr[19:15];
    assign rs2    = instr[24:20];
    assign funct7 = instr[31:25];
    
    // PC logic
    assign pc_plus4 = pc + 4;
    assign pc_target = pc + imm_ext;
    


    assign pc_next = pc_src ? pc_target : pc_plus4;
    
    // ALU source mux
    assign alu_src_b = alu_src ? imm_ext : rs2_data;
    
    // Write-back mux
    assign write_data = mem_to_reg ? mem_read_data : alu_result;
    
    // Instantiate modules
    pc_reg PC (
        .clk(clk), .rst(rst),
        .pc_next(pc_next), .pc(pc)
    );
    
    instr_mem IMEM (
        .addr(pc), .instr(instr)
    );
    
    control_unit CTRL (
        .opcode(opcode),
        .reg_write(reg_write),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .mem_to_reg(mem_to_reg),
        .alu_src(alu_src),
        .branch(branch),
        .alu_op(alu_op),
        .imm_src(imm_src)
    );
    
    regfile RF (
        .clk(clk), .rst(rst),
        .reg_write(reg_write),
        .rs1(rs1), .rs2(rs2), .rd(rd),
        .rd_data(write_data),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );
    
    imm_gen IMMGEN (
        .instr(instr),
        .imm_src(imm_src),
        .imm_out(imm_ext)
    );
    
    ALUControl ALUCTRL (
        .alu_op(alu_op),
        .funct3(funct3),
        .funct7(funct7),
        .alu_control(alu_control)
    );
   // wire less;

    branch_unit BRANCH (
        .funct3(funct3),
        .zero(zero),
        .less(less),
        .branch(branch),
        .pc_src(pc_src)
    );
    
    ALU ALU_UNIT (
        .a(rs1_data),
        .b(alu_src_b),
        .alu_control(alu_control),
        .result(alu_result),
        .zero(zero),
        .less(less)
    );

    
    data_mem DMEM (
        .clk(clk),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .addr(alu_result),
        .write_data(rs2_data),
        .read_data(mem_read_data)
    );
endmodule
