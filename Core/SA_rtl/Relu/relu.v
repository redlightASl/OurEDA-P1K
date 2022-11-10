`timescale 1ns / 1ps

module relu #(
           parameter BITWIDTH = 8,
           parameter THRESSHOLD = {BITWIDTH{1'b0}},
           parameter IS_RELU = 1,
           parameter MAX_VAL = 6
       )(
           input wire signed [BITWIDTH - 1 : 0] data_i, //signed data
           output reg signed [BITWIDTH - 1 : 0] result_o //signed data
       );
if (IS_RELU) begin
    always @( * ) begin
        if (data_i > $signed(THRESSHOLD)) begin
            result_o = data_i;
        end
        else begin
            result_o = THRESSHOLD;
        end
    end
end
else begin
    always @( * ) begin
        if (data_i > $signed(THRESSHOLD)) begin
            if (data_i < MAX_VAL) begin
                result_o = data_i;
            end
            else begin
                result_o = MAX_VAL;
            end
        end
        else begin
            result_o = THRESSHOLD;
        end
    end
end
endmodule
