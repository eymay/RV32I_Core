// `define DEBUG_MEM
module pipeline_reg (clk, rst, D , Q);
    parameter WIDTH=1;

    input wire clk, rst;
    input wire [WIDTH-1:0] D;
    output reg [WIDTH-1:0] Q; 


    // initialize all registers to 0
    initial begin
            Q = 0;
    end

    // write functionality. writes synchronously, on rising edge of clk.
    always @(posedge clk or negedge rst) begin
       if (!rst) 
            // reset is async, works immediately. rst=0 means reset.
            Q <= 0;
        else Q <= D;
    end

endmodule





