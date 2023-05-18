module iverilog_dump();
initial begin
    $dumpfile("ALU_system.fst");
    $dumpvars(0, ALU_system);
end
endmodule
