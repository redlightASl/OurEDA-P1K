`timescale 1ns / 1ps

//normal conv
module conv2d_top #(
           parameter BITWIDTH = 8,
           parameter IS_BITWIDTH_DOUBLE_SCALE = 1,
           parameter IMAGE_WIDTH = 28,
           parameter IMAGE_HEIGHT = 28,
           parameter WEIGHT_WIDTH = 3,
           parameter WEIGHT_HEIGHT = 3,

           parameter IN_CHANNEL = 1,
           parameter OUT_CHANNEL = 1,
           parameter STRIDE = 1,
           parameter PADDING = 0,
           parameter USING_BIAS = 0,

           parameter USING_ACTIVATION = 1,
           parameter ACTIVATION_IS_RELU = 1,
           parameter ACTIVATION_THRESSHOLD = {BITWIDTH{1'b0}},
           parameter ACTIVATION_MAX_VAL = 6
       )
       (
           input wire clk,
           input wire rst_n,
           input wire valid,
           output wire ready,

           input wire signed [IN_CHANNEL * IMAGE_WIDTH * IMAGE_HEIGHT * BITWIDTH - 1: 0] image,
           input wire signed [IN_CHANNEL * OUT_CHANNEL * WEIGHT_WIDTH * WEIGHT_HEIGHT * BITWIDTH - 1: 0] weights_mem,  //weights memory for conv layer
           input wire signed [OUT_CHANNEL * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1 : 0] bias_mem,  //bias memory for conv layer

           output wire signed [OUT_CHANNEL * OUT_IMAGE_WIDTH * OUT_IMAGE_HEIGHT * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1: 0] result
       );
parameter FEATURE_MAP_WIDTH = WEIGHT_WIDTH;
parameter FEATURE_MAP_HEIGHT = WEIGHT_HEIGHT;
parameter SINGLE_KERNEL_SIZE = WEIGHT_WIDTH * WEIGHT_HEIGHT;
parameter SINGLE_FEATURE_MAP_SIZE = FEATURE_MAP_WIDTH * FEATURE_MAP_HEIGHT;

parameter OUT_IMAGE_WIDTH = (IMAGE_WIDTH - WEIGHT_WIDTH + 2 * PADDING) / STRIDE + 1;
parameter OUT_IMAGE_HEIGHT = (IMAGE_HEIGHT - WEIGHT_HEIGHT + 2 * PADDING) / STRIDE + 1;
parameter FEATURE_MAP_NUM = OUT_IMAGE_WIDTH * OUT_IMAGE_HEIGHT; //number of feature-maps == OUT_IMAGE_WIDTH * OUT_IMAGE_HEIGHT

// parameter KERNEL_NUM = (OUT_CHANNEL >= IN_CHANNEL) ? (OUT_CHANNEL / IN_CHANNEL) : (IN_CHANNEL / OUT_CHANNEL); //kernels' number in one channel


/* format weight and image data */
//divide image, weights into channels
genvar i;
generate
    for (i = 0;i < IN_CHANNEL;i = i + 1) begin
        assign image_channel[i] = image[((IN_CHANNEL * IMAGE_WIDTH * IMAGE_HEIGHT * BITWIDTH - 1) - (i * IMAGE_WIDTH * IMAGE_HEIGHT * BITWIDTH)) - : (IMAGE_WIDTH * IMAGE_HEIGHT * BITWIDTH)];
        assign weights[i] = weights_mem[((IN_CHANNEL * OUT_CHANNEL * FEATURE_MAP_WIDTH * FEATURE_MAP_HEIGHT * BITWIDTH - 1) - (i * OUT_CHANNEL * FEATURE_MAP_WIDTH * FEATURE_MAP_HEIGHT * BITWIDTH)) - : (OUT_CHANNEL * FEATURE_MAP_WIDTH * FEATURE_MAP_HEIGHT * BITWIDTH)];
    end
endgenerate

/* calculation over in-channels */
reg channel_start;
wire channel_done;

wire signed [IMAGE_WIDTH * IMAGE_HEIGHT * BITWIDTH - 1: 0] image_channel [0: IN_CHANNEL - 1];
wire signed [OUT_CHANNEL * FEATURE_MAP_WIDTH * FEATURE_MAP_HEIGHT * BITWIDTH - 1: 0] weights [0: IN_CHANNEL - 1];

wire signed [IN_CHANNEL * OUT_CHANNEL * FEATURE_MAP_NUM * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1: 0] channel_out;
wire signed [IN_CHANNEL * OUT_CHANNEL * FEATURE_MAP_NUM * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1: 0] temp_result;

genvar j;
generate
    if (IN_CHANNEL == 1) begin
        conv2d_channel #(
                           .BITWIDTH ( BITWIDTH ),
                           .IS_BITWIDTH_DOUBLE_SCALE ( IS_BITWIDTH_DOUBLE_SCALE ),
                           .IMAGE_WIDTH ( IMAGE_WIDTH ),
                           .IMAGE_HEIGHT ( IMAGE_HEIGHT ),
                           .FEATURE_MAP_WIDTH ( FEATURE_MAP_WIDTH ),
                           .FEATURE_MAP_HEIGHT ( FEATURE_MAP_HEIGHT ),
                           .FEATURE_MAP_NUM ( FEATURE_MAP_NUM ),
                           .KERNEL_NUM ( OUT_CHANNEL ),
                           .PADDING ( PADDING ),
                           .STRIDE ( STRIDE ))
                       u_conv2d_channel(
                           .clk ( clk ),
                           .rst_n ( rst_n ),
                           .calculate_start ( channel_start ),
                           .calculate_done ( channel_done ),
                           .image ( image ),
                           .weights ( weights ),
                           .channel_out ( channel_out )
                       );
    end
    else begin //IN_CHANNLE > 1, multi-image input
        for (j = 0;j < IN_CHANNEL;j = j + 1) begin
            conv2d_channel #(
                               .BITWIDTH ( BITWIDTH ),
                               .IS_BITWIDTH_DOUBLE_SCALE ( IS_BITWIDTH_DOUBLE_SCALE ),
                               .IMAGE_WIDTH ( IMAGE_WIDTH ),
                               .IMAGE_HEIGHT ( IMAGE_HEIGHT ),
                               .FEATURE_MAP_WIDTH ( FEATURE_MAP_WIDTH ),
                               .FEATURE_MAP_HEIGHT ( FEATURE_MAP_HEIGHT ),
                               .FEATURE_MAP_NUM ( FEATURE_MAP_NUM ),
                               .KERNEL_NUM ( OUT_CHANNEL ),
                               .PADDING ( PADDING ),
                               .STRIDE ( STRIDE ))
                           u_conv2d_channel(
                               .clk ( clk ),
                               .rst_n ( rst_n ),
                               .calculate_start ( channel_start ),
                               .calculate_done ( channel_done ),
                               .image ( image_channel[j] ),
                               .weights ( weights[j] ),
                               .channel_out ( channel_out[((IN_CHANNEL * OUT_CHANNEL * FEATURE_MAP_NUM * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1) - (j * OUT_CHANNEL * FEATURE_MAP_NUM * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1))) - : (OUT_CHANNEL * FEATURE_MAP_NUM * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1))] )
                           );
        end
    end
endgenerate

genvar k;
generate
    for (k = 0;k < IN_CHANNEL;k = k + 1) begin
        always @( * ) begin

        end
    end
endgenerate


/* control FSM */
localparam IDLE = 2'b01;
localparam BUSY = 2'b10;
reg [1: 0] current_state;
reg [1: 0] next_state;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        current_state <= IDLE;
    end
    else begin
        current_state <= next_state;
    end
end

always @( * ) begin
    case (current_state)
        IDLE: begin

        end
        BUSY: begin

        end
        default: begin
            next_state = IDLE;
        end
    endcase
end


/* post cal */
wire signed [BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1 : 0] bias [0: OUT_CHANNEL - 1];
//bias load
genvar bias_index;
generate
    if (USING_BIAS) begin
        for (bias_index = 0;bias_index < OUT_CHANNEL;bias_index = bias_index + 1) begin
            assign bias[bias_index] = bias_mem[(OUT_CHANNEL * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1) - (bias_index * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)) - : BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)];
        end
    end
    else begin
        for (bias_index = 0;bias_index < OUT_CHANNEL;bias_index = bias_index + 1) begin
            assign bias[bias_index] = {(BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)){1'b0}};
        end
    end
endgenerate

//bias calculate
// genvar a, b;
// generate
//     for (a = 0;a < OUT_CHANNEL;a = a + 1) begin
//         for (b = 0;b < IN_CHANNEL * FEATURE_MAP_NUM;b = b + 1) begin
//             always @(posedge clk or negedge rst_n) begin
//                 if (!rst_n) begin
//                     temp_result[(OUT_CHANNEL * IN_CHANNEL * FEATURE_MAP_NUM * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1) - (a * IN_CHANNEL * FEATURE_MAP_NUM * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)) - (b * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)) -: BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)] = {(BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)){1'b0}};
//                 end
//                 else begin
//                     temp_result[(OUT_CHANNEL * IN_CHANNEL * FEATURE_MAP_NUM * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1) - (a * IN_CHANNEL * FEATURE_MAP_NUM * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)) - (b * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)) -: BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)] = channel_out[(OUT_CHANNEL * IN_CHANNEL * FEATURE_MAP_NUM * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1) - (a * IN_CHANNEL * FEATURE_MAP_NUM * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)) - (b * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)) -: BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)] + bias[a];
//                 end
//             end
//         end
//     end
// endgenerate



//activation function
// genvar act;
// generate
//     for (act = 0;act < OUT_CHANNEL * OUT_IMAGE_WIDTH * OUT_IMAGE_HEIGHT;act = act + 1) begin
//         if (USING_ACTIVATION) begin
//             relu #(
//                      .BITWIDTH ( BITWIDTH ),
//                      .THRESSHOLD ( ACTIVATION_THRESSHOLD ),
//                      .IS_RELU ( ACTIVATION_IS_RELU ),
//                      .MAX_VAL ( ACTIVATION_MAX_VAL ))
//                  u_relu(
//                      .data_i ( temp_result[(OUT_CHANNEL * OUT_IMAGE_WIDTH * OUT_IMAGE_HEIGHT * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1) - (act * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)) -: BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)] ),
//                      .result_o ( result[(OUT_CHANNEL * OUT_IMAGE_WIDTH * OUT_IMAGE_HEIGHT * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1) - (act * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)) -: BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)] )
//                  );

//             // simple_relu #(
//             //                 .BITWIDTH ( BITWIDTH ))
//             //             u_simple_relu(
//             //                 //ports
//             //                 .data_i ( ),
//             //                 .result_o ( )
//             //             );
//         end
//         else begin
//             assign result[(OUT_CHANNEL * OUT_IMAGE_WIDTH * OUT_IMAGE_HEIGHT * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1) - (act * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)) -: BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)] = temp_result[(OUT_CHANNEL * OUT_IMAGE_WIDTH * OUT_IMAGE_HEIGHT * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1) - (act * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)) -: BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)];
//         end
//     end
// endgenerate


endmodule

