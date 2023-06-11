
// iverilog -g2005-sv Datapath.sv hw6/FunctionUnit.v hw5/Datamemory.sv hw5/Regfile.v

module Datapath (clk, rst, cwordID, cwordEX, cwordMEM, cwordWB, pc, immEX, immMEM, r_for_pc, funit_ZCNVFlags,
                datamem_rd_addr0, datamem_wr_addr0, datamem_wr_din0, datamem_we0, datamem_rd_dout0, datamem_wr_strb
);

// control word
input wire clk, rst;
input wire [22:0] cwordID, cwordEX, cwordMEM, cwordWB;

`define instTypeID cwordID[3:0]
`define fun3ID cwordID[6:4]
`define fun7ID cwordID[7]
`define rdID cwordID[12:8]
`define rs1ID cwordID[17:13]
`define rs2ID cwordID[22:18]

`define instTypeEX cwordEX[3:0]
`define fun3EX cwordEX[6:4]
`define fun7EX cwordEX[7]
`define rdEX cwordEX[12:8]
`define rs1EX cwordEX[17:13]
`define rs2EX cwordEX[22:18]

`define instTypeMEM cwordMEM[3:0]
`define fun3MEM cwordMEM[6:4]
`define fun7MEM cwordMEM[7]
`define rdMEM cwordMEM[12:8]
`define rs1MEM cwordMEM[17:13]
`define rs2MEM cwordMEM[22:18]

`define instTypeWB cwordWB[3:0]
`define fun3WB cwordWB[6:4]
`define fun7WB cwordWB[7]
`define rdWB cwordWB[12:8]
`define rs1WB cwordWB[17:13]
`define rs2WB cwordWB[22:18]

// other stuff from control unit
input wire [31:0] pc;
input wire [31:0] immEX, immMEM;
output wire [31:0] r_for_pc;

// parts of function unit
reg [31:0] funit_A;
reg [31:0] funit_B;
reg [3:0] funit_FS;
output wire [3:0] funit_ZCNVFlags;
wire [31:0] funit_S;

// parts of datamem
output reg datamem_we0;
output reg [6:0] datamem_rd_addr0;
input wire [31:0] datamem_rd_dout0;
reg [31:0] datamem_out;
output reg [6:0] datamem_wr_addr0; // note: this value selects the word, not the byte. wr_addr0=1 -> risc-v addresses 4,5,6,7
output reg [31:0] datamem_wr_din0;
output reg [2:0] datamem_wr_strb;

// parts of regfile
reg regfile_we0;
reg [4:0] regfile_rd_addr0;
wire [31:0] regfile_rd_dout0; // rs1
reg [4:0] regfile_rd_addr1;
wire [31:0] regfile_rd_dout1;  // rs2
reg [4:0] regfile_wr_addr0;
reg [31:0] regfile_wr_din0;


FunctionUnit funit (
    .A(funit_A), .B(funit_B), .FS(funit_FS), .S(funit_S), .ZCNVFlags(funit_ZCNVFlags) );

regfile regfile (
    .clk(clk), 
    .rst(rst),
    .rd_addr0(regfile_rd_addr0),
    .rd_addr1(regfile_rd_addr1), 
    .wr_addr0(regfile_wr_addr0), 
    .wr_din0(regfile_wr_din0), 
    .we0(regfile_we0), 
    .rd_dout0(regfile_rd_dout0),
    .rd_dout1(regfile_rd_dout1));

assign r_for_pc = regfile_rd_dout0;

initial begin
    funit_A = 0;
    funit_B = 0;
    funit_FS = 0;
    datamem_we0 = 0;
    datamem_rd_addr0 = 0;
    datamem_wr_addr0 = 0;
    datamem_wr_din0 = 0;
    datamem_wr_strb = 0;
    regfile_we0 = 0;
    regfile_rd_addr0 = 0;
    regfile_rd_addr1 = 0;
    regfile_wr_addr0 = 0;
    regfile_wr_din0 = 0;
end

