

module control_unit (clk, rst, r_for_pc, cword, inst, imm, pc);

input wire clk, rst;

input wire [31:0] r_for_pc;
output wire [22:0] cword;
input wire [31:0] inst;
output wire [31:0] imm;
output wire [31:0] pc;

immed_gen immed_gen (.cword(cword), .inst(inst), .imm(imm));
instr_dec instr_dec  ( .inst(inst), .cword(cword));
pc_updater pc_updater  (.clk(clk), .cword(cword), .imm(imm), .r(r_for_pc), .pc(pc));
endmodule
