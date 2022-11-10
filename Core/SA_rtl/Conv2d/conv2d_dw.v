`timescale 1ns / 1ps

//depth-wise conv
//in_channel == out_channel
module conv2d_dw#(
           parameter BITWIDTH = 8,
           parameter IS_BITWIDTH_DOUBLE_SCALE = 1,
           parameter IMAGE_WIDTH = 28,
           parameter IMAGE_HEIGHT = 28,
           parameter WEIGHT_WIDTH = 3,
           parameter WEIGHT_HEIGHT = 3,

           parameter INOUT_CHANNEL = 1,
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

           input wire signed [INOUT_CHANNEL * IMAGE_WIDTH * IMAGE_HEIGHT * BITWIDTH - 1: 0] image,
           input wire signed [INOUT_CHANNEL * WEIGHT_WIDTH * WEIGHT_HEIGHT * BITWIDTH - 1: 0] weights_mem,
           output wire signed [INOUT_CHANNEL * OUT_IMAGE_WIDTH * OUT_IMAGE_HEIGHT * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1: 0] result //out_channel = in_channel
       );
localparam FEATURE_MAP_WIDTH = WEIGHT_WIDTH;
localparam FEATURE_MAP_HEIGHT = WEIGHT_HEIGHT;
localparam SINGLE_KERNEL_SIZE = WEIGHT_WIDTH * WEIGHT_HEIGHT;
localparam SINGLE_FEATURE_MAP_SIZE = FEATURE_MAP_WIDTH * FEATURE_MAP_HEIGHT;

localparam OUT_IMAGE_WIDTH = (IMAGE_WIDTH - WEIGHT_WIDTH + 2 * PADDING) / STRIDE + 1;
localparam OUT_IMAGE_HEIGHT = (IMAGE_HEIGHT - WEIGHT_HEIGHT + 2 * PADDING) / STRIDE + 1;
localparam FEATURE_MAP_NUM = OUT_IMAGE_WIDTH * OUT_IMAGE_HEIGHT; //number of feature-maps == OUT_IMAGE_WIDTH * OUT_IMAGE_HEIGHT

/* format weight and image data */
//divide image, weights into channels
wire signed [IMAGE_WIDTH * IMAGE_HEIGHT * BITWIDTH - 1: 0] image_channel [0: INOUT_CHANNEL - 1];
wire signed [FEATURE_MAP_WIDTH * FEATURE_MAP_HEIGHT * BITWIDTH - 1: 0] weights [0: INOUT_CHANNEL - 1];
wire signed [OUT_IMAGE_WIDTH * OUT_IMAGE_HEIGHT * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1: 0] channel_out [0: INOUT_CHANNEL - 1];

//input feature number == output feature number
genvar i;
generate
    for (i = 0;i < INOUT_CHANNEL;i = i + 1) begin
        assign image_channel[i] = image[((INOUT_CHANNEL * IMAGE_WIDTH * IMAGE_HEIGHT * BITWIDTH - 1) - (i * IMAGE_WIDTH * IMAGE_HEIGHT * BITWIDTH)) -: (IMAGE_WIDTH * IMAGE_HEIGHT * BITWIDTH)];
        assign weights[i] = weights_mem[((INOUT_CHANNEL * FEATURE_MAP_WIDTH * FEATURE_MAP_HEIGHT * BITWIDTH - 1) - (i * FEATURE_MAP_WIDTH * FEATURE_MAP_HEIGHT * BITWIDTH)) -: (FEATURE_MAP_WIDTH * FEATURE_MAP_HEIGHT * BITWIDTH)];
    end
endgenerate

genvar j;
generate
    for (j = 0;j < INOUT_CHANNEL;j = j + 1) begin
        conv2d_channel #(
                           .BITWIDTH ( BITWIDTH ),
                           .IS_BITWIDTH_DOUBLE_SCALE ( IS_BITWIDTH_DOUBLE_SCALE ),
                           .IMAGE_WIDTH ( IMAGE_WIDTH ),
                           .IMAGE_HEIGHT ( IMAGE_HEIGHT ),
                           .FEATURE_MAP_WIDTH ( FEATURE_MAP_WIDTH ),
                           .FEATURE_MAP_HEIGHT ( FEATURE_MAP_HEIGHT ),
                           .FEATURE_MAP_NUM ( FEATURE_MAP_NUM ),
                           .KERNEL_NUM ( 1 ),
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

genvar k;
generate
    for (k = 0;k < INOUT_CHANNEL;k = k + 1) begin
        assign result[(INOUT_CHANNEL * OUT_IMAGE_WIDTH * OUT_IMAGE_HEIGHT * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1) - (k * OUT_IMAGE_WIDTH * OUT_IMAGE_HEIGHT * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)) -: (BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1))] = channel_out[k];
    end
endgenerate

endmodule
