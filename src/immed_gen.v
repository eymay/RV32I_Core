module immed_gen (
    input [24:0] field,
    input [1:0]select,
    output reg [31:0] immediate
);
    //select[1:0] is opcode[6:5]
    always @(*) begin
        case (select)
            2'b00:
                immediate = {{20{field[24]}},field[24:12]};
            2'b11:
                immediate = {{19{field[0]}}, field[24], field[0], field[22:17], field[4:1], 1'b0};
            2'b01:
                immediate = {{20{field[24]}}, field[24:17], field[4:0]};
        endcase
    end
endmodule
