module param_decoder #(
    input_length = 5
) (
    input en_dec, [input_length -1:0] i_dec, output reg [2**input_length - 1:0] o_dec 
);

    always @(*) begin
        if(!en_dec)
            o_dec = {2**input_length{1'b0}};
        else
            o_dec = {{(2**input_length - 1){1'b0}}, 1'b1 } << i_dec;
        
    end
    
endmodule