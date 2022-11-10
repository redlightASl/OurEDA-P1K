`timescale 1ns / 1ps

/* calculate one channel in conv */
//input data: regenerated feature-maps
//format: row0_row1_row2_..._rown
//weight: regenerated weight in one kernel
//output data: conv data in one channel
module conv2d_feature#(
           parameter BITWIDTH = 8,
           parameter IS_BITWIDTH_DOUBLE_SCALE = 1,
           parameter FEATURE_MAP_NUM = 9, //number of the regenerated feature-maps
           parameter FEATURE_MAP_WIDTH = 3, //single feature map size == weight size
           parameter FEATURE_MAP_HEIGHT = 3,
           parameter KERNEL_NUM = 1 //number of conv-kernel
       )(
           input wire clk,
           input wire rst_n,
           input wire calculate_start,
           output wire calculate_done,

           input wire signed [FEATURE_MAP_NUM * FEATURE_MAP_WIDTH * FEATURE_MAP_HEIGHT * BITWIDTH - 1: 0] feature_maps,
           input wire signed [KERNEL_NUM * FEATURE_MAP_WIDTH * FEATURE_MAP_HEIGHT * BITWIDTH - 1: 0] weights,

           output wire signed [BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) * FEATURE_MAP_NUM * KERNEL_NUM - 1: 0] channel_out
       );

//main systolic array for conv2d
//row input: regenerated feature-map data lane
//col input: regenerated weight(kernel data) lane
systolic_array_top #(
                       .BITWIDTH ( BITWIDTH ),
                       .IS_BITWIDTH_DOUBLE_SCALE ( IS_BITWIDTH_DOUBLE_SCALE ),
                       .X_ROW ( FEATURE_MAP_NUM ),
                       .XCOL_YROW ( FEATURE_MAP_WIDTH * FEATURE_MAP_HEIGHT ),
                       .Y_COL ( KERNEL_NUM ))
                   u_systolic_array_top(
                       .sys_clk ( clk ),
                       .sys_rst_n ( rst_n ),
                       .start ( calculate_start ),
                       .done ( calculate_done ),
                       .X ( feature_maps ),
                       .Y ( weights ),
                       .Z ( channel_out )
                   );

endmodule
