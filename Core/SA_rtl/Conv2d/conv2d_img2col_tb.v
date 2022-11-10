`timescale 1ns / 1ps
`include "conv2d_img2col.v"

module conv2d_img2col_tb();
// conv2d_img2col Parameters
parameter BITWIDTH = 8;
parameter IMAGE_WIDTH = 5;
parameter IMAGE_HEIGHT = 5;
parameter WEIGHT_WIDTH = 3;
parameter WEIGHT_HEIGHT = 3;
parameter PADDING = 0;
parameter STRIDE = 1;
parameter FEATURE_MAP_NUM = 9;
parameter KERNEL_NUM = 3;

// conv2d_img2col Inputs
reg signed [IMAGE_WIDTH * IMAGE_HEIGHT * BITWIDTH - 1: 0] image = 0;
reg signed [KERNEL_NUM * WEIGHT_WIDTH * WEIGHT_HEIGHT * BITWIDTH - 1: 0] weights;

// conv2d_img2col Outputs
wire signed [FEATURE_MAP_NUM * WEIGHT_WIDTH * WEIGHT_HEIGHT * BITWIDTH - 1: 0] feature_maps_v;
wire signed [KERNEL_NUM * WEIGHT_WIDTH * WEIGHT_HEIGHT * BITWIDTH - 1: 0] weights_v;

//af fe 3d
//ce 45 a8
//c1 a5 38
//46 6d d7
//00 7f 17
//d0 74 a5
//7f ad ed
//02 40 7f
//cb 66 0c

initial begin
    #5;
    image = 200'h0102030405_060708090A_0B0C0D0C0B_0A09080706_0504030201;
    // image = 72'h010203_040506_070809;
    weights = 216'hAFCEC1_4600D0_7F02CB_FE45A5_6D7F74_AD4066_3DA838_D717A5_ED7F0C;
    #5;
    $display("feature_maps_v: %h", feature_maps_v);
    $display("weights_v: %h", weights_v);
end

initial begin
    $dumpfile("conv2d_img2col.vcd");
    $dumpvars();
    #20;
    $finish;
end

conv2d_img2col #(
                      .BITWIDTH ( BITWIDTH ),
                      .IMAGE_WIDTH ( IMAGE_WIDTH ),
                      .IMAGE_HEIGHT ( IMAGE_HEIGHT ),
                      .WEIGHT_WIDTH ( WEIGHT_WIDTH ),
                      .WEIGHT_HEIGHT ( WEIGHT_HEIGHT ),
                      .FEATURE_MAP_NUM ( FEATURE_MAP_NUM ),
                      .KERNEL_NUM ( KERNEL_NUM ),
                      .PADDING ( PADDING ),
                      .STRIDE ( STRIDE )
                  )
                  u_conv2d_img2col(
                      .image ( image ),
                      .weights ( weights ),
                      .feature_maps_v ( feature_maps_v ),
                      .weights_v ( weights_v )
                  );

endmodule
