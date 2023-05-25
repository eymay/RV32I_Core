

module pc_updater (t, imm, r, clk, pc);

input wire [3:0] t;
input wire [31:0] r;
input wire [31:0] imm;
input wire clk;
output reg [31:0] pc;

reg [31:0] A, B;
wire [31:0] S;
wire Cout;

ripple_carry_adder_subtractor adder ( .Cin(1'b0), .A(A), .B(B), .Cout(Cout), .S(S));
assign pc = {S[31:2], 2'b0};

initial begin
    A = 0;
    B = 0;
end

always @(posedge clk) begin
    if (t == 4'd7) begin // if jalr
        A <= r;
    end
    else begin
        A <= pc;
    end

    if (t==4'd6 || t==4'd8 || t==4'd7 || t==4'd5 ) begin // if branch, jal, jalr, auipc
        B <= imm;
    end
    else begin
        B <= 32'd4; // compressed instructions are not supported
    end
end

endmodule

// load, imm, store, reg, lui, auipc, brnch, jalr, jal
// 0     1    2      3    4    5      6      7     8
