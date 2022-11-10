`timescale 1ns / 1ps

module conv2d_channel #(
           parameter BITWIDTH = 8,
           parameter IS_BITWIDTH_DOUBLE_SCALE = 1,
           parameter IMAGE_WIDTH = 28,
           parameter IMAGE_HEIGHT = 28,
           parameter FEATURE_MAP_WIDTH = 3, //single feature map size == weight size
           parameter FEATURE_MAP_HEIGHT = 3,
           parameter FEATURE_MAP_NUM = 9, //number of the regenerated feature-maps
           parameter KERNEL_NUM = 1, //number of conv-kernel in one channel

           parameter PADDING = 0,
           parameter STRIDE = 1
       )(
           input wire clk,
           input wire rst_n,
           input wire calculate_start,
           output wire calculate_done,

           input wire signed [IMAGE_WIDTH * IMAGE_HEIGHT * BITWIDTH - 1: 0] image,
           input wire signed [KERNEL_NUM * FEATURE_MAP_WIDTH * FEATURE_MAP_HEIGHT * BITWIDTH - 1: 0] weights,

           output wire signed [KERNEL_NUM * FEATURE_MAP_NUM * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1: 0] channel_out
       );

wire signed [FEATURE_MAP_NUM * FEATURE_MAP_WIDTH * FEATURE_MAP_HEIGHT * BITWIDTH - 1: 0] feature_maps_v;
wire signed [KERNEL_NUM * FEATURE_MAP_WIDTH * FEATURE_MAP_HEIGHT * BITWIDTH - 1: 0] weights_v;
wire signed [KERNEL_NUM * FEATURE_MAP_NUM * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1: 0] channel_out_v;

conv2d_img2col #(
                      .BITWIDTH ( BITWIDTH ),
                      .IMAGE_WIDTH ( IMAGE_WIDTH ),
                      .IMAGE_HEIGHT ( IMAGE_HEIGHT ),
                      .WEIGHT_WIDTH ( FEATURE_MAP_WIDTH ),
                      .WEIGHT_HEIGHT ( FEATURE_MAP_HEIGHT ),
                      .FEATURE_MAP_NUM ( FEATURE_MAP_NUM ),
                      .KERNEL_NUM ( KERNEL_NUM ),
                      .PADDING ( PADDING ),
                      .STRIDE ( STRIDE ))
                  u_conv2d_img2col(
                      .image ( image ),
                      .weights ( weights ),
                      .feature_maps_v ( feature_maps_v ),
                      .weights_v ( weights_v )
                  );

conv2d_feature #(
                   .BITWIDTH ( BITWIDTH ),
                   .IS_BITWIDTH_DOUBLE_SCALE ( IS_BITWIDTH_DOUBLE_SCALE ),
                   .FEATURE_MAP_NUM ( FEATURE_MAP_NUM ),
                   .FEATURE_MAP_WIDTH ( FEATURE_MAP_WIDTH ),
                   .FEATURE_MAP_HEIGHT ( FEATURE_MAP_HEIGHT ),
                   .KERNEL_NUM ( KERNEL_NUM ))
               u_conv2d_feature(
                   .clk ( clk ),
                   .rst_n ( rst_n ),
                   .calculate_start ( calculate_start ),
                   .calculate_done ( calculate_done ),
                   .feature_maps ( feature_maps_v ),
                   .weights ( weights_v ),
                   .channel_out ( channel_out_v )
               );

//re-arrange the result
//col2img
/*
ae
bf
cg
dh
->
abcd
efgh
*/
genvar i, j;
generate
    for (i = 0;i < KERNEL_NUM;i = i + 1) begin
        for (j = 0;j < FEATURE_MAP_NUM;j = j + 1) begin
            assign channel_out[((KERNEL_NUM * FEATURE_MAP_NUM * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1) - (i * FEATURE_MAP_NUM * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)) - (j * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1))) -: BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)] = channel_out_v[((FEATURE_MAP_NUM * KERNEL_NUM * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1) - (j * KERNEL_NUM * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)) - (i * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1))) -: BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)];
        end
    end
endgenerate

endmodule
