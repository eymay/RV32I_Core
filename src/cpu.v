
module cpu (clk, rst)

wire [31:0] r_for_pc;
wire [22:0] cword;
wire [31:0] inst;
wire [31:0] imm;

control_unit u1 (.clk(clk), .rst(rst), .cword(cword), .pc(pc), .imm(imm))
Datapath u2 (.clk(clk), .rst(rst), .cword(cword), .pc(pc), .imm(imm), .r_for_pc(r_for_pc));

endmodule