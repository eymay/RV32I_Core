module param_decoder_tb ();
    
    reg [4:0] x;
    wire [31:0] y;

    param_decoder #(.input_length(5)) dec(.i_dec(x), .o_dec(y));
    
    initial begin
        x = 5'b00011;
        #30;
        x = 5'b01001;
        #30;
        x = 5'b01010;
        #30;
        x = 5'b11111;
        #30;
        x = 5'b00000;
    end
endmodule