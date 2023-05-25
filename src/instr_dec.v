
module instr_dec ( inst, instType, fun3, rd, rs1, rs2, fun7);

input wire [31:0] inst;
output reg [3:0] instType;
output wire [2:0] fun3;
output wire fun7;
output wire [4:0] rd, rs1, rs2;

assign fun3 = inst[14:12];
assign rd = inst[11:7];
assign rs1 = inst[19:15];
assign rs2 = inst[24:20];
assign fun7 = inst[30];


// TODO: not tested
always @(*) begin
    if (inst[2]==1'b1) begin
        case (inst[6:3])
            4'b0110: instType <= 4; // lui
            4'b0010: instType <= 5; // auipc
            4'b1101: instType <= 8; // jal
            default: instType <= 7; // jalr
        endcase
    end
    else begin
        case (inst[6:4])
            3'b110: instType <= 6; // brnch
            3'b000: instType <= 0; // load
            3'b010: instType <= 2; // store
            3'b001: instType <= 1; // imm
            3'b011: instType <= 3; // r
        endcase
    end
end

endmodule

// load, imm, store, reg, lui, auipc, brnch, jalr, jal
// 0     1    2      3    4    5      6      7     8
