module n_bit_mux #(
    N = 32
) (
    input s, [N -1 :0] i_n_mux_x, [N-1:0] i_n_mux_y, output reg [N-1:0] o_n_mux
);

    always @(*) begin
        
        if(!s)
            o_n_mux = i_n_mux_x;
        else
            o_n_mux = i_n_mux_y;
    end
    
endmodule