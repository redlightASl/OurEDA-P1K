`timescale 1ns / 1ps

module conv2d_img2col#(
           parameter BITWIDTH = 8,
           parameter IMAGE_WIDTH = 28,
           parameter IMAGE_HEIGHT = 28,
           parameter WEIGHT_WIDTH = 3,
           parameter WEIGHT_HEIGHT = 3,
           parameter FEATURE_MAP_NUM = 9,
           parameter KERNEL_NUM = 1,

           parameter PADDING = 0,
           parameter STRIDE = 1
       )(
           input wire signed [IMAGE_WIDTH * IMAGE_HEIGHT * BITWIDTH - 1: 0] image,
           input wire signed [KERNEL_NUM * WEIGHT_WIDTH * WEIGHT_HEIGHT * BITWIDTH - 1: 0] weights,
           output wire signed [FEATURE_MAP_NUM * WEIGHT_WIDTH * WEIGHT_HEIGHT * BITWIDTH - 1: 0] feature_maps_v,
           output wire signed [KERNEL_NUM * WEIGHT_WIDTH * WEIGHT_HEIGHT * BITWIDTH - 1: 0] weights_v
       );
wire signed [BITWIDTH - 1: 0] image_padding [0: IMAGE_WIDTH + 2 * PADDING - 1][0: IMAGE_HEIGHT + 2 * PADDING - 1];
wire signed [BITWIDTH - 1: 0] feature_maps [0: FEATURE_MAP_NUM - 1][0: WEIGHT_WIDTH * WEIGHT_HEIGHT - 1];

//re-arrange image to array, add padding rows&cols
genvar m, n;
generate
    if (PADDING) begin
        for (m = 0;m < IMAGE_WIDTH + 2 * PADDING;m = m + 1) begin
            for (n = 0;n < IMAGE_HEIGHT + 2 * PADDING;n = n + 1) begin
                if (m < PADDING) begin //first row
                    assign image_padding[m][n] = 8'b0;
                end
                else if (m >= IMAGE_WIDTH + 2 * PADDING - PADDING) begin //last row
                    assign image_padding[m][n] = 8'b0;
                end
                else if (n < PADDING) begin //first column
                    assign image_padding[m][n] = 8'b0;
                end
                else if (n >= IMAGE_HEIGHT + 2 * PADDING - PADDING) begin //last column
                    assign image_padding[m][n] = 8'b0;
                end
                else begin
                    assign image_padding[m][n] = image[(IMAGE_WIDTH * IMAGE_HEIGHT * BITWIDTH - 1) - ((m - PADDING) * IMAGE_HEIGHT * BITWIDTH) - ((n - PADDING) * BITWIDTH) -: BITWIDTH];
                end
            end
        end
    end
    else begin
        for (m = 0;m < IMAGE_WIDTH;m = m + 1) begin
            for (n = 0;n < IMAGE_HEIGHT;n = n + 1) begin
                assign image_padding[m][n] = image[(IMAGE_WIDTH * IMAGE_HEIGHT * BITWIDTH - 1) - (m * IMAGE_HEIGHT * BITWIDTH) - (n * BITWIDTH) -: BITWIDTH];
            end
        end
    end
endgenerate

//generate feature-maps
genvar i, j;
genvar p, q;
generate
    for (i = 0;i < IMAGE_WIDTH + 2 * PADDING - WEIGHT_WIDTH + 1;i = i + STRIDE) begin
        for (j = 0;j < IMAGE_HEIGHT + 2 * PADDING - WEIGHT_HEIGHT + 1;j = j + STRIDE) begin
            for (p = 0;p < WEIGHT_WIDTH;p = p + 1) begin
                for (q = 0;q < WEIGHT_HEIGHT;q = q + 1) begin
                    assign feature_maps[(i / STRIDE) * ((IMAGE_HEIGHT - WEIGHT_HEIGHT + 2 * PADDING) / STRIDE + 1) + (j / STRIDE)][p * WEIGHT_HEIGHT + q] = image_padding[i + p][j + q];
                end
            end
        end
    end
endgenerate

//combine array values to a vector
genvar a, b;
generate
    for (a = 0;a < FEATURE_MAP_NUM;a = a + 1) begin
        for (b = 0;b < WEIGHT_WIDTH * WEIGHT_HEIGHT;b = b + 1) begin
            assign feature_maps_v[((FEATURE_MAP_NUM * WEIGHT_WIDTH * WEIGHT_HEIGHT * BITWIDTH - 1) - (a * WEIGHT_WIDTH * WEIGHT_HEIGHT * BITWIDTH) - (b * BITWIDTH)) -: BITWIDTH] = feature_maps[a][b];
        end
    end
endgenerate

wire [BITWIDTH - 1: 0] weights_trans [0: KERNEL_NUM - 1][0: WEIGHT_WIDTH * WEIGHT_HEIGHT - 1];

//trans weight matrix
genvar c, d;
generate
    for (c = 0;c < KERNEL_NUM;c = c + 1) begin
        for (d = 0;d < WEIGHT_WIDTH * WEIGHT_HEIGHT;d = d + 1) begin
            assign weights_trans[c][d] = weights[((KERNEL_NUM * WEIGHT_WIDTH * WEIGHT_HEIGHT * BITWIDTH - 1) - (c * WEIGHT_WIDTH * WEIGHT_HEIGHT * BITWIDTH) - (d * BITWIDTH)) -: BITWIDTH];
        end
    end
endgenerate

genvar e,f;
generate
    for (e = 0;e < WEIGHT_WIDTH * WEIGHT_HEIGHT;e = e + 1) begin
        for (f = 0;f < KERNEL_NUM;f = f + 1) begin
            assign weights_v[((KERNEL_NUM * WEIGHT_WIDTH * WEIGHT_HEIGHT * BITWIDTH - 1) - (e * KERNEL_NUM * BITWIDTH) - (f * BITWIDTH)) -: BITWIDTH] = weights_trans[f][e];
        end
    end
endgenerate

endmodule
