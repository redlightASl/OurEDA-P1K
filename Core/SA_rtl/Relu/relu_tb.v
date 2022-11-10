`timescale 1ns / 1ps 
// `include "relu.v"

module relu_tb();
parameter PERIOD = 10;

parameter BITWIDTH = 8;
parameter THRESSHOLD = {BITWIDTH{1'b0}};

// relu Inputs
reg signed [BITWIDTH - 1 : 0] data_i;
// relu Outputs
wire signed [BITWIDTH - 1 : 0] result_o;


initial begin
    data_i = 0;
    #10;
    data_i = -127;
    repeat(256) begin
        #10;
        data_i = data_i + 1'b1;
    end
end


initial begin
    $dumpfile("relu_tb.vcd");
    $dumpvars();
    #3000;
    $finish();
end

// relu #(
//          .BITWIDTH ( BITWIDTH ),
//          .THRESSHOLD ( THRESSHOLD ),
//          .IS_RELU(1),
//          .MAX_VAL(6)
//     )
//      u_relu (
//          .data_i ( data_i),
//          .result_o ( result_o )
//      );

simple_relu #(
                .BITWIDTH ( BITWIDTH ))
            u_simple_relu(
                .data_i ( data_i ),
                .result_o ( result_o )
            );

endmodule
