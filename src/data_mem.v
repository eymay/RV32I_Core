module data_mem #(
    register_count = 32, data_length = 32
) (
    input clk, rst,
    input [$clog2(register_count) - 1: 0] rw_addr_mem,
    input [data_length - 1: 0] w_data_mem,
    input r_ctrl_mem,
    input w_ctrl_mem,
    output reg [data_length -1:0] r_data_mem
);
    /*
    wire [register_count - 1:0] enable;
    wire [data_length - 1:0] Q [register_count - 1:0]; 

    genvar i;
    generate
    for (i = 0;i < register_count ; i = i +1) begin
        n_bit_register #(.N(data_length)) register(
            .clk(clk), .rst(rst), .En(enable[i]), .D(w_data_mem), .Q(Q[i]));
    end
    endgenerate
    */
    reg [data_length - 1:0] data_mem [register_count - 1:0];

    initial $readmemh("src/data_mem.mem", data_mem);

    always @(*) begin
        r_data_mem = r_ctrl_mem && data_mem[rw_addr_mem];
    end

    always @(posedge clk ) begin
        if(w_ctrl_mem)
            data_mem[rw_addr_mem] <= w_data_mem;
    end
    

    
    //param_decoder #(.input_length(5)) dec(.en_dec(w_ctrl_reg), .i_dec(rw_addr_mem), .o_dec(enable));

    //param_mux #(.input_length(32), .X_to_1(32)) muxreg1(.i_mux(Q), .en_mux(r_ctrl_mem) ,.select(rw_addr_mem), .o_mux(r_data_mem));
    
endmodule
