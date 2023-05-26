
module pc_updater_tb ();

pc_updater u1 (clk, rst, cword, imm, r, pc, ZCNVFlags);

reg [31:0] r;
reg [31:0] imm;
reg clk, rst;
wire [31:0] pc;
reg [22:0] cword;
reg [3:0] ZCNVFlags;

`define instType cword[3:0]
`define fun3 cword[6:4]

`define Z_flag ZCNVFlags[3]
`define C_flag ZCNVFlags[2]
`define N_flag ZCNVFlags[1]
`define V_flag ZCNVFlags[0]

`define BEQ 3'b000
`define BNE 3'b001
`define BLT 3'b100
`define BGE 3'b101
`define BLTU 3'b110
`define BGEU 3'b111


initial begin
    `instType=0;
    r=9;
    imm=15;
    clk=0;
    rst=1;
    ZCNVFlags=0;
end

always #1 clk = ~clk;

initial begin

    // load, imm, store, reg, lui, auipc, brnch, jalr, jal
    // 0     1    2      3    4    5      6      7     8

    `instType=1; // imm
    #2 $display("t=%3d pc=%b %3d ", $time, pc, pc);
    #2 $display("t=%3d pc=%b %3d ", $time, pc, pc);
    #2 $display("t=%3d pc=%b %3d ", $time, pc, pc);

    `instType=5; // auipc
    // note: here 27 becomes 24 because of 4-aligment
    #2 $display("t=%3d pc=%b %3d ", $time, pc, pc);
    #2 $display("t=%3d pc=%b %3d ", $time, pc, pc);
    #2 $display("t=%3d pc=%b %3d ", $time, pc, pc);

    `instType=7; // jalr
    #2 $display("t=%3d pc=%b %3d ", $time, pc, pc);
    #2 $display("t=%3d pc=%b %3d ", $time, pc, pc);
    #2 $display("t=%3d pc=%b %3d ", $time, pc, pc);

    `instType=0; // load
    #2 $display("t=%3d pc=%b %3d ", $time, pc, pc);
    #2 $display("t=%3d pc=%b %3d ", $time, pc, pc);
    #2 $display("t=%3d pc=%b %3d ", $time, pc, pc);

    $display("testing branches");

    `instType=6; // branch
    `fun3 = `BEQ;

    `Z_flag = 0;
    #2 $display("t=%3d pc=%b %3d ", $time, pc, pc);
    #2 $display("t=%3d pc=%b %3d ", $time, pc, pc);
    #2 $display("t=%3d pc=%b %3d ", $time, pc, pc);

    `Z_flag = 1;
    #2 $display("t=%3d pc=%b %3d ", $time, pc, pc);
    #2 $display("t=%3d pc=%b %3d ", $time, pc, pc);
    #2 $display("t=%3d pc=%b %3d ", $time, pc, pc);

    `instType = 0; // load
    #2 $display("t=%3d pc=%b %3d ", $time, pc, pc);
    #2 $display("t=%3d pc=%b %3d ", $time, pc, pc);
    #2 $display("t=%3d pc=%b %3d ", $time, pc, pc);
    $finish;
end


endmodule