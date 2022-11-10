`timescale 1ns / 1ps
`include "eu_bit.v"

module eu_row#(
           parameter DATA_WIDTH = 8,
           parameter IN_DATA_NUM = 10
       )(
           input wire clk,
           input wire rst_n,
           input wire signed [IN_DATA_NUM * DATA_WIDTH - 1: 0] data_i,
           output wire signed [IN_DATA_NUM / 2 * DATA_WIDTH - 1: 0] data_major,
           output wire signed [IN_DATA_NUM / 2 * DATA_WIDTH - 1: 0] data_minor,
           output reg signed [DATA_WIDTH - 1: 0] data_signle
       );
// localparam MAJOR_NUM = DATA_WIDTH / 2;
// localparam MINOR_NUM = DATA_WIDTH / 2;
// localparam SINGLE = DATA_WIDTH - (DATA_WIDTH / 2); //when IN_DATA_NUM is odd number, need a single wire

genvar i;
generate
    for (i = 1;i < IN_DATA_NUM;i = i + 2) begin
        eu_bit #(
                   .DATA_WIDTH ( DATA_WIDTH )
               )
               u_eu_bit(
                   .clk ( clk ),
                   .rst_n ( rst_n ),
                   .data_a ( data_i[(IN_DATA_NUM * DATA_WIDTH - 1) - ((i - 1) * DATA_WIDTH) -: DATA_WIDTH] ),
                   .data_b ( data_i[(IN_DATA_NUM * DATA_WIDTH - 1) - (i * DATA_WIDTH) -: DATA_WIDTH] ),
                   .major_val ( data_major[(IN_DATA_NUM / 2 * DATA_WIDTH - 1) - ((i / 2) * DATA_WIDTH) -: DATA_WIDTH] ),
                   .minor_val ( data_minor[(IN_DATA_NUM / 2 * DATA_WIDTH - 1) - ((i / 2) * DATA_WIDTH) -: DATA_WIDTH] )
               );
    end
endgenerate

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data_signle <= {DATA_WIDTH{1'b0}};
    end
    else begin
        data_signle <= data_i[DATA_WIDTH - 1: 0];
    end
end

endmodule
