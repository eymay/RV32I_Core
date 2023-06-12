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
    cpu.instr_mem.mem[0] = 32'h00a10113; // addi x2, x2, 10
    cpu.instr_mem.mem[1] = 32'h00202023; // sw x2, 0(x0)
    cpu.instr_mem.mem[2] = 32'h00a10113; // addi x2, x2, 10
    cpu.instr_mem.mem[3] = 32'h00202023; // sw x2, 0(x0)
    cpu.instr_mem.mem[4] = 32'h00a10113; // addi x2, x2, 10
    cpu.instr_mem.mem[5] = 32'h00202023; // sw x2, 0(x0)
    cpu.instr_mem.mem[6] = 32'h00a10113; // addi x2, x2, 10
    cpu.instr_mem.mem[7] = 32'h00202023; // sw x2, 0(x0)
    cpu.instr_mem.mem[8] = 32'h00000033; // nop
    cpu.instr_mem.mem[9] = 32'h00000033; // nop
    cpu.instr_mem.mem[10] = 32'h00000033; // nop
    cpu.instr_mem.mem[11] = 32'h00000033; // nop
    cpu.instr_mem.mem[12] = 32'h00000033; // nop
    cpu.instr_mem.mem[13] = 32'h00000033; // nop
end

always begin
    #9 clk = ~clk;
    #1 clk = ~clk;
end

initial begin
    #5; // We do this because we want to sample right in the middle of two rising edge pulses.

    forever begin

        $display("\nt=%5d", $time);

        $display("reg%2d : %2d", 10, cpu.dp.regfile.mem[2]);
        $display("pc : %d", cpu.cu.pc_updater.pc_output);
        // $display("adr%2d..%2d : %d", 8, 11, cpu.datamem.mem[2]);
        $display("adr%2d..%2d : %d", 0, 3, cpu.datamem.mem[0]);

        if (cpu.cu.pc_updater.pc_output == 36) begin
            $finish;
        end

        #10;
    end
end

endmodule