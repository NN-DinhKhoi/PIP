module alu #(WIDTH = 16) (
input wire [2:0] alu_op,
input wire [WIDTH-1:0] a,
input wire [WIDTH-1:0] b,
output reg [WIDTH-1:0] out_alu
    );

always @(*) begin
    case (alu_op)
        3'd0: out_alu = ~a;
        3'd1: out_alu = a & b;
        3'd2: out_alu = a ^ b;
        3'd3: out_alu = a | b;
        3'd4: out_alu = b%2;
        3'd5: out_alu = a + b;
        3'd6: out_alu = a - b;
        3'd7: out_alu = a + 1'b1;
        default: out_alu = {WIDTH{1'b0}};
    endcase
end
endmodule
