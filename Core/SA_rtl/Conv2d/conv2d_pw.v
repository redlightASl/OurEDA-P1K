`timescale 1ns / 1ps

//point-wise conv
//kernel_size = 1x1
//upper dimension or lower dimension
module conv2d_pw#(
           parameter BITWIDTH = 8,
           parameter IS_BITWIDTH_DOUBLE_SCALE = 1,
           parameter IMAGE_WIDTH = 28,
           parameter IMAGE_HEIGHT = 28,

           parameter IN_CHANNEL = 1,
           parameter OUT_CHANNEL = 1,
           parameter STRIDE = 1,
           parameter PADDING = 0,
           parameter USING_BIAS = 0,

           parameter USING_ACTIVATION = 1,
           parameter ACTIVATION_IS_RELU = 1,
           parameter ACTIVATION_THRESSHOLD = {BITWIDTH{1'b0}},
           parameter ACTIVATION_MAX_VAL = 6
       )(
           input wire clk,
           input wire rst_n,

           input wire valid,
           output wire ready,

           input wire signed [IN_CHANNEL * IMAGE_WIDTH * IMAGE_HEIGHT * BITWIDTH - 1: 0] image, //in channel = 1
           output wire signed [OUT_CHANNEL * OUT_IMAGE_WIDTH * OUT_IMAGE_HEIGHT * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1: 0] result //out_channel = 1
       );
localparam FEATURE_MAP_WIDTH = 1;
localparam FEATURE_MAP_HEIGHT = 1;
localparam SINGLE_KERNEL_SIZE = WEIGHT_WIDTH * WEIGHT_HEIGHT;
localparam SINGLE_FEATURE_MAP_SIZE = FEATURE_MAP_WIDTH * FEATURE_MAP_HEIGHT;

localparam OUT_IMAGE_WIDTH = (IMAGE_WIDTH - WEIGHT_WIDTH + 2 * PADDING) / STRIDE + 1;
localparam OUT_IMAGE_HEIGHT = (IMAGE_HEIGHT - WEIGHT_HEIGHT + 2 * PADDING) / STRIDE + 1;
localparam FEATURE_MAP_NUM = OUT_IMAGE_WIDTH * OUT_IMAGE_HEIGHT; //number of feature-maps == OUT_IMAGE_WIDTH * OUT_IMAGE_HEIGHT

genvar j;
generate
    for (j = 0;j < ;j = j + 1) begin
        conv2d_channel #(
                           .BITWIDTH ( BITWIDTH ),
                           .IS_BITWIDTH_DOUBLE_SCALE ( IS_BITWIDTH_DOUBLE_SCALE ),
                           .IMAGE_WIDTH ( IMAGE_WIDTH ),
                           .IMAGE_HEIGHT ( IMAGE_HEIGHT ),
                           .FEATURE_MAP_WIDTH ( FEATURE_MAP_WIDTH ),
                           .FEATURE_MAP_HEIGHT ( FEATURE_MAP_HEIGHT ),
                           .FEATURE_MAP_NUM ( FEATURE_MAP_NUM ),
                           .KERNEL_NUM ( INOUT_CHANNEL ),
                           .PADDING ( PADDING ),
                           .STRIDE ( STRIDE ))
                       u_conv2d_channel(
                           .clk ( clk ),
                           .rst_n ( rst_n ),
                           .calculate_start ( valid ),
                           .calculate_done ( ready ),
                           .image ( image_channel[j] ),
                           .weights ( weights[j] ),
                           .channel_out ( channel_out[j] )
                       );
    end
endgenerate




endmodule
