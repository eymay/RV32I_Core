
// iverilog src/pc_updater.v src/ripple_carry_adder_subtractor.v src/full_adder_LL_nodelay.v 

module pc_updater (clk, cword, imm, r, pc);

input wire [31:0] r;
input wire [31:0] imm;
input wire clk;
output reg [31:0] pc;

input wire [22:0] cword;

`define instType cword[3:0]

reg [31:0] A, B;
wire [31:0] S;
wire Cout;

ripple_carry_adder_subtractor adder ( .Cin(1'b0), .A(A), .B(B), .Cout(Cout), .S(S));

initial begin
    A = 0;
    B = 0;
end

always @(posedge clk) begin
    if (`instType == 4'd7) begin // if jalr
        A <= r;
    end
    else begin
        A <= pc;
    end

    if (`instType==4'd6 || `instType==4'd8 || `instType==4'd7 || `instType==4'd5 ) begin // if branch, jal, jalr, auipc
        B <= imm;
    end
    else begin
        B <= 32'd4; // compressed instructions are not supported
    end
end

always @(S) begin
    pc = {S[31:2], 2'b0};
end

endmodule

// load, imm, store, reg, lui, auipc, brnch, jalr, jal
// 0     1    2      3    4    5      6      7     8
