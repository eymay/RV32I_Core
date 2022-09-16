module param_mux_tb ();
    
    reg [31:0] x [31:0];
    reg [4:0] s;
    wire [31:0] y;
    integer i = 0;

    param_mux #(.input_length(32), .X_to_1(32)) muxx(.i_mux(x), .select(s), .o_mux(y));
    
    initial begin
        for (i= 0; i < 32 ; i = i+1) begin
            x[i] = i;
        end

        s = 5'b00000;
        #30;
        s = 5'b00101;
        #30;
        s = 5'b00111;
        #30;
        s = 5'b11111;
        #30;
    end
endmodule