module Datapath (
    input clk,
    input rst,
    input [3:0] FS, //{o_instruction_mem[14:12], o_instruction_mem[30]}
    input [2:0] CW4_2,  //{s_reg_imm_ALU_B, s_ALU_dmem_wregdata, sig_w_ctrl_reg}
    input [31:0] o_imm,
    input [31:0] o_data_mem,
    input [4:0] r_addr_reg1, //o_instruction_mem[19:15]
    input [4:0] r_addr_reg2, //o_instruction_mem[24:20]
    input [4:0] w_addr_reg,  //o_instruction_mem[11:7]
    output [31:0] o_ALU,
    output [3:0] ZCNV,
    output [31:0] o_regfile_rreg2,
);

wire s_reg_imm_ALU_B;
wire s_ALU_dmem_wregdata;
wire sig_w_ctrl_reg;

assign {s_reg_imm_ALU_B, s_ALU_dmem_wregdata, sig_w_ctrl_reg} = CW4_2;


wire [31:0] o_regfile_rreg1;
wire [31:0] i_ALU_B;
wire [31:0] i_regfile_wdata;

FunctionUnit ALU(.FS(FS), .A(o_regfile_rreg1), .B(i_ALU_B), .S(o_ALU), .ZCNVFlags(ZCNV));

n_bit_mux #(.N(32)) ALU_B_select (
    .s(s_reg_imm_ALU_B), .i_n_mux_x(o_regfile_rreg2), .i_n_mux_y(o_imm), .o_n_mux(i_ALU_B));

n_bit_mux #(.N(32)) wdata_reg_select(
    .s(s_ALU_dmem_wregdata), .i_n_mux_x(o_ALU), .i_n_mux_y(o_data_mem), .o_n_mux(i_regfile_wdata)
);
regfile regfile(.clk(clk), .rst(rst), 
    .r_addr_reg1(r_addr_reg1), .r_addr_reg2(r_addr_reg2),
    .w_addr_reg(w_addr_reg), .w_data_reg(i_regfile_wdata), 
    .w_ctrl_reg(sig_w_ctrl_reg), .r_data_reg1(o_regfile_rreg1), .r_data_reg2(o_regfile_rreg2));

endmodule
