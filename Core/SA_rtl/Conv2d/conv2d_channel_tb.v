`timescale 1ns / 1ps

module conv2d_channel_tb();
// conv2d_channel Parameters
parameter BITWIDTH = 8;
parameter IS_BITWIDTH_DOUBLE_SCALE = 0;
parameter IMAGE_WIDTH = 5;
parameter IMAGE_HEIGHT = 5;
parameter FEATURE_MAP_WIDTH = 3;
parameter FEATURE_MAP_HEIGHT = 3;
parameter KERNEL_NUM = 3;
parameter PADDING = 0;
parameter STRIDE = 1;

parameter OUT_IMAGE_WIDTH = (IMAGE_WIDTH - FEATURE_MAP_WIDTH + 2 * PADDING) / STRIDE + 1;
parameter OUT_IMAGE_HEIGHT = (IMAGE_HEIGHT - FEATURE_MAP_HEIGHT + 2 * PADDING) / STRIDE + 1;
parameter FEATURE_MAP_NUM = OUT_IMAGE_WIDTH * OUT_IMAGE_HEIGHT; //number of feature-maps == OUT_IMAGE_WIDTH * OUT_IMAGE_HEIGHT

// conv2d_channel Inputs
reg clk = 0;
reg rst_n = 0;
reg calculate_start = 0;
reg signed [IMAGE_WIDTH * IMAGE_HEIGHT * BITWIDTH - 1: 0] image = 0;
reg signed [KERNEL_NUM * FEATURE_MAP_WIDTH * FEATURE_MAP_HEIGHT * BITWIDTH - 1: 0] weights = 0;

// conv2d_channel Outputs
wire calculate_done;
wire signed [BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) * FEATURE_MAP_NUM * KERNEL_NUM - 1: 0] channel_out;

initial begin
    forever
        #2 clk = ~clk;
end

/*
原始图像
torch.tensor([[[[1, 2, 3, 4, 5],
                [6, 7, 8, 9, 10],
                [11, 12, 13, 12, 11],
                [10, 9, 8, 7, 6],
                [5, 4, 3, 2, 1]]]],
                              dtype=torch.int8)
 
0102030405_060708090A_0B0C0D0C0B_0A09080706_0504030201
 
卷积核
[[[[1, 0, -1], 
[2, 0, -2],
[1, 0, -1]]]],
h0100FF_0200FE_0100FF

特征图
010203_060708_0B0C0D
020304_070809_0C0D0C
030405_08090A_0D0C0B
060708_0B0C0D_0A0908
070809_0C0D0C_090807
08090A_0D0C0B_080706
0B0C0D_0A0908_050403
0C0D0C_090807_040302
0D0C0B_080706_030201

010203_060708_0B0C0D_020304_070809_0C0D0C_030405_08090A_0D0C0B_060708_0B0C0D_0A0908_070809_0C0D0C_090807_08090A_0D0C0B_080706_0B0C0D_0A0908_050403_0C0D0C_090807_040302_0D0C0B_080706_030201

结果
-8 -6 -4
-4  0  4
 4  6  8

F8 FA FC
FC 00 04
04 06 08
*/

/*
原始图像
torch.tensor([[[[1, 2, 3, 4, 5],
                [6, 7, 8, 9, 10],
                [11, 12, 13, 12, 11],
                [10, 9, 8, 7, 6],
                [5, 4, 3, 2, 1]]]],
                              dtype=torch.int8)

0102030405_060708090A_0B0C0D0C0B_0A09080706_0504030201

卷积核
in_weight_2d = torch.tensor(
    [[[[-81, -50, -63], [70, 0, -48], [127, 2, -53]]],
     [[[-2, 69, -91], [109, 127, 116], [-83, 64, 102]]],
     [[[61, -88, 56], [-41, 23, -91], [-19, 127, 12]]]],
    dtype=torch.int8)

AFCEC1_4600D0_7F02CB_FE45A5_6D7F74_AD4066_3DA838_D717A5_ED7F0C

结果
-114, -104,  -98
 -74,   30, -122
  26,  116,   50

 -69, -118,  -39
 -72,  -59,  -44
 115,   94,  -65

 -57,  -41,  -23
-111,  127,   63
 117,   23,  105

8E989E_B61E86_1A7432_
BB8AD9_B8C5D4_735EBF_
C7D7E9_917F3F_751769

PADDING=1时
-11,  -6,  -6,  -6,  17
-28,  -8,  -6,  -4,  34
-40,  -4,   0,   4,  40
-34,   4,   6,   8,  28
-17,   6,   6,   6,  11

F5FAFAFA11_
E4F8FAFC22_
D8FC000428_
DE0406081C_
EF0606060B
*/

integer stage = 0;
always @(posedge clk) begin
    case (stage)
        0: begin
            rst_n = 1'b1;
            calculate_start = 1'b0;
            stage = 1;
        end
        1: begin
            image = 200'h0102030405_060708090A_0B0C0D0C0B_0A09080706_0504030201;
            // weights = 72'h0100FF_0200FE_0100FF;
            weights = 216'hAFCEC1_4600D0_7F02CB_FE45A5_6D7F74_AD4066_3DA838_D717A5_ED7F0C;
            calculate_start = 1'b1;
            stage = 2;
        end
        2: begin
            // calculate_start = 1'b1;
            stage = 3;
        end
        3: begin
            stage = 4;
        end
        4: begin
            if (calculate_done) begin
                image = 200'h0;
                // weights = 72'h0;
                weights = 216'h0;
                calculate_start = 1'b0;
                stage = 5;
            end
            else begin
                stage = 4;
            end
        end
        5: begin
            stage = 5;
        end
        default: begin
            stage = 5;
        end
    endcase
end

initial begin
    $dumpfile("conv2d_channel_tb.vcd");
    $dumpvars();
    #1000;
    $finish;
end

conv2d_channel #(
                   .BITWIDTH ( BITWIDTH ),
                   .IS_BITWIDTH_DOUBLE_SCALE ( IS_BITWIDTH_DOUBLE_SCALE ),
                   .IMAGE_WIDTH ( IMAGE_WIDTH ),
                   .IMAGE_HEIGHT ( IMAGE_HEIGHT ),
                   .FEATURE_MAP_WIDTH ( FEATURE_MAP_WIDTH ),
                   .FEATURE_MAP_HEIGHT ( FEATURE_MAP_HEIGHT ),
                   .FEATURE_MAP_NUM ( FEATURE_MAP_NUM ),
                   .KERNEL_NUM ( KERNEL_NUM ),
                   .PADDING ( PADDING ),
                   .STRIDE ( STRIDE ))
               u_conv2d_channel (
                   .clk ( clk ),
                   .rst_n ( rst_n ),
                   .calculate_start ( calculate_start ),
                   .image ( image ),
                   .weights ( weights ),

                   .calculate_done ( calculate_done ),
                   .channel_out ( channel_out )
               );

endmodule
