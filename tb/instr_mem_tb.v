

module instr_mem_tb();

reg [31:0] pc;
wire [31:0] r_data_imem;

instr_mem m(.r_addr_imem(pc), .r_data_imem(r_data_imem));

initial begin
    #1;
    pc = 0;
    #0;
    $display("pc=%5d %32b %8h", pc, r_data_imem, r_data_imem);

    #1;
    pc = 1;
    #0;
    $display("pc=%5d %32b %8h", pc, r_data_imem, r_data_imem);

    #1;
    pc = 4;
    #0;
    $display("pc=%5d %32b %8h", pc, r_data_imem, r_data_imem);

    #1;
    pc = 0;
    #0;
    $display("pc=%5d %32b %8h", pc, r_data_imem, r_data_imem);
end

endmodule