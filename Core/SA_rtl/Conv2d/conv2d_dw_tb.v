`timescale  1ns / 1ps

module tb_conv2d_dw();
parameter PERIOD = 4;
parameter BITWIDTH = 8;
parameter IS_BITWIDTH_DOUBLE_SCALE = 1;
parameter IMAGE_WIDTH = 28;
parameter IMAGE_HEIGHT = 28;
parameter WEIGHT_WIDTH = 3;
parameter WEIGHT_HEIGHT = 3;
parameter INOUT_CHANNEL = 1;
parameter STRIDE = 1;
parameter PADDING = 0;
parameter USING_BIAS = 0;
parameter USING_ACTIVATION = 1;
parameter ACTIVATION_IS_RELU = 1;
parameter ACTIVATION_THRESSHOLD = {BITWIDTH{1'b0}};
parameter ACTIVATION_MAX_VAL = 6;

// conv2d_dw Inputs
reg clk = 0;
reg rst_n = 0;
reg valid = 0;
reg [INOUT_CHANNEL * IMAGE_WIDTH * IMAGE_HEIGHT * BITWIDTH - 1: 0] image = 0;
reg [INOUT_CHANNEL * WEIGHT_WIDTH * WEIGHT_HEIGHT * BITWIDTH - 1: 0] weights_mem = 0;

// conv2d_dw Outputs
wire ready ;
wire [INOUT_CHANNEL * OUT_IMAGE_WIDTH * OUT_IMAGE_HEIGHT * BITWIDTH * (IS_BITWIDTH_DOUBLE_SCALE + 1) - 1: 0] result;


initial begin
    forever
        #(PERIOD / 2) clk = ~clk;
end

integer stage = 0;
always @(posedge clk) begin
    case (stage)
        0: begin
            rst_n = 1'b0;
            stage = 1;
        end
        1: begin
            rst_n = 1'b1;
            stage = 2;
        end
        2: begin
            stage = 2;
        end
        default: begin
            stage = 0;
        end
    endcase
end

initial begin
    $dumpfile("tb.vcd");
    $dumpvars();
    #1000;
    $finish();
end

conv2d_dw #(
              .BITWIDTH ( BITWIDTH ),
              .IS_BITWIDTH_DOUBLE_SCALE ( IS_BITWIDTH_DOUBLE_SCALE ),
              .IMAGE_WIDTH ( IMAGE_WIDTH ),
              .IMAGE_HEIGHT ( IMAGE_HEIGHT ),
              .WEIGHT_WIDTH ( WEIGHT_WIDTH ),
              .WEIGHT_HEIGHT ( WEIGHT_HEIGHT ),
              .INOUT_CHANNEL ( INOUT_CHANNEL ),
              .STRIDE ( STRIDE ),
              .PADDING ( PADDING ),
              .USING_BIAS ( USING_BIAS ),
              .USING_ACTIVATION ( USING_ACTIVATION ),
              .ACTIVATION_IS_RELU ( ACTIVATION_IS_RELU ),
              .ACTIVATION_THRESSHOLD ( ACTIVATION_THRESSHOLD ),
              .ACTIVATION_MAX_VAL ( ACTIVATION_MAX_VAL ))
          u_conv2d_dw (
              .clk ( clk ),
              .rst_n ( rst_n ),
              .valid ( valid ),
              .image ( image [INOUT_CHANNEL * IMAGE_WIDTH * IMAGE_HEIGHT * BITWIDTH - 1: 0] ),
              .weights_mem ( weights_mem [INOUT_CHANNEL * WEIGHT_WIDTH * WEIGHT_HEIGHT * BITWIDTH - 1: 0] ),

              .ready ( ready ),
          );

endmodule
