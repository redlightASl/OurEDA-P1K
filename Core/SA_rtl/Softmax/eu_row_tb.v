`timescale  1ns / 1ps
`include "eu_row.v"

module tb_eu_row();
// eu_row Parameters
parameter DATA_WIDTH = 8;
parameter IN_DATA_NUM = 9;

// eu_row Inputs
reg clk = 0;
reg rst_n = 0;
reg signed [IN_DATA_NUM * DATA_WIDTH - 1: 0] data_i = 0;

// eu_row Outputs
wire signed [IN_DATA_NUM / 2 * DATA_WIDTH - 1: 0] data_major;
wire signed [IN_DATA_NUM / 2 * DATA_WIDTH - 1: 0] data_minor;
wire signed [DATA_WIDTH - 1: 0] data_signle;

initial begin
    forever
        #2 clk = ~clk;
end

initial begin
    rst_n = 0;
    #1;
    rst_n = 1;
    #4;
    // data_i = 80'h0102_0408_0305_FD03_EE0A;
    data_i = 72'h0102_0408_0305_FD03_EE;
    #4;
    // data_i = 80'h0201_0804_0503_03FD_0AEE;
    data_i = 72'h0802_0608_03DE_FD03_0A;
end

initial begin
    $dumpfile("eu_row_tb.vcd");
    $dumpvars();
    #1000;
    $finish;
end

eu_row #(
           .DATA_WIDTH ( DATA_WIDTH ),
           .IN_DATA_NUM ( IN_DATA_NUM ))
       u_eu_row (
           .clk ( clk ),
           .rst_n ( rst_n ),
           .data_i ( data_i [IN_DATA_NUM * DATA_WIDTH - 1: 0] ),

           .data_major ( data_major [IN_DATA_NUM / 2 * DATA_WIDTH - 1: 0] ),
           .data_minor ( data_minor [IN_DATA_NUM / 2 * DATA_WIDTH - 1: 0] ),
           .data_signle ( data_signle [DATA_WIDTH - 1: 0] )
       );
endmodule
