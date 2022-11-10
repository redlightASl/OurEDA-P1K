`timescale 1ns / 1ps

module eu_bit#(
           parameter DATA_WIDTH = 8
       )(
           input wire clk,
           input wire rst_n,
           input wire signed [DATA_WIDTH - 1: 0] data_a,
           input wire signed [DATA_WIDTH - 1: 0] data_b,
           output reg signed [DATA_WIDTH - 1: 0] major_val,
           output reg signed [DATA_WIDTH - 1: 0] minor_val
       );
/* return max number and min number */
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        {major_val, minor_val} <= {{DATA_WIDTH{1'b0}}, {DATA_WIDTH{1'b0}}};
    end
    else begin
        {major_val, minor_val} <= (data_a > data_b) ? {data_a, data_b} : {data_b, data_a};
    end
end

endmodule
