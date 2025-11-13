module ALU (
    input  wire [31:0] a, b,
    input  wire [3:0]  alu_control,
    output reg  [31:0] result,
    output wire        zero,
    output wire        less      // added output for branch comparisons
);

    always @(*) begin
        case (alu_control)
            4'b0000: result = a + b;                      // ADD
            4'b0001: result = a - b;                      // SUB
            4'b0010: result = a & b;                      // AND
            4'b0011: result = a | b;                      // OR
            4'b0100: result = a ^ b;                      // XOR
            4'b0101: result = a << b[4:0];                // SLL
            4'b0110: result = a >> b[4:0];                // SRL
            4'b0111: result = $signed(a) >>> b[4:0];      // SRA
            4'b1000: result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0; // SLT
            4'b1001: result = (a < b) ? 32'd1 : 32'd0;                   // SLTU
            default: result = 32'b0;
        endcase
    end

    assign zero = (result == 32'b0);
    assign less = ($signed(a) < $signed(b)); // for branch unit (BLT/BGE)

endmodule
