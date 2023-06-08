
// iverilog tb/cpu_tb.v src/cpu.v src/control_unit.v src/Datapath.v src/instr_mem.v src/FunctionUnit.v src/data_mem.v src/immed_gen.v src/instr_dec.v src/pc_updater.v src/regfile.v src/ALU_LL.v src/ripple_carry_adder_subtractor.v src/shifter.v src/full_adder_LL_nodelay.v src/logical_unit.v src/shift_right.v src/mux_2to1.v

module cpu_tb ();

reg clk;
reg rst;

cpu cpu(clk,rst);

initial begin
    $dumpvars;
    clk = 0;
    rst = 1;

    #1; // initialize memories with data after t=0 because at t=0 they're filled with zeros.

    // initialize instruction memory:
    $readmemh("tb/bubble_sort/bubble_sort.instr", cpu.instr_mem.mem);
    // $readmemh("exponentiation.mem", cpu.instr_mem.mem);

    // initialize registers:
    // cpu.dp.regfile.mem[10] = 5;

    // initialize data memory:
    $readmemh("tb/bubble_sort/bubble_sort.data", cpu.datamem.mem);

    #10;

    $display("datamem:");
    for (integer i = 0; i<=511/4; i=i+1) begin
        $display("adr%2d..%2d : %d", 4*i, 4*i+3, cpu.datamem.mem[i]);
    end

    $display("instr_mem:");
    for (integer i = 0; i<=511/4; i=i+1) begin
        $display("adr%2d..%2d : %h", 4*i, 4*i+3, cpu.instr_mem.mem[i]);
    end

    // $finish;

    // #1000;
    // $finish;

end

always begin
    #9 clk = ~clk;
    #1 clk = ~clk;
end

initial begin
    #5;

    forever begin

        $display("\nt=%5d", $time);

        // These are for exponentiation algo testing
        // Here input is x10 (a0) and output is the same register
        // By t=600 the output is already calculated
        // $display("reg%2d (sp) : %2d", 2, cpu.dp.regfile.mem[2]);
        // $display("reg%2d (s0) : %2d", 8, cpu.dp.regfile.mem[8]);
        // $display("reg%2d (s1) : %2d", 9, cpu.dp.regfile.mem[9]);
        // $display("reg%2d (s2) : %2d", 18, cpu.dp.regfile.mem[18]);
        // $display("reg%2d (a5) : %2d", 15, cpu.dp.regfile.mem[15]);
        // $display("reg%2d (a4) : %2d", 14, cpu.dp.regfile.mem[14]);
        $display("reg%2d (a0) : %2d", 10, cpu.dp.regfile.mem[10]);

        // You can uncomment this to see the memory
        // This is not necessary because memory here
        // is used only to save certain registers (callee saves)

        $display("FROM:");
        for (integer i = 67; i<=70; i=i+1) begin
            $display("adr%2d..%2d : %d", 4*i, 4*i+3, cpu.datamem.mem[i]);
        end

        $display("TO:");
        for (integer i = 117; i<=120; i=i+1) begin
            $display("adr%2d..%2d : %d", 4*i, 4*i+3, cpu.datamem.mem[i]);
        end

        $display("pc : %d", cpu.cu.pc_updater.pc);

        if ( cpu.cu.pc_updater.pc == 32'h108 ) begin
            $finish;
        end

        #10;
    end
end

endmodule