
// iverilog -g2005-sv Datapath.sv hw6/FunctionUnit.v hw5/Datamemory.sv hw5/Regfile.v

module Datapath (clk, rst, instType, fun3, rd, rs1, rs2, fun7, pc, imm);

// control word
input wire [3:0] instType;
input wire [2:0] fun3;
input wire fun7;
input wire [4:0] rd, rs1, rs2;

// other stuff from control unit
input wire [31:0] pc;
input wire [31:0] imm;

// parts of function unit
reg [31:0] funit_A;
reg [31:0] funit_B;
reg [3:0] funit_FS;
wire [3:0] funit_ZCNVFlags;
wire [31:0] funit_S;

// parts of datamem
reg datamem_we0;
reg [6:0] datamem_rd_addr0;
wire [31:0] datamem_rd_dout0;
reg [6:0] datamem_wr_addr0; // note: this value selects the word, not the byte. wr_addr0=1 -> risc-v addresses 4,5,6,7
reg [31:0] datamem_wr_din0;
reg [2:0] datamem_wr_strb;

// parts of regfile
reg regfile_we0;
reg [4:0] regfile_rd_addr0;
wire [31:0] regfile_rd_dout0; // rs1
reg [4:0] regfile_rd_addr1;
wire [31:0] regfile_rd_dout1;  // rs2
reg [4:0] regfile_wr_addr0;
reg [31:0] regfile_wr_din0;


FunctionUnit funit (.A(funit_A), .B(funit_B), .FS(funit_FS), .S(funit_S), .ZCNVFlags(funit_ZCNVFlags)  );
Datamemory datamem (.clk(clk), .rst(rst), .rd_addr0(datamem_rd_addr0), .wr_addr0(datamem_wr_addr0), .wr_din0(datamem_wr_din0), .we0(datamem_we0), .rd_dout0(datamem_rd_dout0), .wr_strb(datamem_wr_strb));
Regfile regfile (.clk(clk), .rst(rst), .rd_addr0(regfile_rd_addr0), .rd_addr1(regfile_rd_addr1), .wr_addr0(regfile_wr_addr0), .wr_din0(regfile_wr_din0), .we0(regfile_we0), .rd_dout0(regfile_rd_dout0), .rd_dout1(regfile_rd_dout1));

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

// TODO: rst not implemented yet
always @(posedge clk) {
    case (instType)
        // jal, jalr, auipc
        4'd8, 4'd7, 4'd5: funit_A <= pc;
        // load, imm, store, reg, lui, brnch
        4'd0, 4'd1, 4'd2, 4'd3, 4'd4, 4'd6: funit_A <= regfile_rd_dout0;
        default: funit_A <= -1; // this should never happen
    endcase

    case (instType)
        // reg
        4'd3: funit_B <= regfile_rd_dout1;
        // store, load, auipc, lui, imm
        4'd2, 4'd0, 4'd5, 4'd4, 4'd1: funit_B <= imm;
        // jal, jalr
        4'd7, 4'd8: funit_B <= 4;
        // brnch
        4'd6: funit_B <= -2; // this is not going to be used anyway
        default: funit_B <= -1; // this should never happen
    endcase
}

endmodule


// load, imm, store, reg, lui, auipc, brnch, jalr, jal
// 0     1    2      3    4    5      6      7     8
