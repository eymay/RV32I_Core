module immed_gen_tb ();
    

    reg [22:0] cword;
    reg [31:0] inst;
    wire [31:0] imm;
    `define instType cword[3:0]


    initial begin
        cword = 0;
        inst = 0;
    end

    immed_gen i (cword, inst, imm);

    initial begin

        #1;
        `instType = 4'd4; // lui
        inst = 32'h030391b7; // lui x3, 12345
        #0
        $display("imm=%d", imm); // must print imm<<12

        #1;
        `instType = 4'd8; // jal
        inst = 32'h038031ef; // jal x3, 12344
        #0
        $display("imm=%d", imm);

        #1;
        `instType = 4'd6; // brnch
        inst = 32'h08418063; // beq x3, x4, 128
        #0
        $display("imm=%d", imm);

        #1;
        `instType = 4'd2; // store
        inst = 32'h08320023; // sb x3, 128(x4)
        #0
        $display("imm=%d", imm);

        #1;
        `instType = 4'd0; // load
        inst = 32'h08020183; // lb x3, 128(x4)
        #0
        $display("imm=%d", imm);

        #1;
        `instType = 4'd3; // reg
        inst = 32'h005201b3; // add x3,x4,x5
        #0
        $display("imm=%d", imm);

        #1;
        `instType = 4'd1; // imm
        inst = 32'h07b20193; // addi x3,x4,123
        #0
        $display("imm=%d", imm);


    end
    

endmodule


// load, imm, store, reg, lui, auipc, brnch, jalr, jal
// 0     1    2      3    4    5      6      7     8
