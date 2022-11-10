`timescale 1ns / 1ps

//in_feature=196
//out_feature=10
//fixed full connect layer
module linear#(
           parameter BITWIDTH = 8,
           parameter IS_BITWIDTH_DOUBLE_SCALE = 1,
           parameter IN_FEATURES = 14 * 14,
           parameter OUT_FEATURES = 10,
           parameter USING_BIAS = 0
       )(
           input wire clk,
           input wire rst_n,

           input wire valid,
           output wire ready,

           input wire signed [IN_FEATURES * BITWIDTH - 1 : 0] weight_mem_0,
           input wire signed [IN_FEATURES * BITWIDTH - 1 : 0] weight_mem_1,
           input wire signed [IN_FEATURES * BITWIDTH - 1 : 0] weight_mem_2,
           input wire signed [IN_FEATURES * BITWIDTH - 1 : 0] weight_mem_3,
           input wire signed [IN_FEATURES * BITWIDTH - 1 : 0] weight_mem_4,
           input wire signed [IN_FEATURES * BITWIDTH - 1 : 0] weight_mem_5,
           input wire signed [IN_FEATURES * BITWIDTH - 1 : 0] weight_mem_6,
           input wire signed [IN_FEATURES * BITWIDTH - 1 : 0] weight_mem_7,
           input wire signed [IN_FEATURES * BITWIDTH - 1 : 0] weight_mem_8,
           input wire signed [IN_FEATURES * BITWIDTH - 1 : 0] weight_mem_9,
           input wire signed [OUT_FEATURES * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1 : 0] bias_mem,

           input wire signed [BITWIDTH * IN_FEATURES - 1 : 0] in_features,
           output reg signed [BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) * OUT_FEATURES - 1 : 0] out_features
       );
//load bias
wire signed [BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1 : 0] bias [0: OUT_FEATURES - 1]; //bias: BITWIDTH * OUT_FEATURES = 80

genvar c;
generate
    if (USING_BIAS) begin
        for (c = 0;c < OUT_FEATURES;c = c + 1) begin
            assign bias[c] = bias_mem[(OUT_FEATURES * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1) - (c * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)) -: BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)];
        end
    end
    else begin
        for (c = 0;c < OUT_FEATURES;c = c + 1) begin
            assign bias[c] = {(BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)){1'b0}};
        end
    end
endgenerate

//loading weights
wire signed [BITWIDTH * OUT_FEATURES * IN_FEATURES - 1: 0] in_weights;
assign in_weights = {weight_mem_0, weight_mem_1, weight_mem_2, weight_mem_3, weight_mem_4, weight_mem_5, weight_mem_6, weight_mem_7, weight_mem_8, weight_mem_9};

//full connection calculator
wire signed [BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) * OUT_FEATURES - 1 : 0] matrix_mul;

systolic_array_top #(
                     .BITWIDTH ( BITWIDTH ),
                     .IS_BITWIDTH_DOUBLE_SCALE( IS_BITWIDTH_DOUBLE_SCALE ),
                     .X_ROW ( OUT_FEATURES ),
                     .XCOL_YROW ( IN_FEATURES ),
                     .Y_COL ( 1 ))
                 u_systolic_array_top(
                     //ports
                     .sys_clk ( clk ),
                     .sys_rst_n ( rst_n ),
                     .start ( valid ),
                     .done ( ready ),
                     .X ( in_weights ),
                     .Y ( in_features ),
                     .Z ( matrix_mul )
                 );

//add with bias
genvar r;
generate
    for (r = 0;r < OUT_FEATURES;r = r + 1) begin
        always @(posedge clk or negedge rst_n) begin
            if (!rst_n) begin
                out_features[(BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) * OUT_FEATURES - 1) - (r * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)) -: BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)] <= {(BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)){1'b0}};
            end
            else begin
                out_features[(BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) * OUT_FEATURES - 1) - (r * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)) -: BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)] <= matrix_mul[(OUT_FEATURES * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1) - (r * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)) -: BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1)] + bias[r];
            end
        end
    end
endgenerate

endmodule
