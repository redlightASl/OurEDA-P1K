`timescale  1ns / 1ps

module conv2d_feature_tb();
// conv2d_feature Parameters
parameter BITWIDTH = 8;
parameter IS_BITWIDTH_DOUBLE_SCALE = 0;
parameter IMAGE_WIDTH = 5;
parameter IMAGE_HEIGHT = 5;
parameter WEIGHT_WIDTH = 3;
parameter WEIGHT_HEIGHT = 3;
parameter IN_CHANNEL = 1;
parameter OUT_CHANNEL = 1;
parameter STRIDE = 1;
parameter PADDING = 0;

localparam FEATURE_MAP_WIDTH = WEIGHT_WIDTH;
localparam FEATURE_MAP_HEIGHT = WEIGHT_HEIGHT;

localparam OUT_IMAGE_WIDTH = (IMAGE_WIDTH - WEIGHT_WIDTH + 2 * PADDING) / STRIDE + 1;
localparam OUT_IMAGE_HEIGHT = (IMAGE_HEIGHT - WEIGHT_HEIGHT + 2 * PADDING) / STRIDE + 1;
localparam FEATURE_MAP_NUM = OUT_IMAGE_WIDTH * OUT_IMAGE_HEIGHT; //number of feature-maps == OUT_IMAGE_WIDTH * OUT_IMAGE_HEIGHT

localparam KERNEL_NUM = (OUT_CHANNEL >= IN_CHANNEL) ? (OUT_CHANNEL / IN_CHANNEL) : (IN_CHANNEL / OUT_CHANNEL); //number of kernels

// conv2d_feature Inputs
reg clk = 0;
reg rst_n = 0;
reg calculate_start = 0;

reg signed [FEATURE_MAP_NUM * FEATURE_MAP_WIDTH * FEATURE_MAP_HEIGHT * BITWIDTH - 1: 0] feature_maps = 0;
reg signed [KERNEL_NUM * FEATURE_MAP_WIDTH * FEATURE_MAP_HEIGHT * BITWIDTH - 1: 0] weights = 0;

// conv2d_feature Outputs
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

integer stage = 0;
always @(posedge clk) begin
    case (stage)
        0: begin
            rst_n = 1'b1;
            calculate_start = 1'b0;
            stage = 1;
        end
        1: begin
            feature_maps = 648'h010203_060708_0B0C0D_020304_070809_0C0D0C_030405_08090A_0D0C0B_060708_0B0C0D_0A0908_070809_0C0D0C_090807_08090A_0D0C0B_080706_0B0C0D_0A0908_050403_0C0D0C_090807_040302_0D0C0B_080706_030201;
            weights = 72'h0100FF_0200FE_0100FF;
            calculate_start = 1'b1;
            stage = 2;
        end
        2: begin
            stage = 3;
        end
        3: begin
            stage = 4;
        end
        4: begin
            if (calculate_done) begin
                feature_maps <= 648'h0;
                weights <= 72'h0;
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
            stage = 4;
        end
    endcase
end


initial begin
    $dumpfile("conv2d_feature_tb.vcd");
    $dumpvars();
    #1000;
    $finish;
end

conv2d_feature #(
                   .BITWIDTH ( BITWIDTH ),
                   .IS_BITWIDTH_DOUBLE_SCALE ( IS_BITWIDTH_DOUBLE_SCALE ),
                   .FEATURE_MAP_NUM ( FEATURE_MAP_NUM ),
                   .FEATURE_MAP_WIDTH ( FEATURE_MAP_WIDTH ),
                   .FEATURE_MAP_HEIGHT ( FEATURE_MAP_HEIGHT ),
                   .KERNEL_NUM ( KERNEL_NUM ))
               u_conv2d_feature(
                   //ports
                   .clk ( clk ),
                   .rst_n ( rst_n ),
                   .calculate_start ( calculate_start ),
                   .calculate_done ( calculate_done ),
                   .feature_maps ( feature_maps ),
                   .weights ( weights ),
                   .channel_out ( channel_out )
               );


endmodule
