module ALU_system_tb ();
    
    reg clk = 1'b0, rst, s_inc_imm_i_PC, sig_w_ctrl_reg, s_reg_imm_ALU_B,
     sig_r_ctrl_data_mem,  sig_w_ctrl_data_mem, s_ALU_dmem_wregdata;
    wire err_inc_PC, err_imm_PC;
    wire [3:0] ZCNV;
    ALU_system ALU_system(.clk(clk), .rst(rst),  .err_inc_PC(err_inc_PC), .err_imm_PC(err_imm_PC),
    .ZCNV(ZCNV));

    
    
    

    always  begin
        #5 clk = ~clk;
    end

    initial begin
        rst = 0;
        #6;
        rst = 1;
        {s_inc_imm_i_PC, s_reg_imm_ALU_B, s_ALU_dmem_wregdata, sig_w_ctrl_reg,  sig_r_ctrl_data_mem,  sig_w_ctrl_data_mem}
         = 6'b000100;
        #10;
        {s_inc_imm_i_PC, s_reg_imm_ALU_B, s_ALU_dmem_wregdata, sig_w_ctrl_reg,  sig_r_ctrl_data_mem,  sig_w_ctrl_data_mem}
         = 6'b000100;
        #10;
        {s_inc_imm_i_PC, s_reg_imm_ALU_B, s_ALU_dmem_wregdata, sig_w_ctrl_reg,  sig_r_ctrl_data_mem,  sig_w_ctrl_data_mem}
         = 6'b000100;
        #10;
        {s_inc_imm_i_PC, s_reg_imm_ALU_B, s_ALU_dmem_wregdata, sig_w_ctrl_reg,  sig_r_ctrl_data_mem,  sig_w_ctrl_data_mem}
         = 6'b000100;
        #400;
        {s_inc_imm_i_PC, s_reg_imm_ALU_B, s_ALU_dmem_wregdata, sig_w_ctrl_reg,  sig_r_ctrl_data_mem,  sig_w_ctrl_data_mem}
         = 6'b000100;
        #10;
        {s_inc_imm_i_PC, s_reg_imm_ALU_B, s_ALU_dmem_wregdata, sig_w_ctrl_reg,  sig_r_ctrl_data_mem,  sig_w_ctrl_data_mem}
         = 6'b011110;
        #10;
        {s_inc_imm_i_PC, s_reg_imm_ALU_B, s_ALU_dmem_wregdata, sig_w_ctrl_reg,  sig_r_ctrl_data_mem,  sig_w_ctrl_data_mem}
         = 6'b010001;
        #10;
        {s_inc_imm_i_PC, s_reg_imm_ALU_B, s_ALU_dmem_wregdata, sig_w_ctrl_reg,  sig_r_ctrl_data_mem,  sig_w_ctrl_data_mem}
         = 6'b100000;
        #10;
    end

endmodule