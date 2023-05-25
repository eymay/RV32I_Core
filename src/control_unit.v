module control_unit (
    input clk,
    input [4:0] type_select,
    output reg [5:0] ctrl_wrd
);
    parameter 
    LUI   = 5'b01101, 
    AUIPC = 5'b00101,
    JAL   = 5'b11011,
    JALR  = 5'b11001,
    Load  = 5'b00000,
    Store = 5'b01000,
    R_imm = 5'b00100,
    R     = 5'b01100,
    B     = 5'b11000;
    //{s_inc_imm_i_PC, s_reg_imm_ALU_B, s_ALU_dmem_wregdata,
    //                sig_w_ctrl_reg,  sig_r_ctrl_data_mem,  sig_w_ctrl_data_mem} = ctrl_wrd

    always @(*) begin
        case (type_select)
            Load, LUI: //Load
                ctrl_wrd <= 6'b011110;
            Store:
                ctrl_wrd <= 6'b010001;
            R_imm:
                ctrl_wrd <= 6'b010100; //TODO check validity of s_reg_imm_ALU_B for all types
            R: 
                ctrl_wrd <= 6'b000100;
            B, AUIPC:
                ctrl_wrd <= 6'b100000;
             
        endcase
    end
    
endmodule
