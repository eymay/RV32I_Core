
module cpu (clk,rst);

input wire clk;
input wire rst;

wire [31:0] r_for_pc;
wire [22:0] cwordID, cwordEX, cwordMEM, cwordWB;
wire [31:0] inst;
wire [31:0] immEX, immMEM;
wire [31:0] pc, pcEX;
wire [3:0] ZCNVFlags;

// parts of datamem
wire datamem_we0;
wire [6:0] datamem_rd_addr0;
wire [31:0] datamem_rd_dout0;
wire [6:0] datamem_wr_addr0; // note: this value selects the word, not the byte. wr_addr0=1 -> risc-v addresses 4,5,6,7
wire [31:0] datamem_wr_din0;
wire [2:0] datamem_wr_strb;

control_unit cu (
    .clk(clk),
    .rst(rst),
    .cwordID(cwordID),
    .cwordEX(cwordEX),
    .cwordMEM(cwordMEM),
    .cwordWB(cwordWB),
    .pc(pc),
    .pcEX(pcEX),
    //TODO ImmID missing
    .immEX(immEX),
    .immMEM(immMEM),
    .inst(inst),
    .r_for_pc(r_for_pc),
    .ZCNVFlags(ZCNVFlags));
Datapath dp (
    .clk(clk),
    .rst(rst),
    .cwordID(cwordID),
    .cwordEX(cwordEX),
    .cwordMEM(cwordMEM),
    .cwordWB(cwordWB),
    .pc(pcEX),
    .immEX(immEX),
    .immMEM(immMEM),
    .r_for_pc(r_for_pc),
    .funit_ZCNVFlags(ZCNVFlags),
    // parts connecting datapath and data_mem
    .datamem_rd_addr0(datamem_rd_addr0),
    .datamem_wr_addr0(datamem_wr_addr0),
    .datamem_wr_din0(datamem_wr_din0),
    .datamem_we0(datamem_we0),
    .datamem_rd_dout0(datamem_rd_dout0),
    .datamem_wr_strb(datamem_wr_strb));
instr_mem instr_mem (
    .rd_addr0(pc[8:2]), // note: this must be changed according to the inst mem size
    .rd_dout0(inst));
data_mem datamem (
    .clk(clk),
    .rst(rst),
    .rd_addr0(datamem_rd_addr0),
    .wr_addr0(datamem_wr_addr0),
    .wr_din0(datamem_wr_din0),
    .we0(datamem_we0),
    .rd_dout0(datamem_rd_dout0),
    .wr_strb(datamem_wr_strb));
endmodule
