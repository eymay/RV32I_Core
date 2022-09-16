module regfile_tb();
    reg clk = 0, rst;
    parameter register_count = 32, data_length = 32;
    reg [$clog2(register_count) - 1: 0] r_addr_reg1;
    reg [$clog2(register_count) - 1: 0] r_addr_reg2;
    reg [$clog2(register_count) - 1: 0] w_addr_reg;
    reg [data_length - 1: 0] w_data_reg;
    reg w_ctrl_reg;
    wire [data_length -1:0] r_data_reg1;
    wire [data_length -1:0] r_data_reg2;

    regfile rf(.clk, .rst, .r_addr_reg1, .r_addr_reg2, .w_addr_reg, .w_data_reg, .w_ctrl_reg, .r_data_reg1, .r_data_reg2);

    always begin
        clk = ~clk;
        #5;
    end
    initial begin
        rst = 0;
        #5;
        rst=1;
        w_ctrl_reg = 1;
        w_data_reg = 32'd3;
        w_addr_reg = 5'd8;
        r_addr_reg1 = 5'd8;
        r_addr_reg2 = 0;

    end
    
 endmodule