

// iverilog tb/exponentiation_tb.v src/cpu.v src/control_unit.v src/Datapath.v src/instr_mem.v src/FunctionUnit.v src/data_mem.v src/immed_gen.v src/instr_dec.v src/pc_updater.v src/regfile.v src/ALU_LL.v src/ripple_carry_adder_subtractor.v src/shifter.v src/full_adder_LL_nodelay.v src/logical_unit.v src/shift_right.v src/mux_2to1.v src/pipeline_reg.v

`define NUMBER_TO_SQUARE 7

module exponentiation_tb ();

reg clk;
reg rst;

cpu cpu(clk,rst);

initial begin
    $dumpvars;
    clk = 0;
    rst = 1;

    #1; // initialize memories with data after t=0 because at t=0 they're filled with zeros.

    // initialize instruction memory:
    $readmemh("exponentiation_pc_fixed.mem", cpu.instr_mem.mem);

    // initialize registers:
    cpu.dp.regfile.mem[10] = `NUMBER_TO_SQUARE;
end

always begin
    #9 clk = ~clk;
    #1 clk = ~clk;
end

initial begin
    #5; // We do this because we want to sample right in the middle of two rising edge pulses.

    forever begin

        $display("\nt=%5d", $time);

        // Here input is x10 (a0) and output is the same register
        $display("reg%2d (a0) : %2d", 10, cpu.dp.regfile.mem[10]);
        $display("pc : %d", cpu.cu.pc_updater.pc_output);

        if (cpu.dp.regfile.mem[10] == `NUMBER_TO_SQUARE * `NUMBER_TO_SQUARE) begin
            $finish;
        end

        if (cpu.cu.pc_updater.pc_output == 108*4) begin // the last instruction
            $finish;
        end

        #10;
    end
end

endmodule