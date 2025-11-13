module branch_unit (
    input  wire [2:0]  funct3,
    input  wire        zero,
    input  wire        less,
    input  wire        branch,
    output reg         pc_src
);
    always @(*) begin
        if (branch) begin
            case (funct3)
                3'b000: pc_src = zero;   // BEQ
                3'b001: pc_src = ~zero;  // BNE
                3'b100: pc_src = less;   // BLT
                3'b101: pc_src = ~less;  // BGE
                3'b110: pc_src = less;   // BLTU
                3'b111: pc_src = ~less;  // BGEU
                default: pc_src = 1'b0;
            endcase
        end else
            pc_src = 1'b0;
    end
endmodule
