


module instr_mem (rd_addr0, rd_dout0);
    parameter DEPTH=128;
    // note: we remove WIDTH as a parameter and give it a fixed 32 bit value, because it's integral in the logic
    // of the memory how it should respond to storing bytes and halfwords.

    // read port 0
    input wire [$clog2(DEPTH)-1:0] rd_addr0;
    output [31:0] rd_dout0;
    
    reg [31:0] mem [0:DEPTH-1];

    // initialize all registers to 0
    initial begin
        for (integer i = 0; i<DEPTH; i=i+1) begin
            mem[i] = {32{1'b0}};
        end
    end


    // read functionality. reads asynchronously.
    // currently rd_dout0 is a reg, but this could be changed to wire & some 'and' logic.
       assign rd_dout0 = mem[rd_addr0];

    


endmodule


