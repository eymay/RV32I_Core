// `define DEBUG_MEM

module regfile (clk, rst, rd_addr0, rd_addr1, wr_addr0, wr_din0, we0, rd_dout0, rd_dout1 );
    parameter WIDTH=32, DEPTH=32;

    input wire clk, rst, we0;
    // read port 0
    input wire [$clog2(DEPTH)-1:0] rd_addr0;
    output [WIDTH-1:0] rd_dout0;

    // read port 1
    input wire [$clog2(DEPTH)-1:0] rd_addr1;
    output [WIDTH-1:0] rd_dout1; 
    
    // write port 0
    input wire [$clog2(DEPTH)-1:0] wr_addr0;
    input wire [WIDTH-1:0] wr_din0;

    reg [WIDTH-1:0] mem [0:DEPTH-1];

    // initialize all registers to 0
    initial begin
        for (integer i = 0; i<DEPTH; i=i+1) begin
            mem[i] = {WIDTH{1'b0}};
        end
    end



    // write functionality. writes synchronously, on rising edge of clk.
    always @(negedge clk or negedge rst) begin
        if(!rst) begin
            for (integer i = 1; i<DEPTH; i=i+1) begin
                mem[i] = {WIDTH{1'b0}};
            end
        end
        else begin
       if (we0 && |wr_addr0) begin
            mem[wr_addr0] <= wr_din0;
        end
    end
    end



    // read functionality. reads asynchronously.
       assign rd_dout0 = mem[rd_addr0];
       assign rd_dout1 = mem[rd_addr1];

endmodule





