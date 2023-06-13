// iverilog tb/structural_hazard_tb.v src/cpu.v src/control_unit.v src/Datapath.v src/instr_mem.v src/FunctionUnit.v src/data_mem.v src/immed_gen.v src/instr_dec.v src/pc_updater.v src/regfile.v src/ALU_LL.v src/ripple_carry_adder_subtractor.v src/shifter.v src/full_adder_LL_nodelay.v src/logical_unit.v src/shift_right.v src/mux_2to1.v src/pipeline_reg.v

module structural_hazard_tb ();

reg clk;
reg rst;

cpu cpu(clk,rst);

initial begin
    $dumpvars;
    clk = 0;
    rst = 1;

    #1; // initialize memories with data after t=0 because at t=0 they're filled with zeros.

    // initialize instruction memory:
    cpu.instr_mem.mem[0] = 32'h00a00113; // addi x2, x0, 10
    cpu.instr_mem.mem[1] = 32'h00000033; // nop
    cpu.instr_mem.mem[2] = 32'h00000033; // nop
    cpu.instr_mem.mem[3] = 32'h00210023; // sb x2, 0(x2)

    // cpu.instr_mem.mem[0] = 32'h00418133; // add x2, x3, x4
    // cpu.instr_mem.mem[1] = 32'h007362b3; // or x5, x6, x7
    // cpu.instr_mem.mem[2] = 32'h00312433; // slt x8, x2, x3
    // cpu.instr_mem.mem[3] = 32'h0022a523; // sw x2, 10(x5)
    cpu.instr_mem.mem[4] = 32'h00000033; // nop
    cpu.instr_mem.mem[5] = 32'h00000033; // nop
    cpu.instr_mem.mem[6] = 32'h00000033; // nop
    cpu.instr_mem.mem[7] = 32'h00000033; // nop
    cpu.instr_mem.mem[8] = 32'h00000033; // nop
    cpu.instr_mem.mem[9] = 32'h00000033; // nop
    // for (integer i = 1; i<100; i=i+1) begin
    //     cpu.instr_mem.mem[i] = 32'h00000033; // nop
    // end

    // initialize registers
    // cpu.dp.regfile.mem[3] = 3;
    // cpu.dp.regfile.mem[4] = 4;
    // cpu.dp.regfile.mem[6] = 1;
    // cpu.dp.regfile.mem[7] = 2;

    // !!
    // cpu.dp.regfile.mem[2] = 7;
    // cpu.dp.regfile.mem[5] = 3;

end

always begin
    #9 clk = ~clk;
    #1 clk = ~clk;
end

initial begin
    #5; // We do this because we want to sample right in the middle of two rising edge pulses.

    forever begin

        $display("\nt=%5d", $time);

        $display("reg%2d :     %2d", 2, cpu.dp.regfile.mem[2]);
        // $display("reg%2d :     %2d", 3, cpu.dp.regfile.mem[3]);
        // $display("reg%2d :     %2d", 4, cpu.dp.regfile.mem[4]);
        // $display("reg%2d :     %2d", 5, cpu.dp.regfile.mem[5]);
        // $display("reg%2d :     %2d", 6, cpu.dp.regfile.mem[6]);
        // $display("reg%2d :     %2d", 7, cpu.dp.regfile.mem[7]);
        $display("pc :       %3d", cpu.cu.pc_updater.pc_output);
        // $display("%3d", cpu.cu.pc_updater.pc_output);
        $display("adr%2d..%2d : %2d", 8, 11, cpu.datamem.mem[2]);
        // $display("adr%2d..%2d : %2d", 12, 15, cpu.datamem.mem[3]);

        if (cpu.cu.pc_updater.pc_output == 9*4) begin
            $finish;
        end

        #10;
    end
end

endmodule