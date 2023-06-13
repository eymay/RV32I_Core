

module control_unit (clk, rst, r_for_pc, cwordID, cwordEX, cwordMEM, cwordWB, inst, immEX, immMEM, pc, pcEX, ZCNVFlags);

input wire clk, rst;

input wire [31:0] r_for_pc;
output wire [22:0] cwordID, cwordEX, cwordMEM, cwordWB;
input wire [31:0] inst;
output wire [31:0] immID, immEX, immMEM;
output wire [31:0] pc, pcEX;
input wire [3:0] ZCNVFlags;

wire [31:0] instID, instEX, instMEM, instWB;
wire [31:0] pcID;

pipeline_reg #(.WIDTH(32)) instIFID (.clk(clk), .rst(rst), .D(inst), .Q(instID));
pipeline_reg #(.WIDTH(32)) instIDEX (.clk(clk), .rst(rst), .D(instID), .Q(instEX));
pipeline_reg #(.WIDTH(32)) instEXMEM (.clk(clk), .rst(rst), .D(instEX), .Q(instMEM));
pipeline_reg #(.WIDTH(32)) instMEMWB (.clk(clk), .rst(rst), .D(instMEM), .Q(instWB));


immed_gen immed_genID (.cword(cwordID), .inst(instID), .imm(immID));
immed_gen immed_genEX (.cword(cwordEX), .inst(instEX), .imm(immEX));
immed_gen immed_genMEM (.cword(cwordMEM), .inst(instMEM), .imm(immMEM));

instr_dec instr_decID  ( .inst(instID), .cword(cwordID));
instr_dec instr_decEX  ( .inst(instEX), .cword(cwordEX));
instr_dec instr_decMEM  ( .inst(instMEM), .cword(cwordMEM));
instr_dec instr_decWB  ( .inst(instWB), .cword(cwordWB));

pc_updater pc_updater  (.clk(clk), .rst(rst), .cword(cwordEX),
    .imm(immEX), .r(r_for_pc), .pc_input(pc), .pc_output(pc), .ZCNVFlags(ZCNVFlags));

pipeline_reg #(.WIDTH(32)) pcIFID (.clk(clk), .rst(rst), .D(pc), .Q(pcID));
pipeline_reg #(.WIDTH(32)) pcIDEX (.clk(clk), .rst(rst), .D(pcID), .Q(pcEX));

endmodule
