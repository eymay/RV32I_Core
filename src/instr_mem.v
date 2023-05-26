

module instr_mem(
    input [6:0] r_addr_imem,
    output reg [31:0] r_data_imem
);

reg [7:0] imem [0:127];
//param_mux #(.input_length(32), .X_to_1(32)) mux(.i_mux(imem), .select(r_addr_imem), .o_mux(r_data_imem));
`ifndef COCOTB_SIM
    initial $readmemh("test2.mem", imem);
`endif
`ifdef COCOTB_SIM
    initial $readmemh("../../zero_inst.mem", imem);
`endif
always @(*) begin
    // output is not 4-aligned but we assume pc%4==0 always holds
    r_data_imem = {imem[r_addr_imem + 3],imem[r_addr_imem + 2],imem[r_addr_imem + 1],imem[r_addr_imem]};    
end
endmodule