`timescale  1ns / 1ps

module conv2d_top_tb();
// conv2d_top Parameters
parameter BITWIDTH = 8;
parameter IS_BITWIDTH_DOUBLE_SCALE = 1;
parameter IMAGE_WIDTH = 28;
parameter IMAGE_HEIGHT = 28;
parameter WEIGHT_WIDTH = 3;
parameter WEIGHT_HEIGHT = 3;
parameter IN_CHANNEL = 1;
parameter OUT_CHANNEL = 1;
parameter STRIDE = 1;
parameter PADDING = 0;
parameter USING_BIAS = 0;
parameter USING_ACTIVATION = 1;
parameter ACTIVATION_IS_RELU = 1;
parameter ACTIVATION_THRESSHOLD = {BITWIDTH{1'b0}};
parameter ACTIVATION_MAX_VAL = 6;
parameter FEATURE_MAP_WIDTH = WEIGHT_WIDTH;
parameter FEATURE_MAP_HEIGHT = WEIGHT_HEIGHT;
parameter SINGLE_KERNEL_SIZE = WEIGHT_WIDTH * WEIGHT_HEIGHT;
parameter SINGLE_FEATURE_MAP_SIZE = FEATURE_MAP_WIDTH * FEATURE_MAP_HEIGHT;
parameter OUT_IMAGE_WIDTH = (IMAGE_WIDTH - WEIGHT_WIDTH + 2 * PADDING) / STRIDE + 1;
parameter OUT_IMAGE_HEIGHT = (IMAGE_HEIGHT - WEIGHT_HEIGHT + 2 * PADDING) / STRIDE + 1;
parameter FEATURE_MAP_NUM = OUT_IMAGE_WIDTH * OUT_IMAGE_HEIGHT;

// conv2d_top Inputs
reg clk = 0;
reg rst_n = 0;
reg valid = 0;
reg [IN_CHANNEL * IMAGE_WIDTH * IMAGE_HEIGHT * BITWIDTH - 1: 0] image = 0;
reg [IN_CHANNEL * OUT_CHANNEL * WEIGHT_WIDTH * WEIGHT_HEIGHT * BITWIDTH - 1: 0] weights_mem = 0;
reg [OUT_CHANNEL * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1 : 0] bias_mem = 0;

// conv2d_top Outputs
wire ready;
wire [OUT_CHANNEL * OUT_IMAGE_WIDTH * OUT_IMAGE_HEIGHT * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1: 0] result;


initial begin
    forever
        #2 clk = ~clk;
end

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
    $dumpfile("conv2d_top_tb.vcd");
    $dumpvars();
    #1000;
    $finish;
end

conv2d_top #(
               .BITWIDTH ( BITWIDTH ),
               .IS_BITWIDTH_DOUBLE_SCALE ( IS_BITWIDTH_DOUBLE_SCALE ),
               .IMAGE_WIDTH ( IMAGE_WIDTH ),
               .IMAGE_HEIGHT ( IMAGE_HEIGHT ),
               .WEIGHT_WIDTH ( WEIGHT_WIDTH ),
               .WEIGHT_HEIGHT ( WEIGHT_HEIGHT ),
               .IN_CHANNEL ( IN_CHANNEL ),
               .OUT_CHANNEL ( OUT_CHANNEL ),
               .STRIDE ( STRIDE ),
               .PADDING ( PADDING ),
               .USING_BIAS ( USING_BIAS ),
               .USING_ACTIVATION ( USING_ACTIVATION ),
               .ACTIVATION_IS_RELU ( ACTIVATION_IS_RELU ),
               .ACTIVATION_THRESSHOLD ( ACTIVATION_THRESSHOLD ),
               .ACTIVATION_MAX_VAL ( ACTIVATION_MAX_VAL ),
               .FEATURE_MAP_WIDTH ( FEATURE_MAP_WIDTH ),
               .FEATURE_MAP_HEIGHT ( FEATURE_MAP_HEIGHT ),
               .SINGLE_KERNEL_SIZE ( SINGLE_KERNEL_SIZE ),
               .SINGLE_FEATURE_MAP_SIZE ( SINGLE_FEATURE_MAP_SIZE ),
               .OUT_IMAGE_WIDTH ( OUT_IMAGE_WIDTH ),
               .OUT_IMAGE_HEIGHT ( OUT_IMAGE_HEIGHT ),
               .FEATURE_MAP_NUM ( FEATURE_MAP_NUM ))
           u_conv2d_top (
               .clk ( clk ),
               .rst_n ( rst_n ),
               .valid ( valid ),
               .image ( image [IN_CHANNEL * IMAGE_WIDTH * IMAGE_HEIGHT * BITWIDTH - 1: 0] ),
               .weights_mem ( weights_mem [IN_CHANNEL * OUT_CHANNEL * WEIGHT_WIDTH * WEIGHT_HEIGHT * BITWIDTH - 1: 0] ),

               .ready ( ready ),
               .result ( result [OUT_CHANNEL * OUT_IMAGE_WIDTH * OUT_IMAGE_HEIGHT * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1: 0] )
           );

endmodule