always @(*) begin

    // funit bindings
    case (`instTypeEX)
        // jal, jalr, auipc
        4'd8, 4'd7, 4'd5: funit_A <= pc;
        // load, imm, store, reg, lui, brnch
        4'd0, 4'd1, 4'd2, 4'd3, 4'd4, 4'd6: funit_A <= regfile_rd_dout0;
        default: funit_A <= -1; // this should never happen
    endcase

    case (`instTypeEX)
        // reg, branch
        4'd3, 4'd6: funit_B <= regfile_rd_dout1;
        // store, load, auipc, lui, imm
        4'd2, 4'd0, 4'd5, 4'd4, 4'd1: funit_B <= immEX;
        // jal, jalr
        4'd7, 4'd8: funit_B <= 4;
        default: funit_B <= -1; // this should never happen
    endcase

    case (`instTypeEX)
        // reg
        4'd3: funit_FS <= {`fun3EX, `fun7EX};
        // imm
        4'd1: funit_FS <= {`fun3EX, 1'b0};
        // branch
        4'd6: funit_FS <= {4'b0001};
        default: funit_FS <= 4'b0; // in all other cases do addition
    endcase

    // datamem bindings

    // if store
    if (`instTypeMEM == 4'd2) datamem_we0 <= 1;
    else datamem_we0 <= 0;

    datamem_rd_addr0 <= funit_S[31:2];
    datamem_wr_addr0 <= funit_S[31:2];
    datamem_wr_din0 <= regfile_rd_dout1;

    case (`fun3MEM)
        // store word
        3'b010: datamem_wr_strb <= 3'b000;
        // store half
        3'b001: datamem_wr_strb <= {1'b0, immMEM[1], 1'b1};
        // store byte
        3'b000: datamem_wr_strb <= {1'b1, immMEM[1:0]};
    endcase

    case (`fun3MEM)
        // LW
        3'b010: datamem_out <= datamem_rd_dout0;
        // LHU
        3'b101: begin
            // lower half
            if (immMEM[1] == 1'b0) datamem_out <= {{16{1'b0}}, datamem_rd_dout0[15:0]};
            // upper half
            else datamem_out <= {{16{1'b0}}, datamem_rd_dout0[31:16]};
        end
        // LH
        3'b001: begin
            // lower half
            if (immMEM[1] == 1'b0) datamem_out <= {{16{datamem_rd_dout0[15]}}, datamem_rd_dout0[15:0]};
            // upper half
            else datamem_out <= {{16{datamem_rd_dout0[31]}}, datamem_rd_dout0[31:16]};
        end
        // LBU
        3'b100: begin
            // lowest byte
            if      (immMEM[1:0] == 2'b00) datamem_out <= {{24{1'b0}}, datamem_rd_dout0[7:0]};
            else if (immMEM[1:0] == 2'b01) datamem_out <= {{24{1'b0}}, datamem_rd_dout0[15:8]};
            else if (immMEM[1:0] == 2'b10) datamem_out <= {{24{1'b0}}, datamem_rd_dout0[23:16]};
            else datamem_out <= {{24{1'b0}}, datamem_rd_dout0[31:24]};
        end
        // LB
        3'b000: begin
            // lowest byte
            if      (immMEM[1:0] == 2'b00) datamem_out <= {{24{datamem_rd_dout0[7]}}, datamem_rd_dout0[7:0]};
            else if (immMEM[1:0] == 2'b01) datamem_out <= {{24{datamem_rd_dout0[15]}}, datamem_rd_dout0[15:8]};
            else if (immMEM[1:0] == 2'b10) datamem_out <= {{24{datamem_rd_dout0[23]}}, datamem_rd_dout0[23:16]};
            else datamem_out <= {{24{datamem_rd_dout0[31]}}, datamem_rd_dout0[31:24]};
        end
    endcase


    // regfile bindings

    regfile_rd_addr0 <= `rs1ID;
    regfile_rd_addr1 <= `rs2ID;
    regfile_wr_addr0 <= `rdWB; // TODO test this
    
    case (`instTypeMEM) // TODO test this
        // reg, imm, auipc, jal, jalr
        4'd3, 4'd1, 4'd5, 4'd7, 4'd8: regfile_wr_din0 <= funit_S;
        // load
        4'd0: regfile_wr_din0 <= datamem_out;
        // lui
        4'd4: regfile_wr_din0 <= immMEM;
        default: regfile_wr_din0 <= -1;
    endcase

    case (`instTypeWB)
        // branch, store
        4'd6, 4'd2: regfile_we0 <= 1'b0;
        default: regfile_we0 <= 1'b1;
    endcase
     
end

endmodule


// load, imm, store, reg, lui, auipc, brnch, jalr, jal
// 0     1    2      3    4    5      6      7     8
