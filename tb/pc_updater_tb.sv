
module pc_updater_tb ();

pc_updater u1 (clk, cword, imm, r, pc);

reg [31:0] r;
reg [31:0] imm;
reg clk;
wire [31:0] pc;
reg [22:0] cword;

`define instType cword[3:0]


initial begin
    `instType=0;
    r=9;
    imm=15;
    clk=0;
end

always #1 clk = ~clk;

initial begin

    // load, imm, store, reg, lui, auipc, brnch, jalr, jal
    // 0     1    2      3    4    5      6      7     8

    #1 $display("t=%3d pc=%b %3d ", $time, pc, pc);
    #1 $display("t=%3d pc=%b %3d ", $time, pc, pc);
    #1 $display("t=%3d pc=%b %3d ", $time, pc, pc);
    #1 $display("t=%3d pc=%b %3d ", $time, pc, pc);
    #1 $display("t=%3d pc=%b %3d ", $time, pc, pc);
    #1 $display("t=%3d pc=%b %3d ", $time, pc, pc);
    #1 $display("t=%3d pc=%b %3d ", $time, pc, pc);

    $finish;
end


endmodule