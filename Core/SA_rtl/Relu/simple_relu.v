`timescale 1ns / 1ps

module simple_relu#(
           parameter BITWIDTH = 8
       )(
           input wire signed [BITWIDTH - 1 : 0] data_i, //signed data
           output reg signed [BITWIDTH - 1 : 0] result_o //signed data
       );
always @(*) begin
    if(data_i[BITWIDTH - 1] == 1) begin //sign-bit == 1: data<0
        result_o = 0;
    end
    else begin //data >= 0
        result_o = data_i;
    end
end
endmodule
