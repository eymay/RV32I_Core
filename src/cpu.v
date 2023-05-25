
module cpu (clk,rst);

input wire clk;
input wire rst;

wire [31:0] r_for_pc;
wire [22:0] cword;
wire [31:0] inst;
wire [31:0] imm;
wire [31:0] pc;

control_unit cu (.clk(clk), .rst(rst), .cword(cword), .pc(pc), .imm(imm), .inst(inst), .r_for_pc(r_for_pc));
Datapath dp (.clk(clk), .rst(rst), .cword(cword), .pc(pc), .imm(imm), .r_for_pc(r_for_pc));
instr_mem im (.r_addr_imem(pc), .r_data_imem(inst));
endmodule
