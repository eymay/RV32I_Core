module param_mux #(
    input_length = 32, X_to_1 = 32
)(
    input en_mux, [input_length - 1:0 ]i_mux [X_to_1 -1:0], [$clog2(X_to_1) - 1:0] select,  output reg [input_length - 1:0 ] o_mux
);

    integer i;
    always @(*) begin
        if(!en_mux)
            o_mux = {input_length{1'b0}};
        else begin
            
        for(i = 0; i < X_to_1; i = i +1)
            if(select == i) o_mux = i_mux[i];
        end
    end

    
endmodule