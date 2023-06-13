// iverilog tb/raw_hazard_tb1.v src/cpu.v src/control_unit.v src/Datapath.v src/instr_mem.v src/FunctionUnit.v src/data_mem.v src/immed_gen.v src/instr_dec.v src/pc_updater.v src/regfile.v src/ALU_LL.v src/ripple_carry_adder_subtractor.v src/shifter.v src/full_adder_LL_nodelay.v src/logical_unit.v src/shift_right.v src/mux_2to1.v src/pipeline_reg.v

module raw_hazard_tb1 ();

reg clk;
reg rst;

cpu cpu(clk,rst);

initial begin
    $dumpvars;
    clk = 0;
    rst = 1;

    #1; // initialize memories with data after t=0 because at t=0 they're filled with zeros.

    // initialize instruction memory:
    cpu.instr_mem.mem[0] = 32'h002080b3; // add x1, x1, x2
    cpu.instr_mem.mem[1] = 32'h003080b3; // add x1, x1, x3
    cpu.instr_mem.mem[2] = 32'h004080b3; // add x1, x1, x4
    cpu.instr_mem.mem[3] = 32'h00000033; // nop
    cpu.instr_mem.mem[4] = 32'h00000033; // nop
    cpu.instr_mem.mem[5] = 32'h00000033; // nop
    cpu.instr_mem.mem[6] = 32'h00000033; // nop
    cpu.instr_mem.mem[7] = 32'h00000033; // nop
    cpu.instr_mem.mem[8] = 32'h00000033; // nop
    cpu.instr_mem.mem[9] = 32'h00000033; // nop

    // initialize registers
    cpu.dp.regfile.mem[1] = 1;
    cpu.dp.regfile.mem[2] = 2;
    cpu.dp.regfile.mem[3] = 3;
    cpu.dp.regfile.mem[4] = 4;
end

always begin
    #9 clk = ~clk;
    #1 clk = ~clk;
end

initial begin
    #5; // We do this because we want to sample right in the middle of two rising edge pulses.

    forever begin

        $display("\nt=%5d", $time);

        $display("reg%2d :     %2d", 1, cpu.dp.regfile.mem[1]);
        $display("pc :       %3d", cpu.cu.pc_updater.pc_output);
        
        if (cpu.cu.pc_updater.pc_output == 9*4) begin
            $finish;
        end

        #10;
    end
end

endmodule