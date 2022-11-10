`timescale  1ns / 1ps
`include "eu_bit.v"

module tb_eu_bit();

// eu_bit Parameters
parameter PERIOD = 10;
parameter DATA_WIDTH = 8;

// eu_bit Inputs
reg clk = 0;
reg rst_n = 0;
reg signed [DATA_WIDTH - 1: 0] data_a = 0;
reg signed [DATA_WIDTH - 1: 0] data_b = 0;

// eu_bit Outputs
wire [DATA_WIDTH - 1: 0] major_val;
wire [DATA_WIDTH - 1: 0] minor_val;


initial begin
    forever
        #2 clk = ~clk;
end

initial begin
    rst_n = 0;
    #3;
    rst_n = 1;
    #4;
    data_a = 12;
    data_b = 6;
    #4;
    data_a = 1;
    data_b = 6;
    #4;
    data_a = -3;
    data_b = 5;
    #4;
    data_a = 5;
    data_b = -3;
end

initial begin
    $dumpfile("eu_bit_tb.vcd");
    $dumpvars();
    #1000;
    $finish;
end

eu_bit #(
           .DATA_WIDTH ( DATA_WIDTH ))
       u_eu_bit (
           .clk ( clk ),
           .rst_n ( rst_n ),
           .data_a ( data_a [DATA_WIDTH - 1: 0] ),
           .data_b ( data_b [DATA_WIDTH - 1: 0] ),

           .major_val ( major_val [DATA_WIDTH - 1: 0] ),
           .minor_val ( minor_val [DATA_WIDTH - 1: 0] )
       );

endmodule
