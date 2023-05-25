

module control_unit (clk, rst, r_for_pc, cword, inst, imm);

input wire clk, rst;

input wire [31:0] r_for_pc;
output wire [22:0] cword;
output wire [31:0] inst;
output wire [31:0] imm;
output wire [31:0] pc;

immed_gen u1 (.cword(cword), .inst(inst), .imm(imm));
instr_dec u2 ( .inst(inst), .cword(cword));
pc_updater u3 (.clk(clk), .cword(cword), .imm(imm), .r(r_for_pc), .pc(pc));
endmodule