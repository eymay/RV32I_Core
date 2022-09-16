module n_bit_register #(
    N = 32
)(
    input clk, rst, En, [N - 1:0] D, output reg [N-1:0] Q
);

    always @(posedge clk or negedge rst) begin
        if(!rst)
        Q <= 0;
        else if(En)
            Q <= D; 
        else
            Q <= Q;
    end

endmodule