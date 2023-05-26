
// iverilog tb/cpu_tb.v src/cpu.v src/control_unit.v src/Datapath.v src/instr_mem.v src/FunctionUnit.v src/data_mem.v src/immed_gen.v src/instr_dec.v src/pc_updater.v src/regfile.v src/ALU_LL.v src/ripple_carry_adder_subtractor.v src/shifter.v src/full_adder_LL_nodelay.v src/logical_unit.v src/shift_right.v src/mux_2to1.v 

module cpu_tb ();

reg clk;
reg rst;

cpu cpu(clk,rst);

`define imem cpu.instr_mem.imem
initial begin
    $dumpvars;
    clk = 0;
    rst = 1;

    
    // for (integer i = 0; i<128; i=i+4) begin
    //     $display("%h %h %h %h", `imem[i+3],`imem[i+2],`imem[i+1],`imem[i]);
    // end


    
    

    #50;
    $finish;

end

always begin
    #9 clk = ~clk;
    #1 clk = ~clk;
end

initial begin
    #5;

    forever begin

        #10;
        $display("t=%d", $time);

        for (integer i = 0; i<5; i=i+1) begin
            $display("reg%2d : %d", i, cpu.dp.regfile.mem[i]);
        end
    end
end

endmodule