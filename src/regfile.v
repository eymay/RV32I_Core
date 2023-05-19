module regfile #(
    register_count = 32, data_length = 32
) (
    input clk, rst,
    input [$clog2(register_count) - 1: 0] r_addr_reg1,
    input [$clog2(register_count) - 1: 0] r_addr_reg2,
    input [$clog2(register_count) - 1: 0] w_addr_reg,
    input [data_length - 1: 0] w_data_reg,
    input w_ctrl_reg,
    output reg [data_length -1:0] r_data_reg1,
    output reg [data_length -1:0] r_data_reg2
);
    /*
    wire [register_count - 1:0]  enable;
    wire [data_length - 1:0] Q [register_count - 1:0]; 

    genvar i;
    generate
    for (i = 0;i < register_count ; i = i +1) begin
        n_bit_register #(.N(data_length)) register(
            .clk(clk), .rst(rst), .En(enable[i]), .D(w_data_reg), .Q(Q[i]));
    end
    endgenerate

    param_decoder #(.input_length(5)) dec(.en_dec(w_ctrl_reg), .i_dec(w_addr_reg), .o_dec(enable));

    param_mux #(.input_length(32), .X_to_1(32)) muxreg1(.i_mux(Q), .en_mux(1'b1),.select(r_addr_reg1), .o_mux(r_data_reg1));
    param_mux #(.input_length(32), .X_to_1(32)) muxreg2(.i_mux(Q), .en_mux(1'b1), .select(r_addr_reg2), .o_mux(r_data_reg2));
    */
    reg [data_length - 1:0] regfile [register_count - 1:0]; 

`ifdef COCOTB_SIM
    initial $readmemh("../../src/regfile_mem.mem", regfile);
`endif
    always @(*) begin
        r_data_reg1 = regfile[r_addr_reg1];
        r_data_reg2 = regfile[r_addr_reg2];
    end

    always @(posedge clk ) begin
        if(w_ctrl_reg)
            regfile[w_addr_reg] <= w_data_reg;
    end


endmodule
