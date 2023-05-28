

module instr_dec_tb ( );

reg [31:0] inst;
wire [22:0] cword;

`define instType cword[3:0]
`define fun3 cword[6:4]
`define fun7 cword[7]
`define rd cword[12:8]
`define rs1 cword[17:13]
`define rs2 cword[22:18]

instr_dec i (inst, cword);

initial begin
    inst = 0;


    #1; // load
    inst = 32'h01ea1503; // lh x10, 30(x20)
    #0;
    $display("type=%d fun3=%3b fun7=%b rd=%2d rs1=%2d rs2=%2d inst=%32b", `instType, `fun3, `fun7, `rd, `rs1, `rs2, inst);

    #1; // imm
    inst = 32'h01ea0513; // addi x10, x20, 30
    #0;
    $display("type=%d fun3=%3b fun7=%b rd=%2d rs1=%2d rs2=%2d inst=%32b", `instType, `fun3, `fun7, `rd, `rs1, `rs2, inst);

    #1; // store
    // note: stores are "op rs2, offset(rs1)" while loads are "op rd, offset(rs1)""
    inst = 32'h00aa1f23; // sh x10, 30(x20)
    #0;
    $display("type=%d fun3=%3b fun7=%b rd=%2d rs1=%2d rs2=%2d inst=%32b", `instType, `fun3, `fun7, `rd, `rs1, `rs2, inst);

    #1; // reg
    inst = 32'h01ea0533; // add x10, x20, x30
    #0;
    $display("type=%d fun3=%3b fun7=%b rd=%2d rs1=%2d rs2=%2d inst=%32b", `instType, `fun3, `fun7, `rd, `rs1, `rs2, inst);

    #1; // lui
    inst = 32'h030391b7; // lui x3, 12345
    #0;
    $display("type=%d fun3=%3b fun7=%b rd=%2d rs1=%2d rs2=%2d inst=%32b", `instType, `fun3, `fun7, `rd, `rs1, `rs2, inst);

    #1; // auipc
    inst = 32'h0002a697; // auipc x13, 42
    #0;
    $display("type=%d fun3=%3b fun7=%b rd=%2d rs1=%2d rs2=%2d inst=%32b", `instType, `fun3, `fun7, `rd, `rs1, `rs2, inst);

    #1; // brnch
    inst = 32'h08419063; // bne x3, x4, 128
    #0;
    $display("type=%d fun3=%3b fun7=%b rd=%2d rs1=%2d rs2=%2d inst=%32b", `instType, `fun3, `fun7, `rd, `rs1, `rs2, inst);

    #1; // jalr
    inst = 32'h04548367; // jalr x6, x9, 69
    #0;
    $display("type=%d fun3=%3b fun7=%b rd=%2d rs1=%2d rs2=%2d inst=%32b", `instType, `fun3, `fun7, `rd, `rs1, `rs2, inst);

    #1; // jal
    inst = 32'h038031ef; // jal x3, 12344
    #0;
    $display("type=%d fun3=%3b fun7=%b rd=%2d rs1=%2d rs2=%2d inst=%32b", `instType, `fun3, `fun7, `rd, `rs1, `rs2, inst);
end

endmodule