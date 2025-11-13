module regfile (
    input  wire        clk,
    input  wire        rst,
    input  wire        reg_write,    // control signal
    input  wire [4:0]  rs1, rs2, rd, // register indices
    input  wire [31:0] rd_data,      // data to write
    output wire [31:0] rs1_data,     // read data 1
    output wire [31:0] rs2_data      // read data 2
);

    // 32 registers of 32 bits each
    reg [31:0] regs [31:0];
    integer i;
    
    assign rs1_data = (rs1 == 0) ? 32'b0 : regs[rs1]; 
    assign rs2_data = (rs2 == 0) ? 32'b0 : regs[rs2];

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            
            for (i = 0; i < 32; i = i + 1)
                regs[i] <= 32'b0;   
        end else if (reg_write && rd != 0) begin
            regs[rd] <= rd_data;    
        end
    end

endmodule

