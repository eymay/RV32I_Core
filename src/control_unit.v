module control_unit (
    input clk,
    input [2:0] type_select,
    output reg [5:0] ctrl_wrd
);
    parameter 
    Load = 3'b000,
    Store = 3'b010,
    R_imm = 3'b001,
    R = 3'b011,
    B = 3'b110;
    //{s_inc_imm_i_PC, s_reg_imm_ALU_B, s_ALU_dmem_wregdata, sig_w_ctrl_reg,  sig_r_ctrl_data_mem,  sig_w_ctrl_data_mem} = ctrl_wrd

    always @(*) begin
        case (type_select)
            Load: //Load
                ctrl_wrd <= 6'b011110;
            Store:
                ctrl_wrd <= 6'b010001;
            R_imm:
                ctrl_wrd <= 6'b000100;
            R: 
                ctrl_wrd <= 6'b010100;
            B:
                ctrl_wrd <= 6'b100000;
             
        endcase
    end
    
endmodule
