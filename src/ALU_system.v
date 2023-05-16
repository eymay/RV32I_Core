module ALU_system (
    input clk, rst,
    output err_inc_PC, err_imm_PC, [3:0] ZCNV
);
    wire  s_inc_imm_i_PC, sig_w_ctrl_reg, s_reg_imm_ALU_B,
     sig_r_ctrl_data_mem,  sig_w_ctrl_data_mem, s_ALU_dmem_wregdata;
    wire [31:0] i_PC, o_PC, o_PC_plus4, o_PC_imm;
    wire [31:0] o_imm;
    wire [31:0] o_instruction_mem;
    wire [31:0] o_data_mem;
    wire [31:0] o_ALU;
    wire [31:0] o_regfile_rreg2;
    n_bit_register #(.N(32)) PC(.clk(clk), .rst(rst), .En(1'b1), .D(i_PC), .Q(o_PC));

    ripple_carry_adder_subtractor #(.N(32)) PC_increment(.Cin(1'b0), .A(o_PC), .B(32'd4),
     .Cout(err_inc_PC), .S(o_PC_plus4));

    n_bit_mux #(.N(32)) PC_select (
        .s(s_inc_imm_i_PC), .i_n_mux_x(o_PC_plus4), .i_n_mux_y(o_PC_imm), .o_n_mux(i_PC));

    ripple_carry_adder_subtractor #(.N(32)) PC_imm_adder(.Cin(1'b0), .A(o_PC), .B(o_imm),
     .Cout(err_imm_PC), .S(o_PC_imm));

    instr_mem instr_mem(.r_addr_imem(o_PC), .r_data_imem(o_instruction_mem));


    immed_gen immed_gen(.field(o_instruction_mem[31:7]), .select(o_instruction_mem[6:5]),
                .immediate(o_imm));

    Datapath dp(.clk(clk), .rst(rst),
        //Control Signals
        .FS({o_instruction_mem[14:12], o_instruction_mem[30]}),
        .CW4_2({s_reg_imm_ALU_B, s_ALU_dmem_wregdata, sig_w_ctrl_reg}),
        //Inputs
        .o_imm(o_imm), .o_data_mem(o_data_mem),
        .r_addr_reg1(o_instruction_mem[19:15]),
        .r_addr_reg2(o_instruction_mem[24:20]),
        .w_addr_reg(o_instruction_mem[11:7]),
        //Outputs
        .o_ALU(o_ALU),
        .ZCNV(ZCNV),
        .o_regfile_rreg2(o_regfile_rreg2)
    );

    data_mem data_mem(.clk(clk), .rst(rst), .rw_addr_mem(o_ALU),
         .w_data_mem(o_regfile_rreg2), .r_ctrl_mem(sig_r_ctrl_data_mem),
         .w_ctrl_mem(sig_w_ctrl_data_mem), .r_data_mem(o_data_mem));


    control_unit cu(.clk(clk), .type_select(o_instruction_mem[6:4]), 
    .ctrl_wrd({s_inc_imm_i_PC, s_reg_imm_ALU_B, s_ALU_dmem_wregdata,
     sig_w_ctrl_reg,  sig_r_ctrl_data_mem,  sig_w_ctrl_data_mem}));

endmodule
